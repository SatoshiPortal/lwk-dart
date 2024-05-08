
use lwk_signer::SwSigner;
use lwk_wollet:: ElementsNetwork;

// use crate::frb_generated::RustOpaque;

use super::{error::LwkError, types::Network};

#[derive(Debug)]
pub struct Descriptor {
    pub ct_descriptor: String,
}
impl Descriptor{

    pub fn new_confidential(network: Network, mnemonic: String) -> Result<Descriptor, LwkError> {
        let el_network: ElementsNetwork = network.into();
        let is_mainnet = el_network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str =
            lwk_common::singlesig_desc(&signer, script_variant, blinding_variant, is_mainnet)?;
        Ok(Descriptor{ct_descriptor:desc_str.to_string()})
    }
}

