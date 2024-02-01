#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_Wallet {
  int32_t network;
  struct wire_uint_8_list *dbpath;
  struct wire_uint_8_list *desc;
} wire_Wallet;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_new_wallet__static_method__Api(int64_t port_,
                                         struct wire_uint_8_list *mnemonic,
                                         int32_t network,
                                         struct wire_uint_8_list *electrum_url,
                                         struct wire_uint_8_list *db_path);

void wire_sync__static_method__Api(int64_t port_,
                                   struct wire_uint_8_list *electrum_url,
                                   struct wire_Wallet *wallet);

void wire_address__static_method__Api(int64_t port_, struct wire_Wallet *wallet);

void wire_balance__static_method__Api(int64_t port_, struct wire_Wallet *wallet);

void wire_txs__static_method__Api(int64_t port_, struct wire_Wallet *wallet);

void wire_build_tx__static_method__Api(int64_t port_,
                                       struct wire_Wallet *wallet,
                                       uint64_t sats,
                                       struct wire_uint_8_list *out_address,
                                       float *abs_fee);

void wire_decode_tx__static_method__Api(int64_t port_,
                                        struct wire_Wallet *wallet,
                                        struct wire_uint_8_list *pset);

void wire_sign_tx__static_method__Api(int64_t port_,
                                      struct wire_Wallet *wallet,
                                      struct wire_uint_8_list *pset,
                                      struct wire_uint_8_list *mnemonic);

void wire_broadcast_tx__static_method__Api(int64_t port_,
                                           struct wire_uint_8_list *electrum_url,
                                           struct wire_uint_8_list *tx_bytes);

float *new_box_autoadd_f32_0(float value);

struct wire_Wallet *new_box_autoadd_wallet_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_new_wallet__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_sync__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_address__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_balance__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_txs__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_build_tx__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_decode_tx__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_sign_tx__static_method__Api);
    dummy_var ^= ((int64_t) (void*) wire_broadcast_tx__static_method__Api);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_f32_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_wallet_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
