#include "../native_linked_contract_01/contract.h"
#include "../native_runtime_01/self_read.h"
#include <assert.h>

#ifndef FAIL_STAGE
#define FAIL_STAGE 0
#endif
static unsigned contracts, rtti, menus;
extern void iq4_extensions_initialize_01(void);
extern uint32_t iq4_extensions_installation_stage_02(void);
extern uint32_t iq4_extensions_installation_error_02(void);
int iq4_native_self_read_01(void *c, uintptr_t p, void *out, size_t n) {
    (void)c; (void)p; (void)out; (void)n; return 0;
}
int iq4_linked_contract_current_01(void *v) {
    struct Iq4LinkedContractRead01 *r = v;
    assert(r && !r->context && r->read == iq4_native_self_read_01);
    ++contracts; return FAIL_STAGE != 10;
}
int iq4_native_copy_rtti_current_01(void *c,
        int (*read)(void *, uintptr_t, void *, size_t)) {
    assert(!c && read == iq4_native_self_read_01);
    ++rtti; return FAIL_STAGE != 20;
}
void iq4_f1_menu_initialize_04(void) { ++menus; }
int main(void) {
    assert(!iq4_extensions_installation_stage_02());
    iq4_extensions_initialize_01();
    iq4_extensions_initialize_01();
    assert(contracts == 1 && rtti == (FAIL_STAGE == 10 ? 0u : 1u));
    assert(menus == 2); /* Mask settings startup remains connected on failure. */
    assert(iq4_extensions_installation_stage_02() == (FAIL_STAGE ? FAIL_STAGE : 100));
    assert(iq4_extensions_installation_error_02() == FAIL_STAGE);
    return 0;
}
