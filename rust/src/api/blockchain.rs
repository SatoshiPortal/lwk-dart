use std::str::FromStr;

use lwk_wollet::{blocking::BlockchainBackend, elements::{pset::{serialize::Deserialize, PartiallySignedTransaction}, Transaction, Txid}, ElectrumClient};

use super::error::LwkError;


pub struct Blockchain {}

impl Blockchain {
    pub fn test(&self, electrum_url: String) -> anyhow::Result<(), LwkError> {
        ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, false))?;
        Ok(())
    }
}
/// Broadcast transaction bytes
pub fn broadcast_tx_bytes(
    electrum_url: String,
    tx_bytes: Vec<u8>,
) -> anyhow::Result<String, LwkError> {
    let electrum_client: ElectrumClient =
        ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, true))?;
    let tx = Transaction::deserialize(&tx_bytes)?;
    let txid: Txid = electrum_client.broadcast(&tx)?;
    Ok(txid.to_string())
}


/// Broadcast a signed pset
pub fn broadcast_signed_pset(
    electrum_url: String,
    signed_pset: String,
) -> anyhow::Result<String, LwkError> {
    let electrum_client: ElectrumClient =
        ElectrumClient::new(&lwk_wollet::ElectrumUrl::Tls(electrum_url, true))?;
    let pset = PartiallySignedTransaction::from_str(&signed_pset)?;
    let tx = pset.extract_tx()?;
    let txid: Txid = electrum_client.broadcast(&tx)?;
    Ok(txid.to_string())
}
