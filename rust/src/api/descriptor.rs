use lwk_signer::SwSigner;
use zeroize::Zeroizing;

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
        let script_variant = lwk_common::Singlesig::Wpkh;
        let blinding_variant = lwk_common::DescriptorBlindingKey::Slip77;
        let desc_str = lwk_common::singlesig_desc(&signer, script_variant, blinding_variant)?;
        Ok(Descriptor {
            ct_descriptor: desc_str.to_string(),
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const ABANDON_MNEMONIC: &str = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";

    #[test]
    fn regtest_uses_the_testnet_descriptor() {
        // Elements regtest, like lwk, uses testnet keys: tpub and coin type 1.
        let regtest =
            Descriptor::new_confidential(LiquidNetwork::Regtest, ABANDON_MNEMONIC.to_owned())
                .unwrap();
        let testnet =
            Descriptor::new_confidential(LiquidNetwork::Testnet, ABANDON_MNEMONIC.to_owned())
                .unwrap();
        assert_eq!(regtest.ct_descriptor, testnet.ct_descriptor);
        assert_eq!(
            regtest.ct_descriptor,
            "ct(slip77(9c8e4f05c7711a98c838be228bcb84924d4570ca53f35fa1c793e58841d47023),elwpkh([73c5da0a/84h/1h/0h]tpubDC8msFGeGuwnKG9Upg7DM2b4DaRqg3CUZa5g8v2SRQ6K4NSkxUgd7HsL2XVWbVm39yBA4LAxysQAm397zwQSQoQgewGiYZqrA9DsP4zbQ1M/<0;1>/*))#xte2lx9x"
        );
    }
}
