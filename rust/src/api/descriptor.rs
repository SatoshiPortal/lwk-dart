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
    use crate::api::wallet::Wallet;

    const MNEMONIC: &str = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";

    /// Key derivation must not move across LWK upgrades: these vectors were
    /// produced with lwk 0.18.1 and LWK master alike.
    #[test]
    fn keys_and_addresses_derive_as_before() {
        let cases = [
            (
                LiquidNetwork::Mainnet,
                "ct(slip77(9c8e4f05c7711a98c838be228bcb84924d4570ca53f35fa1c793e58841d47023),elwpkh([73c5da0a/84h/1776h/0h]xpub6CRFzUgHFDaiDAQFNX7VeV9JNPDRabq6NYSpzVZ8zW8ANUCiDdenkb1gBoEZuXNZb3wPc1SVcDXgD2ww5UBtTb8s8ArAbTkoRQ8qn34KgcY/<0;1>/*))#y8jljyxl",
                "lq1qqvxk052kf3qtkxmrakx50a9gc3smqad2ync54hzntjt980kfej9kkfe0247rp5h4yzmdftsahhw64uy8pzfe7cpg4fgykm7cv",
            ),
            (
                LiquidNetwork::Testnet,
                "ct(slip77(9c8e4f05c7711a98c838be228bcb84924d4570ca53f35fa1c793e58841d47023),elwpkh([73c5da0a/84h/1h/0h]tpubDC8msFGeGuwnKG9Upg7DM2b4DaRqg3CUZa5g8v2SRQ6K4NSkxUgd7HsL2XVWbVm39yBA4LAxysQAm397zwQSQoQgewGiYZqrA9DsP4zbQ1M/<0;1>/*))#xte2lx9x",
                "tlq1qq2xvpcvfup5j8zscjq05u2wxxjcyewk7979f3mmz5l7uw5pqmx6xf5xy50hsn6vhkm5euwt72x878eq6zxx2z58hd7zrsg9qn",
            ),
        ];
        for (network, expected_descriptor, expected_address) in cases {
            let descriptor = Descriptor::new_confidential(network, MNEMONIC.to_string()).unwrap();
            assert_eq!(descriptor.ct_descriptor, expected_descriptor);

            let dbpath = std::env::temp_dir()
                .join(format!("lwk_derivation_{network:?}_{}", std::process::id()));
            let wallet =
                Wallet::init(network, dbpath.to_string_lossy().into_owned(), descriptor).unwrap();
            assert_eq!(wallet.address(0).unwrap().confidential, expected_address);
            let _ = std::fs::remove_dir_all(dbpath);
        }
    }
}
