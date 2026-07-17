use flutter_rust_bridge::frb;

/// Liquid Bitcoin mainnet asset ID
pub const L_BTC_ASSET_ID: &str =
    "6f0279e9ed041c3d710a9f57d0c02928416460c4b722ae3457a11eec381c526d";

/// Liquid Bitcoin testnet asset ID
pub const L_TEST_ASSET_ID: &str =
    "144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49";

/// Get balance value for a specific asset ID from a list of balances
#[frb(sync)]
pub fn get_balance_by_asset_id(balances: Vec<Balance>, asset_id: String) -> i64 {
    balances
        .iter()
        .find(|b| b.asset_id == asset_id)
        .map(|b| b.value)
        .unwrap_or(0)
}

/// Get L-BTC mainnet balance
#[frb(sync)]
pub fn get_lbtc_balance(balances: Vec<Balance>) -> i64 {
    get_balance_by_asset_id(balances, L_BTC_ASSET_ID.to_string())
}

/// Get L-BTC testnet balance
#[frb(sync)]
pub fn get_ltest_balance(balances: Vec<Balance>) -> i64 {
    get_balance_by_asset_id(balances, L_TEST_ASSET_ID.to_string())
}

/// Get L-BTC mainnet asset ID
#[frb(sync)]
pub fn get_lbtc_asset_id() -> String {
    L_BTC_ASSET_ID.to_string()
}

/// Get L-BTC testnet asset ID
#[frb(sync)]
pub fn get_ltest_asset_id() -> String {
    L_TEST_ASSET_ID.to_string()
}

use lwk_common::PsetBalance;
use lwk_wollet::{
    elements::{
        self,
        hex::{FromHex, ToHex},
        pset::PartiallySignedTransaction,
        Address as LwkAddress, AddressParams, AssetId, Script,
    },
    secp256k1, AddressResult, WalletTx, WalletTxOut,
};
pub use std::collections::{BTreeMap, HashMap};
use std::str::FromStr;
pub use std::vec::Vec;

use lwk_wollet::Network as ElementsNetwork;
use std::convert::TryFrom;

use super::error::LwkError;

#[derive(Clone, Copy, PartialEq, Debug)]
pub enum LiquidNetwork {
    Mainnet,
    Testnet,
}

impl Into<ElementsNetwork> for LiquidNetwork {
    fn into(self) -> ElementsNetwork {
        match self {
            LiquidNetwork::Mainnet => ElementsNetwork::Liquid,
            LiquidNetwork::Testnet => ElementsNetwork::TestnetLiquid,
        }
    }
}

pub struct AssetIdBTreeMapUInt(BTreeMap<AssetId, u64>);
pub struct AssetIdBTreeMapInt(BTreeMap<AssetId, i64>);
pub struct AssetIdHashMapInt(HashMap<AssetId, i64>);
pub struct AssetIdHashMapUInt(HashMap<AssetId, u64>);

// Implement From for BTreeMap and HashMap
impl From<BTreeMap<AssetId, i64>> for AssetIdBTreeMapInt {
    fn from(map: BTreeMap<AssetId, i64>) -> Self {
        AssetIdBTreeMapInt(map)
    }
}

impl From<BTreeMap<AssetId, u64>> for AssetIdBTreeMapUInt {
    fn from(map: BTreeMap<AssetId, u64>) -> Self {
        AssetIdBTreeMapUInt(map)
    }
}

impl From<HashMap<AssetId, i64>> for AssetIdHashMapInt {
    fn from(map: HashMap<AssetId, i64>) -> Self {
        AssetIdHashMapInt(map)
    }
}
impl From<HashMap<AssetId, u64>> for AssetIdHashMapUInt {
    fn from(map: HashMap<AssetId, u64>) -> Self {
        AssetIdHashMapUInt(map)
    }
}
/// Balance represents a balance of a specific asset
#[derive(Clone, Debug, PartialEq)]
pub struct Balance {
    pub asset_id: String,
    pub value: i64,
}

/// Balances is a list of Balance objects
/// A multi asset wallet will have more than one item in the list for each asset
pub type Balances = Vec<Balance>;

impl From<AssetIdBTreeMapInt> for Balances {
    fn from(asset_id_map: AssetIdBTreeMapInt) -> Self {
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
impl From<AssetIdHashMapInt> for Balances {
    fn from(asset_id_map: AssetIdHashMapInt) -> Self {
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

impl From<AssetIdBTreeMapUInt> for Balances {
    fn from(asset_id_map: AssetIdBTreeMapUInt) -> Self {
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

impl From<AssetIdHashMapUInt> for Balances {
    fn from(asset_id_map: AssetIdHashMapUInt) -> Self {
        asset_id_map
            .0
            .into_iter()
            .filter_map(|(key, value)| match u64::try_from(value) {
                Ok(converted_value) => Some(Balance {
                    asset_id: key.to_string(),
                    value: converted_value as i64,
                }),
                Err(_) => {
                    eprintln!("Warning: Overflow encountered converting {} to i64", value);
                    None
                }
            })
            .collect()
    }
}

impl From<elements::TxOutSecrets> for TxOutSecrets {
    fn from(value: elements::TxOutSecrets) -> Self {
        TxOutSecrets {
            value: value.value,
            value_bf: value.value_bf.to_string(),
            asset: value.asset.to_string(),
            asset_bf: value.asset_bf.to_string(),
        }
    }
}

impl From<WalletTxOut> for TxOut {
    fn from(wallet_tx_out: WalletTxOut) -> Self {
        TxOut {
            script_pubkey: wallet_tx_out.script_pubkey.to_hex(),
            height: wallet_tx_out.height,
            unblinded: wallet_tx_out.unblinded.into(),
            outpoint: OutPoint {
                txid: wallet_tx_out.outpoint.txid.to_string(),
                vout: wallet_tx_out.outpoint.vout,
            },
            address: Address::from(wallet_tx_out.address.clone()),
            is_spent: wallet_tx_out.is_spent,
        }
    }
}

/// Address class which contains both standard and confidential addresses with the address index in the wallet
#[derive(Clone, Debug, PartialEq)]
pub struct Address {
    pub standard: String,
    pub confidential: String,
    pub index: Option<u32>,
    pub blinding_key: Option<String>,
}

/// A wallet address paired with the secret blinding key derived for that address.
pub struct AddressWithBlindingSecret {
    pub address: Address,
    pub blinding_secret: String,
}

impl From<AddressResult> for Address {
    fn from(address: AddressResult) -> Self {
        Address {
            standard: address.address().to_unconfidential().to_string(),
            confidential: address.address().to_string(),
            index: Some(address.index()),
            blinding_key: address.address().blinding_pubkey.map(|pk| pk.to_string()),
        }
    }
}
impl From<LwkAddress> for Address {
    fn from(address: LwkAddress) -> Self {
        Address {
            standard: address.to_unconfidential().to_string(),
            confidential: address.to_string(),
            index: None,
            blinding_key: address.blinding_pubkey.map(|pk| pk.to_string()),
        }
    }
}

impl Address {
    /// Validate the address string and return the network
    pub fn validate(address_string: String) -> anyhow::Result<LiquidNetwork, LwkError> {
        let address = LwkAddress::from_str(&address_string)?;
        if address.params.to_owned() == AddressParams::LIQUID {
            Ok(LiquidNetwork::Mainnet)
        } else {
            Ok(LiquidNetwork::Testnet)
        }
    }

    /// Create an address from a scriptpubkey. Always returns 0 as the index is only for wallet generated addresses
    pub fn address_from_script(
        network: LiquidNetwork,
        script: String,
        blinding_key: Option<String>,
    ) -> anyhow::Result<Address, LwkError> {
        let blinding_pubkey = if blinding_key == None {
            None
        } else {
            let pubkey = match secp256k1::PublicKey::from_str(&blinding_key.clone().unwrap()) {
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
            blinding_pubkey,
            match network {
                LiquidNetwork::Mainnet => &AddressParams::LIQUID,
                LiquidNetwork::Testnet => &AddressParams::LIQUID_TESTNET,
            },
        );
        if let Some(address) = address {
            Ok(Address {
                standard: address.to_unconfidential().to_string(),
                confidential: address.to_string(),
                index: None,
                blinding_key: blinding_key,
            })
        } else {
            Err(LwkError {
                msg: "Could not convert script to address".to_string(),
            })
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
    pub is_spent: bool,
    pub address: Address,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TxOutSecrets {
    pub value: u64,
    pub value_bf: String,
    pub asset: String,
    pub asset_bf: String,
}

/// Transaction object returned by getTransactions.
#[derive(Clone, Debug, PartialEq)]
pub struct Tx {
    pub timestamp: Option<u32>,
    pub kind: String,
    pub balances: Balances,
    pub txid: String,
    pub outputs: Vec<TxOut>,
    pub inputs: Vec<TxOut>,
    pub fee: u64,
    pub height: Option<u32>,
    pub unblinded_url: String,
    pub vsize: usize,
}

impl From<WalletTx> for Tx {
    fn from(wallet_tx: WalletTx) -> Self {
        let mut outputs: Vec<TxOut> = Vec::new();
        let mut inputs: Vec<TxOut> = Vec::new();

        for output in &wallet_tx.outputs {
            if let Some(output) = output {
                let script_pubkey = output.script_pubkey.to_hex();
                outputs.push(TxOut {
                    script_pubkey,
                    height: output.height,
                    unblinded: output.unblinded.into(),
                    outpoint: OutPoint {
                        txid: output.outpoint.txid.to_string(),
                        vout: output.outpoint.vout,
                    },
                    address: Address::from(output.address.clone()),
                    is_spent: output.is_spent,
                })
            }
        }

        for input in &wallet_tx.inputs {
            if let Some(input) = input {
                let script_pubkey = input.script_pubkey.to_string();
                inputs.push(TxOut {
                    script_pubkey,
                    height: input.height,
                    unblinded: input.unblinded.into(),
                    outpoint: OutPoint {
                        txid: input.outpoint.txid.to_string(),
                        vout: input.outpoint.vout,
                    },
                    address: Address::from(input.address.clone()),
                    is_spent: input.is_spent,
                })
            }
        }
        // let now = SystemTime::now();
        // let since_the_epoch = now.duration_since(UNIX_EPOCH).expect("Time went backwards");
        Tx {
            kind: wallet_tx.type_.clone(),
            balances: Balances::from(AssetIdBTreeMapInt(wallet_tx.balance.as_ref().clone())),
            txid: wallet_tx.tx.txid().to_string().clone(),
            outputs: outputs,
            inputs: inputs,
            fee: wallet_tx.fee,
            timestamp: wallet_tx.timestamp,
            height: wallet_tx.height,
            unblinded_url: wallet_tx.unblinded_url("").clone(),
            vsize: wallet_tx.tx.discount_vsize(),
        }
    }
}

/// Decoded PSET amounts
#[derive(Clone, Debug, PartialEq)]
pub struct PsetAmounts {
    pub absolute_fees: u64,
    pub balances: Balances,
}
impl PsetAmounts {
    pub(super) fn from_balance(balance: PsetBalance, policy_asset: &AssetId) -> Self {
        PsetAmounts {
            absolute_fees: balance.fees_in(policy_asset),
            balances: Balances::from(AssetIdBTreeMapInt(balance.balances.as_ref().clone())),
        }
    }
}

#[frb(unignore)]
#[derive(Clone, Debug, PartialEq)]
pub struct SizeAndFees {
    pub discounted_vsize: usize,
    pub discounted_weight: usize,
    pub absolute_fees: Balances,
}
impl TryFrom<String> for SizeAndFees {
    type Error = LwkError;
    fn try_from(pset_string: String) -> Result<Self, Self::Error> {
        let pset = PartiallySignedTransaction::from_str(&pset_string)
            .map_err(|e| LwkError { msg: e.to_string() })?;
        let tx = pset
            .extract_tx()
            .map_err(|e| LwkError { msg: e.to_string() })?;
        let all_fees: AssetIdHashMapUInt = tx.all_fees().into();

        Ok(SizeAndFees {
            discounted_vsize: tx.discount_vsize(),
            discounted_weight: tx.discount_weight(),
            absolute_fees: all_fees.into(),
        })
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct PayjoinTx {
    /// Partially signed transaction
    pub pset: String,
    /// LiquidNetwork fee
    pub network_fee: u64,
    /// Asset fee amount paid to the server
    pub asset_fee: u64,
    /// All unblinded outputs
    pub unblinded_outputs: Vec<TxOutSecrets>,
}

// #[test]
// fn test_address_from_script() {
//     // The script provided: 0014ac45b647d82582d4ed416e5b84fd418789025dc5
//     let script = "0014ac45b647d82582d4ed416e5b84fd418789025dc5".to_string();
//     // Generate blinding key from SLIP77 seed
//     let slip77_string = "".to_string();

//     // Get the script for blinding

//     // Call the address_from_script method
//     let address_result = Address::address_from_script(
//         LiquidNetwork::Mainnet,
//         script,
//         slip77_string,
//     ).unwrap();
//     println!("{:?}", address_result);
//     // Expected values - verify these are correct for your implementation
//     // let expected_standard = "ex1q9g4gvcdszt4krclr7tcw50vg5hyuuk2kjfyyxu";
//     // let expected_confidential = "lq1qqg4gvcdszt4krclr7tcw50vg5hyuuk2krzm3el3kvfpe60vf025x2dfqlxzse3rppkan5kdz8qc9f7qwjcc0shw90x34wlse5s3ydw8pyq4eqehu";

//     // assert_eq!(address_result.standard, expected_standard);
//     // assert_eq!(address_result.confidential, expected_confidential);
//     // assert_eq!(address_result.index, 0);
// }
