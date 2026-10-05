#include <stdint.h>
#include <stddef.h>
#include "policy.h"
#ifndef IQ4_F3_MENU_PRODUCTION_ENABLE
#define IQ4_F3_MENU_PRODUCTION_ENABLE 0
#endif

/* Exact native constructor/VT ABI reused from working F1 menu04. No native
 * property/enum rewrite, RAW pixels, EEPROM, storage call, thread or listener. */
static void *format_menu,*size_menu,*quality_menu,*format_items[3],*size_items[6],*quality_items[3];
static uintptr_t bound_parent,menu_table[24],item_table[22];
static unsigned building;
static const char *const format_names[3]={"RAW","JPEG","RAW + JPEG"};
static const uint32_t format_modes[3]={F3_RAW,F3_JPEG_ONLY,F3_RAW_JPEG};
static const char *const size_names[6]={"Full","75%","50%","25%","Long edge 3840","Long edge 7680"};
static const char *const quality_names[3]={"Decrease by 1","Increase by 1","Reset to 95"};

#ifdef IQ4_F3_MENU_HOST
extern uintptr_t iq4_f3_fixture_word_01(uintptr_t);
extern void *iq4_f3_fixture_new_01(size_t);
extern void iq4_f3_fixture_ctor_01(uintptr_t,void*,uint32_t,void*,void*);
extern void iq4_f3_fixture_append_01(void*,void*);
#endif
static uintptr_t word(uintptr_t p) {
#ifdef IQ4_F3_MENU_HOST
    return iq4_f3_fixture_word_01(p);
#else
    uintptr_t x;__builtin_memcpy(&x,(const void*)p,sizeof x);return x;
#endif
}
static void put(void *p,size_t off,uintptr_t x) {__builtin_memcpy((char*)p+off,&x,sizeof x);}
static void *native_new(size_t n) {
#ifdef IQ4_F3_MENU_HOST
    return iq4_f3_fixture_new_01(n);
#else
    return ((void*(*)(size_t))(uintptr_t)0x409e60)(n);
#endif
}
static void ctor(uintptr_t fn,void *p) {
#ifdef IQ4_F3_MENU_HOST
    iq4_f3_fixture_ctor_01(fn,p,UINT32_MAX,0,0);
#else
    ((void(*)(void*,uint32_t,void*,void*))fn)(p,UINT32_MAX,0,0);
#endif
}
static void append(void *parent,void *item) {
#ifdef IQ4_F3_MENU_HOST
    iq4_f3_fixture_append_01(parent,item);
#else
    ((void(*)(void*,void*))(uintptr_t)0x4e58b8)(parent,item);
#endif
}
static char *text(char *b,int32_t n,const char *s) {
    int32_t i=0;if(!b || n<=0) return (char*)"";
    for(;i+1<n && s[i];++i) b[i]=s[i];b[i]=0;return b;
}
static unsigned index_of(const void *p,void *const *items,unsigned count) {
    unsigned i;for(i=0;i<count;++i) if(p && p==items[i]) return i;return count;
}
static const char *format_label(uint32_t mode) {
    unsigned i;for(i=0;i<3;++i) if(format_modes[i]==mode) return format_names[i];return "Unavailable";
}
static char *menu_name(void *p,char *b,int32_t n) {
    return text(b,n,p==size_menu?"JPEG Size":(p==quality_menu?"JPEG Quality":"Capture Output"));
}
static char *menu_value(void *p,char *b,int32_t n) {
    if(p==quality_menu) {
        char value[4];uint32_t q=iq4_f3_quality_get_03();unsigned k=0;
        if(q>=100) value[k++]='1';
        if(q>=10) value[k++]=(char)('0'+(q/10)%10);
        value[k++]=(char)('0'+q%10);value[k]=0;
        return text(b,n,value);
    }
    uint32_t scale=iq4_f3_scale_get_01();
    return text(b,n,p==size_menu?(scale<6?size_names[scale]:"Unavailable"):format_label(iq4_f3_mode_get_01()));
}
static char *item_name(void *p,char *b,int32_t n) {
    unsigned i=index_of(p,format_items,3);if(i<3) return text(b,n,format_names[i]);
    i=index_of(p,quality_items,3);if(i<3) return text(b,n,quality_names[i]);
    i=index_of(p,size_items,6);return text(b,n,i<6?size_names[i]:"");
}
static char *item_value(void *p,char *b,int32_t n) {
    unsigned i=index_of(p,format_items,3);if(i<3) return text(b,n,format_modes[i]==iq4_f3_mode_get_01()?"Selected":"");
    i=index_of(p,size_items,6);return text(b,n,i<6 && i==iq4_f3_scale_get_01()?"Selected":"");
}
static uint32_t activate(void *p) {
    unsigned i=index_of(p,format_items,3);if(i<3) return (uint32_t)iq4_f3_mode_set_on_ui_01(format_modes[i]);
    i=index_of(p,size_items,6);if(i<6) return (uint32_t)iq4_f3_scale_set_on_ui_01(i);
    i=index_of(p,quality_items,3);if(i<3) {
        uint32_t q=iq4_f3_quality_get_03();
        return (uint32_t)iq4_f3_quality_set_on_ui_03(i==2?95:(i==0?(q>1?q-1:1):(q<100?q+1:100)));
    }
    return 0;
}
static int present(uintptr_t parent,uintptr_t item) {
    uintptr_t head=parent+0x28,previous=head,p;unsigned n=0;int found=0;
    if(word(parent+0x18)!=0xb8faa0 || word(parent+0x20)!=0xc22908 || word(head)!=0xc22960) return -1;
    p=word(head+8);
    while(p!=head) {
        if(!p || (p&7) || ++n>64 || word(p)!=0xb8f958 || word(p+16)!=previous) return -1;
        if(word(p+24)==item) found=1;previous=p;p=word(p+8);
    }
    return word(head+16)==previous?found:-1;
}
/* Called only after exact original append4f0d34 once. It is deliberately EN0
 * in production until Root's actual complete-RAW consumer is linked/accepted.
 * Host macro activates only a synthetic owned-memory native ABI fixture. */
void iq4_f3_after_file_settings_append_01(void *root,uintptr_t original_return_pc) {
    uintptr_t parent=(uintptr_t)root;uint32_t title;unsigned i;int attached;
#if !IQ4_F3_MENU_PRODUCTION_ENABLE && !defined(IQ4_F3_MENU_HOST)
    (void)root;(void)original_return_pc;return;
#endif
    if(original_return_pc!=0x4f0d38 || !parent || (parent&7) || word(parent)!=0xb8f9b8) return;
    __builtin_memcpy(&title,(const void*)(parent+0x14),sizeof title);
    if(title!=391) return;
    attached=present(parent,(uintptr_t)format_menu);
    if(attached<0 || attached || building || (bound_parent && bound_parent!=parent)) return;
    building=1;
    for(i=0;i<24;++i) menu_table[i]=word(0xb8f9a8+8*i);
    for(i=0;i<22;++i) item_table[i]=word(0xb90738+8*i);
    menu_table[5]=(uintptr_t)menu_name;menu_table[6]=(uintptr_t)menu_value;
    item_table[5]=(uintptr_t)item_name;item_table[6]=(uintptr_t)item_value;item_table[12]=(uintptr_t)activate;
    format_menu=native_new(0x118);if(!format_menu) return;
    ctor(0x4e5744,format_menu);put(format_menu,0,(uintptr_t)&menu_table[2]);
    size_menu=native_new(0x118);if(!size_menu) return;
    ctor(0x4e5744,size_menu);put(size_menu,0,(uintptr_t)&menu_table[2]);
    quality_menu=native_new(0x118);if(!quality_menu) return;
    ctor(0x4e5744,quality_menu);put(quality_menu,0,(uintptr_t)&menu_table[2]);
    for(i=0;i<3;++i) {
        format_items[i]=native_new(0x38);if(!format_items[i]) return;
        ctor(0x4e9d30,format_items[i]);put(format_items[i],0,(uintptr_t)&item_table[2]);
    }
    for(i=0;i<6;++i) {
        size_items[i]=native_new(0x38);if(!size_items[i]) return;
        ctor(0x4e9d30,size_items[i]);put(size_items[i],0,(uintptr_t)&item_table[2]);
    }
    for(i=0;i<3;++i) {
        quality_items[i]=native_new(0x38);if(!quality_items[i]) return;
        ctor(0x4e9d30,quality_items[i]);put(quality_items[i],0,(uintptr_t)&item_table[2]);
    }
    for(i=0;i<3;++i) append(format_menu,format_items[i]);
    for(i=0;i<6;++i) append(size_menu,size_items[i]);
    for(i=0;i<3;++i) append(quality_menu,quality_items[i]);
    append(format_menu,size_menu);append(format_menu,quality_menu);append(root,format_menu);bound_parent=parent;building=0;
}
