# lwk

A dart/flutter library with language bindings for rust library [lwk](https://github.com/Blockstream/lwk) - Liquid Wallet Kit.

## BREAKING CHANGE FROM 0.1.3 -> 0.1.4

If you are currently using 0.1.3 - updating to 0.1.4 will create a breaking change that will make it difficult for you to spend your existing utxos.

If you are using 0.1.3 sweep your wallets before updating.

### legacy branch

To access legacy 0.1.3 wallets, use the legacy branch.

## Usage

Initialize the library once, in main()

```
await LibLwk.init();
```

This will load the binary. It does not need to be called again.

Now use the library as usual. See `test/lwk_root_test.dart`

## Dependencies

Docker is required for linux builds.

```bash
dart pub global activate ffigen
cargo install flutter_rust_bridge_codegen --version 2.12.0
cargo install cargo-expand
cargo install cargo-ndk
@if [ $$(uname) == "Darwin" ] ; then cargo install cargo-lipo ; fi
```

For ios builds, make sure you have xcode installed.

## Update & Build process

Add new types to `types.rs` and static functions to `api.rs`

api.rs contains an `Api` struct that holds all the static functions.

types.rs structures and enums are also re-exported via api.rs

```bash
# in the project root directory

./compile.native.sh # build for your native platform (linux/macos). adds binary to dart test folder.

```

## MacOS as host

macos as the host machine can build binaries for all platforms using:

```bash
# requires dockerd running
./compile.all.sh
```

Compile will first build native binaries of the rust code and move them to the dart test folder.

It will then run flutter_rust_bridge_codegen and generate ffi code in rust and dart.

### Non-debian linux users

On non-debian systems you will get some errors with the `bridge_generated.dart` files.

Error would be related to:

```rust
  void store_dart_post_cobject(
    int ptr,
  ) {
    return _store_dart_post_cobject(
      ptr,
    );
  }
```

You may need to set the path the clang in CPATH manually.
Run the following:

```bash
export CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include"
```

## BIP39 seeds and Liquid regtest

Applications can derive a 64-byte BIP39 seed from any supported wordlist and passphrase, then call `Descriptor.newConfidentialFromSeed`, `Wallet.signTxWithSeed` or `Wallet.signedPsetWithExtraDetailsWithSeed`. Pass seed bytes, not mnemonic entropy. The existing English mnemonic APIs remain available. See `SECURITY.md` for buffer-erasure limits and transaction-review requirements.

`LiquidNetwork.regtest` uses Elements regtest addresses and the default policy asset `5ac9f65c0efcc4775e0baec4ec03abdde22473cd3cf33c0419ca290e0751b225`. For a differently configured node, pass its asset ID through `Wallet.init(policyAsset: ...)`; mainnet and testnet reject overrides.

For a local Nigiri Liquid stack, sync and broadcast with `tcp://127.0.0.1:50001` and `network: LiquidNetwork.regtest`. Only an explicit regtest TCP URL uses plaintext. Use a fee rate of `1000.0` sats/kvB (1 sat/vB). Enable mining on the local stack, or mine a block manually after broadcast. The optional integration test derives a wallet from a public test seed, receives faucet funds, syncs, builds and signs a PSET, broadcasts it, and waits for confirmation:

```sh
cd rust
LWK_REGTEST_ELECTRUM=tcp://127.0.0.1:50001 LWK_REGTEST_FAUCET=http://127.0.0.1:3001/faucet cargo test regtest_round_trip_over_plaintext_electrum -- --ignored
```
