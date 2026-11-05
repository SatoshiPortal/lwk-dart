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
    /// from a 64-byte BIP39 seed instead of English mnemonic words.
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
