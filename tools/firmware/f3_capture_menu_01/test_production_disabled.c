#include <stdint.h>
#include <stdio.h>
extern void iq4_f3_after_file_settings_append_01(void*,uintptr_t);
int main(void) {
    /* EN0 must not dereference even a supplied native-looking/invalid pointer. */
    iq4_f3_after_file_settings_append_01((void*)(uintptr_t)1,0x4f0d38);
    iq4_f3_after_file_settings_append_01(0,0x4f0d38);
    puts("PASS: production EN0 performs no menu or native read/call");return 0;
}
