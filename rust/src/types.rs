use elements::{Address as LiquidAddress, AddressParams, AssetId};
use lwk_common::PsetBalance;
use lwk_wollet::{AddressResult, WalletTx};
use std::collections::HashMap;
use std::str::FromStr;
const TLBTC_ASSET_ID: &str = "144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49";

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
pub struct TxOut {
    pub address: String,
    pub amount: u64,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Tx {
    pub kind: String,
    pub amount: u64,
    pub txid: String,
    pub outputs: Vec<TxOut>,
    pub fee: u64,
}

impl From<WalletTx> for Tx {
    fn from(wallet_tx: WalletTx) -> Self {
        let mut outputs: Vec<TxOut> = Vec::new();

        for output in wallet_tx.outputs {
            if output.is_some() {
                let script_pubkey = output.clone().unwrap().script_pubkey;
                let amount = output.unwrap().unblinded.value;
                let address =
                    LiquidAddress::from_script(&script_pubkey, None, &AddressParams::LIQUID_TESTNET)
                        .unwrap();
                outputs.push(TxOut {
                    address: address.to_string(),
                    amount: amount,
                })
            }
        }

        Tx {
            kind: wallet_tx.type_,
            amount: wallet_tx
                .balance
                .get(&AssetId::from_str(TLBTC_ASSET_ID).unwrap())
                .unwrap_or(&0)
                .to_owned()
                .abs() as u64,
            txid: wallet_tx.tx.txid().to_string(),
            outputs: outputs,
            fee: wallet_tx.fee,
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct PsetAmounts {
    pub fee: u64,
    pub balances: Balance,
}
impl From<PsetBalance> for PsetAmounts {
    fn from(balance: PsetBalance) -> Self {
        let balances = Balance::from(balance.balances);
        PsetAmounts {
            fee: balance.fee,
            balances,
        }
    }
}
#[derive(Clone, Debug, PartialEq)]
pub struct Balance {
    pub lbtc: i64,
    // lcad: u32,
    // usdt: u32,
}

impl From<HashMap<AssetId, i64>> for Balance {
    fn from(balance: HashMap<AssetId, i64>) -> Self {
        let lbtc_balance: i64 = balance
            .get(&AssetId::from_str(TLBTC_ASSET_ID).unwrap())
            .unwrap_or(&0)
            .to_owned();
        Balance { lbtc: lbtc_balance }
    }
}

impl From<HashMap<AssetId, u64>> for Balance {
    fn from(balance: HashMap<AssetId, u64>) -> Self {
        let lbtc_balance: u64 = balance
            .get(&AssetId::from_str(TLBTC_ASSET_ID).unwrap())
            .unwrap_or(&0)
            .to_owned();
        Balance {
            lbtc: lbtc_balance as i64,
        }
    }
}

#[cfg(test)]
mod test {

    #[test]
    fn test_types() {}
}
