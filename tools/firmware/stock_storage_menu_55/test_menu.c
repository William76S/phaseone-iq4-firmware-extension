#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "menu.c"

static unsigned allocations,ctors,appends;
static unsigned fail_alloc,fail_ctor,fail_append,bad_pin;
static uint32_t stage=100,backend_format;
static int busy,get_available=1;
static unsigned format_sets;
static void *owned[80];
static unsigned owned_count;
static unsigned char queue_mem[0x200],manager_mem[32];
static uintptr_t actual_queue;
static void store(void *p,size_t off,uintptr_t v) { memcpy((char *)p+off,&v,8); }
static void initialize_submenu(void *p,uint32_t title) {
    store(p,0,0xb8f9b8);memcpy((char *)p+0x14,&title,4);
    store(p,0x18,0xb8faa0);store(p,0x20,0xc22908);store(p,0x28,0xc22960);
    store(p,0x30,(uintptr_t)p+0x28);store(p,0x38,(uintptr_t)p+0x28);
}
uint32_t iq4_extensions_installation_stage_02(void) { return stage; }
int iq4_native_self_read_01(void *ctx,uintptr_t p,void *out,size_t n) {
    (void)ctx;
    for (unsigned i=0;i<sizeof MenuPins01/sizeof *MenuPins01;++i) {
        const struct MenuPin01 *pin=MenuPins01+i;
        if (p>=pin->va&&p+n<=pin->va+pin->bytes) {
            memcpy(out,pin->data+p-pin->va,n);
            if (bad_pin&&p==pin->va) ((unsigned char *)out)[0]^=1;
            return 1;
        }
    }
    if (p==0xbbf3f8&&n==8) { uintptr_t v=0xbbf3f8;memcpy(out,&v,8);return 1; }
    if (p<0x100000000ULL) return 0;
    memcpy(out,(void *)p,n);return 1;
}
int iq4_f4_native_current_02(uintptr_t *out) { *out=actual_queue;return 1; }
int iq4_f4_menu_new_03(size_t bytes,void **out) {
    if (++allocations==fail_alloc) { *out=0;return 1; }
    *out=calloc(1,bytes);assert(*out&&owned_count<80);owned[owned_count++]=*out;return 1;
}
int iq4_f4_menu_ctor_03(uintptr_t f,void *p) {
    if (++ctors==fail_ctor) return 0;
    if (f==0x4e5744) initialize_submenu(p,UINT32_MAX);
    else assert(f==0x4e9d30);
    return 1;
}
int iq4_f4_menu_append_03(void *parent,void *item) {
    if (++appends==fail_append) return 0;
    uintptr_t head=(uintptr_t)parent+0x28,tail;
    memcpy(&tail,(void *)(head+16),8);
    void *node=calloc(1,32);assert(node&&owned_count<80);owned[owned_count++]=node;
    store(node,0,0xb8f958);store(node,8,head);store(node,16,tail);store(node,24,(uintptr_t)item);
    store((void *)tail,8,(uintptr_t)node);store((void *)head,16,(uintptr_t)node);
    return 1;
}
int iq4_stock_xqd_format_get_55(uint32_t *out) {
    if(!get_available)return 0;
    *out=backend_format;return 1;
}
int iq4_stock_xqd_format_set_55(uint32_t value) {
    if(busy)return 0;
    assert(value<=2);backend_format=value;++format_sets;return 1;
}
int main(int argc,char **argv) {
    if (argc==3) {
        unsigned n=(unsigned)atoi(argv[2]);
        if (!strcmp(argv[1],"alloc")) fail_alloc=n;
        else if (!strcmp(argv[1],"ctor")) fail_ctor=n;
        else if (!strcmp(argv[1],"append")) fail_append=n;
        else assert(0);
    }
    unsigned char root[0x118],sd_property[0x48],original[0x48],dto[312];
    memset(root,0,sizeof root);memset(sd_property,0x5a,sizeof sd_property);memset(original,0,sizeof original);memset(dto,0,sizeof dto);
    initialize_submenu(root,389);store(original,0,0xb8fd40);store(original,0x18,(uintptr_t)dto);
    /* DTO vtable is its first field, not a pointer to the copied table itself. */
    store(dto,0,0xbbf3f8);
    store(queue_mem,0,0xb91f48);store(queue_mem,0x1c8,(uintptr_t)manager_mem);
    store(manager_mem,0,0xb8f358);store(manager_mem,8,(uintptr_t)queue_mem);
    actual_queue=(uintptr_t)queue_mem;
    unsigned requested_append_failure=fail_append; fail_append=0;
    assert(iq4_f4_menu_append_03(root,sd_property));
    assert(iq4_f4_menu_append_03(root,original));
    fail_append=requested_append_failure;
    appends=0;
    if (argc==2) {
        if (!strcmp(argv[1],"stage")) stage=20;
        else if (!strcmp(argv[1],"pin")) bad_pin=1;
        else if (!strcmp(argv[1],"title")) { uint32_t t=391;memcpy(root+0x14,&t,4); }
        else if (!strcmp(argv[1],"ui")) store(manager_mem,8,0);
        else if (!strcmp(argv[1],"list")) store(root,0x38,0);
        else if (!strcmp(argv[1],"dto")) store(dto,0,0);
        else assert(0);
    }
    /* Size property and DTO bytes must not be replaced or modified. */
    unsigned char original_before[sizeof original],dto_before[sizeof dto],sd_before[sizeof sd_property];
    memcpy(sd_before,sd_property,sizeof sd_property);
    memcpy(original_before,original,sizeof original);memcpy(dto_before,dto,sizeof dto);
    iq4_stock_jpeg_after_menu_append_01(root,original,0x4f052c);
    assert(!memcmp(original_before,original,sizeof original)&&!memcmp(dto_before,dto,sizeof dto)&&!memcmp(sd_before,sd_property,sizeof sd_property));
    assert(present((uintptr_t)root,(uintptr_t)original)==(argc==2&&!strcmp(argv[1],"list")?-1:1));
    if (argc>1) {
        assert(!bound_parent);
        assert(argc==2?allocations==0:held==1);
        assert(argc==2?format_menu==0:present((uintptr_t)root,(uintptr_t)format_menu)==0);
        unsigned count=allocations;
        iq4_stock_jpeg_after_menu_append_01(root,original,0x4f052c);
        assert(count==allocations); /* Partial construction never retries. */
    } else {
        assert(bound_parent==(uintptr_t)root&&present((uintptr_t)root,(uintptr_t)format_menu)==1);
        assert(allocations==4&&ctors==4&&appends==4);
        uintptr_t first,next,value;
        memcpy(&first,root+0x30,8);memcpy(&value,(void *)(first+24),8);assert(value==(uintptr_t)sd_property);
        memcpy(&next,(void *)(first+8),8);memcpy(&value,(void *)(next+24),8);assert(value==(uintptr_t)original);
        memcpy(&next,(void *)(next+8),8);memcpy(&value,(void *)(next+24),8);assert(value==(uintptr_t)format_menu);
        unsigned count=appends;
        iq4_stock_jpeg_after_menu_append_01(root,original,0x4f052c);assert(appends==count);
        char b[40];assert(!strcmp(menu_name(format_menu,b,sizeof b),"XQD Storage"));
        assert(!strcmp(menu_value(format_menu,b,sizeof b),"IIQ Only"));
        const uint32_t expected[3]={1,0,2};
        const char *const labels[3]={"JPEG Only","IIQ Only","IIQ+JPEG"};
        for(unsigned i=0;i<3;++i){
            assert(activate(format_items[i])==1&&backend_format==expected[i]);
            assert(!strcmp(item_name(format_items[i],b,sizeof b),labels[i]));
            assert(!strcmp(menu_value(format_menu,b,sizeof b),labels[i]));
            for(unsigned j=0;j<3;++j)assert(!strcmp(item_value(format_items[j],b,sizeof b),i==j?"Selected":""));
        }
        assert(format_sets==3);
        busy=1;assert(!activate(format_items[0]));assert(backend_format==2&&format_sets==3);
        assert(!strcmp(menu_value(format_menu,b,sizeof b),"IIQ+JPEG"));
        busy=0;actual_queue=0;assert(!activate(format_items[1]));assert(backend_format==2&&format_sets==3);
        actual_queue=(uintptr_t)queue_mem;get_available=0;
        assert(!strcmp(menu_value(format_menu,b,sizeof b),""));
        for(unsigned i=0;i<3;++i)assert(!strcmp(item_value(format_items[i],b,sizeof b),""));
        get_available=1;backend_format=9;assert(!strcmp(menu_value(format_menu,b,sizeof b),""));
        for(unsigned i=0;i<3;++i)assert(!strcmp(item_value(format_items[i],b,sizeof b),""));
        assert(!activate(0)&&!activate(original));
        assert(!memcmp(original_before,original,sizeof original)&&!memcmp(dto_before,dto,sizeof dto)&&!memcmp(sd_before,sd_property,sizeof sd_property));
        char tiny[2]={'x','x'};item_name(format_items[2],tiny,sizeof tiny);assert(tiny[1]==0);
    }
    for (unsigned i=0;i<owned_count;++i) free(owned[i]);
    return 0;
}
