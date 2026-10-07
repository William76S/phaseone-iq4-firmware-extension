#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "menu.c"

static unsigned allocations,ctors,appends;
static unsigned fail_alloc,fail_ctor,fail_append,bad_pin;
static uint32_t stage=100,mode,card=10;
static int busy;
static unsigned mode_sets,destination_sets;
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
uint32_t iq4_stock_jpeg_destination_get_01(void) { return card; }
int iq4_stock_jpeg_destination_set_01(uint32_t v) {
    if (busy) return 0;
    assert(v==10||v==11);card=v;++destination_sets;return 1;
}
int iq4_stock_jpeg_mode_get_01(uint32_t *out) { *out=mode;return 1; }
int iq4_stock_jpeg_mode_set_01(uint32_t v) {
    if (busy) return 0;
    assert(v<3);mode=v;++mode_sets;return 1;
}
int main(int argc,char **argv) {
    if (argc==3) {
        unsigned n=(unsigned)atoi(argv[2]);
        if (!strcmp(argv[1],"alloc")) fail_alloc=n;
        else if (!strcmp(argv[1],"ctor")) fail_ctor=n;
        else if (!strcmp(argv[1],"append")) fail_append=n;
        else assert(0);
    }
    unsigned char root[0x118],original[0x38],dto[312];
    memset(root,0,sizeof root);memset(original,0,sizeof original);memset(dto,0,sizeof dto);
    initialize_submenu(root,389);store(original,0,0xb8fd40);store(original,0x18,(uintptr_t)dto);
    /* DTO vtable is its first field, not a pointer to the copied table itself. */
    store(dto,0,0xbbf3f8);
    store(queue_mem,0,0xb91f48);store(queue_mem,0x1c8,(uintptr_t)manager_mem);
    store(manager_mem,0,0xb8f358);store(manager_mem,8,(uintptr_t)queue_mem);
    actual_queue=(uintptr_t)queue_mem;
    unsigned requested_append_failure=fail_append; fail_append=0;
    assert(iq4_f4_menu_append_03(root,original));
    fail_append=requested_append_failure;
    appends=0;
    if (argc==2) {
        if (!strcmp(argv[1],"stage")) stage=20;
        else if (!strcmp(argv[1],"pin")) bad_pin=1;
        else if (!strcmp(argv[1],"title")) { uint32_t t=391;memcpy(root+0x14,&t,4); }
        else if (!strcmp(argv[1],"ui")) store(manager_mem,8,0);
        else if (!strcmp(argv[1],"list")) store(root,0x38,0);
        else assert(0);
    }
    /* Size property and DTO bytes must not be replaced or modified. */
    unsigned char original_before[sizeof original],dto_before[sizeof dto];
    memcpy(original_before,original,sizeof original);memcpy(dto_before,dto,sizeof dto);
    iq4_stock_jpeg_after_menu_append_01(root,original,0x4f052c);
    assert(!memcmp(original_before,original,sizeof original)&&!memcmp(dto_before,dto,sizeof dto));
    assert(present((uintptr_t)root,(uintptr_t)original)==(argc==2&&!strcmp(argv[1],"list")?-1:1));
    if (argc>1) {
        assert(!bound_parent);
        assert(argc==2?allocations==0:held==1);
    } else {
        assert(bound_parent==(uintptr_t)root&&present((uintptr_t)root,(uintptr_t)export_menu)==1);
        assert(allocations==8&&ctors==8&&appends==8);
        unsigned count=appends;
        iq4_stock_jpeg_after_menu_append_01(root,original,0x4f052c);assert(appends==count);
        char b[40];assert(!strcmp(menu_name(export_menu,b,sizeof b),"JPEG Export"));
        assert(!strcmp(menu_value(export_menu,b,sizeof b),"Off / SD"));
        for (unsigned i=0;i<3;++i) {
            assert(activate(mode_items[i])==1&&mode==i);
            assert(!strcmp(item_name(mode_items[i],b,sizeof b),mode_names[i]));
            assert(!strcmp(item_value(mode_items[i],b,sizeof b),"Selected"));
        }
        for (unsigned i=0;i<2;++i) {
            assert(activate(destination_items[i])==1&&card==10+i);
            assert(!strcmp(item_value(destination_items[i],b,sizeof b),"Selected"));
        }
        assert(mode_sets==3&&destination_sets==2);
        busy=1;assert(!activate(mode_items[0])&&!activate(destination_items[0]));
        assert(mode==2&&card==11&&mode_sets==3&&destination_sets==2);
        busy=0;actual_queue=0;assert(!activate(mode_items[0]));
        assert(mode==2);actual_queue=(uintptr_t)queue_mem;
        char tiny[2]={'x','x'};item_name(destination_items[1],tiny,sizeof tiny);assert(tiny[1]==0);
    }
    for (unsigned i=0;i<owned_count;++i) free(owned[i]);
    return 0;
}
