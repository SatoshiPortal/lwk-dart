use elements::{Address as LiquidAddress, AddressParams, AssetId, TxOutSecrets as LwkTxOutSecrets, OutPoint as LwkOutPoint};
use lwk_common::PsetBalance;
use lwk_wollet::{AddressResult, WalletTx};
use std::collections::HashMap;
use std::str::FromStr;


pub struct AssetIdMapUInt(pub HashMap<AssetId, u64>);
pub struct AssetIdMapInt(pub HashMap<AssetId, i64>);

pub type Balances = Vec<(String, i64)>;

impl From<AssetIdMapInt> for Balances {
    fn from(asset_id_map: AssetIdMapInt) -> Self {
        asset_id_map.0.into_iter()
            .map(|(key, value)| (key.to_string(), value))
            .collect()
    }
}

impl From<AssetIdMapUInt> for Balances {
    fn from(asset_id_map: AssetIdMapUInt) -> Self {
        asset_id_map.0.into_iter()
            .map(|(key, value)| {
                // This may overflow for very large u64 values.
                let converted_value = value as i64;
                (key.to_string(), converted_value)
            })
            .collect()
    }
}


#[derive(Clone, Debug, PartialEq)]
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


#[derive(Clone, Debug, PartialEq)]
pub struct OutPoint {
    pub txid: String,
    pub vout: u32,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TxOut {
    pub script_pubkey: String,
    pub outpoint: OutPoint,
    pub height: Option<u32>,
    pub unblinded: TxOutSecrets,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TxOutSecrets{
    pub value: u64,
    pub value_bf: String,
    pub asset: String,
    pub asset_bf: String,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Tx {
    pub timestamp: u32,
    pub kind: String,
    pub balances: Balances,
    pub txid: String,
    pub outputs: Vec<TxOut>,
    pub inputs: Vec<TxOut>,
    pub fee: u64,
}

impl From<WalletTx> for Tx {
    fn from(wallet_tx: WalletTx) -> Self {
        let mut outputs: Vec<TxOut> = Vec::new();
        let mut inputs: Vec<TxOut> = Vec::new();

        for output in wallet_tx.outputs {
            if output.is_some() { // safe to unwrap
                let script_pubkey = output.clone().unwrap().script_pubkey;
                let amount = output.clone().unwrap().unblinded.value;
                outputs.push(TxOut {
                    script_pubkey:script_pubkey.to_string(),
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
                    } ,
                })
            }
        }

        for input in wallet_tx.inputs {
            if input.is_some() { // safe to unwrap
                let script_pubkey = input.clone().unwrap().script_pubkey;
                let amount = input.clone().unwrap().unblinded.value;
                inputs.push(TxOut {
                    script_pubkey:script_pubkey.to_string(),
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
                    } ,
                })
            }
        }
        Tx {
            kind: wallet_tx.type_,
            balances: Balances::from(AssetIdMapInt(wallet_tx
                .balance)),
            txid: wallet_tx.tx.txid().to_string(),
            outputs: outputs,
            inputs: inputs,
            fee: wallet_tx.fee,
            timestamp: wallet_tx.timestamp.unwrap(),
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct PsetAmounts {
    pub fee: u64,
    pub balances: Balances,
}
impl From<PsetBalance> for PsetAmounts {
    fn from(balance: PsetBalance) -> Self {
        PsetAmounts {
            fee: balance.fee,
            balances: Balances::from(AssetIdMapInt(balance.balances)),
        }
    }
}


#[cfg(test)]
mod test {

    #[test]
    fn test_types() {}
}
