// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.31.

// Section: imports

use super::*;
use crate::api::wallet::*;
use flutter_rust_bridge::for_generated::byteorder::{NativeEndian, ReadBytesExt, WriteBytesExt};
use flutter_rust_bridge::for_generated::transform_result_dco;
use flutter_rust_bridge::{Handler, IntoIntoDart};

// Section: boilerplate

flutter_rust_bridge::frb_generated_boilerplate_io!();

// Section: dart2rust

impl CstDecode<RustOpaqueNom<Mutex<lwk_wollet::Wollet>>> for usize {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> RustOpaqueNom<Mutex<lwk_wollet::Wollet>> {
        unsafe { decode_rust_opaque_nom(self as _) }
    }
}
impl CstDecode<String> for *mut wire_cst_list_prim_u_8_strict {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> String {
        let vec: Vec<u8> = self.cst_decode();
        String::from_utf8(vec).unwrap()
    }
}
impl CstDecode<crate::api::types::Address> for wire_cst_address {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Address {
        crate::api::types::Address {
            standard: self.standard.cst_decode(),
            confidential: self.confidential.cst_decode(),
            index: self.index.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::Balance> for wire_cst_balance {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Balance {
        crate::api::types::Balance {
            asset_id: self.asset_id.cst_decode(),
            value: self.value.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::descriptor::Descriptor> for *mut wire_cst_descriptor {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::descriptor::Descriptor {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::descriptor::Descriptor>::cst_decode(*wrap).into()
    }
}
impl CstDecode<u32> for *mut u32 {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> u32 {
        unsafe { *flutter_rust_bridge::for_generated::box_from_leak_ptr(self) }
    }
}
impl CstDecode<crate::api::wallet::Wallet> for *mut wire_cst_wallet {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::wallet::Wallet {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::wallet::Wallet>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::descriptor::Descriptor> for wire_cst_descriptor {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::descriptor::Descriptor {
        crate::api::descriptor::Descriptor {
            ct_descriptor: self.ct_descriptor.cst_decode(),
        }
    }
}
impl CstDecode<Vec<crate::api::types::Balance>> for *mut wire_cst_list_balance {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::Balance> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<Vec<u8>> for *mut wire_cst_list_prim_u_8_loose {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<u8> {
        unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
impl CstDecode<Vec<u8>> for *mut wire_cst_list_prim_u_8_strict {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<u8> {
        unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
impl CstDecode<Vec<crate::api::types::Tx>> for *mut wire_cst_list_tx {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::Tx> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<Vec<crate::api::types::TxOut>> for *mut wire_cst_list_tx_out {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> Vec<crate::api::types::TxOut> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<crate::api::error::LwkError> for wire_cst_lwk_error {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::error::LwkError {
        crate::api::error::LwkError {
            msg: self.msg.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::OutPoint> for wire_cst_out_point {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::OutPoint {
        crate::api::types::OutPoint {
            txid: self.txid.cst_decode(),
            vout: self.vout.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::PsetAmounts> for wire_cst_pset_amounts {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::PsetAmounts {
        crate::api::types::PsetAmounts {
            fee: self.fee.cst_decode(),
            balances: self.balances.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::Tx> for wire_cst_tx {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::Tx {
        crate::api::types::Tx {
            timestamp: self.timestamp.cst_decode(),
            kind: self.kind.cst_decode(),
            balances: self.balances.cst_decode(),
            txid: self.txid.cst_decode(),
            outputs: self.outputs.cst_decode(),
            inputs: self.inputs.cst_decode(),
            fee: self.fee.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::TxOut> for wire_cst_tx_out {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::TxOut {
        crate::api::types::TxOut {
            script_pubkey: self.script_pubkey.cst_decode(),
            outpoint: self.outpoint.cst_decode(),
            height: self.height.cst_decode(),
            unblinded: self.unblinded.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::types::TxOutSecrets> for wire_cst_tx_out_secrets {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::types::TxOutSecrets {
        crate::api::types::TxOutSecrets {
            value: self.value.cst_decode(),
            value_bf: self.value_bf.cst_decode(),
            asset: self.asset.cst_decode(),
            asset_bf: self.asset_bf.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::wallet::Wallet> for wire_cst_wallet {
    // Codec=Cst (C-struct based), see doc to use other codecs
    fn cst_decode(self) -> crate::api::wallet::Wallet {
        crate::api::wallet::Wallet {
            inner: self.inner.cst_decode(),
        }
    }
}
impl NewWithNullPtr for wire_cst_address {
    fn new_with_null_ptr() -> Self {
        Self {
            standard: core::ptr::null_mut(),
            confidential: core::ptr::null_mut(),
            index: Default::default(),
        }
    }
}
impl Default for wire_cst_address {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_balance {
    fn new_with_null_ptr() -> Self {
        Self {
            asset_id: core::ptr::null_mut(),
            value: Default::default(),
        }
    }
}
impl Default for wire_cst_balance {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_descriptor {
    fn new_with_null_ptr() -> Self {
        Self {
            ct_descriptor: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_descriptor {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_lwk_error {
    fn new_with_null_ptr() -> Self {
        Self {
            msg: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_lwk_error {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_out_point {
    fn new_with_null_ptr() -> Self {
        Self {
            txid: core::ptr::null_mut(),
            vout: Default::default(),
        }
    }
}
impl Default for wire_cst_out_point {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_pset_amounts {
    fn new_with_null_ptr() -> Self {
        Self {
            fee: Default::default(),
            balances: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_pset_amounts {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_tx {
    fn new_with_null_ptr() -> Self {
        Self {
            timestamp: Default::default(),
            kind: core::ptr::null_mut(),
            balances: core::ptr::null_mut(),
            txid: core::ptr::null_mut(),
            outputs: core::ptr::null_mut(),
            inputs: core::ptr::null_mut(),
            fee: Default::default(),
        }
    }
}
impl Default for wire_cst_tx {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_tx_out {
    fn new_with_null_ptr() -> Self {
        Self {
            script_pubkey: core::ptr::null_mut(),
            outpoint: Default::default(),
            height: core::ptr::null_mut(),
            unblinded: Default::default(),
        }
    }
}
impl Default for wire_cst_tx_out {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_tx_out_secrets {
    fn new_with_null_ptr() -> Self {
        Self {
            value: Default::default(),
            value_bf: core::ptr::null_mut(),
            asset: core::ptr::null_mut(),
            asset_bf: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_tx_out_secrets {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_wallet {
    fn new_with_null_ptr() -> Self {
        Self {
            inner: Default::default(),
        }
    }
}
impl Default for wire_cst_wallet {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_descriptor_new_confidential(
    port_: i64,
    network: i32,
    mnemonic: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_descriptor_new_confidential_impl(port_, network, mnemonic)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_address_address_from_script(
    port_: i64,
    network: i32,
    script: *mut wire_cst_list_prim_u_8_strict,
    blinding_key: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_address_address_from_script_impl(port_, network, script, blinding_key)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_address_validate(
    port_: i64,
    address_string: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_address_validate_impl(port_, address_string)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_address(
    port_: i64,
    that: *mut wire_cst_wallet,
    index: u32,
) {
    wire_wallet_address_impl(port_, that, index)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_address_last_unused(
    port_: i64,
    that: *mut wire_cst_wallet,
) {
    wire_wallet_address_last_unused_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_balances(port_: i64, that: *mut wire_cst_wallet) {
    wire_wallet_balances_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_blinding_key(port_: i64, that: *mut wire_cst_wallet) {
    wire_wallet_blinding_key_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_broadcast_tx(
    port_: i64,
    electrum_url: *mut wire_cst_list_prim_u_8_strict,
    tx_bytes: *mut wire_cst_list_prim_u_8_loose,
) {
    wire_wallet_broadcast_tx_impl(port_, electrum_url, tx_bytes)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_build_asset_tx(
    port_: i64,
    that: *mut wire_cst_wallet,
    sats: u64,
    out_address: *mut wire_cst_list_prim_u_8_strict,
    fee_rate: f32,
    asset: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_wallet_build_asset_tx_impl(port_, that, sats, out_address, fee_rate, asset)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_build_lbtc_tx(
    port_: i64,
    that: *mut wire_cst_wallet,
    sats: u64,
    out_address: *mut wire_cst_list_prim_u_8_strict,
    fee_rate: f32,
) {
    wire_wallet_build_lbtc_tx_impl(port_, that, sats, out_address, fee_rate)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_decode_tx(
    port_: i64,
    that: *mut wire_cst_wallet,
    pset: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_wallet_decode_tx_impl(port_, that, pset)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_descriptor(port_: i64, that: *mut wire_cst_wallet) {
    wire_wallet_descriptor_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_init(
    port_: i64,
    network: i32,
    dbpath: *mut wire_cst_list_prim_u_8_strict,
    descriptor: *mut wire_cst_descriptor,
    electrum_url: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_wallet_init_impl(port_, network, dbpath, descriptor, electrum_url)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_sign_tx(
    port_: i64,
    that: *mut wire_cst_wallet,
    network: i32,
    pset: *mut wire_cst_list_prim_u_8_strict,
    mnemonic: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_wallet_sign_tx_impl(port_, that, network, pset, mnemonic)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_sync(
    port_: i64,
    that: *mut wire_cst_wallet,
    electrum_url: *mut wire_cst_list_prim_u_8_strict,
) {
    wire_wallet_sync_impl(port_, that, electrum_url)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_txs(port_: i64, that: *mut wire_cst_wallet) {
    wire_wallet_txs_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_wire_wallet_utxos(port_: i64, that: *mut wire_cst_wallet) {
    wire_wallet_utxos_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        StdArc::<Mutex<lwk_wollet::Wollet>>::increment_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        StdArc::<Mutex<lwk_wollet::Wollet>>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_box_autoadd_descriptor() -> *mut wire_cst_descriptor {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wire_cst_descriptor::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_box_autoadd_u_32(value: u32) -> *mut u32 {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_box_autoadd_wallet() -> *mut wire_cst_wallet {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wire_cst_wallet::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_list_balance(len: i32) -> *mut wire_cst_list_balance {
    let wrap = wire_cst_list_balance {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_balance>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_list_prim_u_8_loose(
    len: i32,
) -> *mut wire_cst_list_prim_u_8_loose {
    let ans = wire_cst_list_prim_u_8_loose {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(ans)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_list_prim_u_8_strict(
    len: i32,
) -> *mut wire_cst_list_prim_u_8_strict {
    let ans = wire_cst_list_prim_u_8_strict {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(ans)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_list_tx(len: i32) -> *mut wire_cst_list_tx {
    let wrap = wire_cst_list_tx {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_tx>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn frbgen_lwk_dart_cst_new_list_tx_out(len: i32) -> *mut wire_cst_list_tx_out {
    let wrap = wire_cst_list_tx_out {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_tx_out>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_address {
    standard: *mut wire_cst_list_prim_u_8_strict,
    confidential: *mut wire_cst_list_prim_u_8_strict,
    index: u32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_balance {
    asset_id: *mut wire_cst_list_prim_u_8_strict,
    value: i64,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_descriptor {
    ct_descriptor: *mut wire_cst_list_prim_u_8_strict,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_balance {
    ptr: *mut wire_cst_balance,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_prim_u_8_loose {
    ptr: *mut u8,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_prim_u_8_strict {
    ptr: *mut u8,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_tx {
    ptr: *mut wire_cst_tx,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_tx_out {
    ptr: *mut wire_cst_tx_out,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_lwk_error {
    msg: *mut wire_cst_list_prim_u_8_strict,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_out_point {
    txid: *mut wire_cst_list_prim_u_8_strict,
    vout: u32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_pset_amounts {
    fee: u64,
    balances: *mut wire_cst_list_balance,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_tx {
    timestamp: u32,
    kind: *mut wire_cst_list_prim_u_8_strict,
    balances: *mut wire_cst_list_balance,
    txid: *mut wire_cst_list_prim_u_8_strict,
    outputs: *mut wire_cst_list_tx_out,
    inputs: *mut wire_cst_list_tx_out,
    fee: u64,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_tx_out {
    script_pubkey: *mut wire_cst_list_prim_u_8_strict,
    outpoint: wire_cst_out_point,
    height: *mut u32,
    unblinded: wire_cst_tx_out_secrets,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_tx_out_secrets {
    value: u64,
    value_bf: *mut wire_cst_list_prim_u_8_strict,
    asset: *mut wire_cst_list_prim_u_8_strict,
    asset_bf: *mut wire_cst_list_prim_u_8_strict,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_wallet {
    inner: usize,
}
