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
    wallet: wire_Wallet,
    electrum_url: *mut wire_uint_8_list,
) {
    wire_sync__static_method__Api_impl(port_, wallet, electrum_url)
}

#[no_mangle]
pub extern "C" fn wire_descriptor__static_method__Api(port_: i64, wallet: wire_Wallet) {
    wire_descriptor__static_method__Api_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_address__static_method__Api(port_: i64, wallet: wire_Wallet) {
    wire_address__static_method__Api_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_balance__static_method__Api(port_: i64, wallet: wire_Wallet) {
    wire_balance__static_method__Api_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_txs__static_method__Api(port_: i64, wallet: wire_Wallet) {
    wire_txs__static_method__Api_impl(port_, wallet)
}

#[no_mangle]
pub extern "C" fn wire_build_tx__static_method__Api(
    port_: i64,
    wallet: wire_Wallet,
    sats: u64,
    out_address: *mut wire_uint_8_list,
    abs_fee: f32,
) {
    wire_build_tx__static_method__Api_impl(port_, wallet, sats, out_address, abs_fee)
}

#[no_mangle]
pub extern "C" fn wire_decode_tx__static_method__Api(
    port_: i64,
    wallet: wire_Wallet,
    pset: *mut wire_uint_8_list,
) {
    wire_decode_tx__static_method__Api_impl(port_, wallet, pset)
}

#[no_mangle]
pub extern "C" fn wire_sign_tx__static_method__Api(
    port_: i64,
    wallet: wire_Wallet,
    network: i32,
    pset: *mut wire_uint_8_list,
    mnemonic: *mut wire_uint_8_list,
) {
    wire_sign_tx__static_method__Api_impl(port_, wallet, network, pset, mnemonic)
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
pub extern "C" fn new_Wallet() -> wire_Wallet {
    wire_Wallet::new_with_null_ptr()
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

#[no_mangle]
pub extern "C" fn drop_opaque_Wallet(ptr: *const c_void) {
    unsafe {
        Arc::<Wallet>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn share_opaque_Wallet(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<Wallet>::increment_strong_count(ptr as _);
        ptr
    }
}

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<RustOpaque<Wallet>> for wire_Wallet {
    fn wire2api(self) -> RustOpaque<Wallet> {
        unsafe { support::opaque_from_dart(self.ptr as _) }
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
pub struct wire_Wallet {
    ptr: *const core::ffi::c_void,
}

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

impl NewWithNullPtr for wire_Wallet {
    fn new_with_null_ptr() -> Self {
        Self {
            ptr: core::ptr::null(),
        }
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
