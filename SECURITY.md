# Security Considerations

## Mnemonics And Seeds

`lwk-dart` does not generate wallet mnemonics. Applications must use a
cryptographically secure BIP39 generator, keep mnemonics outside source code,
logs, crash reports, and analytics, and provide any live-test mnemonic through
an environment variable or secret store.

Mnemonic strings and seed byte buffers received by Rust are wrapped in `Zeroizing`. The seed API accepts exactly 64 bytes (the BIP39 seed, not 16/32-byte entropy); Dart byte-list arguments reject values outside 0..255 before native allocation. The caller derives the seed using its BIP39 language and passphrase and must clear its own mutable buffers after use.

This cannot erase immutable Dart strings, bridge copies, or guarantee erasure of every upstream key allocation. Applications with stronger memory-erasure requirements should isolate signing in a hardware signer or dedicated process. Never put mnemonics or seeds in logs, crash reports or analytics.

Any mnemonic that has ever been committed to a repository must be considered
public. Do not fund addresses derived from it.

## Transaction Signing

The signing API accepts a caller-provided PSET. The caller is responsible for
establishing a trusted transaction-review boundary and verifying recipients,
assets, amounts, fees, change outputs, and sighash policy before signing.
`lwk-dart` delegates signature construction and sighash handling to
`lwk_signer` and `elements-miniscript`; it does not independently enforce a
wallet policy for arbitrary PSETs.

Signing fails when the key adds no signature, including a PSET already signed by that key. A key owning only some inputs can still sign those; the caller must verify that all required signatures are present.

## Electrum Transport

Mainnet and testnet always use TLS with domain validation, including when a caller supplies a `tcp://` prefix. `validateDomain` is retained for compatibility but does not disable validation. Plaintext is permitted only for an explicit `tcp://` URL on regtest. Regtest with `ssl://` or no scheme still requires TLS and a certificate valid for the domain name.

## Dependencies And Releases

Cargo and Dart lockfiles are part of the reviewed dependency set and should be updated deliberately. The Rust crate pins stable Rust 1.100.0 in `rust/rust-toolchain.toml`. Native Assets builds the library locally with `--locked`; the package no longer downloads precompiled release binaries. The legacy Docker build image also pins Rust 1.100.0, but its build path requires separate validation.
