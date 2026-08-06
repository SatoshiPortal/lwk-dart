## 0.7.0

- fix (BREAKING): `Wallet.balances()` and `SizeAndFees.absoluteFees` now return
  `WalletBalance` (unsigned `BigInt`) instead of `Balance` (signed). Balances
  above `i64::MAX` were previously dropped from the list entirely. `Tx.balances`
  still uses the signed `Balance`, since transaction deltas can be negative
- fix (BREAKING): `getBalanceByAssetId`, `getLbtcBalance` and `getLtestBalance`
  take `WalletBalance` and return `BigInt`
- fix (BREAKING): `Address.validate` now fails on addresses that are neither
  Liquid mainnet nor Liquid testnet, instead of reporting Elements/regtest
  addresses as testnet
- fix (BREAKING): transaction builders reject a non-finite, zero, negative or
  implausibly large `feeRate`. The unit is sats/kvB, so 1 sat/vB is `1000.0`;
  lwk previously turned such values into a 0 sat or `u64::MAX` fee
- fix: validate the destination address on drain paths (`buildLbtcTx`,
  `buildCustomTx`), which accepted a wrong-network or unblinded address
- fix: derive signing keys for the requested network — `signTx` and
  `signedPsetWithExtraDetails` had mainnet/testnet inverted
- fix: propagate signing failures instead of finalizing an unsigned PSET
- fix: reject `BigInt` amounts outside the unsigned 64-bit range at the FFI
  boundary rather than wrapping them modulo 2^64
- chore: zeroize mnemonic strings after use; remove the hardcoded mainnet test
  mnemonic in favour of `LWK_MAINNET_TEST_MNEMONIC`
- chore: verify downloaded native libraries against a pinned digest, repair the
  release asset URL, and pin the release Rust nightly
- docs: add `SECURITY.md`

## 0.6.0

- feat: add `Wallet.consolidate` — builds N unsigned PSETs batching confirmed
  L-BTC UTXOs under a safe input cap (default threshold 125, max 250 inputs/tx);
  each batch drains to a fresh unused address; dust batches are skipped
- feat: add `confirmedLbtcUtxoCount`, `batchSign`, `batchBroadcast` helpers
- feat: add `Wallet.build_custom_tx` — general-purpose builder for custom
  output shapes (explicit UTXOs, recipients, optional drain-to address)

## 0.5.0

- feat (BREAKING): rename the public `Network` enum to `LiquidNetwork`
- feat: add `getLbtcAssetId` and `getLtestAssetId` functions
- chore: update `lwk_wollet`, `lwk_signer` and `lwk_common` to 0.18.0 (via 0.17.0)
- chore: update `sideswap_rust` to latest (rev `3722a83`)
- chore: install the rustls `ring` CryptoProvider at init (required by lwk 0.18's rustls)
- chore: replace deprecated `Wollet::with_fs_persist` with `WolletBuilder` using the legacy fs store (same on-disk format, existing wallet caches still load)
- chore: switch `PsetAmounts` construction to `PsetBalance::fees_in(policy_asset)` after `PsetBalance::fee` was removed upstream
- chore: cfg-gate `frb_generated` behind a `bull_sdk` feature for the aggregated bull_sdk crate
- chore: regenerate FRB bindings (standalone crate compiles again; Dart surface now exposes `LiquidNetwork`)
- chore: ignore `test_broadcast` (live-network test; its pre-signed tx inputs are long spent)

## 0.4.0

- chore: pin lockfiles and update dependencies to latest; Flutter 3.44.1 / Dart 3.12.1 / `flutter_rust_bridge` 2.12.0; release toolchain on stable Rust

## 0.3.0

- feat: add `LiquidTransaction` and `PartiallySignedElementsTransaction` APIs
- feat: `isSendAll` for create Payjoin
- fix: return `unblinded_outputs` from `build_payjoin_tx`
- fix: building for Flutter >3.32.0
- fix: Android 16kb page size
- chore: update `flutter_rust_bridge` to 2.11.1
- chore: update to the latest `sideswap_rust`

## 0.2.2

- Fix payjoins for nested segwit wallets. 
- Allow config of base_url to fetch usdt utxos for payjoin
- Add stop-at-index and timeout options to sync

## 0.2.1

- fix: export error type
- added: DecodedPset for absolute fees from pset
- added: method to return SizeAndFees (renamed DecodedPset)
- updated generated code

## 0.2.0

- upgrade: frb 2.9.0
- Add PayJoin API

## 0.1.7

- Updated to lwk 0.9
- Discount CT (Confidential Transaction)

## 0.1.6

- Score improvments
- fix liblwk.a not found

## 0.1.5

- Initial version
