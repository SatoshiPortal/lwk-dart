use elements::hex::ToHex;
use elements::pset::serialize::Serialize;
use elements::pset::PartiallySignedTransaction;
use lwk_common::Signer;
use lwk_signer::SwSigner;
use lwk_wollet::AddressResult;
use lwk_wollet::ElectrumClient;
use lwk_wollet::ElementsNetwork;
use lwk_wollet::Update;
use std::collections::HashMap;

use std::sync::{Mutex, MutexGuard};

use crate::types::{AssetIdMapInt, AssetIdMapUInt};
use crate::types::PsetAmounts;
use crate::types::{Balances, Tx};
use crate::types::Address;
use crate::{error::LwkError, network::Network};
use elements::AssetId;
use lwk_wollet::BlockchainBackend;
use lwk_wollet::{EncryptedFsPersister, Wollet, WolletDescriptor};
use std::str::FromStr;
//const TLBTC_ASSET_ID: &str = "144c654344aa716d6f3abcc1ca90e5641e4e2a7f633bc09fe3baf64585819a49";
use lazy_static::lazy_static;
use std::collections::hash_map::DefaultHasher;
// use std::collections::HashMap;
use std::hash::Hash;
use std::hash::Hasher;
use std::sync::Arc;
use std::sync::RwLock;

lazy_static! {
    static ref WALLET: RwLock<HashMap<String, Arc<Wallet>>> = RwLock::new(HashMap::new());
}

fn persist_wallet(id: String, wallet: Wallet) {
    let mut wallet_lock = WALLET.write().unwrap();
    wallet_lock.insert(id, Arc::new(wallet));
    return;
}
pub fn default_hasher<T>(obj: T) -> u64
where
    T: Hash,
{
    let mut hasher = DefaultHasher::new();
    obj.hash(&mut hasher);
    hasher.finish()
}
pub struct Wallet {
    pub inner: Mutex<Wollet>,
}

impl Wallet {
    pub fn retrieve_wallet(id: String) -> Arc<Wallet> {
        let wallet_lock = WALLET.read().unwrap();
        wallet_lock.get(id.as_str()).unwrap().clone()
    }

    pub fn new_descriptor(network: Network, mnemonic: &str) -> Result<String, LwkError> {
        let el_network: ElementsNetwork = network.into();
        let is_mainnet = el_network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str =
            lwk_common::singlesig_desc(&signer, script_variant, blinding_variant, is_mainnet)?;
        Ok(desc_str)
    }

    pub fn new(network: Network, dbpath: &str, desc_str: &str) -> Result<String, LwkError> {
        let descriptor = WolletDescriptor::from_str(&desc_str)?;
        let wollet = Wollet::new(
            network.into(),
            EncryptedFsPersister::new(dbpath, network.into(), &descriptor)?,
            &desc_str,
        )?;
        let wallet = Wallet {
            inner: Mutex::new(wollet),
        };
        let id = default_hasher(&descriptor.to_string()).to_hex();
        persist_wallet(id.clone(), wallet);
        Ok(id)
    }

    pub(crate) fn get_wollet(&self) -> MutexGuard<Wollet> {
        self.inner.lock().expect("wallet")
    }

    pub fn sync(&self, electrum_url: String) -> anyhow::Result<(), LwkError> {
        let mut electrum_client: ElectrumClient =
            ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        let update: Update =
            if let Some(value) = electrum_client.full_scan(&mut self.get_wollet())? {
                value
            } else {
                return Ok(());
            };
        let _ = self.get_wollet().apply_update(update)?;
        Ok(())
    }

    pub fn descriptor(&self) -> anyhow::Result<String, LwkError> {
        Ok(self.get_wollet().descriptor().to_string())
    }

    pub fn address_last_unused(&self) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wollet().address(None)?.into();
        Ok(address.into())
    }

    pub fn address(&self, index: u32) -> anyhow::Result<Address, LwkError> {
        let address: AddressResult = self.get_wollet().address(Some(index))?.into();
        Ok(address.into())
    }

    pub fn balances(&self) -> anyhow::Result<Balances, LwkError> {
        let balance= Balances::from(AssetIdMapUInt(self.get_wollet().balance()?));
        Ok(balance)
    }

    pub fn txs(&self) -> anyhow::Result<Vec<Tx>, LwkError> {
        let txs = self
            .get_wollet()
            .transactions()?
            .iter()
            .map(|x| Tx::from(x.to_owned()))
            .collect();
        Ok(txs)
    }

    pub fn build_tx(
        &self,
        sats: u64,
        out_address: String,
        abs_fee: f32,
    ) -> anyhow::Result<String, LwkError> {
        let pset: PartiallySignedTransaction =
            self.get_wollet()
                .send_lbtc(sats, &out_address, Some(abs_fee))?;
        Ok(pset.to_string())
    }

    pub fn decode_tx(&self, pset: String) -> anyhow::Result<PsetAmounts, LwkError> {
        let mut pset = PartiallySignedTransaction::from_str(&pset)?;
        let pset_details = self.get_wollet().get_details(&mut pset)?;
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
        let tx = self.get_wollet().finalize(&mut pset)?;
        Ok(tx.serialize())
    }
}
