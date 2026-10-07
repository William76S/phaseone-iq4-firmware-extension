#include <stdint.h>
#include <stddef.h>
#include "../runtime/ratio_mask_settings.h"
#include "../../tools/firmware/f1_stock_display_payload_16/payload.h"

/* This translation unit is the complete added menu runtime. Native C++ objects
 * are only constructed by their pinned native constructors. No replacement
 * declaration of a C++ class, data config property, or RAW crop is introduced. */
static unsigned requested_mode;
static unsigned requested_opacity = 65u;
static unsigned remembered_mode = 1u;
static unsigned settings_result = IQ4_RATIO_SETTINGS_ABSENT;
static unsigned settings_loaded;

static void load_settings(void) {
    struct Iq4RatioMaskSettings value;
    unsigned result = (unsigned)iq4_ratio_settings_load_01(&value);
    __atomic_store_n(&requested_mode,value.mode,__ATOMIC_RELAXED);
    __atomic_store_n(&requested_opacity,value.opacity,__ATOMIC_RELAXED);
    __atomic_store_n(&remembered_mode,value.remembered_mode,__ATOMIC_RELAXED);
    __atomic_store_n(&settings_result,result,__ATOMIC_RELAXED);
    settings_loaded = result != IQ4_RATIO_SETTINGS_IO;
}
static void save_settings(unsigned mode,unsigned opacity) {
    const struct Iq4RatioMaskSettings value = {mode,opacity,
        mode ? mode : __atomic_load_n(&remembered_mode,__ATOMIC_RELAXED)};
    unsigned result = (unsigned)iq4_ratio_settings_save_01(&value);
    __atomic_store_n(&settings_result,result,__ATOMIC_RELAXED);
    /* Keep the user's active display choice even when storage fails; the menu
     * reports failure rather than pretending the choice survived power-off. */
    settings_loaded = 1;
}
static int save_failed(void) {
    unsigned result = __atomic_load_n(&settings_result,__ATOMIC_RELAXED);
    return result == IQ4_RATIO_SETTINGS_INVALID || result == IQ4_RATIO_SETTINGS_IO;
}
#define MENUS 2u
#define ITEMS 7u
#define MODES 8u
#define OPACITY_ITEMS 21u
static void *own_menu[MENUS], *own_items[MENUS][ITEMS];
static void *opacity_menu[MENUS], *opacity_items[MENUS][OPACITY_ITEMS];
static uintptr_t bound_parent[MENUS];
static unsigned building[MENUS];
static uintptr_t menu_table[24], item_table[22];
/* Mode IDs stay compatible with saved records; only nonzero modes are menu
 * choices. Enable/disable belongs to the dedicated LV shortcut. */
static const char *const labels[MODES] = {"Off", "XPan 65:24", "16:9", "3:2", "1:1", "4:5", "6:7", "21:9"};

/* Keep the existing display callback ABI, without diagnostic collection or UI. */
void iq4_f1_report_16(unsigned code,const F1Facts16 *f,unsigned filled) {
    (void)code; (void)f; (void)filled;
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
    for (k = 0; k < MENUS; ++k) for (i = 0; i < ITEMS; ++i)
        if (p && p == own_items[k][i]) return i;
    return ITEMS;
}
static unsigned opacity_index(const void *p) {
    unsigned i,k;
    for(k=0;k<MENUS;++k) for(i=0;i<OPACITY_ITEMS;++i)
        if(p && p==opacity_items[k][i]) return i;
    return OPACITY_ITEMS;
}
static int is_opacity_menu(const void *p) {
    for(unsigned k=0;k<MENUS;++k) if(p && p==opacity_menu[k]) return 1;
    return 0;
}
static char *percentage(char *,int32_t,unsigned);
static char *menu_name(void *p, char *b, int32_t n) {
    return text(b,n,is_opacity_menu(p)?"Opacity":"Ratio Mask");
}
static char *menu_value(void *p, char *b, int32_t n) {
    char value[64];
    const char *label;
    if(is_opacity_menu(p)) { percentage(value,sizeof value,__atomic_load_n(&requested_opacity,__ATOMIC_RELAXED)); label=value; }
    else label=labels[__atomic_load_n(&requested_mode,__ATOMIC_RELAXED)];
    if(!save_failed()) return text(b,n,label);
    char message[80]; unsigned i=0,j=0; const char *suffix=" (not saved)";
    for(;label[i]&&i+1<sizeof message;++i) message[i]=label[i];
    while(suffix[j]&&i+1<sizeof message) message[i++]=suffix[j++];
    message[i]=0; return text(b,n,message);
}
static char *item_name(void *p, char *b, int32_t n) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return percentage(b,n,i*5u);
    i=item_index(p); return text(b, n, i < ITEMS ? labels[i+1u] : "");
}
typedef struct {char *b; int32_t n,i;} Writer;
static void ch(Writer *w,char c) {if(w->i+1<w->n) w->b[w->i++]=c;}
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
static char *item_value(void *p, char *b, int32_t n) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return text(b,n,i*5u==__atomic_load_n(&requested_opacity,__ATOMIC_RELAXED)?"Selected":"");
    i=item_index(p);
    return text(b, n, i < ITEMS && i+1u == __atomic_load_n(&requested_mode, __ATOMIC_RELAXED) ? "Selected" : "");
}
unsigned iq4_f1_mode_get_01(void) { return __atomic_load_n(&requested_mode, __ATOMIC_RELAXED); }
int iq4_f1_mode_set_on_ui_01(unsigned mode) {
    if (mode > 7) return 0;
    if(mode!=iq4_f1_mode_get_01()||save_failed())
        save_settings(mode,__atomic_load_n(&requested_opacity,__ATOMIC_RELAXED));
    if(mode) __atomic_store_n(&remembered_mode,mode,__ATOMIC_RELAXED);
    __atomic_store_n(&requested_mode,mode,__ATOMIC_RELAXED);
    return 1;
}
int iq4_f1_toggle_on_ui_01(void) {
    if(!settings_loaded) load_settings();
    unsigned mode=iq4_f1_mode_get_01();
    return iq4_f1_mode_set_on_ui_01(mode ? 0u :
        __atomic_load_n(&remembered_mode,__ATOMIC_RELAXED));
}
unsigned iq4_f1_opacity_get_01(void) { return __atomic_load_n(&requested_opacity,__ATOMIC_RELAXED); }
int iq4_f1_opacity_set_on_ui_01(unsigned opacity) {
    if(opacity>100u || opacity%5u) return 0;
    if(opacity!=iq4_f1_opacity_get_01()||save_failed())
        save_settings(__atomic_load_n(&requested_mode,__ATOMIC_RELAXED),opacity);
    __atomic_store_n(&requested_opacity,opacity,__ATOMIC_RELAXED);return 1;
}
static uint32_t activate(void *p) {
    unsigned i = opacity_index(p);
    if(i<OPACITY_ITEMS) return (uint32_t)iq4_f1_opacity_set_on_ui_01(i*5u);
    i=item_index(p);
    if (i >= ITEMS) return 0;
    iq4_f1_mode_set_on_ui_01(i+1u);
    /* Original Navigator handles return/back after this callback returns. */
    return 1;
}
void iq4_f1_menu_initialize_04(void) {
    /* Normal boot mounts persistent user storage before launching P1Linux.
     * No setting file is created during startup. Missing files keep defaults. */
    load_settings();
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

static void *ensure_menu(unsigned k) {
    unsigned i;
    if(k>=MENUS || building[k]) return NULL;
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
        if (!own_menu[k]) { building[k]=0; return NULL; }
        ctor(0x4e5744, own_menu[k]);
        put(own_menu[k], 0, (uintptr_t)&menu_table[2]);
        for (i = 0; i < ITEMS; ++i) {
            own_items[k][i] = native_new(0x38);
            if (!own_items[k][i]) return NULL;
            ctor(0x4e9d30, own_items[k][i]);
            put(own_items[k][i], 0, (uintptr_t)&item_table[2]);
            append(own_menu[k], own_items[k][i]);
        }
        opacity_menu[k]=native_new(0x118);
        if(!opacity_menu[k]) return NULL;
        ctor(0x4e5744,opacity_menu[k]);
        put(opacity_menu[k],0,(uintptr_t)&menu_table[2]);
        for(i=0;i<OPACITY_ITEMS;++i) {
            opacity_items[k][i]=native_new(0x38);
            if(!opacity_items[k][i]) return NULL;
            ctor(0x4e9d30,opacity_items[k][i]);
            put(opacity_items[k][i],0,(uintptr_t)&item_table[2]);
            append(opacity_menu[k],opacity_items[k][i]);
        }
        append(own_menu[k],opacity_menu[k]);
    }
    building[k]=0;
    return own_menu[k];
}

/* The shortcut has its own native tree, so the LV Settings navigator and
 * popup never share parent/list ownership. Leaf callbacks share settings. */
void *iq4_f1_quick_menu_root_on_ui_01(void) {
    if(!settings_loaded) load_settings();
    return ensure_menu(1);
}

void iq4_f1_before_native_menu_04(void *selector, void *root, uintptr_t return_pc) {
    uintptr_t s = (uintptr_t)selector, parent = (uintptr_t)root, manager;
    uint32_t title;
    int attached;
    if (return_pc != 0x4eea5c) return;
    if (!s || (s & 7) || !parent || (parent & 7)) return;
    if (word(s) != 0xb931b0 || word(parent) != 0xb8f9b8) return;
    __builtin_memcpy(&title, (const void *)(parent + 0x14), 4);
    if (title != 604u) return;
    manager = word(s + 0xb0);
    if (!manager || (manager & 7) || word(manager) != 0xb8f358) return;
    if(!settings_loaded) load_settings();
    attached = present(parent, (uintptr_t)own_menu[0]);
    if (attached < 0 || attached || building[0]) return;
    if (bound_parent[0] && bound_parent[0] != parent) return;
    void *menu=ensure_menu(0);
    if(!menu) return;
    append(root,menu);
    bound_parent[0]=parent;
}
