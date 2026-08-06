# Security Considerations

## Mnemonics

`lwk-dart` does not generate wallet mnemonics. Applications must use a
cryptographically secure BIP39 generator, keep mnemonics outside source code,
logs, crash reports, and analytics, and provide any live-test mnemonic through
an environment variable or secret store.

Mnemonic strings received by Rust are zeroized after use. This cannot erase
immutable Dart `String` objects or guarantee erasure of the `Mnemonic` and
`Xpriv` retained internally by the upstream `lwk_signer::SwSigner`. Applications
with stronger memory-erasure requirements should isolate signing in a hardware
signer or a dedicated process. Complete zeroization also requires support in
`lwk_signer` and its key types.

Any mnemonic that has ever been committed to a repository must be considered
public. Do not fund addresses derived from it.

## Transaction Signing

The signing API accepts a caller-provided PSET. The caller is responsible for
establishing a trusted transaction-review boundary and verifying recipients,
assets, amounts, fees, change outputs, and sighash policy before signing.
`lwk-dart` delegates signature construction and sighash handling to
`lwk_signer` and `elements-miniscript`; it does not independently enforce a
wallet policy for arbitrary PSETs.

## Dependencies And Releases

Cargo and Dart lockfiles are part of the reviewed dependency set and should be
updated deliberately. Release workflows pin the Rust nightly by date, but
third-party GitHub Actions referenced by version tags remain part of the CI
trust boundary. Release artifacts must retain their pinned digest checks when
downloaded by the package.
