use elements::pset::serialize::Deserialize;
use elements::pset::serialize::Serialize;
use elements::pset::PartiallySignedTransaction;
use elements::Transaction;
use elements::Txid;
use flutter_rust_bridge::frb;
use lwk_common::Signer;
use lwk_signer::SwSigner;
// use lwk_wollet::elements_miniscript::descriptor;
use lwk_wollet::AddressResult;
use lwk_wollet::ElectrumClient;
use lwk_wollet::EncryptedFsPersister;
use lwk_wollet::Update;
use lwk_wollet::WolletDescriptor;

pub use std::sync::Mutex;
use std::sync::MutexGuard;

use crate::frb_generated::RustOpaque;

use lwk_wollet::BlockchainBackend;
use lwk_wollet::Wollet;
use std::str::FromStr;

use super::descriptor::DescriptorBase;
use super::error::LwkError;
use super::types::Address;
use super::types::AssetIdMapUInt;
use super::types::Balances;
use super::types::Network;
use super::types::PsetAmounts;
use super::types::Tx;
use super::types::TxOut;

pub struct Wallet {
    pub ptr: RustOpaque<Mutex<lwk_wollet::Wollet>>,
}

impl Wallet {
    fn get_wallet(&self) -> MutexGuard<lwk_wollet::Wollet> {
        self.ptr.lock().expect("")
    }

    #[frb(sync)]
    pub fn new(
        network: Network,
        dbpath: String,
        descriptor: DescriptorBase,
    ) -> Result<Self, LwkError> {
        let desc_str = descriptor.ct_descriptor;
        let descriptor = WolletDescriptor::from_str(&desc_str)?;
        let wollet = Wollet::new(
            network.into(),
            EncryptedFsPersister::new(dbpath, network.into(), &descriptor)?,
            &descriptor.clone().to_string(),
        )?;
        Ok(Wallet {
            ptr: RustOpaque::new(Mutex::new(wollet)),
        })
    }

    pub fn sync(&self, electrum_url: String) -> anyhow::Result<(), LwkError> {
        let mut electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        let update: Update =
            if let Some(value) = electrum_client.full_scan(&mut self.get_wallet())? {
                value
            } else {
                return Ok(());
            };
        let _ = self.get_wallet().apply_update(update)?;
        Ok(())
    }

    pub fn descriptor(&self) -> anyhow::Result<String, LwkError> {
        Ok(self.get_wallet().descriptor().to_string())
    }

    pub fn blinding_key(&self) -> anyhow::Result<String, LwkError> {
        Ok(self
            .get_wallet()
            .descriptor()
            .key
            .to_string())
    }

    pub fn address_last_unused(&self) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wallet().address(None)?.into();
        Ok(address.into())
    }

    pub fn address(&self, index: u32) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wallet().address(Some(index))?.into();
        Ok(address.into())
    }

    pub fn balances(&self) -> anyhow::Result<Balances, LwkError> {
        let balance = Balances::from(AssetIdMapUInt(self.get_wallet().balance()?));
        Ok(balance)
    }

    pub fn txs(&self) -> anyhow::Result<Vec<Tx>, LwkError> {
        let txs = self
            .get_wallet()
            .transactions()?
            .iter()
            .map(|x| Tx::from(x.to_owned()))
            .collect();
        Ok(txs)
    }

    pub fn utxos(&self) -> anyhow::Result<Vec<TxOut>, LwkError> {
        let wallet_tx_outs = self.get_wallet().utxos()?;
        let tx_outs = wallet_tx_outs.into_iter().map(TxOut::from).collect();
        Ok(tx_outs)
    }

    pub fn build_lbtc_tx(
        &self,
        sats: u64,
        out_address: String,
        abs_fee: f32,
    ) -> anyhow::Result<String, LwkError> {
        let pset: PartiallySignedTransaction =
            self.get_wallet()
                .send_lbtc(sats, &out_address, Some(abs_fee))?;
        Ok(pset.to_string())
    }

    pub fn build_asset_tx(
        &self,
        sats: u64,
        out_address: String,
        abs_fee: f32,
        asset: String,
    ) -> anyhow::Result<String, LwkError> {
        let pset: PartiallySignedTransaction =
            self.get_wallet()
                .send_asset(sats, &out_address, &asset, Some(abs_fee))?;
        Ok(pset.to_string())
    }

    pub fn decode_tx(&self, pset: String) -> anyhow::Result<PsetAmounts, LwkError> {
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;
        let pset_details = self.get_wallet().get_details(&mut pset)?;
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
        let tx = self.get_wallet().finalize(&mut pset)?;
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
}
