#ifndef IQ4_F3_CORE_RECEIPT_01_H
#define IQ4_F3_CORE_RECEIPT_01_H
#include "render_plan.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Pure receipt model for a future exact-original hook. It neither reads a
 * native stack nor installs a hook. This proves one core pass, never an
 * entire PreviewProcess, 75% resample, orientation or JPEG transaction. */
struct f3_core_identity {
    uint64_t request, thread;
    uintptr_t settings, cancel, arena_base;
    uint64_t arena_bytes;
};
struct f3_core_entry {
    uintptr_t frame_sp, allocator, output, return_pc, arena_base;
    uint64_t arena_bytes;
    uintptr_t settings, cancel;
};
struct f3_core_terminal {
    struct f3_core_entry entry;
    uint32_t completed_stages, total_stages, thread_count, cancel_value;
};
struct f3_core_receipt {
    struct f3_core_identity identity;
    struct f3_core_entry entry;
    uint32_t armed, entered, terminal_seen, returned;
};
enum f3_result f3_core_arm(struct f3_core_receipt *, const struct f3_core_identity *);
enum f3_result f3_core_enter(struct f3_core_receipt *, uint64_t request, uint64_t thread,
                             const struct f3_core_entry *);
enum f3_result f3_core_terminal(struct f3_core_receipt *, uint64_t request, uint64_t thread,
                                const struct f3_core_terminal *);
enum f3_result f3_core_return(struct f3_core_receipt *, uint64_t request, uint64_t thread,
                              uintptr_t frame_sp);
#ifdef __cplusplus
}
#endif
#endif
