use lwk_common::Signer;
use lwk_signer::SwSigner;
use zeroize::Zeroizing;

use crate::signer::SeedSigner;

// use crate::frb_generated::RustOpaque;

use super::{error::LwkError, types::LiquidNetwork};

/// Wallet descriptor class used to create a new wallet
#[derive(Debug)]
pub struct Descriptor {
    pub ct_descriptor: String,
}
impl Descriptor {
    /// Createa new wpkh confidential descriptor based on Slip77 blinding key derivation
    pub fn new_confidential(network: LiquidNetwork, mnemonic: String) -> Result<Descriptor, LwkError> {
        let mnemonic = Zeroizing::new(mnemonic);
        let signer: SwSigner = SwSigner::new(&mnemonic, network.is_mainnet())?.into();
        Self::from_signer(&signer)
    }

    /// Create a new wpkh confidential descriptor based on Slip77 blinding key derivation,
    /// from a BIP39 seed (16 to 64 bytes) instead of English mnemonic words.
    ///
    /// The seed encodes the mnemonic language and passphrase, which `new_confidential` cannot
    /// carry. An English mnemonic without passphrase gives the same descriptor through both.
    pub fn new_confidential_from_seed(
        network: LiquidNetwork,
        seed: Vec<u8>,
    ) -> Result<Descriptor, LwkError> {
        let seed = Zeroizing::new(seed);
        let signer = SeedSigner::new(&seed, network.is_mainnet())?;
        Self::from_signer(&signer)
    }

    fn from_signer<S: Signer>(signer: &S) -> Result<Descriptor, LwkError> {
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str = lwk_common::singlesig_desc(signer, script_variant, blinding_variant)?;
        Ok(Descriptor {
            ct_descriptor: desc_str.to_string(),
        })
    }
}

#[cfg(test)]
mod tests {
    use bip39::{Language, Mnemonic};

    use super::*;

    const ABANDON_MNEMONIC: &str = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";

    fn seed(language: Language, entropy: &[u8], passphrase: &str) -> Vec<u8> {
        Mnemonic::from_entropy_in(language, entropy)
            .unwrap()
            .to_seed(passphrase)
            .to_vec()
    }

    #[test]
    fn seed_of_an_english_mnemonic_gives_the_mnemonic_descriptor() {
        let english = seed(Language::English, &[0u8; 16], "");
        for network in [LiquidNetwork::Mainnet, LiquidNetwork::Testnet] {
            let from_mnemonic =
                Descriptor::new_confidential(network, ABANDON_MNEMONIC.to_owned()).unwrap();
            let from_seed =
                Descriptor::new_confidential_from_seed(network, english.clone()).unwrap();
            assert_eq!(from_seed.ct_descriptor, from_mnemonic.ct_descriptor);
        }
    }

    #[test]
    fn passphrase_changes_the_descriptor() {
        let network = LiquidNetwork::Mainnet;
        // BIP39 reference vector: entropy 00..00, passphrase "TREZOR".
        let with_passphrase = seed(Language::English, &[0u8; 16], "TREZOR");
        assert_eq!(
            hex::encode(&with_passphrase),
            "c55257c360c07c72029aebc1b53c05ed0362ada38ead3e3e9efa3708e53495531f09a6987599d18264c1e1c92f2cf141630c7a3c4ab7c81b2f001698e7463b04"
        );
        let from_passphrase =
            Descriptor::new_confidential_from_seed(network, with_passphrase).unwrap();
        let from_mnemonic =
            Descriptor::new_confidential(network, ABANDON_MNEMONIC.to_owned()).unwrap();
        assert_ne!(from_passphrase.ct_descriptor, from_mnemonic.ct_descriptor);
    }

    #[test]
    fn japanese_mnemonic_is_supported_through_its_seed() {
        let network = LiquidNetwork::Mainnet;
        // First vector of the Japanese BIP39 test vectors (github.com/bip32JP/bip32JP.github.io,
        // test_JP_BIP39.json): the same zero entropy as "abandon ... about".
        let mnemonic = Mnemonic::from_entropy_in(Language::Japanese, &[0u8; 16]).unwrap();
        let japanese = mnemonic.to_seed("㍍ガバヴァぱばぐゞちぢ十人十色");
        assert_eq!(
            hex::encode(japanese),
            "a262d6fb6122ecf45be09c50492b31f92e9beb7d9a845987a02cefda57a15f9c467a17872029a9e92299b5cbdf306e3a0ee620245cbd508959b6cb7ca637bd55"
        );

        let from_seed = Descriptor::new_confidential_from_seed(network, japanese.to_vec()).unwrap();
        let again = Descriptor::new_confidential_from_seed(network, japanese.to_vec()).unwrap();
        let english = Descriptor::new_confidential(network, ABANDON_MNEMONIC.to_owned()).unwrap();
        assert_eq!(from_seed.ct_descriptor, again.ct_descriptor);
        assert_ne!(from_seed.ct_descriptor, english.ct_descriptor);
    }

    #[test]
    fn rejects_a_seed_of_invalid_length() {
        for len in [0, 15, 65] {
            let err =
                Descriptor::new_confidential_from_seed(LiquidNetwork::Mainnet, vec![0u8; len])
                    .unwrap_err();
            assert!(err.msg.contains("16 to 64 bytes"), "{}", err.msg);
        }
    }
}
