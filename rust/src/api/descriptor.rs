use lwk_signer::SwSigner;
use lwk_wollet::ElementsNetwork;

// use crate::frb_generated::RustOpaque;

use super::{error::LwkError, types::Network};

/// Script type for singlesig wallets
#[derive(Debug, Clone, Copy)]
pub enum ScriptVariant {
    /// BIP84: Native SegWit (Witness Public Key Hash)
    Wpkh,
    /// BIP49: Nested SegWit (Script Hash wrapping Witness Public Key Hash)
    ShWpkh,
}

impl From<ScriptVariant> for lwk_common::Singlesig {
    fn from(variant: ScriptVariant) -> Self {
        match variant {
            ScriptVariant::Wpkh => lwk_common::Singlesig::Wpkh,
            ScriptVariant::ShWpkh => lwk_common::Singlesig::ShWpkh,
        }
    }
}

/// Wallet descriptor class used to create a new wallet
#[derive(Debug)]
pub struct Descriptor {
    pub ct_descriptor: String,
}
impl Descriptor {
    /// Createa new wpkh confidential descriptor based on Slip77 blinding key derivation
    pub fn new_confidential(network: Network, mnemonic: String) -> Result<Descriptor, LwkError> {
        Self::new_confidential_with_script(network, mnemonic, ScriptVariant::Wpkh)
    }

    /// Create a new confidential descriptor with specified script variant and Slip77 blinding
    pub fn new_confidential_with_script(
        network: Network,
        mnemonic: String,
        script_variant: ScriptVariant,
    ) -> Result<Descriptor, LwkError> {
        let el_network: ElementsNetwork = network.into();
        let is_mainnet = el_network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str = lwk_common::singlesig_desc(
            &signer,
            script_variant.into(),
            blinding_variant,
            is_mainnet,
        )?;
        Ok(Descriptor {
            ct_descriptor: desc_str.to_string(),
        })
    }
}
