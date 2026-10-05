/* Preserve source05 frame handling; add only an original-LV client-ownership query. Native stop 0x520590 releases the client
 * at 0x520658 and clears LV+0x104 at 0x520660. A temporary lack of
 * new frames does not by itself mean that this flag is zero. */
#include "../f4_native_source_05/source.c"
#include "liveness.h"
int iq4_f4_source_native_owned_on_ui_06(void *p) {
 Source *s=p; uint8_t first,second;
 if(!s||!on_ui(s)||loaded(&s->hold)||
    !rd(s,s->owner.lv+0x104,&first,1)||
    !rd(s,s->owner.lv+0x104,&second,1)||first!=second||first>1)return -1;
 return first;
}
