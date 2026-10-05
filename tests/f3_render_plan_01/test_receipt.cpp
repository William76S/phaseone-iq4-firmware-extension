#include "core_receipt.h"
#include <cstdlib>
#include <iostream>
static unsigned passed = 0;
static void check(bool v) { if (!v) std::exit(1); ++passed; }
int main() {
    f3_core_identity i{42,7,0x1000,0x2000,0x10000000,0x100000};
    f3_core_entry e{0x70000000,0x3000,0x4000,0x964864,0x10001000,0x80000,0x1000,0x2000};
    struct f3_core_terminal t{e,3,3,3,0}; f3_core_receipt r{};
    check(f3_core_arm(&r,&i)==F3_OK && f3_core_enter(&r,42,7,&e)==F3_OK);
    check(f3_core_return(&r,42,7,e.frame_sp)==F3_NATIVE_FAILURE); // capacity early return
    check(f3_core_arm(&r,&i)==F3_OK && f3_core_enter(&r,42,7,&e)==F3_OK);
    t.completed_stages=2;
    check(f3_core_terminal(&r,42,7,&t)==F3_NATIVE_FAILURE); // cancel reaches same terminal address
    t.completed_stages=3;t.cancel_value=1;
    check(f3_core_terminal(&r,42,7,&t)==F3_NATIVE_FAILURE);
    t.cancel_value=0;t.thread_count=0;
    check(f3_core_terminal(&r,42,7,&t)==F3_NATIVE_FAILURE);
    t.thread_count=3;t.total_stages=0;
    check(f3_core_terminal(&r,42,7,&t)==F3_NATIVE_FAILURE);
    t.total_stages=3;
    check(f3_core_terminal(&r,43,7,&t)==F3_BAD_STATE &&
          f3_core_terminal(&r,42,8,&t)==F3_BAD_STATE);
    t.entry.frame_sp++;
    check(f3_core_terminal(&r,42,7,&t)==F3_BAD_STATE);
    t.entry=e;t.entry.output++;
    check(f3_core_terminal(&r,42,7,&t)==F3_BAD_STATE);
    t.entry=e;
    check(f3_core_terminal(&r,42,7,&t)==F3_OK &&
          f3_core_terminal(&r,42,7,&t)==F3_BAD_STATE);
    check(f3_core_return(&r,42,7,e.frame_sp)==F3_OK &&
          f3_core_return(&r,42,7,e.frame_sp)==F3_BAD_STATE);
    check(f3_core_arm(&r,&i)==F3_OK);
    e.arena_base=0x20000000;
    check(f3_core_enter(&r,42,7,&e)==F3_BAD_ARGUMENT); // stock allocator is outside owned backing
    e.arena_base=0x10001000;e.return_pc=0x7b7ed4;
    check(f3_core_enter(&r,42,7,&e)==F3_BAD_ARGUMENT);
    std::cout << "{\"schema\":\"iq4_f3_core_receipt_host_model_01\",\"passed\":" << passed
              << ",\"native_hook_installed\":false,\"whole_render_proved\":false}\n";
}
