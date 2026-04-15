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
