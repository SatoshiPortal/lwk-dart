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

/**
 * Upper sanity bound on the fee rate, in sats/kvB: 100 sat/vB.
 *
 * Liquid fees sit around 0.1 sat/vB, so this is three orders of magnitude of
 * headroom. It exists to stop a fat-fingered or unit-confused value, not to
 * express policy.
 */
#define MAX_FEE_RATE_SATS_PER_KVB 100000.0

/**
 * UTXO count above which consolidation is offered
 */
#define HIGH_UTXO_THRESHOLD 125

/**
 * Max inputs per consolidation tx (safety margin under the 256 hard limit)
 */
#define MAXIMUM_INPUTS 250

typedef struct wire_cst_list_prim_u_8_loose {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_loose;

typedef struct wire_cst_list_prim_u_8_strict {
  uint8_t *ptr;
  int32_t len;
} wire_cst_list_prim_u_8_strict;

typedef struct wire_cst_blockchain {

} wire_cst_blockchain;

typedef struct wire_cst_wallet_balance {
  struct wire_cst_list_prim_u_8_strict *asset_id;
  uint64_t value;
} wire_cst_wallet_balance;

typedef struct wire_cst_list_wallet_balance {
  struct wire_cst_wallet_balance *ptr;
  int32_t len;
} wire_cst_list_wallet_balance;

typedef struct wire_cst_wallet {
  uintptr_t inner;
} wire_cst_wallet;

typedef struct wire_cst_out_point {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
} wire_cst_out_point;

typedef struct wire_cst_list_out_point {
  struct wire_cst_out_point *ptr;
  int32_t len;
} wire_cst_list_out_point;

typedef struct wire_cst_tx_output_spec {
  struct wire_cst_list_prim_u_8_strict *address;
  uint64_t satoshi;
  struct wire_cst_list_prim_u_8_strict *asset_id;
} wire_cst_tx_output_spec;

typedef struct wire_cst_list_tx_output_spec {
  struct wire_cst_tx_output_spec *ptr;
  int32_t len;
} wire_cst_list_tx_output_spec;

typedef struct wire_cst_descriptor {
  struct wire_cst_list_prim_u_8_strict *ct_descriptor;
} wire_cst_descriptor;

typedef struct wire_cst_pset_input {
  struct wire_cst_list_prim_u_8_strict *witness_utxo_script;
  uint64_t *witness_utxo_amount;
  struct wire_cst_list_prim_u_8_strict *witness_utxo_asset;
} wire_cst_pset_input;

typedef struct wire_cst_pset_output {
  struct wire_cst_list_prim_u_8_strict *script_pubkey;
  uint64_t *amount;
  struct wire_cst_list_prim_u_8_strict *asset;
  struct wire_cst_list_prim_u_8_strict *blinding_key;
} wire_cst_pset_output;

typedef struct wire_cst_list_String {
  struct wire_cst_list_prim_u_8_strict **ptr;
  int32_t len;
} wire_cst_list_String;

typedef struct wire_cst_tx_input {
  struct wire_cst_list_prim_u_8_strict *txid;
  uint32_t vout;
  struct wire_cst_list_prim_u_8_strict *script_sig;
  uint32_t sequence;
  struct wire_cst_list_String *witness;
  bool is_pegin;
} wire_cst_tx_input;

typedef struct wire_cst_tx_output {
  struct wire_cst_list_prim_u_8_strict *script_pubkey;
  struct wire_cst_list_prim_u_8_strict *asset;
  uint64_t *value;
  struct wire_cst_list_prim_u_8_strict *nonce;
} wire_cst_tx_output;

typedef struct wire_cst_balance {
  struct wire_cst_list_prim_u_8_strict *asset_id;
  int64_t value;
} wire_cst_balance;

typedef struct wire_cst_list_balance {
  struct wire_cst_balance *ptr;
  int32_t len;
} wire_cst_list_balance;

typedef struct wire_cst_list_pset_input {
  struct wire_cst_pset_input *ptr;
  int32_t len;
} wire_cst_list_pset_input;

typedef struct wire_cst_list_pset_output {
  struct wire_cst_pset_output *ptr;
  int32_t len;
} wire_cst_list_pset_output;

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

typedef struct wire_cst_list_tx_input {
  struct wire_cst_tx_input *ptr;
  int32_t len;
} wire_cst_list_tx_input;

typedef struct wire_cst_list_tx_out_secrets {
  struct wire_cst_tx_out_secrets *ptr;
  int32_t len;
} wire_cst_list_tx_out_secrets;

typedef struct wire_cst_list_tx_output {
  struct wire_cst_tx_output *ptr;
  int32_t len;
} wire_cst_list_tx_output;

typedef struct wire_cst_lwk_error {
  struct wire_cst_list_prim_u_8_strict *msg;
} wire_cst_lwk_error;

typedef struct wire_cst_payjoin_tx {
  struct wire_cst_list_prim_u_8_strict *pset;
  uint64_t network_fee;
  uint64_t asset_fee;
  struct wire_cst_list_tx_out_secrets *unblinded_outputs;
} wire_cst_payjoin_tx;

typedef struct wire_cst_pset_amounts {
  uint64_t absolute_fees;
  struct wire_cst_list_balance *balances;
} wire_cst_pset_amounts;

typedef struct wire_cst_size_and_fees {
  uintptr_t discounted_vsize;
  uintptr_t discounted_weight;
  struct wire_cst_list_wallet_balance *absolute_fees;
} wire_cst_size_and_fees;

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_fee(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_from_bytes(struct wire_cst_list_prim_u_8_loose *tx_bytes);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_from_pset(struct wire_cst_list_prim_u_8_strict *pset_string);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_input(uintptr_t that,
                                                                                           uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_inputs(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output(uintptr_t that,
                                                                                            uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_asset(uintptr_t that,
                                                                                                  uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_nonce(uintptr_t that,
                                                                                                  uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_script_pubkey(uintptr_t that,
                                                                                                          uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_value(uintptr_t that,
                                                                                                  uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_outputs(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_input_count(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_is_coinbase(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_lock_time(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_output_count(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_to_bytes(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_txid(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_version(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_vsize(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_weight(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_extract_tx(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_from_string(struct wire_cst_list_prim_u_8_strict *pset_string);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input(uintptr_t that,
                                                                                                            uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_amount(uintptr_t that,
                                                                                                                        uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_asset(uintptr_t that,
                                                                                                                       uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_script(uintptr_t that,
                                                                                                                        uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_inputs(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output(uintptr_t that,
                                                                                                             uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_amount(uintptr_t that,
                                                                                                                    uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_asset(uintptr_t that,
                                                                                                                   uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_blinding_key(uintptr_t that,
                                                                                                                          uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_script(uintptr_t that,
                                                                                                                    uintptr_t index);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_outputs(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_input_count(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_lock_time(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_output_count(uintptr_t that);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_to_string(uintptr_t that);

void frbgen_lwk_wire__crate__api__types__address_address_from_script(int64_t port_,
                                                                     int32_t network,
                                                                     struct wire_cst_list_prim_u_8_strict *script,
                                                                     struct wire_cst_list_prim_u_8_strict *blinding_key);

void frbgen_lwk_wire__crate__api__types__address_validate(int64_t port_,
                                                          struct wire_cst_list_prim_u_8_strict *address_string);

void frbgen_lwk_wire__crate__api__blockchain__blockchain_broadcast_signed_pset(int64_t port_,
                                                                               struct wire_cst_list_prim_u_8_strict *electrum_url,
                                                                               struct wire_cst_list_prim_u_8_strict *signed_pset);

void frbgen_lwk_wire__crate__api__blockchain__blockchain_broadcast_tx_bytes(int64_t port_,
                                                                            struct wire_cst_list_prim_u_8_strict *electrum_url,
                                                                            struct wire_cst_list_prim_u_8_loose *tx_bytes);

void frbgen_lwk_wire__crate__api__blockchain__blockchain_test(int64_t port_,
                                                              struct wire_cst_blockchain *that,
                                                              struct wire_cst_list_prim_u_8_strict *electrum_url);

void frbgen_lwk_wire__crate__api__descriptor__descriptor_new_confidential(int64_t port_,
                                                                          int32_t network,
                                                                          struct wire_cst_list_prim_u_8_strict *mnemonic);

void frbgen_lwk_wire__crate__api__transaction__extract_tx_bytes(int64_t port_,
                                                                struct wire_cst_list_prim_u_8_strict *pset);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__types__get_balance_by_asset_id(struct wire_cst_list_wallet_balance *balances,
                                                                                 struct wire_cst_list_prim_u_8_strict *asset_id);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__types__get_lbtc_asset_id(void);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__types__get_lbtc_balance(struct wire_cst_list_wallet_balance *balances);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__types__get_ltest_asset_id(void);

WireSyncRust2DartDco frbgen_lwk_wire__crate__api__types__get_ltest_balance(struct wire_cst_list_wallet_balance *balances);

void frbgen_lwk_wire__crate__api__transaction__get_size_and_absolute_fees(int64_t port_,
                                                                          struct wire_cst_list_prim_u_8_strict *pset);

void frbgen_lwk_wire__crate__api__wallet__wallet_address(int64_t port_,
                                                         struct wire_cst_wallet *that,
                                                         uint32_t index);

void frbgen_lwk_wire__crate__api__wallet__wallet_address_last_unused(int64_t port_,
                                                                     struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_balances(int64_t port_,
                                                          struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_blinding_key(int64_t port_,
                                                              struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_asset_tx(int64_t port_,
                                                                struct wire_cst_wallet *that,
                                                                uint64_t sats,
                                                                struct wire_cst_list_prim_u_8_strict *out_address,
                                                                float fee_rate,
                                                                struct wire_cst_list_prim_u_8_strict *asset);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_custom_tx(int64_t port_,
                                                                 struct wire_cst_wallet *that,
                                                                 struct wire_cst_list_out_point *utxos,
                                                                 struct wire_cst_list_tx_output_spec *outputs,
                                                                 struct wire_cst_list_prim_u_8_strict *drain_to,
                                                                 float fee_rate);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_lbtc_tx(int64_t port_,
                                                               struct wire_cst_wallet *that,
                                                               uint64_t sats,
                                                               struct wire_cst_list_prim_u_8_strict *out_address,
                                                               float fee_rate,
                                                               bool drain);

void frbgen_lwk_wire__crate__api__wallet__wallet_build_payjoin_tx(int64_t port_,
                                                                  struct wire_cst_wallet *that,
                                                                  uint64_t sats,
                                                                  struct wire_cst_list_prim_u_8_strict *out_address,
                                                                  struct wire_cst_list_prim_u_8_strict *asset,
                                                                  int32_t network,
                                                                  struct wire_cst_list_prim_u_8_strict *base_url,
                                                                  bool is_send_all);

void frbgen_lwk_wire__crate__api__wallet__wallet_consolidate(int64_t port_,
                                                             struct wire_cst_wallet *that,
                                                             float fee_rate,
                                                             uint32_t *high_utxo_threshold,
                                                             uint32_t *maximum_inputs);

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
                                                      bool validate_domain,
                                                      uint32_t *stop_at_index,
                                                      uint8_t *timeout);

void frbgen_lwk_wire__crate__api__wallet__wallet_txs(int64_t port_, struct wire_cst_wallet *that);

void frbgen_lwk_wire__crate__api__wallet__wallet_utxos(int64_t port_, struct wire_cst_wallet *that);

void frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet(const void *ptr);

void frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet(const void *ptr);

void frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLiquidTransaction(const void *ptr);

void frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLiquidTransaction(const void *ptr);

void frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerPartiallySignedElementsTransaction(const void *ptr);

void frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerPartiallySignedElementsTransaction(const void *ptr);

struct wire_cst_blockchain *frbgen_lwk_cst_new_box_autoadd_blockchain(void);

struct wire_cst_descriptor *frbgen_lwk_cst_new_box_autoadd_descriptor(void);

struct wire_cst_pset_input *frbgen_lwk_cst_new_box_autoadd_pset_input(void);

struct wire_cst_pset_output *frbgen_lwk_cst_new_box_autoadd_pset_output(void);

struct wire_cst_tx_input *frbgen_lwk_cst_new_box_autoadd_tx_input(void);

struct wire_cst_tx_output *frbgen_lwk_cst_new_box_autoadd_tx_output(void);

uint32_t *frbgen_lwk_cst_new_box_autoadd_u_32(uint32_t value);

uint64_t *frbgen_lwk_cst_new_box_autoadd_u_64(uint64_t value);

uint8_t *frbgen_lwk_cst_new_box_autoadd_u_8(uint8_t value);

struct wire_cst_wallet *frbgen_lwk_cst_new_box_autoadd_wallet(void);

struct wire_cst_list_String *frbgen_lwk_cst_new_list_String(int32_t len);

struct wire_cst_list_balance *frbgen_lwk_cst_new_list_balance(int32_t len);

struct wire_cst_list_out_point *frbgen_lwk_cst_new_list_out_point(int32_t len);

struct wire_cst_list_prim_u_8_loose *frbgen_lwk_cst_new_list_prim_u_8_loose(int32_t len);

struct wire_cst_list_prim_u_8_strict *frbgen_lwk_cst_new_list_prim_u_8_strict(int32_t len);

struct wire_cst_list_pset_input *frbgen_lwk_cst_new_list_pset_input(int32_t len);

struct wire_cst_list_pset_output *frbgen_lwk_cst_new_list_pset_output(int32_t len);

struct wire_cst_list_tx *frbgen_lwk_cst_new_list_tx(int32_t len);

struct wire_cst_list_tx_input *frbgen_lwk_cst_new_list_tx_input(int32_t len);

struct wire_cst_list_tx_out *frbgen_lwk_cst_new_list_tx_out(int32_t len);

struct wire_cst_list_tx_out_secrets *frbgen_lwk_cst_new_list_tx_out_secrets(int32_t len);

struct wire_cst_list_tx_output *frbgen_lwk_cst_new_list_tx_output(int32_t len);

struct wire_cst_list_tx_output_spec *frbgen_lwk_cst_new_list_tx_output_spec(int32_t len);

struct wire_cst_list_wallet_balance *frbgen_lwk_cst_new_list_wallet_balance(int32_t len);
static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_blockchain);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_descriptor);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_pset_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_pset_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_tx_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_tx_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_u_32);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_u_64);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_u_8);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_box_autoadd_wallet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_String);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_out_point);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_prim_u_8_loose);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_prim_u_8_strict);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_pset_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_pset_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_out);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_out_secrets);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_tx_output_spec);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_cst_new_list_wallet_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_Mutexlwk_wolletWollet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLiquidTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_decrement_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerPartiallySignedElementsTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_Mutexlwk_wolletWollet);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerLiquidTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_rust_arc_increment_strong_count_RustOpaque_flutter_rust_bridgefor_generatedRustAutoOpaqueInnerPartiallySignedElementsTransaction);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__blockchain__blockchain_broadcast_signed_pset);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__blockchain__blockchain_broadcast_tx_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__blockchain__blockchain_test);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__descriptor__descriptor_new_confidential);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_fee);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_from_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_from_pset);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_inputs);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_asset);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_nonce);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_script_pubkey);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_output_value);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_get_outputs);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_input_count);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_is_coinbase);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_output_count);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_to_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_txid);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_version);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_vsize);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__LiquidTransaction_weight);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_extract_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_from_string);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_asset);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_input_utxo_script);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_inputs);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_amount);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_asset);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_blinding_key);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_output_script);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_get_outputs);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_input_count);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_lock_time);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_output_count);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__PartiallySignedElementsTransaction_to_string);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__extract_tx_bytes);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__transaction__get_size_and_absolute_fees);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__address_address_from_script);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__address_validate);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__get_balance_by_asset_id);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__get_lbtc_asset_id);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__get_lbtc_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__get_ltest_asset_id);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__types__get_ltest_balance);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_address);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_address_last_unused);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_balances);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_blinding_key);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_asset_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_custom_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_lbtc_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_build_payjoin_tx);
    dummy_var ^= ((int64_t) (void*) frbgen_lwk_wire__crate__api__wallet__wallet_consolidate);
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
