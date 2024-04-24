use elements::pset::serialize::Deserialize;
use elements::pset::serialize::Serialize;
use elements::pset::PartiallySignedTransaction;
use elements::{OutPoint, Transaction};
use elements::Txid;
use lwk_common::Signer;
use lwk_signer::SwSigner;
// use lwk_wollet::elements_miniscript::descriptor;
use lwk_wollet::AddressResult;
use lwk_wollet::ElectrumClient;
use lwk_wollet::FsPersister;
use lwk_wollet::Update;
use lwk_wollet::WolletDescriptor;

pub use std::sync::Mutex;
use std::sync::MutexGuard;

use crate::frb_generated::RustOpaque;

use lwk_wollet::BlockchainBackend;
use lwk_wollet::Wollet;
use std::str::FromStr;

use super::descriptor::Descriptor;
use super::error::LwkError;
use super::types::Address;
use super::types::AssetIdMapUInt;
use super::types::Balances;
use super::types::Network;
use super::types::PsetAmounts;
use super::types::Tx;
use super::types::TxOut;

pub struct Wallet {
    pub inner: RustOpaque<Mutex<lwk_wollet::Wollet>>,
}

impl Wallet {
    fn get_wallet(&self) -> Result<MutexGuard<lwk_wollet::Wollet>, LwkError> {
        {
            match self.inner.lock() {
                Ok(result) => Ok(result),
                Err(_) => Err(LwkError {
                    msg: "Could not aquire lock on wallet".to_string(),
                }),
            }
        }
    }

    pub fn init(
        network: Network,
        dbpath: String,
        descriptor: Descriptor,
        // electrum_url: String,
    ) -> anyhow::Result<Wallet, LwkError> {
        let desc_str = descriptor.ct_descriptor;
        let descriptor = WolletDescriptor::from_str(&desc_str)?;
        // let db = FsPersister::new(dbpath.clone(), network.into(), &descriptor)?;
        let wollet = Wollet::with_fs_persist(network.into(), descriptor, dbpath.clone())?;
        let opaque = RustOpaque::new(Mutex::new(wollet));
        let wallet = Wallet { inner: opaque };
        // wallet.sync(electrum_url)?;
        Ok(wallet)
    }
    pub fn sync(&self, electrum_url: String) -> anyhow::Result<(), LwkError> {
        let mut electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        println!("---rust---Locking Wallet");

        let mut wallet = self.get_wallet()?;
        println!("---rust---Wallet Locked");
        println!("---rust---Syncing Wallet");

        let update: Update = if let Some(value) = electrum_client.full_scan(&mut wallet)? {
            println!("---rust---Has Update");
            value
        } else {
            println!("---rust---No Update");
            return Ok(());
        };
        println!("---rust---Wallet Synced");
        println!("---rust---Updateing Wallet");
        let _ = wallet.apply_update(update)?;
        println!("---rust---Wallet Updated");
        Ok(())
    }

    pub fn descriptor(&self) -> anyhow::Result<String, LwkError> {
        Ok(self.get_wallet()?.descriptor().to_string())
    }

    pub fn blinding_key(&self) -> anyhow::Result<String, LwkError> {
        Ok(self.get_wallet()?.descriptor().key.to_string())
    }

    pub fn address_last_unused(&self) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wallet()?.address(None)?.into();
        Ok(address.into())
    }

    pub fn address(&self, index: u32) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wallet()?.address(Some(index))?.into();
        Ok(address.into())
    }

    pub fn balances(&self) -> anyhow::Result<Balances, LwkError> {
        let balance = Balances::from(AssetIdMapUInt(self.get_wallet()?.balance()?));
        Ok(balance)
    }

    pub fn txs(&self) -> anyhow::Result<Vec<Tx>, LwkError> {
        let txs = self
            .get_wallet()?
            .transactions()?
            .iter()
            .map(|x| Tx::from(x.to_owned()))
            .collect();
        Ok(txs)
    }

    pub fn build_lbtc_tx(
        &self,
        sats: u64,
        out_address: String,
        fee_rate: f32,
    ) -> anyhow::Result<String, LwkError> {
        let wallet = self.get_wallet()?;
        let tx_builder = wallet.tx_builder();
        let address = elements::Address::from_str(&out_address)?;
        let pset = tx_builder
            .add_lbtc_recipient(&address, sats)?
            .fee_rate(Some(fee_rate))
            .finish()?;
        Ok(pset.to_string())
    }

    pub fn build_asset_tx(
        &self,
        sats: u64,
        out_address: String,
        fee_rate: f32,
        asset: String,
    ) -> anyhow::Result<String, LwkError> {
        let wallet = self.get_wallet()?;
        let tx_builder = wallet.tx_builder();
        let address = elements::Address::from_str(&out_address)?;
        let asset = elements::AssetId::from_str(&asset)?;
        let pset = tx_builder
            .add_recipient(&address, sats, asset)?
            .fee_rate(Some(fee_rate))
            .finish()?;
        Ok(pset.to_string())
    }

    pub fn decode_tx(&self, pset: String) -> anyhow::Result<PsetAmounts, LwkError> {
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;
        let pset_details = self.get_wallet()?.get_details(&mut pset)?;
        Ok(PsetAmounts::from(pset_details.balance))
    }

    pub fn sign_tx(
        &self,
        network: Network,
        pset: String,
        mnemonic: String,
    ) -> anyhow::Result<Vec<u8>, LwkError> {
        let is_mainnet = network == Network::Testnet;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?;
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;
        let _ = signer.sign(&mut pset);
        let tx = self.get_wallet()?.finalize(&mut pset)?;
        Ok(tx.serialize())
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

    pub fn utxos(&self) -> anyhow::Result<Vec<TxOut>, LwkError> {
        let wallet_tx_outs = self.get_wallet()?.utxos()?;
        let tx_outs = wallet_tx_outs.into_iter().map(TxOut::from).collect();
        Ok(tx_outs)
    }

    fn get_txout(&self, outpoint: &OutPoint) -> Result<elements::TxOut, LwkError> {
        let wallet_transaction = self.get_wallet()?.transaction(&outpoint.txid)?;
        let transaction = wallet_transaction.ok_or(LwkError {
            msg: "Wallet transaction not found".to_string(),
        })?;
        let txout = transaction
            .tx
            .output
            .get(outpoint.vout as usize)
            .ok_or(LwkError {
                msg: "Could not find txout".to_string(),
            })?;
        Ok(txout.clone())
    }

    pub fn signed_pset_with_extra_details(
        &self,
        network: Network,
        pset: String,
        mnemonic: String,
    ) -> anyhow::Result<String, LwkError> {
        let is_mainnet = network == Network::Testnet;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?;
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;

        for input in pset.inputs_mut().iter_mut() {
            let res = self.get_txout(&elements::OutPoint {
                txid: input.previous_txid,
                vout: input.previous_output_index,
            });
            if let Ok(mut txout) = res {
                input.in_utxo_rangeproof = txout.witness.rangeproof.take();
                input.witness_utxo = Some(txout);
            }
        }
        self.get_wallet()?.add_details(&mut pset)?;
        let _ = signer.sign(&mut pset);
        Ok(pset.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn testable_wallets() {
        let mnemonic =
            "fossil install fever ticket wisdom outer broken aspect lucky still flavor dial";
        let electrum_url = "blockstream.info:465".to_string();
        let desc = Descriptor::new_confidential(Network::Testnet, mnemonic.to_string()).expect("");
        let wallet = Wallet::init(Network::Testnet, "/tmp/lwk".to_string(), desc).expect("");
        let _ = wallet.sync(electrum_url);
        let _txs = wallet.txs();
        let balances = wallet.balances();
        let address = wallet.address_last_unused();
        println!("{:#?}", address);
        println!("{:#?}", balances);
    }
}
