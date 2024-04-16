
use std::str::FromStr;

pub use crate::error::LwkError;
pub use crate::network::Network;
use crate::types::{Address, Balances};
pub use crate::types::{PsetAmounts, Tx};
pub use crate::wallet::Wallet;
use elements::hex::FromHex;
use elements::pset::serialize::Deserialize;
// use elements::{ Transaction};
use elements::{secp256k1_zkp, Address as LwkAddress, AddressParams, Transaction, Script};

use elements::Txid;
use lwk_wollet::{BlockchainBackend, ElectrumClient};
pub struct Api {}

impl Api {
    pub fn new_descriptor(
        network: Network,
        mnemonic: String,
    ) -> anyhow::Result<String, LwkError> {
        Ok(Wallet::new_descriptor(network, &mnemonic)?.into())
    }

    pub fn blinding_key(wallet_id: String) -> anyhow::Result<String, LwkError> {
        Ok(Wallet::retrieve_wallet(wallet_id).get_wollet().descriptor().key.to_string())
    }

    pub fn new_wallet(
        network: Network,
        db_path: String,
        descriptor: String,
    ) -> anyhow::Result<String, LwkError> {
        Ok(Wallet::new(network, &db_path, &descriptor)?.into())
    }

    pub fn sync(wallet_id: String, electrum_url: String) -> anyhow::Result<(), LwkError> {
        Wallet::retrieve_wallet(wallet_id).sync(electrum_url)
    }

    pub fn wallet_descriptor(wallet_id: String) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).descriptor()
    }

    pub fn address_last_unused(wallet_id: String) -> anyhow::Result<Address, LwkError> {
        Wallet::retrieve_wallet(wallet_id).address_last_unused()
    }

    pub fn address(wallet_id: String, index: u32) -> anyhow::Result<Address, LwkError> {
        Wallet::retrieve_wallet(wallet_id).address(index)
    }

    pub fn validate_address(address_string: String) -> anyhow::Result<(), LwkError> {
        LwkAddress::from_str(&address_string)?;
        Ok(())
    }

    pub fn address_from_script(network: Network, script: String, blinding_key: String) -> anyhow::Result<Address, LwkError> {
        let blinding_key = if blinding_key == "".to_string() {
            None
        } else {
            let pubkey = match secp256k1_zkp::PublicKey::from_str(&blinding_key){
                Ok(result)=> result,
                Err(e)=>return Err(LwkError { msg: e.to_string() }),
            };
            Some(pubkey)
        };
        let script_pubkey = match Script::from_hex(&script) {
            Ok(result)=> result,
            Err(e)=> return Err(LwkError { msg: e.to_string() }),
        };

        let address = LwkAddress::from_script(
            &script_pubkey,
            blinding_key,
            match network {
                Network::Mainnet=>&AddressParams::LIQUID,
                Network::Testnet=>&AddressParams::LIQUID_TESTNET
            },
        );
        if address.is_none(){
            Err(LwkError { msg: "Could not convert script to address".to_string() })
        }
        else{
   
        Ok(Address {
            standard: address.clone().unwrap().to_unconfidential().to_string(),
            confidential: address.unwrap().to_string(),
            index: 0
        })
    }
    }

    pub fn balance(wallet_id: String) -> anyhow::Result<Balances, LwkError> {
        Wallet::retrieve_wallet(wallet_id).balances()
    }

    pub fn txs(wallet_id: String) -> anyhow::Result<Vec<Tx>, LwkError> {
        Wallet::retrieve_wallet(wallet_id).txs()
    }

    pub fn build_lbtc_tx(
        wallet_id: String,
        sats: u64,
        out_address: String,
        abs_fee: f32,
    ) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).build_lbtc_tx(sats, out_address, abs_fee)
    }

    pub fn build_asset_tx(
        wallet_id: String,
        sats: u64,
        out_address: String,
        abs_fee: f32,
        asset_id: String
    ) -> anyhow::Result<String, LwkError> {
        Wallet::retrieve_wallet(wallet_id).build_asset_tx(sats, out_address, abs_fee, asset_id)
    }

    pub fn decode_tx(wallet_id: String, pset: String) -> anyhow::Result<PsetAmounts, LwkError> {
        Wallet::retrieve_wallet(wallet_id).decode_tx(pset)
    }

    pub fn sign_tx(
        wallet_id: String,
        network: Network,
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
        let network = Network::Testnet;
        //println!("DESC: {}", desc);

        // use lwk
        let electrum_url = "blockstream.info:465".to_string();
        let _electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url.clone(), false))
                .unwrap();
        let dbpath = "/tmp/lwk".to_string();
        let desc = Api::new_descriptor(network,mnemonic.clone()).unwrap();
        let wallet_id = Api::new_wallet(network, dbpath, desc.clone()).unwrap();
        Api::sync(wallet_id.clone(), electrum_url.clone()).unwrap();
        let address = Api::address_last_unused(wallet_id.clone()).unwrap();
        println!("ADDRESS: {:#?}", address);
        let pre_balance: Balances = Api::balance(wallet_id.clone()).unwrap();
        println!("BALANCES: {:#?}", pre_balance);
        let txs_test = Api::txs(wallet_id.clone()).unwrap();
        println!("Total Txs: {}", txs_test.len());
        for tx in txs_test {
            println!("type: {:?}", tx.kind);
            // for output in tx.outputs {
            //     // let amount = output.clone().unblinded.value;
            //     // let address = Api::address_from_script(Network::Testnet, output.clone().script_pubkey,"".to_string()).unwrap();            
            //     // println!("amount:{:?},address:{:?}", amount, address.standard);
            // }
        }
        // build tx
        let sats = 11349;
        let out_address="tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu".to_string();
        let fee_rate = 300.0;
        let pset = Api::build_lbtc_tx(wallet_id.clone(), sats, out_address, fee_rate).unwrap();
        let decoded = Api::decode_tx(wallet_id.clone(), pset.clone()).unwrap();
        // println!("DECODED TX: {:#?}", decoded);
        //sign tx
        // let tx = Api::sign_tx(wallet_id.clone(), network, pset, mnemonic).unwrap();
        // println!("RAW TX: {:#?}", tx);

        //broadcast tx
        // let txid = Api::broadcast_tx(electrum_url.clone(), tx).unwrap();
        // println!("SEND: TXID: {:#?}", txid);

    }
}
