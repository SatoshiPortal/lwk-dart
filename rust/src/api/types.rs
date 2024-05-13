use elements::hex::{FromHex, ToHex};
use elements::Address as LwkAddress;
use elements::{secp256k1_zkp, AddressParams, AssetId, Script};
use flutter_rust_bridge::frb;
use lwk_common::PsetBalance;
use lwk_wollet::{AddressResult, WalletTx, WalletTxOut};
use std::collections::HashMap;
use std::str::FromStr;

use lwk_wollet::ElementsNetwork;

#[derive(Clone, Copy, PartialEq, Debug)]
#[frb(dart_metadata=("freezed"))]
pub enum Network {
    Mainnet,
    Testnet,
}

impl Into<ElementsNetwork> for Network {
    fn into(self) -> ElementsNetwork {
        match self {
            Network::Mainnet => ElementsNetwork::Liquid,
            Network::Testnet => ElementsNetwork::LiquidTestnet,
        }
    }
}

pub struct AssetIdMapUInt(pub HashMap<AssetId, u64>);
pub struct AssetIdMapInt(pub HashMap<AssetId, i64>);

#[frb(dart_metadata=("freezed"))]
pub type Balances = Vec<Balance>;

impl From<AssetIdMapInt> for Balances {
    fn from(asset_id_map: AssetIdMapInt) -> Self {
        asset_id_map
            .0
            .into_iter()
            .map(|(key, value)| Balance {
                asset_id: key.to_string(),
                value,
            })
            .collect()
    }
}

use std::convert::TryFrom;
use std::time::{SystemTime, UNIX_EPOCH};

use super::error::LwkError;

impl From<AssetIdMapUInt> for Balances {
    fn from(asset_id_map: AssetIdMapUInt) -> Self {
        asset_id_map
            .0
            .into_iter()
            .filter_map(|(key, value)| match i64::try_from(value) {
                Ok(converted_value) => Some(Balance {
                    asset_id: key.to_string(),
                    value: converted_value,
                }),
                Err(_) => {
                    eprintln!("Warning: Overflow encountered converting {} to i64", value);
                    None
                }
            })
            .collect()
    }
}

impl From<WalletTxOut> for TxOut {
    fn from(wallet_tx_out: WalletTxOut) -> Self {
        TxOut {
            script_pubkey: wallet_tx_out.script_pubkey.to_hex(),
            height: wallet_tx_out.height,
            unblinded: TxOutSecrets {
                value: wallet_tx_out.unblinded.value,
                value_bf: wallet_tx_out.unblinded.value_bf.to_string(),
                asset: wallet_tx_out.unblinded.asset.to_string(),
                asset_bf: wallet_tx_out.unblinded.asset_bf.to_string(),
            },
            outpoint: OutPoint {
                txid: wallet_tx_out.outpoint.txid.to_string(),
                vout: wallet_tx_out.outpoint.vout,
            },
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct Balance {
    pub asset_id: String,
    pub value: i64,
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct Address {
    pub standard: String,
    pub confidential: String,
    pub index: u32,
}

impl From<AddressResult> for Address {
    fn from(address: AddressResult) -> Self {
        Address {
            standard: address.address().to_unconfidential().to_string(),
            confidential: address.address().to_string(),
            index: address.index(),
        }
    }
}

impl Address {
    pub fn validate(address_string: String) -> anyhow::Result<(), LwkError> {
        LwkAddress::from_str(&address_string)?;
        Ok(())
    }

    pub fn address_from_script(
        network: Network,
        script: String,
        blinding_key: String,
    ) -> anyhow::Result<Address, LwkError> {
        let blinding_key = if blinding_key == "".to_string() {
            None
        } else {
            let pubkey = match secp256k1_zkp::PublicKey::from_str(&blinding_key) {
                Ok(result) => result,
                Err(e) => return Err(LwkError { msg: e.to_string() }),
            };
            Some(pubkey)
        };
        let script_pubkey = match Script::from_hex(&script) {
            Ok(result) => result,
            Err(e) => return Err(LwkError { msg: e.to_string() }),
        };

        let address = LwkAddress::from_script(
            &script_pubkey,
            blinding_key,
            match network {
                Network::Mainnet => &AddressParams::LIQUID,
                Network::Testnet => &AddressParams::LIQUID_TESTNET,
            },
        );
        if address.is_none() {
            Err(LwkError {
                msg: "Could not convert script to address".to_string(),
            })
        } else {
            Ok(Address {
                standard: address.clone().unwrap().to_unconfidential().to_string(),
                confidential: address.unwrap().to_string(),
                index: 0,
            })
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct OutPoint {
    pub txid: String,
    pub vout: u32,
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct TxOut {
    pub script_pubkey: String,
    pub outpoint: OutPoint,
    pub height: Option<u32>,
    pub unblinded: TxOutSecrets,
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct TxOutSecrets {
    pub value: u64,
    pub value_bf: String,
    pub asset: String,
    pub asset_bf: String,
}

#[derive(Clone, Debug, PartialEq)]
#[frb(dart_metadata=("freezed"))]
pub struct Tx {
    pub timestamp: u32,
    pub kind: String,
    pub balances: Balances,
    pub txid: String,
    pub outputs: Vec<TxOut>,
    pub inputs: Vec<TxOut>,
    pub fee: u64,
    pub height: u32,
}

impl From<WalletTx> for Tx {
    fn from(wallet_tx: WalletTx) -> Self {
        let mut outputs: Vec<TxOut> = Vec::new();
        let mut inputs: Vec<TxOut> = Vec::new();

        for output in wallet_tx.outputs {
            if output.is_some() {
                // safe to unwrap
                let script_pubkey = output.clone().unwrap().script_pubkey;
                outputs.push(TxOut {
                    script_pubkey: script_pubkey.to_hex(),
                    height: output.clone().unwrap().height,
                    unblinded: TxOutSecrets {
                        value: output.clone().unwrap().unblinded.value,
                        value_bf: output.clone().unwrap().unblinded.value_bf.to_string(),
                        asset: output.clone().unwrap().unblinded.asset.to_string(),
                        asset_bf: output.clone().unwrap().unblinded.asset_bf.to_string(),
                    },
                    outpoint: OutPoint {
                        txid: output.clone().unwrap().outpoint.txid.to_string(),
                        vout: output.clone().unwrap().outpoint.vout,
                    },
                })
            }
        }

        for input in wallet_tx.inputs {
            if input.is_some() {
                // safe to unwrap
                let script_pubkey = input.clone().unwrap().script_pubkey;
                inputs.push(TxOut {
                    script_pubkey: script_pubkey.to_string(),
                    height: input.clone().unwrap().height,
                    unblinded: TxOutSecrets {
                        value: input.clone().unwrap().unblinded.value,
                        value_bf: input.clone().unwrap().unblinded.value_bf.to_string(),
                        asset: input.clone().unwrap().unblinded.asset.to_string(),
                        asset_bf: input.clone().unwrap().unblinded.asset_bf.to_string(),
                    },
                    outpoint: OutPoint {
                        txid: input.clone().unwrap().outpoint.txid.to_string(),
                        vout: input.clone().unwrap().outpoint.vout,
                    },
                })
            }
        }
        let now = SystemTime::now();
        let since_the_epoch = now.duration_since(UNIX_EPOCH).expect("Time went backwards");
        Tx {
            kind: wallet_tx.type_,
            balances: Balances::from(AssetIdMapInt(wallet_tx.balance)),
            txid: wallet_tx.tx.txid().to_string(),
            outputs: outputs,
            inputs: inputs,
            fee: wallet_tx.fee,
            timestamp: wallet_tx
                .timestamp
                .unwrap_or(since_the_epoch.as_secs() as u32),
            height: wallet_tx.height.unwrap_or(0),
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct PsetAmounts {
    pub absolute_fees: u64,
    pub balances: Balances,
}
impl From<PsetBalance> for PsetAmounts {
    fn from(balance: PsetBalance) -> Self {
        PsetAmounts {
            absolute_fees: balance.fee,
            balances: Balances::from(AssetIdMapInt(balance.balances)),
        }
    }
}
