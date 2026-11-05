use std::str::FromStr;
use std::time::Duration;

use lwk_wollet::{
    blocking::BlockchainBackend,
    elements::{
        pset::{serialize::Deserialize, PartiallySignedTransaction},
        Transaction, Txid,
    },
    ElectrumClient, ElectrumClientBuilder,
};

use super::error::LwkError;

/// Connect to an Electrum server over TLS.
///
/// `host_port` has no scheme, e.g. `example.com:50002`. The certificate is
/// always validated against the domain name: `ElectrumClientBuilder` derives
/// that from the `ssl://` URL and offers no way to turn it off, so a TLS server
/// addressed by IP is rejected. `timeout` is in seconds.
pub(crate) fn tls_electrum_client(
    host_port: &str,
    timeout: Option<u8>,
) -> Result<ElectrumClient, LwkError> {
    let mut builder = ElectrumClientBuilder::new(&format!("ssl://{host_port}"));
    if let Some(timeout) = timeout {
        builder = builder.timeout(Duration::from_secs(timeout.into()));
    }
    Ok(builder.build()?)
}

pub struct Blockchain {}

impl Blockchain {
    /// Check that a TLS connection to the Electrum server can be opened.
    ///
    /// ⚠️ Like `Wallet.sync`, it always validates the certificate against the
    /// server's domain name, so a self-signed or IP-addressed server fails.
    pub fn test(&self, electrum_url: String) -> anyhow::Result<(), LwkError> {
        super::ensure_crypto_provider();
        tls_electrum_client(&electrum_url, None)?;
        Ok(())
    }
    /// Broadcast transaction bytes
    pub fn broadcast_tx_bytes(
        electrum_url: String,
        tx_bytes: Vec<u8>,
    ) -> anyhow::Result<String, LwkError> {
        super::ensure_crypto_provider();
        let electrum_client = tls_electrum_client(&electrum_url, None)?;
        let tx = Transaction::deserialize(&tx_bytes)?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }

    /// Broadcast a signed pset
    pub fn broadcast_signed_pset(
        electrum_url: String,
        signed_pset: String,
    ) -> anyhow::Result<String, LwkError> {
        super::ensure_crypto_provider();
        let electrum_client = tls_electrum_client(&electrum_url, None)?;
        let pset = PartiallySignedTransaction::from_str(&signed_pset)?;
        let tx = pset.extract_tx()?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn tls_to_an_ip_address_is_rejected() {
        // Rejected while parsing the URL, before any connection attempt.
        let err = tls_electrum_client("127.0.0.1:50002", None).unwrap_err();
        assert!(err.msg.contains("SslWithoutDomain"), "{}", err.msg);
    }
}
