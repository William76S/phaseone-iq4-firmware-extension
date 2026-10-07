#include "../native_linked_contract_01/contract.h"
#include "../native_copy_rtti_01/rtti.h"
#include "../native_runtime_01/self_read.h"

extern void iq4_f1_menu_initialize_04(void);
static struct Iq4LinkedContractRead01 linked_reader = {0, iq4_native_self_read_01};
static uint32_t installation_state, installation_stage, installation_error;

uint32_t iq4_extensions_installation_error_02(void) {
    return __atomic_load_n(&installation_error, __ATOMIC_ACQUIRE);
}
uint32_t iq4_extensions_installation_stage_02(void) {
    return __atomic_load_n(&installation_stage, __ATOMIC_ACQUIRE);
}
int iq4_extensions_contract_current_01(void *v) {
    struct Iq4LinkedContractRead01 *r = v;
    return r && iq4_linked_contract_current_01(r) == 1 &&
        iq4_native_copy_rtti_current_01(r->context, r->read) == 1;
}

/* Process-local read-only admission. No old F3 coordinator, decoder, executor,
 * storage override, Card/TLS/Reader/pool creation or JPEG-only RAW removal.
 * Stage100 means sealed-link/RTTI checks passed, not camera capability proof.
 * Preserved F4 resources remain lazy on their existing UI/worker path.
 * Any new stock-JPEG component supplies its own checked native UI/worker hook.
 */
void iq4_extensions_initialize_01(void) {
    uint32_t idle = 0;
    if (__atomic_compare_exchange_n(&installation_state, &idle, 1, 0,
                                   __ATOMIC_ACQ_REL, __ATOMIC_ACQUIRE)) {
        __atomic_store_n(&installation_stage, 10, __ATOMIC_RELEASE);
        int ok = iq4_linked_contract_current_01(&linked_reader) == 1;
        if (!ok) __atomic_store_n(&installation_error, 10, __ATOMIC_RELEASE);
        if (ok) {
            __atomic_store_n(&installation_stage, 20, __ATOMIC_RELEASE);
            ok = iq4_native_copy_rtti_current_01(linked_reader.context,
                                                linked_reader.read) == 1;
            if (!ok) __atomic_store_n(&installation_error, 20, __ATOMIC_RELEASE);
        }
        if (ok) __atomic_store_n(&installation_stage, 100, __ATOMIC_RELEASE);
        __atomic_store_n(&installation_state, ok ? 2u : 3u, __ATOMIC_RELEASE);
    }
    /* Settings load stays connected to real executable startup even if a
     * separate admission check fails; never move file I/O into LV getters. */
    iq4_f1_menu_initialize_04();
}
