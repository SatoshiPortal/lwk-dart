use crate::error::LwkError;
use crate::network::LiquidNetwork;
use crate::types::{Balance, DecodedTx, Tx, Wallet};
use elements::hashes::hash160::Hash;
use elements::hex::ToHex;
use elements::pset::serialize::{Deserialize, Serialize};
use elements::pset::PartiallySignedTransaction;
use elements::{Address, Txid};
use elements::{AssetId, Transaction};
use lwk_common::Signer;
use lwk_signer::{bip39::Mnemonic, SwSigner};
use lwk_wollet::{
    AddressResult, BlockchainBackend, ElectrumClient, ElementsNetwork, Update, Wollet,
};
use std::collections::HashMap;
use std::str::FromStr;
pub struct Api {}
trait RustApi {
    fn new_wallet(
        mnemonic: String,
        network: LiquidNetwork,
        electrum_url: String,
        db_path: String,
    ) -> anyhow::Result<Wallet, LwkError>;
    fn sync(electrum_url: String, wallet: Wallet) -> anyhow::Result<(), LwkError>;
    fn address(wallet: Wallet) -> anyhow::Result<String, LwkError>;
    fn balance(wallet: Wallet) -> anyhow::Result<Balance, LwkError>;
    fn txs(wallet: Wallet) -> anyhow::Result<Vec<Tx>, LwkError>;
    fn build_tx(
        wallet: Wallet,
        sats: u64,
        out_address: String,
        abs_fee: Option<f32>,
    ) -> anyhow::Result<String, LwkError>;
    fn decode_tx(pset: String) -> anyhow::Result<DecodedTx, LwkError>;
    fn sign_tx(wallet: Wallet, pset: String, mnemonic: String)
        -> anyhow::Result<Vec<u8>, LwkError>;
    fn broadcast_tx(electrum_url: String, tx_bytes: Vec<u8>) -> anyhow::Result<String, LwkError>;
}
impl RustApi for Api {
    fn new_wallet(
        mnemonic: String,
        network: LiquidNetwork,
        electrum_url: String,
        db_path: String,
    ) -> anyhow::Result<Wallet, LwkError> {
        let el_network: ElementsNetwork = network.into();
        let is_mainnet = el_network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str =
            lwk_common::singlesig_desc(&signer, script_variant, blinding_variant, is_mainnet)?
                .into();
        let _electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url.clone(), false))
                .unwrap();
        Ok(Wallet {
            dbpath: db_path.clone(),
            desc: desc_str,
            network: network,
        })
    }
    fn sync(electrum_url: String, wallet: Wallet) -> anyhow::Result<(), LwkError> {
        let mut electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        let mut wallet: Wollet = wallet.try_into()?;
        let update: Update = if let Some(value) = electrum_client.full_scan(&mut wallet)? {
            value
        } else {
            return Ok(());
        };
        let _ = wallet.apply_update(update)?;
        Ok(())
    }

    fn address(wallet: Wallet) -> anyhow::Result<String, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let address: AddressResult = wallet.address(None)?.into();
        Ok(address.address().to_string())
    }

    fn balance(wallet: Wallet) -> anyhow::Result<Balance, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let balance: HashMap<AssetId, u64> = wallet.balance()?.into();
        Ok(Balance::from(balance))
    }

    fn txs(wallet: Wallet) -> anyhow::Result<Vec<Tx>, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let txs = wallet
            .transactions()?
            .iter()
            .map(|x| Tx::from(x.to_owned()))
            .collect();
        Ok(txs)
    }

    fn build_tx(
        wallet: Wallet,
        sats: u64,
        out_address: String,
        abs_fee: Option<f32>,
    ) -> anyhow::Result<String, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let pset: PartiallySignedTransaction = wallet.send_lbtc(sats, &out_address, abs_fee)?;
        Ok(pset.to_string())
    }

    fn decode_tx(pset: String) -> anyhow::Result<DecodedTx, LwkError> {
        let pset = PartiallySignedTransaction::from_str(&pset)?;
        let outputs = pset.extract_tx().unwrap().output;
        let inputs = pset.extract_tx().unwrap().input;
        let mut out_map = HashMap::new();
        for output in outputs {
            let value = output.value.explicit().unwrap_or(0);
            let script_pubkey = output.script_pubkey.to_string();
            out_map.insert(script_pubkey, value);
        }
        Ok(DecodedTx { outputs: out_map })
    }

    fn sign_tx(
        wallet: Wallet,
        pset: String,
        mnemonic: String,
    ) -> anyhow::Result<Vec<u8>, LwkError> {
        let network = wallet.network;
        let wallet: Wollet = wallet.try_into()?;
        let is_mainnet = network == LiquidNetwork::Testnet;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?;
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;
        let _ = signer.sign(&mut pset);
        let tx = wallet.finalize(&mut pset)?;
        Ok(tx.serialize())
    }

    fn broadcast_tx(electrum_url: String, tx_bytes: Vec<u8>) -> anyhow::Result<String, LwkError> {
        let electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        let tx = Transaction::deserialize(&tx_bytes)?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }
}

#[cfg(test)]
mod tests {
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
        let wallet =
            Api::new_wallet(mnemonic.clone(), network, electrum_url.clone(), dbpath).unwrap();

        Api::sync(electrum_url.clone(), wallet.clone()).unwrap();
        // let wollet: Wollet = Wollet::new(network.into(), Some(&dbpath), &desc).unwrap();
        let address = Api::address(wallet.clone()).unwrap();
        println!("ADDRESS: {:#?}", address);
        let pre_balance: Balance = Api::balance(wallet.clone()).unwrap();
        println!("BALANCE: {:#?}", pre_balance.lbtc);

        // build tx
        let sats = 10000;
        let out_address="tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu".to_string();
        let abs_fee = 300.0;
        let pset = Api::build_tx(wallet.clone(), sats, out_address, Some(abs_fee)).unwrap();

        // println!("PSET: {:#?}", pset);

        // sign tx
        let tx = Api::sign_tx(wallet.clone(), pset, mnemonic).unwrap();
        // println!("RAW TX: {:#?}", tx);

        // broadcast tx
        let txid = Api::broadcast_tx(electrum_url.clone(), tx).unwrap();
        println!("SEND: TXID: {:#?}", txid);
        Api::sync(electrum_url.clone(), wallet.clone()).unwrap();
        let txs = Api::txs(wallet.clone()).unwrap();
        for tx in txs {
            if tx.txid == txid {
                let fees = tx.fee;
                let post_balance: Balance = Api::balance(wallet.clone()).unwrap();
                assert_eq!((post_balance.lbtc), (pre_balance.lbtc - (sats + fees)));
            }
        }
    }
}
