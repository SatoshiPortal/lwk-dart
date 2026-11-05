//! Software signer built from a BIP39 seed rather than from English mnemonic words.
//!
//! `SwSigner::new` only parses English mnemonics and always derives the seed with an empty
//! passphrase. Taking the 64-byte BIP39 seed instead lets the caller support every BIP39
//! wordlist and a passphrase, and derive the same keys as the mnemonic path for an English
//! mnemonic without passphrase.

use std::ops::RangeInclusive;

use lwk_common::Signer;
use lwk_signer::{SignError, SwSigner};
use lwk_wollet::bitcoin::bip32::{self, DerivationPath, Xpriv, Xpub};
use lwk_wollet::bitcoin::sign_message::MessageSignature;
use lwk_wollet::bitcoin::Network;
use lwk_wollet::elements::pset::PartiallySignedTransaction;
use lwk_wollet::elements_miniscript::slip77::MasterBlindingKey;

/// Seed lengths accepted by BIP32, in bytes. A BIP39 seed is always 64 bytes.
pub const SEED_LENGTH: RangeInclusive<usize> = 16..=64;

/// Why a seed cannot back a signer.
#[derive(Debug, thiserror::Error)]
pub enum SeedError {
    #[error("seed is {0} bytes, BIP32 requires 16 to 64 bytes")]
    InvalidLength(usize),
    #[error("cannot derive a master key from the seed: {0}")]
    Bip32(#[from] bip32::Error),
}

/// A `SwSigner` built from an xprv, plus the SLIP77 master blinding key from the same seed.
///
/// `SwSigner::from_xprv` keeps no seed, so it cannot produce the SLIP77 key on its own.
pub struct SeedSigner {
    signer: SwSigner,
    master_blinding_key: MasterBlindingKey,
}

impl SeedSigner {
    /// Mirrors `SwSigner::new`: mainnet keys for Liquid, testnet keys otherwise.
    pub fn new(seed: &[u8], is_mainnet: bool) -> Result<Self, SeedError> {
        if !SEED_LENGTH.contains(&seed.len()) {
            return Err(SeedError::InvalidLength(seed.len()));
        }
        let network = if is_mainnet {
            Network::Bitcoin
        } else {
            Network::Testnet
        };
        let xprv = Xpriv::new_master(network, seed)?;
        Ok(Self {
            signer: SwSigner::from_xprv(xprv),
            master_blinding_key: MasterBlindingKey::from_seed(seed),
        })
    }
}

impl Signer for SeedSigner {
    type Error = SignError;

    fn sign(&self, pset: &mut PartiallySignedTransaction) -> Result<u32, Self::Error> {
        self.signer.sign(pset)
    }

    fn derive_xpub(&self, path: &DerivationPath) -> Result<Xpub, Self::Error> {
        self.signer.derive_xpub(path)
    }

    fn slip77_master_blinding_key(&self) -> Result<MasterBlindingKey, Self::Error> {
        Ok(self.master_blinding_key)
    }

    fn sign_message(
        &self,
        message: &str,
        path: &DerivationPath,
    ) -> Result<MessageSignature, Self::Error> {
        self.signer.sign_message(message, path)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn rejects_seeds_outside_the_bip32_length_range() {
        for len in [0, 15, 65, 128] {
            assert!(
                matches!(
                    SeedSigner::new(&vec![1u8; len], false),
                    Err(SeedError::InvalidLength(l)) if l == len
                ),
                "a {len}-byte seed must be refused"
            );
        }
        for len in [16, 32, 64] {
            assert!(SeedSigner::new(&vec![1u8; len], false).is_ok());
        }
    }

    #[test]
    fn derives_keys_for_the_requested_network() {
        let seed = [7u8; 64];
        assert!(SeedSigner::new(&seed, true).unwrap().is_mainnet().unwrap());
        assert!(!SeedSigner::new(&seed, false).unwrap().is_mainnet().unwrap());
    }
}
