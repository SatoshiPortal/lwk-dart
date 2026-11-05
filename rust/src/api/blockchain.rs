use std::str::FromStr;

use lwk_wollet::{
    blocking::BlockchainBackend,
    elements::{
        pset::{serialize::Deserialize, PartiallySignedTransaction},
        Transaction, Txid,
    },
    ElectrumClient, ElectrumUrl,
};

use super::error::LwkError;
use super::types::LiquidNetwork;

/// The Electrum endpoint for `electrum_url` on `network`.
///
/// An `ssl://` or `tcp://` prefix is stripped. Plaintext is allowed only on regtest, and only
/// when asked for with `tcp://`, since a local node such as Nigiri serves Electrum without TLS.
/// Mainnet and testnet always connect over TLS, even for a `tcp://` URL: a plaintext connection
/// would let the network observe and tamper with the wallet's queries and broadcasts.
pub(crate) fn electrum_url(
    network: LiquidNetwork,
    electrum_url: &str,
    validate_domain: bool,
) -> ElectrumUrl {
    if network == LiquidNetwork::Regtest {
        if let Some(host_port) = electrum_url.strip_prefix("tcp://") {
            return ElectrumUrl::Plaintext(host_port.to_string());
        }
    }
    let host_port = electrum_url
        .strip_prefix("ssl://")
        .or_else(|| electrum_url.strip_prefix("tcp://"))
        .unwrap_or(electrum_url);
    ElectrumUrl::Tls(host_port.to_string(), validate_domain)
}

pub struct Blockchain {}

impl Blockchain {
    /// Check that an Electrum server is reachable, without validating its TLS domain.
    ///
    /// The connection uses TLS, except for a `tcp://` URL on regtest.
    pub fn test(
        &self,
        network: LiquidNetwork,
        electrum_url: String,
    ) -> anyhow::Result<(), LwkError> {
        super::ensure_crypto_provider();
        ElectrumClient::new(&self::electrum_url(network, &electrum_url, false))?;
        Ok(())
    }

    /// Broadcast transaction bytes
    ///
    /// The connection uses TLS with domain validation, except for a `tcp://` URL on regtest.
    pub fn broadcast_tx_bytes(
        network: LiquidNetwork,
        electrum_url: String,
        tx_bytes: Vec<u8>,
    ) -> anyhow::Result<String, LwkError> {
        super::ensure_crypto_provider();
        let electrum_client: ElectrumClient =
            ElectrumClient::new(&self::electrum_url(network, &electrum_url, true))?;
        let tx = Transaction::deserialize(&tx_bytes)?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }

    /// Broadcast a signed pset
    ///
    /// The connection uses TLS with domain validation, except for a `tcp://` URL on regtest.
    pub fn broadcast_signed_pset(
        network: LiquidNetwork,
        electrum_url: String,
        signed_pset: String,
    ) -> anyhow::Result<String, LwkError> {
        super::ensure_crypto_provider();
        let electrum_client: ElectrumClient =
            ElectrumClient::new(&self::electrum_url(network, &electrum_url, true))?;
        let pset = PartiallySignedTransaction::from_str(&signed_pset)?;
        let tx = pset.extract_tx()?;
        let txid: Txid = electrum_client.broadcast(&tx)?;
        Ok(txid.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const HOST: &str = "example.com:50002";

    #[test]
    fn plaintext_only_for_a_tcp_url_on_regtest() {
        let url = |network, scheme: &str, validate_domain| {
            electrum_url(network, &format!("{scheme}{HOST}"), validate_domain)
        };
        for validate_domain in [true, false] {
            assert_eq!(
                url(LiquidNetwork::Regtest, "tcp://", validate_domain),
                ElectrumUrl::Plaintext(HOST.to_string())
            );
            for scheme in ["ssl://", ""] {
                assert_eq!(
                    url(LiquidNetwork::Regtest, scheme, validate_domain),
                    ElectrumUrl::Tls(HOST.to_string(), validate_domain),
                    "regtest {scheme:?}"
                );
            }
            for network in [LiquidNetwork::Mainnet, LiquidNetwork::Testnet] {
                for scheme in ["tcp://", "ssl://", ""] {
                    assert_eq!(
                        url(network, scheme, validate_domain),
                        ElectrumUrl::Tls(HOST.to_string(), validate_domain),
                        "{network:?} {scheme:?} must keep TLS"
                    );
                }
            }
        }
    }
}
