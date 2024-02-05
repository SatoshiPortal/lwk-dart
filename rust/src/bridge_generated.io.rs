use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_new_wallet__static_method__Api(
    port_: i64,
    mnemonic: *mut wire_uint_8_list,
    network: i32,
    db_path: *mut wire_uint_8_list,
) {
    wire_new_wallet__static_method__Api_impl(port_, mnemonic, network, db_path)
}

#[no_mangle]
pub extern "C" fn wire_sync__static_method__Api(
    port_: i64,
    wallet_id: *mut wire_uint_8_list,
    electrum_url: *mut wire_uint_8_list,
) {
    wire_sync__static_method__Api_impl(port_, wallet_id, electrum_url)
}

#[no_mangle]
pub extern "C" fn wire_descriptor__static_method__Api(
    port_: i64,
    wallet_id: *mut wire_uint_8_list,
) {
    wire_descriptor__static_method__Api_impl(port_, wallet_id)
}

#[no_mangle]
pub extern "C" fn wire_address__static_method__Api(port_: i64, wallet_id: *mut wire_uint_8_list) {
    wire_address__static_method__Api_impl(port_, wallet_id)
}

#[no_mangle]
pub extern "C" fn wire_balance__static_method__Api(port_: i64, wallet_id: *mut wire_uint_8_list) {
    wire_balance__static_method__Api_impl(port_, wallet_id)
}

#[no_mangle]
pub extern "C" fn wire_txs__static_method__Api(port_: i64, wallet_id: *mut wire_uint_8_list) {
    wire_txs__static_method__Api_impl(port_, wallet_id)
}

#[no_mangle]
pub extern "C" fn wire_build_tx__static_method__Api(
    port_: i64,
    wallet_id: *mut wire_uint_8_list,
    sats: u64,
    out_address: *mut wire_uint_8_list,
    abs_fee: f32,
) {
    wire_build_tx__static_method__Api_impl(port_, wallet_id, sats, out_address, abs_fee)
}

#[no_mangle]
pub extern "C" fn wire_decode_tx__static_method__Api(
    port_: i64,
    wallet_id: *mut wire_uint_8_list,
    pset: *mut wire_uint_8_list,
) {
    wire_decode_tx__static_method__Api_impl(port_, wallet_id, pset)
}

#[no_mangle]
pub extern "C" fn wire_sign_tx__static_method__Api(
    port_: i64,
    wallet_id: *mut wire_uint_8_list,
    network: i32,
    pset: *mut wire_uint_8_list,
    mnemonic: *mut wire_uint_8_list,
) {
    wire_sign_tx__static_method__Api_impl(port_, wallet_id, network, pset, mnemonic)
}

#[no_mangle]
pub extern "C" fn wire_broadcast_tx__static_method__Api(
    port_: i64,
    electrum_url: *mut wire_uint_8_list,
    tx_bytes: *mut wire_uint_8_list,
) {
    wire_broadcast_tx__static_method__Api_impl(port_, electrum_url, tx_bytes)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
