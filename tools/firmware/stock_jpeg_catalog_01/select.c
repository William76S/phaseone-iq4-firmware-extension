#include <stdint.h>
#include <stddef.h>
extern uint32_t iq4_stock_jpeg_destination_get_01(void);

/* Called only from the two exact loads in the original directory scanner.
 * The native scanner's catalog pointer and saved incoming flag are borrowed.
 * Keep RAW flag4 on SD, and preserve the original JPEG completion flag16;
 * selecting a filesystem never pretends that a file was enumerated or saved.
 */
uintptr_t iq4_stock_jpeg_catalog_select_01(uintptr_t catalog,uint32_t flag,uint32_t path) {
    size_t offset=path?0x7b0u:0x7a0u;
    if (flag==16u && iq4_stock_jpeg_destination_get_01()==11u) offset+=0x30u;
    uintptr_t value;
    __builtin_memcpy(&value,(const void *)(catalog+offset),sizeof value);
    return value;
}
