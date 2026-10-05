#ifndef IQ4_F4_NATIVE_LIVENESS06_H
#define IQ4_F4_NATIVE_LIVENESS06_H
/* UI thread only. Original LV client ownership: 1 acquired, 0 released, -1 unknown.
 * This does not start, stop, restart or alter the original camera pipeline. */
int iq4_f4_source_native_owned_on_ui_06(void *);
#endif
