#include "../f3_stock_half_export_01/half.h"
#include "../f3_stock_half_export_01/quality.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include "../stock_jpeg_half_status_menu_55/pins.h"
#include "../stock_storage_router_55/status.h"
#include <string.h>
#include "../half_entry_trace_58/trace.h"
#include "../f3_native_half_01/half.h"
extern uint32_t iq4_extensions_installation_stage_02(void);
static void *size_menu,*size_items[2],*quality_item,*status_item,*saved_original;
static uintptr_t saved_parent,queue,manager,menu_table[24],item_table[22];
static unsigned building,held;
static const char *const labels[2]={"4K","50%"};

static int rd(uintptr_t p,void *out,size_t n) {
    return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&
        iq4_native_self_read_01(0,p,out,n)==1;
}
static int word(uintptr_t p,uintptr_t *out) {
    uintptr_t again;
    return rd(p,out,8)&&rd(p,&again,8)&&again==*out;
}
static int pins(void) {
    unsigned char b[64];
    for(unsigned i=0;i<sizeof MenuPins01/sizeof *MenuPins01;++i) {
        const struct MenuPin01 *p=MenuPins01+i;
        for(size_t j=0;j<p->bytes;j+=sizeof b) {
            size_t n=p->bytes-j;if(n>sizeof b)n=sizeof b;
            if(!rd(p->va+j,b,n)||memcmp(b,p->data+j,n))return 0;
        }
    }
    return 1;
}
static void put(void *p,size_t offset,uintptr_t value) {
    memcpy((char *)p+offset,&value,8);
}
static char *text(char *b,int32_t n,const char *s) {
    int32_t i=0;if(!b||n<=0)return(char *)"";
    for(;i+1<n&&s[i];++i)b[i]=s[i];b[i]=0;return b;
}
static unsigned index_of(void *p) {
    for(unsigned i=0;i<2;++i)if(p&&p==size_items[i])return i;
    return 2;
}
static int on_ui(void) {
    uintptr_t q,v,m,back;
    return queue&&iq4_f4_native_current_02(&q)&&q==queue&&word(q,&v)&&v==0xb91f48&&
        word(q+0x1c8,&m)&&m==manager&&word(m,&v)&&v==0xb8f358&&
        word(m+8,&back)&&back==q;
}
static char *menu_name(void *p,char *b,int32_t n) {
    return text(b,n,p==size_menu?"JPEG Size":"");
}
static char *menu_value(void *p,char *b,int32_t n) {
    uint32_t choice;
    return text(b,n,p==size_menu&&iq4_stock_jpeg_extended_size_get_02(&choice)&&
        choice<2?labels[choice]:"");
}
static char *item_name(void *p,char *b,int32_t n) {
    if(p&&p==quality_item)return text(b,n,"JPEG Quality");
    if(p&&p==status_item)return text(b,n,"JPEG Status");
    unsigned i=index_of(p);return text(b,n,i<2?labels[i]:"");
}
static char *item_value(void *p,char *b,int32_t n) {
    if(p&&p==status_item){uint32_t stage,detail;
        if(!iq4_stock_jpeg_last_failure_55(&stage,&detail))return text(b,n,"Unavailable");
        const char *message;
        switch(stage){
        case IQ4_JPEG_FAILURE_NONE55:message="Ready";break;
        case IQ4_JPEG_FAILURE_HALF_BIND55:message="50% source unavailable";break;
        case IQ4_JPEG_FAILURE_HALF_MATCH55:message=iq4_half_entry_text_58(detail);break;
        case IQ4_JPEG_FAILURE_HALF_RENDER55:
            switch(detail){
            case IQ4_HALF_RENDER_ARGUMENT_01:message="50% invalid input";break;
            case IQ4_HALF_RENDER_UNBOUND_01:message="50% source unavailable";break;
            case IQ4_HALF_RENDER_CANCELLED_01:message="50% cancelled";break;
            case IQ4_HALF_RENDER_INCOMPLETE_01:message="50% processing incomplete";break;
            case IQ4_HALF_RENDER_PLANE_01:message="50% output mismatch";break;
            case IQ4_HALF_RENDER_SINK_01:message="50% encode entry failed";break;
            case IQ4_HALF_RENDER_EXCEPTION_01:message="50% processing exception";break;
            default:message="50% render failed";break;
            }break;
        case IQ4_JPEG_FAILURE_HALF_CODEC55:message="50% encode failed";break;
        case IQ4_JPEG_FAILURE_CARD55:message="JPEG write failed";break;
        case IQ4_JPEG_FAILURE_HOLD55:message="Saving held";break;
        case IQ4_JPEG_FAILURE_PENDING55:message="Pending cleanup failed";break;
        case IQ4_JPEG_FAILURE_ARCHIVE55:message="Backup All active";break;
        default:message="JPEG failed";break;
        }
        return text(b,n,message);
    }
    if(p&&p==quality_item){
        uint32_t quality;char value[4];unsigned count=0;
        if(!iq4_stock_jpeg_quality_get_02(&quality)||quality<1||quality>100)return text(b,n,"");
        do{value[count++]=(char)('0'+quality%10);quality/=10;}while(quality);
        char forward[4];unsigned i=0;while(count)forward[i++]=value[--count];forward[i]=0;
        return text(b,n,forward);
    }
    unsigned i=index_of(p);uint32_t choice;
    return text(b,n,i<2&&iq4_stock_jpeg_extended_size_get_02(&choice)&&
        choice==i?"Selected":"");
}
static uint32_t activate(void *p) {
    unsigned i=index_of(p);
    if(i>=2||held||!on_ui())return 0;
    /* Core owns busy/admission, persistence, nativeSize=1 and the actual source
     * choice. A rejection stays in this menu and never publishes a fake value. */
    return iq4_stock_jpeg_extended_size_set_02(i)==1?1u:0u;
}
static int construct(void **out,size_t bytes,uintptr_t ctor,uintptr_t *table) {
    if(!iq4_f4_menu_new_03(bytes,out)||!*out||!iq4_f4_menu_ctor_03(ctor,*out))return 0;
    put(*out,0,(uintptr_t)&table[2]);return 1;
}

/* Replace the child at the existing Storage Setup JPEG Size append. The
 * original PropertyEnum/DTO/event are retained unchanged, never passed enum2.
 * The wrapper still performs the original append once using this return value,
 * then invokes the existing JPEG Export submenu attachment separately. */
void *iq4_stock_jpeg_size_child_02(void *root,void *original,uintptr_t pc) {
    uintptr_t parent=(uintptr_t)root,v,dto,q,m,back;uint32_t title;
    if(pc!=0x4f052c||!root||!original||parent<4096||(parent&7)||
        ((uintptr_t)original&7)||held||building||
        iq4_extensions_installation_stage_02()!=100||!pins()||
        !word(parent,&v)||v!=0xb8f9b8||!rd(parent+0x14,&title,4)||title!=389||
        !word((uintptr_t)original,&v)||v!=0xb8fd40||
        !word((uintptr_t)original+0x18,&dto)||!word(dto,&v)||v!=0xbbf3f8)return original;
    if(!iq4_f4_native_current_02(&q)||!word(q,&v)||v!=0xb91f48||
        !word(q+0x1c8,&m)||!word(m,&v)||v!=0xb8f358||
        !word(m+8,&back)||back!=q)return original;
    if(saved_parent)return saved_parent==parent&&saved_original==original&&
        q==queue&&m==manager?size_menu:original;
    queue=q;manager=m;building=1;
    for(unsigned i=0;i<24;++i)if(!word(0xb8f9a8+8*i,&menu_table[i]))goto fail;
    for(unsigned i=0;i<22;++i)if(!word(0xb90738+8*i,&item_table[i]))goto fail;
    menu_table[5]=(uintptr_t)menu_name;menu_table[6]=(uintptr_t)menu_value;
    item_table[5]=(uintptr_t)item_name;item_table[6]=(uintptr_t)item_value;
    item_table[12]=(uintptr_t)activate;
    if(!construct(&size_menu,0x118,0x4e5744,menu_table))goto fail;
    for(unsigned i=0;i<2;++i)if(!construct(size_items+i,0x38,0x4e9d30,item_table))goto fail;
    if(!construct(&quality_item,0x38,0x4e9d30,item_table))goto fail;
    if(!construct(&status_item,0x38,0x4e9d30,item_table))goto fail;
    for(unsigned i=0;i<2;++i)if(!iq4_f4_menu_append_03(size_menu,size_items[i]))goto fail;
    if(!iq4_f4_menu_append_03(size_menu,quality_item))goto fail;
    if(!iq4_f4_menu_append_03(size_menu,status_item))goto fail;
    saved_parent=parent;saved_original=original;building=0;return size_menu;
fail:
    held=1;return original; /* No partial replacement is attached or freed. */
}
