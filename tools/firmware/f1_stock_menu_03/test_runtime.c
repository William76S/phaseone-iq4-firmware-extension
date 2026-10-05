#define IQ4_F1_MENU_HOST 1
#include "runtime.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../f1_stock_display_payload_15/payload.h"

uintptr_t iq4_f1_fixture_table_word_15(uintptr_t p) { (void)p; assert(0); return 0; }
void iq4_f1_fixture_fill_15(void *p,const F1Rect15 *a,const F1Rect15 *b,const F1Color15 *c) {
    (void)p; (void)a; (void)b; (void)c; assert(0);
}

static void selected_mode_reaches_display(unsigned mode) {
    F1Facts15 f={0}; F1Plan15 plan;
    f.destination=f.clip=f.surface_bounds=(F1Rect15){0xb73b98,0,0,800,480};
    f.projected=(F1Rect15){0xb73b98,80,0,640,480}; f.roi=(F1Rect15){0xb73b98,0,0,640,480};
    f.source_w=f.locked_w=f.engine_w=f.requested_w=640; f.source_h=f.locked_h=f.engine_h=f.requested_h=480;
    f.stride=1920; f.surface_pitch=800; f.surface_height=480;
    f.scale_bits=f.normal_scale_bits=0x3f800000; f.surface_vt=0xb7cf90;
    f.screen_vt=0xb7cfc0; f.draw_vt=0xb7b7d8;
    f.provider_matches_surface=f.native_tables_valid=1;
    f.source_pixels=0x10000000; f.surface_pixels=0x20000000;
    assert(iq4_f1_plan_15(&f,iq4_f1_mode_get_01(),&plan)==(mode?F1_DRAW15:F1_OFF15));
    if(mode) assert(plan.count>0);
}

static void *allocations[80];
static unsigned allocations_n, appends_n;
static _Alignas(8) unsigned char test_lv[0x1100], test_manager[0x810], test_root[0x118];
static const uintptr_t original_menu[24] = {
  0,0xb8fbe0,0x4e5ed0,0x4e5ee8,0x4e5eb0,0x4e5efc,0x4e5f1c,0x4e58a4,
  0x4e5f84,0x4e5f9c,0x4e5fc0,0x4e5fd8,0x4e5ff0,0x4e5990,0x4e5a2c,
  0x4e5394,0x4e6004,0x4e601c,0x4e5834,0x4e587c,0x4e5ac8,0x4e5b34,0x4e6030,0x4e6054};
static const uintptr_t original_item[22] = {
  0,0xb907e8,0x4ea1a8,0x4ea1c0,0x4ea188,0x4ea200,0x4ea220,0x4ea29c,
  0x4ea1d4,0x4ea1e8,0x4ea2b0,0x4ea2c4,0x4ea2d8,0x4e9e10,0x4e9e28,
  0x4e5394,0x4ea2fc,0x4ea310,0x4e9db8,0x4e9de8,0x4e9e84,0x4e9ea8};
uintptr_t iq4_f1_test_word(uintptr_t p) {
    uintptr_t r;
    if (p >= 0xb8f9a8 && p < 0xb8f9a8 + sizeof original_menu) return original_menu[(p-0xb8f9a8)/8];
    if (p >= 0xb90738 && p < 0xb90738 + sizeof original_item) return original_item[(p-0xb90738)/8];
    memcpy(&r, (void *)p, 8); return r;
}
void *iq4_f1_test_new(size_t n) {
    void *p = calloc(1,n); assert(p && allocations_n < 80);
    allocations[allocations_n++] = p; return p;
}
void iq4_f1_test_ctor(uintptr_t f, void *p, uint32_t id, void *x, void *y) {
    assert(id == UINT32_MAX && !x && !y);
    memcpy((char*)p+0x14,&id,4);
    if (f == 0x4e5744) {
        put(p,0,0xb8f9b8); put(p,0x18,0xb8faa0); put(p,0x20,0xc22908);
        put(p,0x28,0xc22960); put(p,0x30,(uintptr_t)p+0x28); put(p,0x38,(uintptr_t)p+0x28);
    } else { assert(f == 0x4e9d30); put(p,0,0xb90748); }
}
void iq4_f1_test_append(void *parent, void *item) {
    uintptr_t h=(uintptr_t)parent+0x28,last=word(h+16);
    void *node=iq4_f1_test_new(0x20);
    put(node,0,0xb8f958); put(node,8,h); put(node,16,last); put(node,24,(uintptr_t)item);
    put((void*)last,8,(uintptr_t)node); put((void*)h,16,(uintptr_t)node); ++appends_n;
}
static void invoke(void) { iq4_f1_before_native_menu_03(test_lv+0x588,test_root,0x4eea5c); }
static void setup(void) {
    put(test_lv,0,0xb9a9d8); put(test_lv,0xb0,(uintptr_t)test_manager);
    put(test_manager,0,0xb8f358); put(test_lv,0x588,0xb931b0);
    put(test_lv,0x588+0xb0,(uintptr_t)test_manager);
    iq4_f1_test_ctor(0x4e5744,test_root,UINT32_MAX,0,0);
    {uint32_t title=604; memcpy(test_root+0x14,&title,4);}
}
int main(void) {
    unsigned i,j,before; char b[80]; uintptr_t vt;
    setup(); assert(iq4_f1_mode_get_01()==0); /* no initializer invoked */
    iq4_f1_before_native_menu_03(test_lv+0x588,test_root,0x51fe0c);
    assert(allocations_n==0); /* Different LV menu is not modified. */
    put(test_root,0,0xb8fd40); invoke(); assert(allocations_n==0); /* enum menu */
    put(test_root,0,0xb8f9b8); put(test_root,0x38,0); invoke(); assert(allocations_n==0);
    put(test_root,0x38,(uintptr_t)test_root+0x28);
    /* Existing native entries and their exact order remain unchanged. */
    for(i=0;i<3;++i) iq4_f1_test_append(test_root,(void*)(uintptr_t)(0x1000+i*8));
    invoke(); assert(own_menu[0] && !building[0] && present((uintptr_t)test_root,(uintptr_t)own_menu[0])==1);
    assert(appends_n==18); before=allocations_n; invoke(); invoke(); assert(allocations_n==before);
    vt=word((uintptr_t)test_root+0x30);
    for(i=0;i<3;++i) {assert(word(vt+24)==0x1000+i*8); vt=word(vt+8);}
    assert(word(vt+24)==(uintptr_t)own_menu[0]);
    for(i=0;i<24;++i) if(i!=5&&i!=6) assert(menu_table[i]==original_menu[i]);
    for(i=0;i<22;++i) if(i!=5&&i!=6&&i!=12) assert(item_table[i]==original_item[i]);
    assert(menu_table[1]==0xb8fbe0 && item_table[1]==0xb907e8);
    assert(!strcmp(menu_name(own_menu[0],b,64),"F1 Mask"));
    for(i=0;i<5;++i) {
        assert(activate(own_items[0][i])==1 && iq4_f1_mode_get_01()==i);
        selected_mode_reaches_display(i);
        assert(!strcmp(item_name(own_items[0][i],b,64),labels[i]));
        assert(!strcmp(menu_value(own_menu[0],b,32),labels[i]));
        for(j=0;j<5;++j) assert(!strcmp(item_value(own_items[0][j],b,32),i==j?"Selected":""));
    }
    assert(!iq4_f1_mode_set_on_ui_01(5) && iq4_f1_mode_get_01()==4);
    assert(!activate(test_root) && iq4_f1_mode_get_01()==4);
    for(i=5;i<ITEMS;++i) {
        assert(!activate(own_items[0][i])&&iq4_f1_mode_get_01()==4);
        assert(!strcmp(item_name(own_items[0][i],b,64),labels[i]));
        assert(!strcmp(item_value(own_items[0][i],b,32),i==5?"E1 N0 F0":"Not captured"));
    }
    {
        F1Facts15 f={0};
        f.source_w=f.requested_w=1280;f.source_h=f.requested_h=960;f.engine_w=2560;f.engine_h=1920;
        f.roi=(F1Rect15){0xb73b98,0,0,2560,1920};f.rotation=180;
        f.scale_bits=f.normal_scale_bits=0x40800000;
        f.projected=(F1Rect15){0xb73b98,80,0,640,480};f.clip=f.projected;
        f.surface_pitch=800;f.surface_height=480;
        iq4_f1_report_15(10,NULL,0);iq4_f1_report_15(34,&f,0);
        assert(!strcmp(item_value(own_items[0][5],b,32),"E34 N1 F0"));
        assert(!strcmp(item_value(own_items[0][6],b,32),"1280x960 / 2560x1920"));
        assert(!strcmp(item_value(own_items[0][7],b,32),"0,0 2560x1920"));
        assert(!strcmp(item_value(own_items[0][8],b,32),"R180 A0 C0"));
        assert(!strcmp(item_value(own_items[0][9],b,32),"40800000 / 40800000"));
        assert(!strcmp(item_value(own_items[0][10],b,32),"80,0 640x480"));
        assert(!strcmp(item_value(own_items[0][11],b,32),"80,0 640x480"));
        assert(!strcmp(item_value(own_items[0][12],b,32),"800x480 fmt0"));
        assert(!strcmp(item_value(own_items[0][13],b,32),"1280x960"));
        iq4_f1_report_15(2,&f,2);assert(!strcmp(item_value(own_items[0][5],b,32),"E2 N1 F2"));
        for(i=5;i<ITEMS;++i) {
            memset(b,0x55,sizeof b);item_value(own_items[0][i],b+1,32);
            assert(b[0]==0x55&&b[33]==0x55&&memchr(b+1,0,32));
        }
        iq4_f1_report_15(15,NULL,0);
        assert(!strcmp(item_value(own_items[0][7],b,32),"Not captured"));
        assert(iq4_f1_mode_get_01()==4);
    }
    memset(b,0x55,sizeof b); assert(menu_name(own_menu[0],b+1,2)==b+1);
    assert(b[0]==0x55 && b[1]=='F' && b[2]==0 && b[3]==0x55);
    text(b+1,0,"abcd"); assert(b[1]=='F');
    assert(activate(own_items[0][0])==1 && iq4_f1_mode_get_01()==0);
    iq4_f1_mode_set_on_ui_01(1); iq4_f1_menu_initialize_03(); assert(iq4_f1_mode_get_01()==0);
    {
        _Alignas(8) unsigned char grid[0x118]={0}; uint32_t title=727;
        iq4_f1_test_ctor(0x4e5744,grid,UINT32_MAX,0,0); memcpy(grid+0x14,&title,4);
        before=allocations_n;
        iq4_f1_before_native_menu_03(test_lv+0x588,grid,0x4eea5c);
        assert(allocations_n==before); /* Wrong call/title pairing. */
        iq4_f1_before_native_menu_03(test_lv+0x588,grid,0x4ee784);
        assert(own_menu[1] && own_menu[1]!=own_menu[0]);
        assert(present((uintptr_t)grid,(uintptr_t)own_menu[1])==1);
        before=allocations_n;
        iq4_f1_before_native_menu_03(test_lv+0x588,grid,0x4ee784);
        assert(allocations_n==before);
        for(i=0;i<5;++i) {
            assert(own_items[1][i]!=own_items[0][i]);
            assert(activate(own_items[1][i])==1 && iq4_f1_mode_get_01()==i);
            selected_mode_reaches_display(i);
            assert(!strcmp(item_value(own_items[0][i],b,32),"Selected"));
        }
    }
    for(i=0;i<allocations_n;++i) free(allocations[i]);
    puts("PASS: native-menu owned-memory checks; not native target execution");
    return 0;
}
