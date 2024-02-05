pub use crate::error::LwkError;
pub use crate::network::LiquidNetwork;
pub use crate::types::{Balance, PsetAmounts, Tx};
pub use crate::wallet::Wallet;
use elements::pset::serialize::Deserialize;

use elements::Transaction;
use elements::Txid;
use flutter_rust_bridge::RustOpaque;
use lwk_wollet::{BlockchainBackend, ElectrumClient};
pub struct Api {}

impl Api {
    pub fn new_wallet(
        mnemonic: String,
        network: LiquidNetwork,
        db_path: String,
    ) -> anyhow::Result<String, LwkError> {
        Ok(Wallet::new(network, &db_path, &mnemonic)?.into())
    }

    pub fn sync(wallet_id: String, electrum_url: String) -> anyhow::Result<(), LwkError> {
        Wallet::retrieve_wallet(wallet_id).sync(electrum_url)
    }

    pub fn descriptor(wallet_id: String) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).descriptor()
    }

    pub fn address(wallet_id: String) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).address()
    }

    pub fn balance(wallet_id: String) -> anyhow::Result<Balance, LwkError> {
        Wallet::retrieve_wallet(wallet_id).balance()
    }

    pub fn txs(wallet_id: String) -> anyhow::Result<Vec<Tx>, LwkError> {
        Wallet::retrieve_wallet(wallet_id).txs()
    }

    pub fn build_tx(
        wallet_id: String,
        sats: u64,
        out_address: String,
        abs_fee: f32,
    ) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).build_tx(sats, out_address, abs_fee)
    }

    pub fn decode_tx(
        wallet_id: String,
        pset: String,
    ) -> anyhow::Result<PsetAmounts, LwkError> {
        Wallet::retrieve_wallet(wallet_id).decode_tx(pset)
    }

    pub fn sign_tx(
        wallet_id: String,
        network: LiquidNetwork,
        pset: String,
        mnemonic: String,
    ) -> anyhow::Result<Vec<u8>, LwkError> {
        Wallet::retrieve_wallet(wallet_id).sign_tx(network, pset, mnemonic)
    }

    pub fn broadcast_tx(
        electrum_url: String,
        tx_bytes: Vec<u8>,
    ) -> anyhow::Result<String, LwkError> {
        let electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        let tx = Transaction::deserialize(&tx_bytes)?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }
}

#[cfg(test)]
mod test {
    use super::*;
    #[test]
    fn test_api() {
        let mnemonic = "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon".to_string();
        let network = LiquidNetwork::Testnet;
        //println!("DESC: {}", desc);

        // use lwk
        let electrum_url = "blockstream.info:465".to_string();
        let _electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url.clone(), false))
                .unwrap();
        let dbpath = "/tmp/lwk".to_string();
        let wallet = Api::new_wallet(mnemonic.clone(), network, dbpath).unwrap();

        Api::sync(wallet.clone(), electrum_url.clone()).unwrap();
        // let wollet: Wollet = Wollet::new(network.into(), Some(&dbpath), &desc).unwrap();
        let address = Api::address(wallet.clone()).unwrap();
        println!("ADDRESS: {:#?}", address);
        let pre_balance: Balance = Api::balance(wallet.clone()).unwrap();
        println!("BALANCE: {:#?}", pre_balance.lbtc);

        // build tx
        let sats = 10000;
        let out_address="tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu".to_string();
        let fee_rate = 300.0;
        let pset = Api::build_tx(wallet.clone(), sats, out_address, fee_rate).unwrap();
        let decoded = Api::decode_tx(wallet.clone(), pset.clone()).unwrap();
        println!("DECODED TX: {:#?}", decoded);
        // sign tx
        let tx = Api::sign_tx(wallet.clone(), network, pset, mnemonic).unwrap();
        // println!("RAW TX: {:#?}", tx);

        // broadcast tx
        let txid = Api::broadcast_tx(electrum_url.clone(), tx).unwrap();
        println!("SEND: TXID: {:#?}", txid);
        Api::sync(wallet.clone(), electrum_url.clone()).unwrap();
        let txs = Api::txs(wallet.clone()).unwrap();
        for tx in txs {
            if tx.txid == txid {
                let fees = tx.fee;
                let post_balance: Balance = Api::balance(wallet.clone()).unwrap();
                assert_eq!(
                    (post_balance.lbtc),
                    (pre_balance.lbtc - (sats as i64 + fees as i64))
                );
            }
        }
    }
}
