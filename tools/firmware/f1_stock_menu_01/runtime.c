#include <stdint.h>
#include <stddef.h>

/* This translation unit is the complete added menu runtime. Native C++ objects
 * are only constructed by their pinned native constructors. No replacement
 * declaration of a C++ class, data config property, or RAW crop is introduced. */
static unsigned requested_mode;
static void *own_menu[2], *own_items[2][5];
static uintptr_t bound_parent[2];
static unsigned building[2];
static uintptr_t menu_table[24], item_table[22];
static const char *const labels[5] = {"Off / Native", "XPan 65:24", "16:9", "3:2", "1:1"};

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
    for (k = 0; k < 2; ++k) for (i = 0; i < 5; ++i)
        if (p && p == own_items[k][i]) return i;
    return 5;
}
static char *menu_name(void *p, char *b, int32_t n) {
    (void)p; return text(b, n, "F1 Mask");
}
static char *menu_value(void *p, char *b, int32_t n) {
    (void)p; return text(b, n, labels[__atomic_load_n(&requested_mode, __ATOMIC_RELAXED)]);
}
static char *item_name(void *p, char *b, int32_t n) {
    unsigned i = item_index(p); return text(b, n, i < 5 ? labels[i] : "");
}
static char *item_value(void *p, char *b, int32_t n) {
    unsigned i = item_index(p);
    return text(b, n, i == __atomic_load_n(&requested_mode, __ATOMIC_RELAXED) ? "Selected" : "");
}
unsigned iq4_f1_mode_get_01(void) { return __atomic_load_n(&requested_mode, __ATOMIC_RELAXED); }
int iq4_f1_mode_set_on_ui_01(unsigned mode) {
    if (mode > 4) return 0;
    __atomic_store_n(&requested_mode, mode, __ATOMIC_RELAXED); return 1;
}
static uint32_t activate(void *p) {
    unsigned i = item_index(p);
    if (i >= 5) return 0;
    iq4_f1_mode_set_on_ui_01(i);
    /* Original Navigator handles return/back after this callback returns. */
    return 1;
}
void iq4_f1_menu_initialize_01(void) {
    /* State is BSS-initialized; menu installation is driven by the stock menu
     * opening call, so this constructor is not an admission dependency. */
    __atomic_store_n(&requested_mode, 0, __ATOMIC_RELAXED);
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

void iq4_f1_before_native_menu_01(void *selector, void *root, uintptr_t return_pc) {
    uintptr_t s = (uintptr_t)selector, parent = (uintptr_t)root, manager;
    uint32_t title;
    unsigned i,k; int attached;
    if (return_pc == 0x4eea5c) k = 0;
    else if (return_pc == 0x4ee784) k = 1;
    else return;
    if (!s || (s & 7) || !parent || (parent & 7)) return;
    if (word(s) != 0xb931b0 || word(parent) != 0xb8f9b8) return;
    __builtin_memcpy(&title, (const void *)(parent + 0x14), 4);
    /* Exact resources: LiveView Settings / Configure Grid. The latter is
     * reached by long-pressing Grid in the right-hand LV tools drawer. */
    if (title != (k ? 727u : 604u)) return;
    manager = word(s + 0xb0);
    if (!manager || (manager & 7) || word(manager) != 0xb8f358) return;
    attached = present(parent, (uintptr_t)own_menu[k]);
    if (attached < 0 || attached || building[k]) return;
    /* Each original selector owns a separate native menu and five leaves;
     * only the private display mode is shared between these two entry paths. */
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
        for (i = 0; i < 5; ++i) {
            own_items[k][i] = native_new(0x38);
            if (!own_items[k][i]) return;
            ctor(0x4e9d30, own_items[k][i]);
            put(own_items[k][i], 0, (uintptr_t)&item_table[2]);
            append(own_menu[k], own_items[k][i]);
        }
    }
    append(root, own_menu[k]);
    bound_parent[k] = parent;
    building[k] = 0;
}
