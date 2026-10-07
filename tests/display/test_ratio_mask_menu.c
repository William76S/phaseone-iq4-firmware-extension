#define IQ4_F1_MENU_HOST 1
#include "../../src/display/ratio_mask_menu.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static struct Iq4RatioMaskSettings stored = {0,65,1};
static enum Iq4RatioSettingsResult load_result = IQ4_RATIO_SETTINGS_ABSENT;
static enum Iq4RatioSettingsResult save_result = IQ4_RATIO_SETTINGS_OK;
static unsigned saves,loads;
enum Iq4RatioSettingsResult iq4_ratio_settings_load_01(struct Iq4RatioMaskSettings *out) {
    ++loads; *out = load_result==IQ4_RATIO_SETTINGS_OK ? stored : (struct Iq4RatioMaskSettings){0,65,1}; return load_result;
}
enum Iq4RatioSettingsResult iq4_ratio_settings_save_01(const struct Iq4RatioMaskSettings *v) {
    ++saves; if(save_result==IQ4_RATIO_SETTINGS_OK) { stored=*v; load_result=IQ4_RATIO_SETTINGS_OK; } return save_result;
}
static void *allocations[256];
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
    void *p = calloc(1,n); assert(p && allocations_n < 256);
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
static void invoke(void) { iq4_f1_before_native_menu_04(test_lv+0x588,test_root,0x4eea5c); }
static void setup(void) {
    put(test_lv,0,0xb9a9d8); put(test_lv,0xb0,(uintptr_t)test_manager);
    put(test_manager,0,0xb8f358); put(test_lv,0x588,0xb931b0);
    put(test_lv,0x588+0xb0,(uintptr_t)test_manager);
    iq4_f1_test_ctor(0x4e5744,test_root,UINT32_MAX,0,0);
    {uint32_t title=604; memcpy(test_root+0x14,&title,4);}
}
int main(void) {
    char text_buffer[80];
    setup(); iq4_f1_menu_initialize_04(); invoke();
    assert(own_menu[0] && !building[0]);
    uintptr_t node=word((uintptr_t)own_menu[0]+0x30);
    const char *ratio_labels[] = {"XPan 65:24","16:9","3:2","1:1","4:5","6:7","21:9"};
    for(unsigned i=0;i<7;++i) {
        assert(word(node+24)==(uintptr_t)own_items[0][i]); node=word(node+8);
        assert(!strcmp(item_name(own_items[0][i],text_buffer,80),ratio_labels[i]));
    }
    assert(word(node+24)==(uintptr_t)opacity_menu[0]);node=word(node+8);
    assert(node==(uintptr_t)own_menu[0]+0x28); /* no diagnostic items */
    unsigned allocations_before=allocations_n;invoke();assert(allocations_n==allocations_before);
    assert(activate(own_items[0][0])==1 && stored.mode==1 && stored.opacity==65);
    assert(activate(opacity_items[0][7])==1 && stored.mode==1 && stored.opacity==35);
    iq4_f1_menu_initialize_04();assert(iq4_f1_mode_get_01()==1 && iq4_f1_opacity_get_01()==35);
    assert(!strcmp(menu_value(opacity_menu[0],text_buffer,80),"35%"));
    unsigned before=saves;assert(iq4_f1_opacity_set_on_ui_01(35));assert(saves==before);
    assert(!iq4_f1_mode_set_on_ui_01(8)&&!iq4_f1_opacity_set_on_ui_01(101)&&!iq4_f1_opacity_set_on_ui_01(1));assert(saves==before);
    save_result=IQ4_RATIO_SETTINGS_IO;assert(activate(opacity_items[0][8])==1);
    assert(iq4_f1_opacity_get_01()==40 && stored.opacity==35);
    assert(!strcmp(menu_value(opacity_menu[0],text_buffer,80),"40% (not saved)"));
    save_result=IQ4_RATIO_SETTINGS_OK;assert(activate(opacity_items[0][8])==1);assert(stored.opacity==40);
    assert(!strcmp(menu_value(opacity_menu[0],text_buffer,80),"40%"));
    iq4_f1_menu_initialize_04();assert(iq4_f1_opacity_get_01()==40);
    load_result=IQ4_RATIO_SETTINGS_IO;iq4_f1_menu_initialize_04();assert(iq4_f1_opacity_get_01()==65);
    unsigned loads_before=loads;load_result=IQ4_RATIO_SETTINGS_OK;invoke();assert(loads==loads_before+1);
    assert(iq4_f1_opacity_get_01()==40 && iq4_f1_mode_get_01()==1);
    for(unsigned i=0;i<100;++i) { (void)iq4_f1_mode_get_01();(void)iq4_f1_opacity_get_01(); }
    assert(loads==loads_before+1); /* render getters perform no file I/O */
    void *quick=iq4_f1_quick_menu_root_on_ui_01();
    assert(quick && quick!=own_menu[0] && quick==own_menu[1]);
    assert(opacity_menu[1] && opacity_menu[1]!=opacity_menu[0]);
    unsigned quick_allocations=allocations_n;
    assert(iq4_f1_quick_menu_root_on_ui_01()==quick && allocations_n==quick_allocations);
    node=word((uintptr_t)quick+0x30);
    for(unsigned i=0;i<7;++i) {
        assert(word(node+24)==(uintptr_t)own_items[1][i]); node=word(node+8);
        assert(!strcmp(item_name(own_items[1][i],text_buffer,80),ratio_labels[i]));
        assert(activate(own_items[1][i])==1 && stored.mode==i+1u);
        assert(!strcmp(item_value(own_items[0][i],text_buffer,80),"Selected"));
    }
    assert(word(node+24)==(uintptr_t)opacity_menu[1]);node=word(node+8);
    assert(node==(uintptr_t)quick+0x28); /* seven ratios + opacity, no Off leaf */
    assert(activate(NULL)==0 && stored.mode==7);
    assert(activate(own_items[1][5])==1 && stored.mode==6 && stored.remembered_mode==6);
    assert(!strcmp(menu_value(own_menu[0],text_buffer,80),"6:7"));
    assert(iq4_f1_toggle_on_ui_01() && stored.mode==0 && stored.remembered_mode==6);
    assert(iq4_f1_mode_get_01()==0);
    iq4_f1_menu_initialize_04();
    assert(iq4_f1_mode_get_01()==0 && remembered_mode==6);
    assert(iq4_f1_toggle_on_ui_01() && stored.mode==6 && stored.remembered_mode==6);
    assert(activate(opacity_items[1][13])==1 && stored.opacity==65 && stored.remembered_mode==6);
    assert(!strcmp(menu_value(opacity_menu[0],text_buffer,80),"65%"));
    assert(iq4_f1_toggle_on_ui_01() && stored.mode==0 && stored.remembered_mode==6);
    assert(iq4_f1_toggle_on_ui_01() && stored.mode==6);
    assert(iq4_f1_mode_set_on_ui_01(2) && stored.remembered_mode==2);
    save_result=IQ4_RATIO_SETTINGS_IO;
    assert(iq4_f1_toggle_on_ui_01() && iq4_f1_mode_get_01()==0 && remembered_mode==2);
    assert(!strcmp(menu_value(own_menu[1],text_buffer,80),"Off (not saved)"));
    save_result=IQ4_RATIO_SETTINGS_OK;
    assert(iq4_f1_mode_set_on_ui_01(0) && stored.mode==0 && stored.remembered_mode==2);
    iq4_f1_menu_initialize_04();
    assert(iq4_f1_toggle_on_ui_01() && stored.mode==2 && stored.opacity==65);
    for(unsigned i=0;i<allocations_n;++i)free(allocations[i]);
    puts("PASS menu callbacks: independent shortcut tree, remembered toggle/cold load, shared mode/opacity, save error/retry, no diagnostic rows; host fixtures only");
}
