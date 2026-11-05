# Security Considerations

## Mnemonics

`lwk-dart` does not generate wallet mnemonics. Applications must use a
cryptographically secure BIP39 generator, keep mnemonics outside source code,
logs, crash reports, and analytics, and provide any live-test mnemonic through
an environment variable or secret store.

Mnemonic strings and BIP39 seeds received by Rust are zeroized after use. This
cannot erase immutable Dart `String` objects or the caller's copy of a seed, nor
guarantee erasure of the `Mnemonic` and `Xpriv` retained internally by the
upstream `lwk_signer::SwSigner`, or of the SLIP77 master blinding key derived
from a seed. Applications with stronger memory-erasure requirements should
isolate signing in a hardware signer or a dedicated process. Complete
zeroization also requires support in `lwk_signer` and its key types.

The seed functions take the 64-byte BIP39 seed (PBKDF2 of the mnemonic and
passphrase), never the mnemonic entropy. Any other length is rejected: BIP32
would accept 16 or 32 bytes of entropy as a seed and silently derive another
wallet.

Any mnemonic that has ever been committed to a repository must be considered
public. Do not fund addresses derived from it.

## Transaction Signing

The signing API accepts a caller-provided PSET. The caller is responsible for
establishing a trusted transaction-review boundary and verifying recipients,
assets, amounts, fees, change outputs, and sighash policy before signing.
`lwk-dart` delegates signature construction and sighash handling to
`lwk_signer` and `elements-miniscript`; it does not independently enforce a
wallet policy for arbitrary PSETs.

Signing fails when the mnemonic or seed adds no signature to the PSET, so a
key that owns none of its inputs cannot return an unsigned transaction as if it
were signed. This includes a PSET whose inputs this key already signed: only
added signatures count. A key that owns only some inputs still signs those and returns the
transaction; checking that every input is signed remains the caller's
responsibility.

## Electrum Transport

Mainnet and testnet always connect to Electrum over TLS, even when the URL
starts with `tcp://`: a plaintext connection would let the network observe the
wallet's addresses and tamper with its view of the chain and its broadcasts.
Plaintext is allowed only for a `tcp://` URL on `LiquidNetwork.regtest`, for a
local test node such as Nigiri. `Wallet.sync` takes the network from the
wallet; the `Blockchain` broadcast and test functions take it as a parameter.

## Dependencies And Releases

Cargo and Dart lockfiles are part of the reviewed dependency set and should be
updated deliberately. Release workflows pin the Rust nightly by date, but
third-party GitHub Actions referenced by version tags remain part of the CI
trust boundary. Release artifacts must retain their pinned digest checks when
downloaded by the package.
