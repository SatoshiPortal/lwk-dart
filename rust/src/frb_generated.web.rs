// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.28.

// Section: imports

use super::*;
use crate::api::wallet::*;
use flutter_rust_bridge::for_generated::byteorder::{NativeEndian, ReadBytesExt, WriteBytesExt};
use flutter_rust_bridge::for_generated::transform_result_dco;
use flutter_rust_bridge::for_generated::wasm_bindgen;
use flutter_rust_bridge::for_generated::wasm_bindgen::prelude::*;
use flutter_rust_bridge::{Handler, IntoIntoDart};

// Section: boilerplate

flutter_rust_bridge::frb_generated_boilerplate_web!();

// Section: dart2rust

impl CstDecode<String> for String {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> String {
        self
    }
}
impl CstDecode<crate::api::types::Address>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Address {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            3,
            "Expected 3 elements, got {}",
            self_.length()
        );
        crate::api::types::Address {
            standard: self_.get(0).cst_decode(),
            confidential: self_.get(1).cst_decode(),
            index: self_.get(2).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::Balance>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Balance {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        crate::api::types::Balance {
            asset_id: self_.get(0).cst_decode(),
            value: self_.get(1).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::descriptor::DescriptorBase>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::descriptor::DescriptorBase {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            1,
            "Expected 1 elements, got {}",
            self_.length()
        );
        crate::api::descriptor::DescriptorBase {
            ct_descriptor: self_.get(0).cst_decode(),
        }
    }
}
impl CstDecode<Vec<crate::api::types::Balance>>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::Balance> {
        self.dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap()
            .iter()
            .map(CstDecode::cst_decode)
            .collect()
    }
}
impl CstDecode<Vec<u8>> for Box<[u8]> {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<u8> {
        self.into_vec()
    }
}
impl CstDecode<Vec<crate::api::types::Tx>>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::Tx> {
        self.dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap()
            .iter()
            .map(CstDecode::cst_decode)
            .collect()
    }
}
impl CstDecode<Vec<crate::api::types::TxOut>>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::TxOut> {
        self.dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap()
            .iter()
            .map(CstDecode::cst_decode)
            .collect()
    }
}
impl CstDecode<crate::api::error::LwkError>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::error::LwkError {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            1,
            "Expected 1 elements, got {}",
            self_.length()
        );
        crate::api::error::LwkError {
            msg: self_.get(0).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::OutPoint>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::OutPoint {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        crate::api::types::OutPoint {
            txid: self_.get(0).cst_decode(),
            vout: self_.get(1).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::PsetAmounts>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::PsetAmounts {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        crate::api::types::PsetAmounts {
            fee: self_.get(0).cst_decode(),
            balances: self_.get(1).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::Tx>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Tx {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            7,
            "Expected 7 elements, got {}",
            self_.length()
        );
        crate::api::types::Tx {
            timestamp: self_.get(0).cst_decode(),
            kind: self_.get(1).cst_decode(),
            balances: self_.get(2).cst_decode(),
            txid: self_.get(3).cst_decode(),
            outputs: self_.get(4).cst_decode(),
            inputs: self_.get(5).cst_decode(),
            fee: self_.get(6).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::TxOut>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::TxOut {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            4,
            "Expected 4 elements, got {}",
            self_.length()
        );
        crate::api::types::TxOut {
            script_pubkey: self_.get(0).cst_decode(),
            outpoint: self_.get(1).cst_decode(),
            height: self_.get(2).cst_decode(),
            unblinded: self_.get(3).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::TxOutSecrets>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::TxOutSecrets {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            4,
            "Expected 4 elements, got {}",
            self_.length()
        );
        crate::api::types::TxOutSecrets {
            value: self_.get(0).cst_decode(),
            value_bf: self_.get(1).cst_decode(),
            asset: self_.get(2).cst_decode(),
            asset_bf: self_.get(3).cst_decode(),
        }
    }
}
impl CstDecode<crate::api::wallet::Wallet>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::wallet::Wallet {
        let self_ = self
            .dyn_into::<flutter_rust_bridge::for_generated::js_sys::Array>()
            .unwrap();
        assert_eq!(
            self_.length(),
            1,
            "Expected 1 elements, got {}",
            self_.length()
        );
        crate::api::wallet::Wallet {
            ptr: self_.get(0).cst_decode(),
        }
    }
}
impl CstDecode<RustOpaqueNom<Mutex<lwk_wollet::Wollet>>>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> RustOpaqueNom<Mutex<lwk_wollet::Wollet>> {
        #[cfg(target_pointer_width = "64")]
        {
            compile_error!("64-bit pointers are not supported.");
        }
        unsafe { decode_rust_opaque_nom((self.as_f64().unwrap() as usize) as _) }
    }
}
impl CstDecode<String> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl CstDecode<f32> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> f32 {
        self.unchecked_into_f64() as _
    }
}
impl CstDecode<i32> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> i32 {
        self.unchecked_into_f64() as _
    }
}
impl CstDecode<i64> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> i64 {
        ::std::convert::TryInto::try_into(
            self.dyn_into::<flutter_rust_bridge::for_generated::js_sys::BigInt>()
                .unwrap(),
        )
        .unwrap()
    }
}
impl CstDecode<Vec<u8>> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<u8> {
        self.unchecked_into::<flutter_rust_bridge::for_generated::js_sys::Uint8Array>()
            .to_vec()
            .into()
    }
}
impl CstDecode<crate::api::types::Network>
    for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue
{
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Network {
        (self.unchecked_into_f64() as i32).cst_decode()
    }
}
impl CstDecode<u32> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> u32 {
        self.unchecked_into_f64() as _
    }
}
impl CstDecode<u64> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> u64 {
        ::std::convert::TryInto::try_into(
            self.dyn_into::<flutter_rust_bridge::for_generated::js_sys::BigInt>()
                .unwrap(),
        )
        .unwrap()
    }
}
impl CstDecode<u8> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl CstDecode<usize> for flutter_rust_bridge::for_generated::wasm_bindgen::JsValue {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> usize {
        self.unchecked_into_f64() as _
    }
}

#[wasm_bindgen]
pub fn wire_DescriptorBase_new(
    network: i32,
    mnemonic: String,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartDco {
    wire_DescriptorBase_new_impl(network, mnemonic)
}

#[wasm_bindgen]
pub fn wire_Address_address_from_script(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    network: i32,
    script: String,
    blinding_key: String,
) {
    wire_Address_address_from_script_impl(port_, network, script, blinding_key)
}

#[wasm_bindgen]
pub fn wire_Address_validate(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    address_string: String,
) {
    wire_Address_validate_impl(port_, address_string)
}

#[wasm_bindgen]
pub fn wire_Wallet_address(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    index: u32,
) {
    wire_Wallet_address_impl(port_, that, index)
}

#[wasm_bindgen]
pub fn wire_Wallet_address_last_unused(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) {
    wire_Wallet_address_last_unused_impl(port_, that)
}

#[wasm_bindgen]
pub fn wire_Wallet_balances(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) {
    wire_Wallet_balances_impl(port_, that)
}

#[wasm_bindgen]
pub fn wire_Wallet_blinding_key(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) {
    wire_Wallet_blinding_key_impl(port_, that)
}

#[wasm_bindgen]
pub fn wire_Wallet_broadcast_tx(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    electrum_url: String,
    tx_bytes: Box<[u8]>,
) {
    wire_Wallet_broadcast_tx_impl(port_, electrum_url, tx_bytes)
}

#[wasm_bindgen]
pub fn wire_Wallet_build_asset_tx(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    sats: u64,
    out_address: String,
    abs_fee: f32,
    asset: String,
) {
    wire_Wallet_build_asset_tx_impl(port_, that, sats, out_address, abs_fee, asset)
}

#[wasm_bindgen]
pub fn wire_Wallet_build_lbtc_tx(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    sats: u64,
    out_address: String,
    abs_fee: f32,
) {
    wire_Wallet_build_lbtc_tx_impl(port_, that, sats, out_address, abs_fee)
}

#[wasm_bindgen]
pub fn wire_Wallet_decode_tx(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    pset: String,
) {
    wire_Wallet_decode_tx_impl(port_, that, pset)
}

#[wasm_bindgen]
pub fn wire_Wallet_descriptor(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) {
    wire_Wallet_descriptor_impl(port_, that)
}

#[wasm_bindgen]
pub fn wire_Wallet_new(
    network: i32,
    dbpath: String,
    descriptor: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartDco {
    wire_Wallet_new_impl(network, dbpath, descriptor)
}

#[wasm_bindgen]
pub fn wire_Wallet_sign_tx(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    network: i32,
    pset: String,
    mnemonic: String,
) {
    wire_Wallet_sign_tx_impl(port_, that, network, pset, mnemonic)
}

#[wasm_bindgen]
pub fn wire_Wallet_sync(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
    electrum_url: String,
) {
    wire_Wallet_sync_impl(port_, that, electrum_url)
}

#[wasm_bindgen]
pub fn wire_Wallet_txs(
    port_: flutter_rust_bridge::for_generated::MessagePort,
    that: flutter_rust_bridge::for_generated::wasm_bindgen::JsValue,
) {
    wire_Wallet_txs_impl(port_, that)
}

#[wasm_bindgen]
pub fn rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        StdArc::<Mutex<lwk_wollet::Wollet>>::increment_strong_count(ptr as _);
    }
}

#[wasm_bindgen]
pub fn rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        StdArc::<Mutex<lwk_wollet::Wollet>>::decrement_strong_count(ptr as _);
    }
}
