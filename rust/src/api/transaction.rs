use std::str::FromStr;

use lwk_wollet::elements::pset::PartiallySignedTransaction;

use super::error::LwkError;

/// Extract the Transaction Bytes from a PartiallySignedTransaction
pub fn extract_tx_bytes(pset: String) -> anyhow::Result<Vec<u8>, LwkError> {
    let pset = PartiallySignedTransaction::from_str(&pset)?;
    let tx = pset.extract_tx()?;
    let tx_bytes = lwk_wollet::elements::encode::serialize(&tx);
    Ok(tx_bytes)
}

