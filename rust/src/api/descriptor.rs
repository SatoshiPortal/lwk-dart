
use flutter_rust_bridge::frb;
use lwk_signer::SwSigner;
use lwk_wollet:: ElementsNetwork;

// use crate::frb_generated::RustOpaque;

use super::{error::LwkError, types::Network};

#[derive(Debug)]
pub struct DescriptorBase {
    pub ct_descriptor: String,
}
impl DescriptorBase{
    #[frb(sync)]
    pub fn new(network: Network, mnemonic: String) -> Result<DescriptorBase, LwkError> {
        let el_network: ElementsNetwork = network.into();
        let is_mainnet = el_network == ElementsNetwork::Liquid;
        let signer: SwSigner = SwSigner::new(&mnemonic, is_mainnet)?.into();
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str =
            lwk_common::singlesig_desc(&signer, script_variant, blinding_variant, is_mainnet)?;
        Ok(DescriptorBase{ct_descriptor:desc_str.to_string()})
    }
}

