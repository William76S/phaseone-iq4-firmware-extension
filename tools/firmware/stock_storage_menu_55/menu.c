#include "../stock_storage_router_55/router.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include "pins.h"
#include <string.h>

extern uint32_t iq4_extensions_installation_stage_02(void);
static void *format_menu, *format_items[3];
static uintptr_t bound_parent, queue, manager, menu_table[24], item_table[22];
static unsigned building, held;
static const char *const format_names[3] = {"JPEG Only", "IIQ Only", "IIQ+JPEG"};
static const uint32_t format_values[3] = {IQ4_STORAGE_JPEG_ONLY_55, IQ4_STORAGE_IIQ_ONLY_55, IQ4_STORAGE_IIQ_JPEG_55};

static int rd(uintptr_t p, void *out, size_t n) {
    return p >= 4096 && n && n <= 4096 && p <= UINTPTR_MAX-n &&
        iq4_native_self_read_01(0,p,out,n) == 1;
}
static int word(uintptr_t p, uintptr_t *out) {
    uintptr_t again;
    return rd(p,out,8) && rd(p,&again,8) && again == *out;
}
static int pins(void) {
    unsigned char b[64];
    for (unsigned i=0;i<sizeof MenuPins01/sizeof *MenuPins01;++i) {
        const struct MenuPin01 *p=MenuPins01+i;
        for (size_t j=0;j<p->bytes;j+=sizeof b) {
            size_t n=p->bytes-j;
            if (n>sizeof b) n=sizeof b;
            if (!rd(p->va+j,b,n)||memcmp(b,p->data+j,n)) return 0;
        }
    }
    return 1;
}
static void put(void *p,size_t off,uintptr_t v) {
    memcpy((char *)p+off,&v,8);
}
static char *text(char *b,int32_t n,const char *s) {
    int32_t i=0;
    if (!b||n<=0) return (char *)"";
    for (;i+1<n&&s[i];++i) b[i]=s[i];
    b[i]=0; return b;
}
static unsigned index_of(void *p,void *const *a,unsigned count) {
    for (unsigned i=0;i<count;++i) if (p&&p==a[i]) return i;
    return count;
}
static int on_ui(void) {
    uintptr_t q,v,m,back;
    return queue && iq4_f4_native_current_02(&q) && q==queue &&
        word(q,&v) && v==0xb91f48 && word(q+0x1c8,&m) && m==manager &&
        word(m,&v) && v==0xb8f358 && word(m+8,&back) && back==q;
}
static int present(uintptr_t parent,uintptr_t item) {
    uintptr_t head=parent+0x28,prev=head,p,tail,v,next,back,value;
    unsigned count=0,found=0;
    if (!word(parent+0x18,&v)||v!=0xb8faa0||
        !word(parent+0x20,&v)||v!=0xc22908||!word(head,&v)||v!=0xc22960||
        !word(head+8,&p)||!word(head+16,&tail)) return -1;
    while (p!=head) {
        if (!p||(p&7)||++count>64||!word(p,&v)||v!=0xb8f958||
            !word(p+8,&next)||!word(p+16,&back)||back!=prev||
            !word(p+24,&value)) return -1;
        if (value==item) ++found;
        prev=p; p=next;
    }
    return tail==prev&&found<=1?(int)found:-1;
}
static char *menu_name(void *p,char *b,int32_t n) {
    return text(b,n,p==format_menu?"XQD Storage":"");
}
static char *menu_value(void *p,char *b,int32_t n) {
    uint32_t format;
    if(p!=format_menu||!iq4_stock_xqd_format_get_55(&format))return text(b,n,"");
    for(unsigned i=0;i<3;++i)if(format_values[i]==format)return text(b,n,format_names[i]);
    return text(b,n,"");
}
static char *item_name(void *p,char *b,int32_t n) {
    unsigned i=index_of(p,format_items,3);
    return text(b,n,i<3?format_names[i]:"");
}
static char *item_value(void *p,char *b,int32_t n) {
    unsigned i=index_of(p,format_items,3);uint32_t format;
    return text(b,n,i<3&&iq4_stock_xqd_format_get_55(&format)&&format==format_values[i]?"Selected":"");
}
static uint32_t activate(void *p) {
    if(held||!on_ui())return 0;
    unsigned i=index_of(p,format_items,3);
    /* Backend owns admission, persistence and per-capture snapshot. A rejected
     * change does not create UI-only state or claim that an output was written. */
    return i<3&&iq4_stock_xqd_format_set_55(format_values[i])==1?1u:0u;
}
static int construct(void **out,size_t bytes,uintptr_t ctor,uintptr_t *table) {
    if (!iq4_f4_menu_new_03(bytes,out)||!*out||!iq4_f4_menu_ctor_03(ctor,*out)) return 0;
    put(*out,0,(uintptr_t)&table[2]); return 1;
}

/* 54's size wrapper remains byte-identical: it chooses the existing 4K/50%
 * child and appends it exactly once before calling this ABI. Here the removed
 * 52 JPEG Export helper is replaced with one format menu, no Mode/Destination.
 * Original SD Storage policy and the size DTO/event remain untouched.
 * The backend applies this single format to XQD or SD Primary/SD-only.
 * Construction failure keeps the partial tree detached and retained.
 */
void iq4_stock_jpeg_after_menu_append_01(void *root,void *original,uintptr_t pc) {
    uintptr_t parent=(uintptr_t)root,v,dto,q,m,back;
    uint32_t title;
    if (pc!=0x4f052c||!root||!original||parent<4096||(parent&7)||
        ((uintptr_t)original&7)||held||building||
        iq4_extensions_installation_stage_02()!=100||!pins()||
        !word(parent,&v)||v!=0xb8f9b8||!rd(parent+0x14,&title,4)||title!=389||
        !word((uintptr_t)original,&v)||v!=0xb8fd40||
        !word((uintptr_t)original+0x18,&dto)||!word(dto,&v)||v!=0xbbf3f8) return;
    if (!iq4_f4_native_current_02(&q)||!word(q,&v)||v!=0xb91f48||
        !word(q+0x1c8,&m)||!word(m,&v)||v!=0xb8f358||
        !word(m+8,&back)||back!=q) return;
    if (bound_parent && (parent!=bound_parent||q!=queue||m!=manager)) return;
    int attached=present(parent,(uintptr_t)format_menu);
    if (attached<0||attached) return;
    queue=q; manager=m; building=1;
    for (unsigned i=0;i<24;++i) if (!word(0xb8f9a8+8*i,&menu_table[i])) goto fail;
    for (unsigned i=0;i<22;++i) if (!word(0xb90738+8*i,&item_table[i])) goto fail;
    menu_table[5]=(uintptr_t)menu_name; menu_table[6]=(uintptr_t)menu_value;
    item_table[5]=(uintptr_t)item_name; item_table[6]=(uintptr_t)item_value;
    item_table[12]=(uintptr_t)activate;
    if (!construct(&format_menu,0x118,0x4e5744,menu_table)) goto fail;
    for (unsigned i=0;i<3;++i)
        if (!construct(format_items+i,0x38,0x4e9d30,item_table)) goto fail;
    for (unsigned i=0;i<3;++i)
        if (!iq4_f4_menu_append_03(format_menu,format_items[i])) goto fail;
    if (!iq4_f4_menu_append_03(root,format_menu)||
        present(parent,(uintptr_t)format_menu)!=1) goto fail;
    bound_parent=parent; building=0; return;
fail:
    held=1;
}
