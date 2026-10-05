#define IQ4_F3_MENU_HOST 1
#include "runtime.c"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static void *allocations[64];static unsigned allocation_count,append_count,fail_at;
static _Alignas(8) unsigned char root[0x118];
static const uintptr_t original_menu[24]={
  0,0xb8fbe0,0x4e5ed0,0x4e5ee8,0x4e5eb0,0x4e5efc,0x4e5f1c,0x4e58a4,
  0x4e5f84,0x4e5f9c,0x4e5fc0,0x4e5fd8,0x4e5ff0,0x4e5990,0x4e5a2c,
  0x4e5394,0x4e6004,0x4e601c,0x4e5834,0x4e587c,0x4e5ac8,0x4e5b34,0x4e6030,0x4e6054};
static const uintptr_t original_item[22]={
  0,0xb907e8,0x4ea1a8,0x4ea1c0,0x4ea188,0x4ea200,0x4ea220,0x4ea29c,
  0x4ea1d4,0x4ea1e8,0x4ea2b0,0x4ea2c4,0x4ea2d8,0x4e9e10,0x4e9e28,
  0x4e5394,0x4ea2fc,0x4ea310,0x4e9db8,0x4e9de8,0x4e9e84,0x4e9ea8};
uintptr_t iq4_f3_fixture_word_01(uintptr_t p) {
    uintptr_t r;
    if(p>=0xb8f9a8 && p<0xb8f9a8+sizeof original_menu) return original_menu[(p-0xb8f9a8)/8];
    if(p>=0xb90738 && p<0xb90738+sizeof original_item) return original_item[(p-0xb90738)/8];
    memcpy(&r,(const void*)p,8);return r;
}
void *iq4_f3_fixture_new_01(size_t n) {
    void *p;
    if(fail_at && allocation_count+1==fail_at) return 0;
    p=calloc(1,n);assert(p && allocation_count<64);allocations[allocation_count++]=p;return p;
}
void iq4_f3_fixture_ctor_01(uintptr_t f,void *p,uint32_t id,void *x,void *y) {
    assert(id==UINT32_MAX && !x && !y);memcpy((char*)p+0x14,&id,4);
    if(f==0x4e5744) {
        put(p,0,0xb8f9b8);put(p,0x18,0xb8faa0);put(p,0x20,0xc22908);
        put(p,0x28,0xc22960);put(p,0x30,(uintptr_t)p+0x28);put(p,0x38,(uintptr_t)p+0x28);
    } else {assert(f==0x4e9d30);put(p,0,0xb90748);}
}
void iq4_f3_fixture_append_01(void *parent,void *item) {
    uintptr_t h=(uintptr_t)parent+0x28,last=word(h+16);void *node=iq4_f3_fixture_new_01(0x20);assert(node);
    put(node,0,0xb8f958);put(node,8,h);put(node,16,last);put(node,24,(uintptr_t)item);
    put((void*)last,8,(uintptr_t)node);put((void*)h,16,(uintptr_t)node);++append_count;
}
static void invoke(void) {iq4_f3_after_file_settings_append_01(root,0x4f0d38);}
int main(int argc,char **argv) {
    unsigned i,j,before;char b[32];uintptr_t node;uint32_t title=391;
    iq4_f3_fixture_ctor_01(0x4e5744,root,UINT32_MAX,0,0);memcpy(root+0x14,&title,4);
    if(argc==2) {
        fail_at=(unsigned)strtoul(argv[1],0,10);assert(fail_at>=1 && fail_at<=8);
        invoke();assert(building && append_count==0 && !bound_parent);
        before=allocation_count;invoke();assert(allocation_count==before && append_count==0);
        goto cleanup;
    }
    iq4_f3_after_file_settings_append_01(root,0x4eea5c);assert(!allocation_count);
    put(root,0,0xb8fd40);invoke();assert(!allocation_count);put(root,0,0xb8f9b8);
    title=389;memcpy(root+0x14,&title,4);invoke();assert(!allocation_count);
    title=391;memcpy(root+0x14,&title,4);put(root,0x38,0);invoke();assert(!allocation_count);
    put(root,0x38,(uintptr_t)root+0x28);
    for(i=0;i<3;++i) iq4_f3_fixture_append_01(root,(void*)(uintptr_t)(0x1000+8*i));
    invoke();assert(format_menu && size_menu && !building && append_count==11);
    assert(present((uintptr_t)root,(uintptr_t)format_menu)==1);
    before=allocation_count;invoke();invoke();assert(allocation_count==before);
    node=word((uintptr_t)root+0x30);
    for(i=0;i<3;++i) {assert(word(node+24)==0x1000+8*i);node=word(node+8);}
    assert(word(node+24)==(uintptr_t)format_menu && word(node+8)==(uintptr_t)root+0x28);
    for(i=0;i<24;++i) if(i!=5 && i!=6) assert(menu_table[i]==original_menu[i]);
    for(i=0;i<22;++i) if(i!=5 && i!=6 && i!=12) assert(item_table[i]==original_item[i]);
    assert(menu_table[1]==0xb8fbe0 && item_table[1]==0xb907e8);
    assert(menu_table[16]==0x4e6004 && item_table[16]==0x4ea2fc);
    assert(word((uintptr_t)format_menu)==(uintptr_t)&menu_table[2]);
    assert(word((uintptr_t)size_menu)==(uintptr_t)&menu_table[2]);
    assert(!strcmp(menu_name(format_menu,b,32),"Capture Output"));
    assert(!strcmp(menu_name(size_menu,b,32),"JPEG Size"));
    assert(iq4_f3_mode_get_01()==F3_RAW && iq4_f3_scale_get_01()==F3_FULL01);
    for(i=0;i<3;++i) {
        uintptr_t vt=word((uintptr_t)format_items[i]);
        uint32_t (*cb)(void*)=(uint32_t(*)(void*))word(vt+0x50);
        assert(cb(format_items[i])==1 && iq4_f3_mode_get_01()==format_modes[i]);
        assert(!strcmp(item_name(format_items[i],b,32),format_names[i]));
        assert(!strcmp(menu_value(format_menu,b,32),format_names[i]));
        for(j=0;j<3;++j) assert(!strcmp(item_value(format_items[j],b,32),i==j?"Selected":""));
        for(j=0;j<3;++j) {
            assert(activate(size_items[j])==1 && iq4_f3_scale_get_01()==j);
            assert(iq4_f3_mode_get_01()==format_modes[i]);
            assert(!strcmp(item_name(size_items[j],b,32),size_names[j]));
            assert(!strcmp(menu_value(size_menu,b,32),size_names[j]));
            assert(!strcmp(item_value(size_items[j],b,32),"Selected"));
        }
    }
    assert(!activate(root) && !iq4_f3_mode_set_on_ui_01(3) && !iq4_f3_scale_set_on_ui_01(3));
    memset(b,0x55,sizeof b);item_name(format_items[0],b+1,2);
    assert(b[0]==0x55 && b[1]=='R' && b[2]==0 && b[3]==0x55);
    node=word((uintptr_t)format_menu+0x30);
    for(i=0;i<3;++i) {assert(word(node+24)==(uintptr_t)format_items[i]);node=word(node+8);}
    assert(word(node+24)==(uintptr_t)size_menu && word(node+8)==(uintptr_t)format_menu+0x28);
    {
        _Alignas(8) unsigned char other[0x118]={0};
        iq4_f3_fixture_ctor_01(0x4e5744,other,UINT32_MAX,0,0);memcpy(other+0x14,&title,4);
        before=allocation_count;iq4_f3_after_file_settings_append_01(other,0x4f0d38);assert(allocation_count==before);
    }
cleanup:
    for(i=0;i<allocation_count;++i) free(allocations[i]);
    puts("PASS: own-memory native-menu ABI fixture; no native firmware execution");return 0;
}
