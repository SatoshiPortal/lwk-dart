#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
// EXTRA BEGIN
typedef struct DartCObject *WireSyncRust2DartDco;
typedef struct WireSyncRust2DartSse {
  uint8_t *ptr;
  int32_t len;
} WireSyncRust2DartSse;

typedef int64_t DartPort;
typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);
void store_dart_post_cobject(DartPostCObjectFnType ptr);
// EXTRA END
typedef struct _Dart_Handle* Dart_Handle;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_blockchain {

} wire_cst_blockchain;

typedef struct wire_cst_wallet {
  uintptr_t inner;
} wire_cst_wallet;

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_descriptor {
  struct wire_cst_list_prim_u_8_strict *ct_descriptor;
} wire_cst_descriptor;

typedef struct wire_cst_balance {
  struct wire_cst_list_prim_u_8_strict *asset_id;
  int64_t value;
} wire_cst_balance;

typedef struct wire_cst_list_balance {
  struct wire_cst_balance *ptr;
  int32_t len;
} wire_cst_list_balance;

typedef struct wire_cst_out_point {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
} wire_cst_out_point;

typedef struct wire_cst_tx_out_secrets {
  uint64_t value;
  struct wire_cst_list_prim_u_8_strict *value_bf;
  struct wire_cst_list_prim_u_8_strict *asset;
  struct wire_cst_list_prim_u_8_strict *asset_bf;
} wire_cst_tx_out_secrets;

typedef struct wire_cst_address {
  struct wire_cst_list_prim_u_8_strict *standard;
  struct wire_cst_list_prim_u_8_strict *confidential;
  uint32_t *index;
  struct wire_cst_list_prim_u_8_strict *blinding_key;
} wire_cst_address;

typedef struct wire_cst_tx_out {
  struct wire_cst_list_prim_u_8_strict *script_pubkey;
  struct wire_cst_out_point outpoint;
  uint32_t *height;
  struct wire_cst_tx_out_secrets unblinded;
  bool is_spent;
  struct wire_cst_address address;
} wire_cst_tx_out;

typedef struct wire_cst_list_tx_out {
  struct wire_cst_tx_out *ptr;
  int32_t len;
} wire_cst_list_tx_out;

typedef struct wire_cst_tx {
  uint32_t *timestamp;
  struct wire_cst_list_prim_u_8_strict *kind;
  struct wire_cst_list_balance *balances;
  struct wire_cst_list_prim_u_8_strict *txid;
  struct wire_cst_list_tx_out *outputs;
  struct wire_cst_list_tx_out *inputs;
  uint64_t fee;
  uint32_t *height;
  struct wire_cst_list_prim_u_8_strict *unblinded_url;
  uintptr_t vsize;
} wire_cst_tx;

typedef struct wire_cst_list_tx {
  struct wire_cst_tx *ptr;
  int32_t len;
} wire_cst_list_tx;

typedef struct wire_cst_lwk_error {
  struct wire_cst_list_prim_u_8_strict *msg;
} wire_cst_lwk_error;

typedef struct wire_cst_pset_amounts {
  uint64_t absolute_fees;
  struct wire_cst_list_balance *balances;
} wire_cst_pset_amounts;

void frbgen_lwk_wire__crate__api__descriptor__descriptor_new_confidential(int64_t port_,
                                                                          int32_t network,
                                                                          struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_lwk_wire__crate__api__types__address_address_from_script(int64_t port_,
                                                                     int32_t network,
                                                                     struct wire_cst_list_prim_u_8_strict *script,
                                                                     struct wire_cst_list_prim_u_8_strict *blinding_key);

void frbgen_lwk_wire__crate__api__types__address_validate(int64_t port_,
                                                          struct wire_cst_list_prim_u_8_strict *address_string);

void frbgen_lwk_wire__crate__api__types__blockchain_test(int64_t port_,
                                                         struct wire_cst_blockchain *that,
                                                         struct wire_cst_list_prim_u_8_strict *electrum_url);

void frbgen_lwk_wire__crate__api__wallet__wallet_address(int64_t port_,
                                                         struct wire_cst_wallet *that,
                                                         uint32_t index);

void frbgen_lwk_wire__crate__api__wallet__wallet_address_last_unused(int64_t port_,
                                                                     struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_balances(int64_t port_,
                                                          struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_blinding_key(int64_t port_,
                                                              struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_broadcast_tx(int64_t port_,
                                                              struct wire_cst_list_prim_u_8_strict *electrum_url,
                                                              struct wire_cst_list_prim_u_8_loose *tx_bytes);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_asset_tx(int64_t port_,
                                                                struct wire_cst_wallet *that,
                                                                uint64_t sats,
                                                                struct wire_cst_list_prim_u_8_strict *out_address,
                                                                float fee_rate,
                                                                struct wire_cst_list_prim_u_8_strict *asset);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_lbtc_tx(int64_t port_,
                                                               struct wire_cst_wallet *that,
                                                               uint64_t sats,
                                                               struct wire_cst_list_prim_u_8_strict *out_address,
                                                               float fee_rate,
                                                               bool drain);

void frbgen_lwk_wire__crate__api__wallet__wallet_decode_tx(int64_t port_,
                                                           struct wire_cst_wallet *that,
                                                           struct wire_cst_list_prim_u_8_strict *pset);

void frbgen_lwk_wire__crate__api__wallet__wallet_descriptor(int64_t port_,
                                                            struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_init(int64_t port_,
                                                      int32_t network,
                                                      struct wire_cst_list_prim_u_8_strict *dbpath,
                                                      struct wire_cst_descriptor *descriptor);

void frbgen_lwk_wire__crate__api__wallet__wallet_sign_tx(int64_t port_,
                                                         struct wire_cst_wallet *that,
                                                         int32_t network,
                                                         struct wire_cst_list_prim_u_8_strict *pset,
                                                         struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_lwk_wire__crate__api__wallet__wallet_signed_pset_with_extra_details(int64_t port_,
                                                                                struct wire_cst_wallet *that,
                                                                                int32_t network,
                                                                                struct wire_cst_list_prim_u_8_strict *pset,
                                                                                struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_lwk_wire__crate__api__wallet__wallet_sync(int64_t port_,
                                                      struct wire_cst_wallet *that,
                                                      struct wire_cst_list_prim_u_8_strict *electrum_url,
                                                      bool validate_domain);

void frbgen_lwk_wire__crate__api__wallet__wallet_txs(int64_t port_, struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_utxos(int64_t port_, struct wire_cst_wallet *that);

void frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet(const void *ptr);

void frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet(const void *ptr);

struct wire_cst_blockchain *frbgen_lwk_cst_new_box_autoadd_blockchain(void);

struct wire_cst_descriptor *frbgen_lwk_cst_new_box_autoadd_descriptor(void);

uint32_t *frbgen_lwk_cst_new_box_autoadd_u_32(uint32_t value);

struct wire_cst_wallet *frbgen_lwk_cst_new_box_autoadd_wallet(void);

struct wire_cst_list_balance *frbgen_lwk_cst_new_list_balance(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_lwk_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_lwk_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_tx *frbgen_lwk_cst_new_list_tx(int32_t len);

struct wire_cst_list_tx_out *frbgen_lwk_cst_new_list_tx_out(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_blockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_descriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_wallet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__descriptor__descriptor_new_confidential);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__address_address_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__address_validate);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__blockchain_test);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_address);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_address_last_unused);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_balances);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_blinding_key);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_broadcast_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_asset_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_lbtc_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_decode_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_descriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_init);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_sign_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_signed_pset_with_extra_details);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_sync);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_txs);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_utxos);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    return dummy_var;
}
