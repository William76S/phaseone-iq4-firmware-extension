#include <stdint.h>
#include <stddef.h>
#include "../f1_stock_display_payload_16/payload.h"

/* This translation unit is the complete added menu runtime. Native C++ objects
 * are only constructed by their pinned native constructors. No replacement
 * declaration of a C++ class, data config property, or RAW crop is introduced. */
static unsigned requested_mode;
static unsigned requested_opacity = 65u;
#define ITEMS 17u
#define OPACITY_ITEMS 21u
static void *own_menu[1], *own_items[1][ITEMS];
static void *opacity_menu[1], *opacity_items[1][OPACITY_ITEMS];
static uintptr_t bound_parent[1];
static unsigned building[1];
static uintptr_t menu_table[24], item_table[22];
static const char *const labels[ITEMS] = {"Off / Native", "XPan 65:24", "16:9", "3:2", "1:1", "4:5", "6:7", "21:9",
    "LV draw status", "LV image / config", "LV source ROI", "LV rotation / motion",
    "LV scale bits", "LV projected", "LV clip", "LV LCD size", "LV requested size"};
static unsigned diag_code,diag_calls,diag_fills,diag_valid;
static uint32_t diag_data[26];

/* Only fixed, non-sensitive display facts. No pointers, source pixels, file or
 * device API. Counts are hook/fill returns, never frame rate or visible output. */
void iq4_f1_report_16(unsigned code,const F1Facts16 *f,unsigned filled) {
    uint32_t a[26]; unsigned i;
    if(code==10) __atomic_fetch_add(&diag_calls,1,__ATOMIC_RELAXED);
    if(f) {
        a[0]=(uint32_t)f->source_w; a[1]=(uint32_t)f->source_h;
        a[2]=(uint32_t)f->engine_w; a[3]=(uint32_t)f->engine_h;
        a[4]=(uint32_t)f->roi.x; a[5]=(uint32_t)f->roi.y;
        a[6]=(uint32_t)f->roi.w; a[7]=(uint32_t)f->roi.h;
        a[8]=f->rotation; a[9]=f->animation_active; a[10]=f->countdown;
        a[11]=f->scale_bits; a[12]=f->normal_scale_bits;
        a[13]=(uint32_t)f->projected.x; a[14]=(uint32_t)f->projected.y;
        a[15]=(uint32_t)f->projected.w; a[16]=(uint32_t)f->projected.h;
        a[17]=(uint32_t)f->clip.w; a[18]=(uint32_t)f->clip.h;
        a[19]=(uint32_t)f->surface_pitch; a[20]=(uint32_t)f->surface_height;
        a[21]=(uint32_t)f->format;
        a[22]=(uint32_t)f->clip.x; a[23]=(uint32_t)f->clip.y;
        a[24]=(uint32_t)f->requested_w; a[25]=(uint32_t)f->requested_h;
        for(i=0;i<26;++i) __atomic_store_n(&diag_data[i],a[i],__ATOMIC_RELAXED);
        __atomic_store_n(&diag_valid,1,__ATOMIC_RELEASE);
    } else __atomic_store_n(&diag_valid,0,__ATOMIC_RELEASE);
    if(filled) __atomic_fetch_add(&diag_fills,filled,__ATOMIC_RELAXED);
    __atomic_store_n(&diag_code,code,__ATOMIC_RELEASE);
}

#ifdef IQ4_F1_MENU_HOST
extern uintptr_t iq4_f1_test_word(uintptr_t);
extern void *iq4_f1_test_new(size_t);
extern void iq4_f1_test_ctor(uintptr_t, void *, uint32_t, void *, void *);
extern void iq4_f1_test_append(void *, void *);
#endif

static uintptr_t word(uintptr_t p) {
#ifdef IQ4_F1_MENU_HOST
    return iq4_f1_test_word(p);
#else
    uintptr_t r; __builtin_memcpy(&r, (const void *)p, sizeof r); return r;
#endif
}
static void put(void *p, size_t o, uintptr_t x) { __builtin_memcpy((char *)p + o, &x, sizeof x); }
static void *native_new(size_t n) {
#ifdef IQ4_F1_MENU_HOST
    return iq4_f1_test_new(n);
#else
    return ((void *(*)(size_t))(uintptr_t)0x409e60)(n);
#endif
}
static void ctor(uintptr_t f, void *p) {
#ifdef IQ4_F1_MENU_HOST
    iq4_f1_test_ctor(f, p, UINT32_MAX, NULL, NULL);
#else
    ((void (*)(void *, uint32_t, void *, void *))f)(p, UINT32_MAX, NULL, NULL);
#endif
}
static void append(void *parent, void *item) {
#ifdef IQ4_F1_MENU_HOST
    iq4_f1_test_append(parent, item);
#else
    ((void (*)(void *, void *))(uintptr_t)0x4e58b8)(parent, item);
#endif
}

/* Native callbacks take a maximum character count. We use the stricter count
 * including NUL; all labels fit the actual 64/32-character call buffers. */
static char *text(char *b, int32_t n, const char *s) {
    int32_t i = 0;
    if (!b || n <= 0) return (char *)"";
    for (; i + 1 < n && s[i]; ++i) b[i] = s[i];
    b[i] = 0;
    return b;
}
static unsigned item_index(const void *p) {
    unsigned i,k;
    for (k = 0; k < 1; ++k) for (i = 0; i < ITEMS; ++i)
        if (p && p == own_items[k][i]) return i;
    return ITEMS;
}
static unsigned opacity_index(const void *p) {
    unsigned i,k;
    for(k=0;k<1;++k) for(i=0;i<OPACITY_ITEMS;++i)
        if(p && p==opacity_items[k][i]) return i;
    return OPACITY_ITEMS;
}
static int is_opacity_menu(const void *p) {
    return p && (p==opacity_menu[0]);
}
static char *percentage(char *,int32_t,unsigned);
static char *menu_name(void *p, char *b, int32_t n) {
    return text(b,n,is_opacity_menu(p)?"Opacity":"Ratio Mask");
}
static char *menu_value(void *p, char *b, int32_t n) {
    if(is_opacity_menu(p)) return percentage(b,n,__atomic_load_n(&requested_opacity,__ATOMIC_RELAXED));
    return text(b, n, labels[__atomic_load_n(&requested_mode, __ATOMIC_RELAXED)]);
}
static char *item_name(void *p, char *b, int32_t n) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return percentage(b,n,i*5u);
    i=item_index(p); return text(b, n, i < ITEMS ? labels[i] : "");
}
typedef struct {char *b; int32_t n,i;} Writer;
static void ch(Writer *w,char c) {if(w->i+1<w->n) w->b[w->i++]=c;}
static void literal(Writer *w,const char *s) {for(;*s;++s) ch(w,*s);}
static void decimal(Writer *w,uint32_t u) {
    char a[10]; unsigned n=0;
    do {a[n++]=(char)('0'+u%10);u/=10;} while(u);
    while(n) ch(w,a[--n]);
}
static char *percentage(char *b,int32_t n,unsigned value) {
    Writer w={b,n,0};
    if(!b||n<=0) return (char *)"";
    decimal(&w,value);ch(&w,'%');b[w.i]=0;return b;
}
static void hexword(Writer *w,uint32_t u) {
    const char *h="0123456789ABCDEF"; int i;
    for(i=7;i>=0;--i) ch(w,h[(u>>(i*4))&15]);
}
static void signed_decimal(Writer *w,uint32_t u) {
    if(u&0x80000000u) {ch(w,'-');u=0u-u;}
    decimal(w,u);
}
static uint32_t dd(unsigned i) {return __atomic_load_n(&diag_data[i],__ATOMIC_RELAXED);}
static void pair(Writer *w,uint32_t a,uint32_t b) {decimal(w,a);ch(w,'x');decimal(w,b);}
static char *diagnostic_value(unsigned i,char *b,int32_t n) {
    Writer w={b,n,0};
    if(!b||n<=0) return (char *)"";
    if(i==8) {
        literal(&w,"E"); decimal(&w,__atomic_load_n(&diag_code,__ATOMIC_ACQUIRE));
        literal(&w," N"); decimal(&w,__atomic_load_n(&diag_calls,__ATOMIC_RELAXED));
        literal(&w," F"); decimal(&w,__atomic_load_n(&diag_fills,__ATOMIC_RELAXED));
    } else if(!__atomic_load_n(&diag_valid,__ATOMIC_ACQUIRE)) literal(&w,"Not captured");
    else if(i==9) {pair(&w,dd(0),dd(1));literal(&w," / ");pair(&w,dd(2),dd(3));}
    else if(i==10) {signed_decimal(&w,dd(4));ch(&w,',');signed_decimal(&w,dd(5));ch(&w,' ');pair(&w,dd(6),dd(7));}
    else if(i==11) {literal(&w,"R");decimal(&w,dd(8));literal(&w," A");decimal(&w,dd(9));literal(&w," C");decimal(&w,dd(10));}
    else if(i==12) {hexword(&w,dd(11));literal(&w," / ");hexword(&w,dd(12));}
    else if(i==13) {signed_decimal(&w,dd(13));ch(&w,',');signed_decimal(&w,dd(14));ch(&w,' ');pair(&w,dd(15),dd(16));}
    else if(i==14) {signed_decimal(&w,dd(22));ch(&w,',');signed_decimal(&w,dd(23));ch(&w,' ');pair(&w,dd(17),dd(18));}
    else if(i==15) {pair(&w,dd(19),dd(20));literal(&w," fmt");decimal(&w,dd(21));}
    else if(i==16) {pair(&w,dd(24),dd(25));}
    b[w.i]=0; return b;
}
static char *item_value(void *p, char *b, int32_t n) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return text(b,n,i*5u==__atomic_load_n(&requested_opacity,__ATOMIC_RELAXED)?"Selected":"");
    i=item_index(p);
    if(i>=8&&i<ITEMS) return diagnostic_value(i,b,n);
    return text(b, n, i == __atomic_load_n(&requested_mode, __ATOMIC_RELAXED) ? "Selected" : "");
}
unsigned iq4_f1_mode_get_01(void) { return __atomic_load_n(&requested_mode, __ATOMIC_RELAXED); }
int iq4_f1_mode_set_on_ui_01(unsigned mode) {
    if (mode > 7) return 0;
    __atomic_store_n(&requested_mode, mode, __ATOMIC_RELAXED);
    __atomic_store_n(&diag_code,mode?1u:0u,__ATOMIC_RELEASE);
    __atomic_store_n(&diag_valid,0,__ATOMIC_RELEASE); return 1;
}
unsigned iq4_f1_opacity_get_01(void) { return __atomic_load_n(&requested_opacity,__ATOMIC_RELAXED); }
int iq4_f1_opacity_set_on_ui_01(unsigned opacity) {
    if(opacity>100u || opacity%5u) return 0;
    __atomic_store_n(&requested_opacity,opacity,__ATOMIC_RELAXED);return 1;
}
static uint32_t activate(void *p) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return (uint32_t)iq4_f1_opacity_set_on_ui_01(i*5u);
    i=item_index(p);
    if (i >= 8) return 0;
    iq4_f1_mode_set_on_ui_01(i);
    /* Original Navigator handles return/back after this callback returns. */
    return 1;
}
void iq4_f1_menu_initialize_04(void) {
    /* State is BSS-initialized; menu installation is driven by the stock menu
     * opening call, so this constructor is not an admission dependency. */
    __atomic_store_n(&requested_mode, 0, __ATOMIC_RELAXED);
    __atomic_store_n(&requested_opacity,65u,__ATOMIC_RELAXED);
}

/* Original SubMenu list: list+0 VT, list+8 base, sentinel+0 VT,
 * sentinel+8 next, sentinel+16 previous; item node+24 payload. */
static int present(uintptr_t parent, uintptr_t item) {
    uintptr_t head = parent + 0x28, prev = head, p;
    unsigned n = 0; int found = 0;
    if (word(parent + 0x18) != 0xb8faa0 || word(parent + 0x20) != 0xc22908 ||
        word(head) != 0xc22960) return -1;
    p = word(head + 8);
    while (p != head) {
        if (!p || (p & 7) || ++n > 64 || word(p) != 0xb8f958 || word(p + 16) != prev) return -1;
        if (word(p + 24) == item) found = 1;
        prev = p; p = word(p + 8);
    }
    return word(head + 16) == prev ? found : -1;
}

void iq4_f1_before_native_menu_04(void *selector, void *root, uintptr_t return_pc) {
    uintptr_t s = (uintptr_t)selector, parent = (uintptr_t)root, manager;
    uint32_t title;
    unsigned i,k; int attached;
    if (return_pc == 0x4eea5c) k = 0;
    else return;
    if (!s || (s & 7) || !parent || (parent & 7)) return;
    if (word(s) != 0xb931b0 || word(parent) != 0xb8f9b8) return;
    __builtin_memcpy(&title, (const void *)(parent + 0x14), 4);
    /* Only original LiveView Settings. Grid construction is untouched. */
    if (title != 604u) return;
    manager = word(s + 0xb0);
    if (!manager || (manager & 7) || word(manager) != 0xb8f358) return;
    attached = present(parent, (uintptr_t)own_menu[k]);
    if (attached < 0 || attached || building[k]) return;
    /* One owned native menu, entered only through LiveView Settings. */
    if (bound_parent[k] && bound_parent[k] != parent) return;
    building[k] = 1;
    if (!own_menu[k]) {
        for (i = 0; i < 24; ++i) menu_table[i] = word(0xb8f9a8 + 8 * i);
        for (i = 0; i < 22; ++i) item_table[i] = word(0xb90738 + 8 * i);
        menu_table[2 + 0x18 / 8] = (uintptr_t)menu_name;
        menu_table[2 + 0x20 / 8] = (uintptr_t)menu_value;
        item_table[2 + 0x18 / 8] = (uintptr_t)item_name;
        item_table[2 + 0x20 / 8] = (uintptr_t)item_value;
        item_table[2 + 0x50 / 8] = (uintptr_t)activate;
        own_menu[k] = native_new(0x118);
        if (!own_menu[k]) return;
        ctor(0x4e5744, own_menu[k]);
        put(own_menu[k], 0, (uintptr_t)&menu_table[2]);
        for (i = 0; i < ITEMS; ++i) {
            own_items[k][i] = native_new(0x38);
            if (!own_items[k][i]) return;
            ctor(0x4e9d30, own_items[k][i]);
            put(own_items[k][i], 0, (uintptr_t)&item_table[2]);
            if(i<8u) append(own_menu[k], own_items[k][i]);
        }
        opacity_menu[k]=native_new(0x118);
        if(!opacity_menu[k]) return;
        ctor(0x4e5744,opacity_menu[k]);
        put(opacity_menu[k],0,(uintptr_t)&menu_table[2]);
        for(i=0;i<OPACITY_ITEMS;++i) {
            opacity_items[k][i]=native_new(0x38);
            if(!opacity_items[k][i]) return;
            ctor(0x4e9d30,opacity_items[k][i]);
            put(opacity_items[k][i],0,(uintptr_t)&item_table[2]);
            append(opacity_menu[k],opacity_items[k][i]);
        }
        append(own_menu[k],opacity_menu[k]);
        for(i=8u;i<ITEMS;++i) append(own_menu[k],own_items[k][i]);
    }
    append(root, own_menu[k]);
    bound_parent[k] = parent;
    building[k] = 0;
}
