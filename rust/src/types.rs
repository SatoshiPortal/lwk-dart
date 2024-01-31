use crate::{error::LwkError, network::LiquidNetwork};
use elements::AssetId;
use lwk_wollet::{WalletTx, Wollet};
use std::collections::HashMap;
use std::str::FromStr;

const TLBTC_ASSET_ID: &str = "144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49";

#[derive(Clone, Debug, PartialEq)]
pub struct Wallet {
    pub network: LiquidNetwork,
    pub dbpath: String,
    pub desc: String,
}

impl TryInto<Wollet> for Wallet {
    type Error = LwkError;
    fn try_into(self) -> Result<Wollet, Self::Error> {
        Ok(Wollet::new(self.network.into(), Some(&self.dbpath), &self.desc)?.into())
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct Tx {
    pub kind: String,
    pub amount: u64,
    pub txid: String,
    pub address: String,
    pub fee: u64,
}

impl From<WalletTx> for Tx {
    fn from(wallet_tx: WalletTx) -> Self {
        Tx {
            kind: wallet_tx.type_,
            amount: wallet_tx
                .balance
                .get(&AssetId::from_str(TLBTC_ASSET_ID).unwrap())
                .unwrap_or(&0)
                .to_owned()
                .abs() as u64,
            txid: wallet_tx.tx.txid().to_string(),
            address: "".to_string(),
            fee: wallet_tx.fee,
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct DecodedTx {
    pub outputs: HashMap<String, u64>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Balance {
    pub lbtc: u64,
    // lcad: u32,
    // usdt: u32,
}

impl From<HashMap<AssetId, u64>> for Balance {
    fn from(balance: HashMap<AssetId, u64>) -> Self {
        let lbtc_balance: u64 = balance
            .get(&AssetId::from_str(TLBTC_ASSET_ID).unwrap())
            .unwrap_or(&0)
            .to_owned();
        Balance { lbtc: lbtc_balance }
    }
}
