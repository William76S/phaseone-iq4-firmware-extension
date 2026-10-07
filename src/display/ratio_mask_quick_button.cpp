#include "ratio_mask_quick_button.h"
#include "ratio_mask_menu.h"
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <new>

/* P1Linux 6.03.21 native UI adapter. The original LV, toolbar controls,
 * properties and their virtual tables retain their stock identity. Only our
 * new UiButtonControl has a derived draw/destructor table. */
namespace {
struct Rect { uintptr_t vtable; int32_t x,y,width,height; };
struct Color { uint8_t alpha,r,g,b; };
static_assert(sizeof(Rect)==24 && sizeof(Color)==4,"native display ABI");
constexpr unsigned own_tag=0x524d01;
constexpr uint64_t gestures=0x100000100ULL; /* tap byte1, hold byte4 */
struct Quick;
struct Observer { const uintptr_t *vtable; Quick *owner; };
struct Quick {
    alignas(8) unsigned char button[0xa0];
    Observer observer;
    void *lv,*stack,*manager,*check,*corner,*popup,*root;
    Quick *next;
    uintptr_t hold_session;
    uint32_t hold_start;
    bool hold_seen,constructed,attached,destroying;
};
static Quick *first;
/* 0xb84c28 contains the native offset-to-top/RTTI followed by 51 slots.
 * The secondary button observer at this+80 retains its native table. */
static uintptr_t button_table[53];
static unsigned table_ready;
template<class T> T get(const void *p,size_t o=0) {T v;memcpy(&v,(const char*)p+o,sizeof v);return v;}
template<class T> void put(void *p,size_t o,T v) {memcpy((char*)p+o,&v,sizeof v);}
static bool pointer(const void *p) {return (uintptr_t)p>=4096 && !((uintptr_t)p&7);}
[[maybe_unused]] static uintptr_t slot(void *p,unsigned o) {return get<uintptr_t>((const void*)get<uintptr_t>(p),o);}

#ifdef IQ4_RATIO_QUICK_HOST
extern "C" uintptr_t quick_test_word(uintptr_t);
extern "C" bool quick_test_pins(void);
extern "C" void *quick_test_new(size_t);
extern "C" void quick_test_delete(void*);
extern "C" void quick_test_button_ctor(void*,int32_t,int32_t,bool);
extern "C" void quick_test_button_dtor(void*);
extern "C" Rect quick_test_background(void*,void*,const Rect*,const Rect*);
extern "C" void quick_test_icon_ctor(void*,int32_t,int32_t,void*,uint32_t,bool,const Color*,const Color*);
extern "C" void quick_test_attach(void*,void*,int32_t,int32_t,uint32_t,int32_t);
extern "C" void quick_test_stack_append(void*,void*);
extern "C" void quick_test_detach(void*);
extern "C" void quick_test_native_delete(void*);
extern "C" void quick_test_bind(void*,void*,uint64_t,unsigned);
extern "C" void quick_test_visible(void*,bool);
extern "C" void quick_test_invalidate(void*);
extern "C" void quick_test_fill(void*,const Rect*,const Rect*,const Color*);
extern "C" void quick_test_popup_ctor(void*,void*,void*,uint32_t,bool);
extern "C" void quick_test_popup_set(void*,void*);
extern "C" void quick_test_popup_show(void*);
extern "C" void quick_test_popup_close(void*);
extern "C" void quick_test_popup_dtor(void*);
static uintptr_t immutable(uintptr_t p) {return quick_test_word(p);}
static bool pins() {return quick_test_pins();}
static void *allocate(size_t n) {return quick_test_new(n);}
static void release(void *p) {quick_test_delete(p);}
static void button_ctor(void *p) {quick_test_button_ctor(p,150,100,false);}
static void button_dtor(void *p) {quick_test_button_dtor(p);}
static Rect background(void *p,void *s,const Rect *d,const Rect *c) {return quick_test_background(p,s,d,c);}
static void icon_ctor(void *p,void *r,uint32_t id,const Color *fg) {static const Color transparent={0,0,0,0};quick_test_icon_ctor(p,30,30,r,id,true,fg,&transparent);}
static void attach(void *p,void *c,uint32_t flags,int32_t inset) {quick_test_attach(p,c,10,10,flags,inset);}
static void append(void *p,void *c) {quick_test_stack_append(p,c);}
static void detach(void *p) {quick_test_detach(p);}
static void native_delete(void *p) {quick_test_native_delete(p);}
static void bind(void *p,void *o,const uint64_t *f,unsigned tag) {quick_test_bind(p,o,*f,tag);}
static void visible(void *p,bool b) {quick_test_visible(p,b);}
static void invalidate(void *p) {quick_test_invalidate(p);}
static void fill(void *s,const Rect *r,const Rect *c,const Color *v) {quick_test_fill(s,r,c,v);}
static void popup_ctor(void *p,void *m) {quick_test_popup_ctor(p,m,nullptr,750,true);}
static void popup_set(void *p,void *r) {quick_test_popup_set(p,r);}
static void popup_show(void *p) {quick_test_popup_show(p);}
static void popup_close(void *p) {quick_test_popup_close(p);}
static void popup_dtor(void *p) {quick_test_popup_dtor(p);}
#else
#include "ratio_mask_quick_button_pins.h"
static uintptr_t immutable(uintptr_t p) {return get<uintptr_t>((const void*)p);}
static bool pins() {
    static unsigned checked,allowed;
    if(!checked) {checked=1;allowed=1;for(const auto &p:ratio_quick_pins_01)
        if(memcmp((const void*)p.va,p.bytes,p.length)) {allowed=0;break;}}
    return allowed!=0;
}
static void *allocate(size_t n) {return ::operator new(n);}
static void release(void *p) {::operator delete(p);}
static void button_ctor(void *p) {((void(*)(void*,int32_t,int32_t,bool))0x4aee7c)(p,150,100,false);}
static void button_dtor(void *p) {((void(*)(void*))0x4aef54)(p);}
static Rect background(void *p,void *s,const Rect *d,const Rect *c) {return ((Rect(*)(void*,void*,const Rect*,const Rect*))0x4af054)(p,s,d,c);}
static void icon_ctor(void *p,void *r,uint32_t id,const Color *fg) {static const Color transparent={0,0,0,0};((void(*)(void*,int32_t,int32_t,void*,uint32_t,bool,const Color*,const Color*))0x4adc18)(p,30,30,r,id,true,fg,&transparent);}
static void attach(void *p,void *c,uint32_t flags,int32_t inset) {((void(*)(void*,void*,int32_t,int32_t,uint32_t,int32_t))0x4ab898)(p,c,10,10,flags,inset);}
static void append(void *p,void *c) {((void(*)(void*,void*))0x4d0288)(p,c);}
/* Native intrusive remove-self does not clear +8; clear our borrowed parent. */
static void detach(void *p) {((void(*)(void*))0x70c9bc)(p);put<uintptr_t>(p,8,0);}
static void native_delete(void *p) {((void(*)(void*))slot(p,8))(p);}
static void bind(void *p,void *o,const uint64_t *f,unsigned tag) {((void(*)(void*,void*,uint64_t,unsigned))0x4ac6a0)(p,o,*f,tag);}
static void visible(void *p,bool b) {((void(*)(void*,bool))0x4ac144)(p,b);}
static void invalidate(void *p) {((void(*)(void*,unsigned))0x4ac06c)(p,0);}
static void fill(void *s,const Rect *r,const Rect *c,const Color *v) {((void(*)(void*,const Rect*,const Rect*,const Color*))0x46f370)(s,r,c,v);}
static void popup_ctor(void *p,void *m) {((void(*)(void*,void*,void*,uint32_t,bool))0x4fad38)(p,m,nullptr,750,true);}
static void popup_set(void *p,void *r) {((void(*)(void*,void*))0x4fb364)(p,r);}
static void popup_show(void *p) {((void(*)(void*))0x4e12c8)(p);}
static void popup_close(void *p) {((void(*)(void*))0x4e1320)(p);}
static void popup_dtor(void *p) {((void(*)(void*))0x4fb1cc)(p);}
#endif

static void unlink(Quick *q) {
    Quick **p=&first;while(*p && *p!=q)p=&(*p)->next;
    if(*p==q)*p=q->next;
    q->next=nullptr;
}
static bool popup_in_stack(const Quick *q) {
    /* Dialog manager normal list sentinel +78; nodes contain dialog at+18.
     * No guessed popup-visible flag or modification of native stack state. */
    const uintptr_t h=(uintptr_t)q->manager+0x78;
    uintptr_t p=get<uintptr_t>((const void*)h,8);
    for(unsigned n=0;p!=h && n<32;++n) {
        if(!pointer((void*)p))return false;
        if(get<uintptr_t>((const void*)p,24)==(uintptr_t)q->popup)return true;
        p=get<uintptr_t>((const void*)p,8);
    }
    return false;
}
static void dispose(Quick *q) {
    if(q->destroying)return;
    q->destroying=true;unlink(q);
    if(q->constructed)bind(q->button,nullptr,&gestures,0);
    if(q->attached) {detach(q->button);q->attached=false;}
    if(q->popup) {
        if(popup_in_stack(q))popup_close(q->popup);
        popup_set(q->popup,nullptr); /* Root is borrowed resident menu data. */
        popup_dtor(q->popup);release(q->popup);q->popup=nullptr;
    }
    /* The factory control tree is intrusive, not an owning allocation tree.
     * Delete only the exact independent objects allocated by this module. */
    if(q->check) {detach(q->check);native_delete(q->check);q->check=nullptr;}
    if(q->corner) {detach(q->corner);native_delete(q->corner);q->corner=nullptr;}
    if(q->constructed) {button_dtor(q->button);q->constructed=false;}
}
static void complete_dtor(void *p) {dispose((Quick*)p);}
static void deleting_dtor(void *p) {dispose((Quick*)p);release(p);}
static void observer_dtor(void*) {}
static void refresh(Quick *q) {visible(q->check,iq4_f1_mode_get_01()!=0);}

/* Native UiWidget paint returns a 24-byte Rectangle through A64 hidden x8.
 * This C++ return type intentionally preserves that ABI and the native clip. */
static Rect draw(void *p,void *s,const Rect *d,const Rect *c) {
    Quick *q=(Quick*)p;
    refresh(q);
    Rect out=background(p,s,d,c);
    if(!d||!c||d->width<110||d->height<70)return out;
    /* Original 30px status/corner children occupy x10..40 and x110..140.
     * Keep the 70px center glyph between them, including the border. */
    const int32_t x=d->x+(d->width-70)/2,y=d->y+(d->height-44)/2;
    const Color ink={255,224,224,224},shade={255,112,112,112};
    const Rect boxes[6]={{0xb73b98,x,y,70,2},{0xb73b98,x,y+42,70,2},
        {0xb73b98,x,y+2,2,40},{0xb73b98,x+68,y+2,2,40},
        {0xb73b98,x+2,y+2,66,9},{0xb73b98,x+2,y+33,66,9}};
    for(unsigned i=0;i<6;++i)fill(s,&boxes[i],c,i<4?&ink:&shade);
    return out;
}
static void notification(void *o,void *sender,void *event,unsigned tag) {
    Observer *observer=(Observer*)o;Quick *q=observer->owner;
    if(!q||q->destroying||sender!=q->button||tag!=own_tag||!event)return;
    const uint32_t kind=get<uint32_t>(event);
    if(kind==1) {
        /* Native Tap is released before350ms; Hold requires>500ms. The
         * factory recognizer therefore never emits Tap on Hold release. */
        q->hold_seen=false;iq4_f1_toggle_on_ui_01();refresh(q);invalidate(q->button);
    } else if(kind==32) {
        const uintptr_t session=get<uintptr_t>(event,8);
        if(!pointer((void*)session))return;
        const uint32_t start=get<uint32_t>((const void*)session,0xc4);
        if(q->hold_seen&&q->hold_session==session&&q->hold_start==start)return;
        q->hold_seen=true;q->hold_session=session;q->hold_start=start;
        if(popup_in_stack(q))return;
        q->root=iq4_f1_quick_menu_root_on_ui_01();
        if(!q->root)return;
        if(!q->popup) {
            void *p=allocate(0x4b8);
            try {popup_ctor(p,q->manager);} catch(...) {release(p);throw;}
            q->popup=p;
        }
        popup_set(q->popup,q->root);popup_show(q->popup);
    }
}
static const uintptr_t observer_table[3]={(uintptr_t)observer_dtor,(uintptr_t)observer_dtor,(uintptr_t)notification};
static void tables() {
    if(table_ready)return;
    for(unsigned i=0;i<53;++i)button_table[i]=immutable(0xb84c28+8*i);
    button_table[2]=(uintptr_t)complete_dtor;
    button_table[3]=(uintptr_t)deleting_dtor;
    button_table[2+0xa0/8]=(uintptr_t)draw;
    table_ready=1;
}
}

extern "C" void iq4_ratio_quick_append_on_ui_01(void *stack,void *stock,void *lv) {
    if(!pins()||!pointer(stack)||!pointer(stock)||!pointer(lv))return;
    if(get<uintptr_t>(stack)!=0xb8b3f8||get<uintptr_t>(stock)!=0xb8c7b0||get<uintptr_t>(lv)!=0xb9a9d8)return;
    void *manager=(void*)get<uintptr_t>(lv,0xb0),*resource=(void*)get<uintptr_t>(stock,0xa0);
    if(!pointer(manager)||get<uintptr_t>(manager)!=0xb8f358||!pointer(resource))return;
    for(Quick *p=first;p;p=p->next)if(p->lv==lv)return;
    void *root=iq4_f1_quick_menu_root_on_ui_01();if(!root)return;
    tables();Quick *q=(Quick*)allocate(sizeof(Quick));memset(q,0,sizeof *q);
    q->lv=lv;q->stack=stack;q->manager=manager;q->root=root;
    try {
        button_ctor(q->button);q->constructed=true;
        put<uintptr_t>(q->button,0,(uintptr_t)&button_table[2]);
        q->observer={observer_table,q};
        static const Color blue={255,0,174,239},gray={255,128,128,128};
        void *icon=allocate(0xa0);
        try {icon_ctor(icon,resource,1209,&blue);} catch(...) {release(icon);throw;}
        q->check=icon;attach(q->button,icon,0,0);
        icon=allocate(0xa0);
        try {icon_ctor(icon,resource,38,&gray);} catch(...) {release(icon);throw;}
        q->corner=icon;attach(q->button,icon,6,10);
        bind(q->button,&q->observer,&gestures,own_tag);refresh(q);
        append(stack,q->button);q->attached=true;
        q->next=first;first=q;
    } catch(...) {dispose(q);release(q);throw;}
}

extern "C" void iq4_ratio_quick_cleanup_on_ui_01(void *lv) {
    Quick *q=first;
    while(q) {Quick *next=q->next;if(q->lv==lv) {dispose(q);release(q);}q=next;}
}
