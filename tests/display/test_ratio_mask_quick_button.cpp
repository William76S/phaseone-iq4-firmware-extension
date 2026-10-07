#define IQ4_RATIO_QUICK_HOST 1
#include "../../src/display/ratio_mask_quick_button.cpp"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <stdexcept>

static unsigned mode=2,remembered=2,toggles,opens,closes,invalidates,ctor_fail,alloc_fail;
static bool allowed=true;
static std::vector<void*> allocations;
static std::vector<Rect> fills;
static std::vector<uint32_t> resources;
static unsigned background_calls;
extern "C" unsigned iq4_f1_mode_get_01(void) {return mode;}
extern "C" int iq4_f1_toggle_on_ui_01(void) {++toggles;if(mode) {remembered=mode;mode=0;}else mode=remembered;return 1;}
extern "C" void *iq4_f1_quick_menu_root_on_ui_01(void) {alignas(8) static char root[0x118];return root;}
extern "C" bool quick_test_pins(void) {return allowed;}
extern "C" uintptr_t quick_test_word(uintptr_t p) {assert(p>=0xb84c28&&p<0xb84c28+53*8);return p==0xb84c28?0:p==0xb84c30?0xb84ea0:0x500000+8*(p-0xb84c28);}
extern "C" void *quick_test_new(size_t n) {if(alloc_fail&&!--alloc_fail)throw std::bad_alloc();void *p=calloc(1,n);assert(p);allocations.push_back(p);return p;}
extern "C" void quick_test_delete(void *p) {for(auto i=allocations.begin();i!=allocations.end();++i)if(*i==p){allocations.erase(i);free(p);return;}assert(!"free unknown/interior object");}
static void native_link(void *parent,void *child) {
    assert(!get<uintptr_t>(child,8));
    uintptr_t prior=get<uintptr_t>(parent,0x10);
    if(!prior)put<uintptr_t>(parent,0x10,(uintptr_t)child);
    else {while(get<uintptr_t>((void*)prior,0x20))prior=get<uintptr_t>((void*)prior,0x20);put<uintptr_t>((void*)prior,0x20,(uintptr_t)child);put<uintptr_t>(child,0x18,prior);}
    put<uintptr_t>(child,8,(uintptr_t)parent);
}
extern "C" void quick_test_button_ctor(void *p,int32_t w,int32_t h,bool flag) {assert(w==150&&h==100&&!flag);put<uintptr_t>(p,0,0xb84c38);put<Rect>(p,0x28,{0xb73b98,0,0,w,h});put<uint8_t>(p,0x70,1);}
extern "C" void quick_test_button_dtor(void *p) {assert(!get<uintptr_t>(p,0x10)&&!get<uintptr_t>(p,8)&&!get<uintptr_t>(p,0x60));put<uintptr_t>(p,0,0xb84c38);}
extern "C" Rect quick_test_background(void *p,void *s,const Rect *d,const Rect *c) {assert(p&&s&&d&&c);++background_calls;return *d;}
extern "C" void quick_test_icon_ctor(void *p,int32_t w,int32_t h,void *r,uint32_t id,bool flag,const Color *fg,const Color *bg) {
    assert(w==30&&h==30&&r&&flag&&!bg->alpha&&!bg->r&&!bg->g&&!bg->b);
    if(ctor_fail&&!--ctor_fail)throw std::runtime_error("ctor failure");
    if(id==1209)assert(fg->alpha==255&&fg->r==0&&fg->g==174&&fg->b==239);
    else assert(id==38&&fg->alpha==255&&fg->r==128&&fg->g==128&&fg->b==128);
    put<uintptr_t>(p,0,0xb848f0);put<uint32_t>(p,0x88,id);put<uint8_t>(p,0x6f,1);resources.push_back(id);
}
extern "C" void quick_test_attach(void *p,void *c,int32_t x,int32_t y,uint32_t flags,int32_t inset) {
    assert(x==10&&y==10);
    assert((get<uint32_t>(c,0x88)==1209&&flags==0&&inset==0)||(get<uint32_t>(c,0x88)==38&&flags==6&&inset==10));native_link(p,c);
}
extern "C" void quick_test_stack_append(void *p,void *c) {native_link(p,c);}
extern "C" void quick_test_detach(void *p) {
    uintptr_t parent=get<uintptr_t>(p,8),prev=get<uintptr_t>(p,0x18),next=get<uintptr_t>(p,0x20);
    if(parent&&get<uintptr_t>((void*)parent,0x10)==(uintptr_t)p)put<uintptr_t>((void*)parent,0x10,next);
    if(prev)put<uintptr_t>((void*)prev,0x20,next);
    if(next)put<uintptr_t>((void*)next,0x18,prev);
    put<uintptr_t>(p,8,0);put<uintptr_t>(p,0x18,0);put<uintptr_t>(p,0x20,0);
}
extern "C" void quick_test_native_delete(void *p) {assert(!get<uintptr_t>(p,8));quick_test_delete(p);}
extern "C" void quick_test_bind(void *p,void *o,uint64_t f,unsigned tag) {assert(f==0x100000100);put<uintptr_t>(p,0x60,(uintptr_t)o);put<unsigned>(p,0x68,tag);put<uint64_t>(p,0x72,f|1);}
extern "C" void quick_test_visible(void *p,bool v) {assert(get<uint32_t>(p,0x88)==1209);put<uint8_t>(p,0x6f,v);}
extern "C" void quick_test_invalidate(void*) {++invalidates;}
extern "C" void quick_test_fill(void *s,const Rect *r,const Rect *clip,const Color *v) {assert(s&&r->vtable==0xb73b98&&clip&&r->width>0&&r->height>0&&v->alpha==255&&v->r==v->g&&v->g==v->b);fills.push_back(*r);}
extern "C" void quick_test_popup_ctor(void *p,void *m,void *root,uint32_t title,bool flag) {assert(!root&&title==750&&flag);put<uintptr_t>(p,0,0xb931b0);put<uintptr_t>(p,0xb0,(uintptr_t)m);}
extern "C" void quick_test_popup_set(void *p,void *root) {put<uintptr_t>(p,0x128+0x18,(uintptr_t)root);}
extern "C" void quick_test_popup_show(void *p) {
    uintptr_t h=get<uintptr_t>(p,0xb0)+0x78,node=(uintptr_t)p+0x88,prev=get<uintptr_t>((void*)h,16);
    assert(get<uintptr_t>(p,0x128+0x18));put<uintptr_t>((void*)node,8,h);put<uintptr_t>((void*)node,16,prev);put<uintptr_t>((void*)node,24,(uintptr_t)p);
    put<uintptr_t>((void*)prev,8,node);put<uintptr_t>((void*)h,16,node);++opens;
}
extern "C" void quick_test_popup_close(void *p) {
    uintptr_t node=(uintptr_t)p+0x88,next=get<uintptr_t>((void*)node,8),prev=get<uintptr_t>((void*)node,16);
    put<uintptr_t>((void*)prev,8,next);put<uintptr_t>((void*)next,16,prev);put<uintptr_t>((void*)node,8,0);put<uintptr_t>((void*)node,16,0);++closes;
}
extern "C" void quick_test_popup_dtor(void *p) {assert(!get<uintptr_t>(p,0x128+0x18)&&!get<uintptr_t>(p,0x90));}
struct Fixture {
    alignas(8) unsigned char lv[0x1310]={},stack[0x230]={},stock[0xc8]={},manager[0x810]={},resource[0x80]={};
    Fixture() {put<uintptr_t>(lv,0,0xb9a9d8);put<uintptr_t>(lv,0xb0,(uintptr_t)manager);put<uintptr_t>(stack,0,0xb8b3f8);put<uintptr_t>(stock,0,0xb8c7b0);put<uintptr_t>(stock,0xa0,(uintptr_t)resource);put<uintptr_t>(manager,0,0xb8f358);uintptr_t h=(uintptr_t)manager+0x78;put<uintptr_t>((void*)h,8,h);put<uintptr_t>((void*)h,16,h);native_link(stack,stock);}
    void add() {iq4_ratio_quick_append_on_ui_01(stack,stock,lv);}
    void clean() {iq4_ratio_quick_cleanup_on_ui_01(lv);assert(!first&&allocations.empty()&&get<uintptr_t>(stack,0x10)==(uintptr_t)stock&&!get<uintptr_t>(stock,0x20));}
};
static void event(Quick *q,uint32_t kind,void *session=nullptr,unsigned tag=own_tag,void *sender=nullptr) {
    struct {uint32_t kind,reserved;void *session;uint64_t coordinates;} e={kind,0,session,0};
    notification(&q->observer,sender?sender:q->button,&e,tag);
}
int main() {
    unsigned cases=0;
    {Fixture f;allowed=false;f.add();assert(!first&&allocations.empty());allowed=true;put<uintptr_t>(f.stock,0,0);f.add();assert(!first);put<uintptr_t>(f.stock,0,0xb8c7b0);f.add();Quick*q=first;assert(q&&allocations.size()==3&&resources==std::vector<uint32_t>({1209,38}));assert(get<uint64_t>(q->button,0x72)==0x100000101&&get<uint8_t>(q->check,0x6f)==1&&get<uint8_t>(q->corner,0x6f)==1);f.add();assert(first==q&&allocations.size()==3);f.clean();f.clean();cases+=6;}
    {Fixture f;f.add();Quick*q=first;unsigned before=toggles;event(q,8);event(q,1,nullptr,own_tag+1);event(q,1,nullptr,own_tag,f.stock);assert(toggles==before);event(q,1);assert(mode==0&&!get<uint8_t>(q->check,0x6f)&&get<uint8_t>(q->corner,0x6f));event(q,1);assert(mode==2&&get<uint8_t>(q->check,0x6f));cases+=5;
     alignas(8) unsigned char session[0x100]={};put<uint32_t>(session,0xc4,1000);unsigned op=opens,before_hold=toggles;event(q,32,session);assert(opens==op+1&&popup_in_stack(q)&&toggles==before_hold);event(q,32,session);assert(opens==op+1);popup_close(q->popup);event(q,32,session);assert(opens==op+1);put<uint32_t>(session,0xc4,2000);event(q,32,session);assert(opens==op+2);f.clean();assert(closes>=2);cases+=5;f.add();assert(first&&first->popup==nullptr&&mode==2);f.clean();++cases;}
    {Fixture f;f.add();Rect d={0xb73b98,170,140,150,100},clip={0xb73b98,170,140,150,100};fills.clear();unsigned b=background_calls;Rect out=draw(first->button,(void*)0x40000,&d,&clip);assert(!memcmp(&out,&d,24)&&fills.size()==6&&background_calls==b+1);for(auto r:fills)assert(r.x>=d.x+40&&r.y>=d.y&&r.x+r.width<=d.x+110&&r.y+r.height<=d.y+d.height);mode=0;draw(first->button,(void*)0x40000,&d,&clip);assert(!get<uint8_t>(first->check,0x6f)&&get<uint8_t>(first->corner,0x6f));f.clean();cases+=3;}
    for(unsigned fail=1;fail<=3;++fail){Fixture f;alloc_fail=fail;try{f.add();assert(false);}catch(const std::bad_alloc&){}assert(!first&&allocations.empty()&&!get<uintptr_t>(f.stock,0x20));++cases;}
    for(unsigned fail=1;fail<=2;++fail){Fixture f;ctor_fail=fail;try{f.add();assert(false);}catch(const std::runtime_error&){}assert(!first&&allocations.empty()&&!get<uintptr_t>(f.stock,0x20));++cases;}
    printf("PASS %u cases: native value flags, tap/toggle, held latch, borrowed menu, original glyph resources, draw clip/sret and own cleanup; host adapters only\n",cases);
}
