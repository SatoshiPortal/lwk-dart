use crate::error::LwkError;
use crate::network::LiquidNetwork;
use crate::types::{Balance, Tx, Wallet};
use elements::hex::ToHex;
use elements::AssetId;
use lwk_signer::{bip39::Mnemonic, SwSigner};
use lwk_wollet::{
    AddressResult, BlockchainBackend, ElectrumClient, ElementsNetwork, Update, Wollet,
};
use std::collections::HashMap;
use std::str::FromStr;
pub struct Api {}

impl Api {
    pub fn create_descriptor(
        mnemonic: String,
        network: LiquidNetwork,
    ) -> anyhow::Result<String, LwkError> {
        let network: ElementsNetwork = network.into();
        let is_mainnet = network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str =
            lwk_common::singlesig_desc(&signer, script_variant, blinding_variant, is_mainnet)?
                .into();

        Ok(desc_str)
    }
    pub fn sync(electrum_url: String, wallet: Wallet) -> anyhow::Result<(), LwkError> {
        let mut electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false)).unwrap();
        let mut wallet: Wollet = wallet.try_into()?;
        let update: Update = if let Some(value) = electrum_client.full_scan(&mut wallet).unwrap() {
            value
        } else {
            return Ok(());
        };
        let _ = wallet.apply_update(update).unwrap();
        Ok(())
    }

    pub fn address(wallet: Wallet) -> anyhow::Result<String, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let address: AddressResult = wallet.address(None)?.into();
        Ok(address.address().to_string())
    }

    pub fn balance(wallet: Wallet) -> anyhow::Result<Balance, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let balance: HashMap<AssetId, u64> = wallet.balance()?.into();
        Ok(Balance::from(balance))
    }

    pub fn txs(wallet: Wallet) -> anyhow::Result<Vec<Tx>, LwkError> {
        let wallet: Wollet = wallet.try_into()?;
        let txs = wallet
            .transactions()?
            .iter()
            .map(|x| Tx::from(x.to_owned()))
            .collect();
        Ok(txs)
    }

    // pub fn build_tx(wallet:Wallet)

    //pub fn sign tx

    //pub fn broadcast tx
}

#[cfg(test)]
mod tests {
    use std::str::FromStr;

    use super::*;
    use elements::{pset::PartiallySignedTransaction, AssetId, Txid};
    use lwk_common::Signer;
    use lwk_wollet::BlockchainBackend;
    use lwk_wollet::{ElectrumClient, Update, WalletTx};
    // use crate::{wollet::Wollet, Address, ElectrumClient, Mnemonic, Network, Signer, Txid};

    #[test]
    fn test_api() {
        let mnemonic = "bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon bacon".to_string();
        let network = LiquidNetwork::Testnet;
        let desc = Api::create_descriptor(mnemonic.clone(), network).unwrap();
        println!("{}", desc);

        // use lwk
        let electrum_url = "blockstream.info:465".to_string();
        let _electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url.clone(), false))
                .unwrap();
        let dbpath = "/tmp/lwk".to_string();
        let wallet = Wallet {
            dbpath: dbpath.clone(),
            desc: desc.clone(),
            network,
        };
        Api::sync(electrum_url, wallet.clone()).unwrap();
        // let wollet: Wollet = Wollet::new(network.into(), Some(&dbpath), &desc).unwrap();
        let address = Api::address(wallet.clone()).unwrap();
        println!("ADDRESS: {:#?}", address);
        let balance: Balance = Api::balance(wallet.clone()).unwrap();
        println!("BALANCE: {:#?}", balance.lbtc);

        let txs = Api::txs(wallet.clone()).unwrap();
        // println!("HISTORY: {:?}", txs);
        println!("{:#?}", txs);

        let send_address="tlq1qqt4hjkl6sug5ld89sdaekt7ew04va8w7c63adw07l33vcx86vpj5th3w7rkdnckmfpraufnnrfcep4thqt6024phuav99djeu";

        // build tx
        let mut pset: PartiallySignedTransaction =
            wollet.send_lbtc(10000, send_address, Some(300.0)).unwrap();
        // sign tx
        let is_mainnet = network == LiquidNetwork::Testnet;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet).unwrap();
        let numsigs = signer.sign(&mut pset).unwrap();
        assert!(numsigs > 0);
        // finalize tx
        let _ = wollet.finalize(&mut pset);
        // broadcast tx
        let txid: Txid = _electrum_client
            .broadcast(&pset.extract_tx().unwrap())
            .unwrap();

        println!("SEND: TXID: {:#?}", txid);
    }
}
