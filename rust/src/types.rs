use crate::{error::LwkError, network::LiquidNetwork};
use elements::AssetId;
use lwk_common::PsetBalance;
use lwk_wollet::{EncryptedFsPersister, WalletTx, Wollet, WolletDescriptor};
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
        let descriptor  = WolletDescriptor::from_str(&self.desc)?;
        Ok(Wollet::new(self.network.into(), EncryptedFsPersister::new(&self.dbpath, self.network.into(), &descriptor)?, &self.desc)?.into())
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
