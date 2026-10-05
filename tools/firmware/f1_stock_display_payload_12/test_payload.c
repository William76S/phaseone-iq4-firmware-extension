#include "payload.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned mode_now,fills,groups;
static F1Rect12 actual_bands[4];
unsigned iq4_f1_mode_get_01(void){return mode_now;}
void iq4_f1_fixture_fill_12(void *s,const F1Rect12 *b,const F1Rect12 *clip,const F1Color12 *c){
    assert(s&&b->w>0&&b->h>0&&fills<4&&b->vt==0xb73b98);
    assert(b->x>=clip->x&&b->y>=clip->y&&b->x+b->w<=clip->x+clip->w&&b->y+b->h<=clip->y+clip->h);
    assert(c->alpha==166&&c->c1==0&&c->c2==0&&c->c3==0);actual_bands[fills++]=*b;
}
static F1Rect12 r(int x,int y,int w,int h){F1Rect12 a={0xb73b98,x,y,w,h};return a;}
static F1Facts12 normal(void){
    F1Facts12 f={0};f.destination=f.projected=f.clip=f.surface_bounds=r(0,0,640,480);
    f.roi=r(0,0,640,480);f.source_w=f.locked_w=f.engine_w=640;
    f.source_h=f.locked_h=f.engine_h=480;f.stride=1920;f.format=0;
    f.surface_pitch=640;f.surface_height=480;f.scale_bits=f.normal_scale_bits=0x3f800000;
    f.surface_vt=0xb7b780;f.draw_vt=0xb7b7d8;
    f.source_pixels=0x10000000;f.surface_pixels=0x20000000;return f;
}
static void partitions(F1Plan12 *p,F1Rect12 v,int kw,int kh){
    int64_t area=0;unsigned i,j;assert(p->count<=4);
    for(i=0;i<p->count;++i){F1Rect12 a=p->bands[i];assert(a.w>0&&a.h>0);
        assert(a.x>=v.x&&a.y>=v.y&&a.x+a.w<=v.x+v.w&&a.y+a.h<=v.y+v.h);
        area+=(int64_t)a.w*a.h;
        for(j=0;j<i;++j){F1Rect12 b=p->bands[j];
            assert(a.x+a.w<=b.x||b.x+b.w<=a.x||a.y+a.h<=b.y||b.y+b.h<=a.y);}}
    assert(area==(int64_t)v.w*v.h-(int64_t)kw*kh);
}
static void store32(unsigned char *p,size_t o,uint32_t x){memcpy(p+o,&x,4);}
static void storeptr(unsigned char *p,size_t o,uintptr_t x){memcpy(p+o,&x,sizeof x);}
static void storerect(unsigned char *p,size_t o,F1Rect12 x){memcpy(p+o,&x,sizeof x);}
static void core_tests(void){F1Facts12 f=normal();F1Plan12 p;unsigned m;
    assert(iq4_f1_plan_12(&f,0,&p)==F1_OFF12&&p.count==0);++groups;
    for(m=1;m<=4;++m){int kw=640,kh=480;unsigned n=m==1?65:m==2?16:m==3?3:1;
        unsigned d=m==1?24:m==2?9:m==3?2:1;
        if((int64_t)640*d>(int64_t)480*n)kw=480*(int)n/(int)d;else kh=640*(int)d/(int)n;
        assert(iq4_f1_plan_12(&f,m,&p)==F1_DRAW12);partitions(&p,f.projected,kw,kh);}
    ++groups;
    f=normal();f.scale_bits=0x40000000;assert(iq4_f1_plan_12(&f,1,&p)==F1_ZOOM12);
    f=normal();f.normal_scale_bits=f.scale_bits=0x7fc00000;assert(iq4_f1_plan_12(&f,1,&p)==F1_ZOOM12);
    f=normal();f.animation_active=1;assert(iq4_f1_plan_12(&f,1,&p)==F1_ZOOM12);
    f=normal();f.countdown=1;assert(iq4_f1_plan_12(&f,1,&p)==F1_ZOOM12);++groups;
    f=normal();f.roi.w=320;assert(iq4_f1_plan_12(&f,1,&p)==F1_SOURCE12);
    f=normal();f.engine_w=1280;assert(iq4_f1_plan_12(&f,1,&p)==F1_SOURCE12);
    f=normal();f.format=2;assert(iq4_f1_plan_12(&f,1,&p)==F1_SOURCE12);
    f=normal();f.stride=2048;assert(iq4_f1_plan_12(&f,1,&p)==F1_SOURCE12);++groups;
    f=normal();f.source_pixels=f.surface_pixels;assert(iq4_f1_plan_12(&f,1,&p)==F1_SURFACE12);
    f=normal();f.surface_pitch=2560;assert(iq4_f1_plan_12(&f,1,&p)==F1_SURFACE12);
    f=normal();f.draw_vt=1;assert(iq4_f1_plan_12(&f,1,&p)==F1_SURFACE12);++groups;
    f=normal();f.projected.w=639;assert(iq4_f1_plan_12(&f,1,&p)==F1_COVERAGE12);
    f=normal();f.clip.w=639;assert(iq4_f1_plan_12(&f,1,&p)==F1_COVERAGE12);
    f=normal();f.destination=r(0,0,636,476);f.projected=r(1,0,634,476);
    f.clip=f.projected;assert(iq4_f1_plan_12(&f,1,&p)==F1_COVERAGE12);
    f.clip=r(0,0,640,480);assert(iq4_f1_plan_12(&f,1,&p)==F1_DRAW12);++groups;
    for(m=90;m<=270;m+=90){f=normal();f.rotation=m;
        assert(iq4_f1_plan_12(&f,1,&p)==F1_ROTATION12&&p.count==0);}
    f=normal();f.rotation=45;assert(iq4_f1_plan_12(&f,1,&p)==F1_ROTATION12);
    assert(iq4_f1_plan_12(&f,9,&p)==F1_BAD_MODE12);++groups;
    f=normal();f.destination=f.projected=f.clip=f.surface_bounds=r(0,0,1,1);
    f.surface_pitch=f.surface_height=f.source_w=f.source_h=f.locked_w=f.locked_h=f.engine_w=f.engine_h=1;
    f.roi=r(0,0,1,1);f.stride=3;assert(iq4_f1_plan_12(&f,4,&p)==F1_DRAW12&&p.count==0);
    assert(iq4_f1_plan_12(&f,1,&p)==F1_COVERAGE12&&p.count==0);++groups;
}
static void actual_capture_tests(void){
    _Alignas(16) unsigned char stack[0x170]={0};_Alignas(8) unsigned char lv[0x1310]={0};
    _Alignas(8) unsigned char surface[0x40]={0},draw[8]={0},engine[16]={0};
    unsigned char before_stack[sizeof stack],before_lv[sizeof lv];
    void *src=calloc(640*480,3),*dst=calloc(640*480,4);F1Call12 c={0};F1Rect12 original;
    assert(src&&dst);storeptr(lv,0,0xb9a9d8);storeptr(lv,0x188,(uintptr_t)src);
    store32(lv,0x190,0x3f800000);store32(lv,0x194,0x3f800000);
    storeptr(surface,0,0xb7b780);storeptr(surface,8,(uintptr_t)draw);storeptr(draw,0,0xb7b7d8);
    store32(surface,0x14,640);store32(surface,0x18,480);storerect(surface,0x20,r(0,0,640,480));
    storeptr(surface,0x38,(uintptr_t)dst);storeptr(stack,0x30,(uintptr_t)surface);
    storeptr(stack,0x38,(uintptr_t)lv);storeptr(stack,0x168,(uintptr_t)engine);
    store32(engine,4,640);store32(engine,8,480);storerect(stack,0xa0,r(0,0,640,480));
    store32(stack,0xb8,640);store32(stack,0xbc,480);store32(stack,0xc4,640);store32(stack,0xc8,480);
    store32(stack,0xcc,1920);storeptr(stack,0xd0,(uintptr_t)src);
    storerect(stack,0x110,r(0,0,640,480));storerect(stack,0x128,r(0,0,640,480));
    storerect(stack,0xf8,r(0,0,640,480));original=*(F1Rect12*)(stack+0xf8);
    c.caller_sp=c.caller_fp=(uintptr_t)stack;c.return_pc=0x51ddd0;
    c.args[0]=(uintptr_t)surface;c.args[1]=(uintptr_t)stack+0x110;c.args[4]=(uintptr_t)stack+0xc0;
    c.args[6]=(uintptr_t)stack+0x128;c.args[8]=(uintptr_t)stack+0xf8;
    memcpy(before_stack,stack,sizeof stack);memcpy(before_lv,lv,sizeof lv);
    mode_now=0;fills=0;iq4_f1_after_stock_draw_12(&c);assert(fills==0);
    assert(!memcmp(&original,stack+0xf8,sizeof original));++groups;
    mode_now=1;iq4_f1_after_stock_draw_12(&c);assert(fills==2);
    assert(!memcmp(stack,before_stack,sizeof stack)&&!memcmp(lv,before_lv,sizeof lv));++groups;
    fills=0;c.return_pc=0x51ddcc;iq4_f1_after_stock_draw_12(&c);assert(fills==0);c.return_pc=0x51ddd0;
    c.args[8]+=8;iq4_f1_after_stock_draw_12(&c);assert(fills==0);c.args[8]-=8;
    c.caller_fp+=16;iq4_f1_after_stock_draw_12(&c);assert(fills==0);c.caller_fp-=16;++groups;
    store32(lv,0x1b8,1);fills=0;iq4_f1_after_stock_draw_12(&c);assert(fills==0);
    /* A real stock skipped BL never calls this function; no retained last-frame
     * paint or child callback exists. This defensive countdown rejects misuse. */
    store32(lv,0x1b8,0);mode_now=4;iq4_f1_after_stock_draw_12(&c);assert(fills==2);
    fills=0;mode_now=0;iq4_f1_after_stock_draw_12(&c);assert(fills==0);++groups;
    free(src);free(dst);
}
int main(void){core_tests();actual_capture_tests();
    printf("{\"owned_host_groups\":%u,\"passed\":true,\"target_executed\":false}\n",groups);return 0;}
