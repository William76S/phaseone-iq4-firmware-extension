#include "payload.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned mode_now,fills,groups;
static unsigned reported_code,reported_calls,reported_fills,reported_valid;
void iq4_f1_report_14(unsigned code,const F1Facts14 *f,unsigned filled) {
    reported_code=code;
    if(code==10) ++reported_calls;
    reported_fills+=filled; reported_valid=f!=NULL;
}
static F1Rect14 actual_bands[4];
static uintptr_t corrupt_table_word;
uintptr_t iq4_f1_fixture_table_word_14(uintptr_t a){
    static const uintptr_t lcd[12]={0,0xb7d030,0x485e54,0x485eb4,0x4865a0,0x486da4,
        UINTPTR_MAX-0x57,0xb7d030,0x485eac,0x485edc,0x486738,0x486db8};
    static const uintptr_t draw[6]={0,0xb7b7b8,0x47e798,0x47f378,0x47ee78,0x47e9d0};
    uintptr_t v;
    assert((a&7)==0);
    if(a>=0xb7cf80&&a<0xb7cfe0)v=lcd[(a-0xb7cf80)/8];
    else {assert(a>=0xb7b7c8&&a<0xb7b7f8);v=draw[(a-0xb7b7c8)/8];}
    return a==corrupt_table_word?v^1:v;
}
unsigned iq4_f1_mode_get_01(void){return mode_now;}
void iq4_f1_fixture_fill_14(void *s,const F1Rect14 *b,const F1Rect14 *clip,const F1Color14 *c){
    assert(s&&b->w>0&&b->h>0&&fills<4&&b->vt==0xb73b98);
    assert(b->x>=clip->x&&b->y>=clip->y&&b->x+b->w<=clip->x+clip->w&&b->y+b->h<=clip->y+clip->h);
    assert(c->alpha==166&&c->c1==0&&c->c2==0&&c->c3==0);actual_bands[fills++]=*b;
    /* Owned software canvas: reproduce the proven native black blend formula.
     * This checks pixel coverage/stride isolation, not native execution. */
    {uintptr_t pixels;int32_t pitch;int x,y,k;unsigned char *q;
     memcpy(&pixels,(unsigned char*)s+0x38,sizeof pixels);
     memcpy(&pitch,(unsigned char*)s+0x14,sizeof pitch);
     assert(pitch==800);
     for(y=b->y;y<b->y+b->h;++y)for(x=b->x;x<b->x+b->w;++x){
         q=(unsigned char*)pixels+4*((size_t)y*(size_t)pitch+(size_t)x);
         q[0]=(unsigned char)(q[0]+(255u-q[0])*c->alpha/255u);
         for(k=1;k<4;++k)q[k]=(unsigned char)((unsigned)q[k]*(255u-c->alpha)/255u);
     }}
}
static F1Rect14 r(int x,int y,int w,int h){F1Rect14 a={0xb73b98,x,y,w,h};return a;}
static F1Facts14 normal(void){
    F1Facts14 f={0};f.destination=f.clip=f.surface_bounds=r(0,0,800,480);f.projected=r(80,0,640,480);
    f.roi=r(0,0,640,480);f.source_w=f.locked_w=f.engine_w=640;
    f.source_h=f.locked_h=f.engine_h=480;f.stride=1920;f.format=0;
    f.surface_pitch=800;f.surface_height=480;f.scale_bits=f.normal_scale_bits=0x3f800000;
    f.surface_vt=0xb7cf90;f.screen_vt=0xb7cfc0;f.draw_vt=0xb7b7d8;
    f.provider_matches_surface=f.native_tables_valid=1;
    f.source_pixels=0x10000000;f.surface_pixels=0x20000000;return f;
}
static void partitions(F1Plan14 *p,F1Rect14 v,int kw,int kh){
    int64_t area=0;unsigned i,j;assert(p->count<=4);
    for(i=0;i<p->count;++i){F1Rect14 a=p->bands[i];assert(a.w>0&&a.h>0);
        assert(a.x>=v.x&&a.y>=v.y&&a.x+a.w<=v.x+v.w&&a.y+a.h<=v.y+v.h);
        area+=(int64_t)a.w*a.h;
        for(j=0;j<i;++j){F1Rect14 b=p->bands[j];
            assert(a.x+a.w<=b.x||b.x+b.w<=a.x||a.y+a.h<=b.y||b.y+b.h<=a.y);}}
    assert(area==(int64_t)v.w*v.h-(int64_t)kw*kh);
}
static void store32(unsigned char *p,size_t o,uint32_t x){memcpy(p+o,&x,4);}
static void storeptr(unsigned char *p,size_t o,uintptr_t x){memcpy(p+o,&x,sizeof x);}
static void storerect(unsigned char *p,size_t o,F1Rect14 x){memcpy(p+o,&x,sizeof x);}
static void core_tests(void){F1Facts14 f=normal();F1Plan14 p;unsigned m;
    assert(iq4_f1_plan_14(&f,0,&p)==F1_OFF14&&p.count==0);++groups;
    for(m=1;m<=4;++m){int kw=640,kh=480;unsigned n=m==1?65:m==2?16:m==3?3:1;
        unsigned d=m==1?24:m==2?9:m==3?2:1;
        if((int64_t)640*d>(int64_t)480*n)kw=480*(int)n/(int)d;else kh=640*(int)d/(int)n;
        assert(iq4_f1_plan_14(&f,m,&p)==F1_DRAW14);partitions(&p,f.projected,kw,kh);}
    ++groups;
    for(m=1;m<=4;++m) {
        F1Plan14 baseline;F1Facts14 scaled=normal();
        assert(iq4_f1_plan_14(&scaled,m,&baseline)==F1_DRAW14);
        scaled.engine_w=1280;scaled.engine_h=960;scaled.roi=r(0,0,1280,960);
        scaled.scale_bits=scaled.normal_scale_bits=0x40000000;
        assert(iq4_f1_plan_14(&scaled,m,&p)==F1_DRAW14);
        assert(p.count==baseline.count&&!memcmp(p.bands,baseline.bands,sizeof p.bands));
        scaled.roi=r(0,0,640,480);assert(iq4_f1_plan_14(&scaled,m,&p)==F1_SOURCE14);
        scaled.roi=r(1,0,1280,960);assert(iq4_f1_plan_14(&scaled,m,&p)==F1_SOURCE14);
        scaled.engine_h=1024;scaled.roi=r(0,0,1280,1024);
        assert(iq4_f1_plan_14(&scaled,m,&p)==F1_SOURCE14);
    }
    {int32_t invalid[3]={0,-1,65536};unsigned j;
     for(j=0;j<3;++j){f=normal();f.engine_w=invalid[j];assert(iq4_f1_plan_14(&f,1,&p)==F1_SOURCE14);}}
    ++groups;
    f=normal();f.scale_bits=0x40000000;assert(iq4_f1_plan_14(&f,1,&p)==F1_ZOOM14);
    f=normal();f.normal_scale_bits=f.scale_bits=0x7fc00000;assert(iq4_f1_plan_14(&f,1,&p)==F1_ZOOM14);
    f=normal();f.animation_active=1;assert(iq4_f1_plan_14(&f,1,&p)==F1_ZOOM14);
    f=normal();f.countdown=1;assert(iq4_f1_plan_14(&f,1,&p)==F1_ZOOM14);++groups;
    f=normal();f.roi.w=320;assert(iq4_f1_plan_14(&f,1,&p)==F1_SOURCE14);
    f=normal();f.engine_w=1280;assert(iq4_f1_plan_14(&f,1,&p)==F1_SOURCE14);
    f=normal();f.format=2;assert(iq4_f1_plan_14(&f,1,&p)==F1_SOURCE14);
    f=normal();f.stride=2048;assert(iq4_f1_plan_14(&f,1,&p)==F1_SOURCE14);++groups;
    f=normal();f.source_pixels=f.surface_pixels;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.surface_pitch=2560;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.draw_vt=1;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);++groups;
    f=normal();f.projected.w=639;assert(iq4_f1_plan_14(&f,1,&p)==F1_COVERAGE14);
    f=normal();f.clip.w=639;assert(iq4_f1_plan_14(&f,1,&p)==F1_COVERAGE14);
    f=normal();f.destination=r(0,0,636,476);f.projected=r(1,0,634,476);
    f.clip=f.projected;assert(iq4_f1_plan_14(&f,1,&p)==F1_COVERAGE14);
    f.clip=r(0,0,640,480);assert(iq4_f1_plan_14(&f,1,&p)==F1_DRAW14);++groups;
    for(m=90;m<=270;m+=90){f=normal();f.rotation=m;
        assert(iq4_f1_plan_14(&f,1,&p)==F1_ROTATION14&&p.count==0);}
    f=normal();f.rotation=45;assert(iq4_f1_plan_14(&f,1,&p)==F1_ROTATION14);
    assert(iq4_f1_plan_14(&f,9,&p)==F1_BAD_MODE14);++groups;
    f=normal();f.destination=f.projected=f.clip=r(0,0,1,1);
    f.source_w=f.source_h=f.locked_w=f.locked_h=f.engine_w=f.engine_h=1;
    f.roi=r(0,0,1,1);f.stride=3;assert(iq4_f1_plan_14(&f,4,&p)==F1_DRAW14&&p.count==0);
    assert(iq4_f1_plan_14(&f,1,&p)==F1_COVERAGE14&&p.count==0);++groups;
    f=normal();f.surface_vt=0xb7b780;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14&&p.count==0);
    f=normal();f.surface_vt=0xb7c990;f.screen_vt=0xb7c9c0;
    assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14&&p.count==0);
    f=normal();f.surface_vt=0xb7cf98;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.screen_vt=0xb7c9c0;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);++groups;
    f=normal();f.surface_pitch=640;f.surface_bounds=r(0,0,640,480);
    assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.surface_height=481;f.surface_bounds.h=481;
    assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.provider_matches_surface=0;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);
    f=normal();f.native_tables_valid=0;assert(iq4_f1_plan_14(&f,1,&p)==F1_SURFACE14);++groups;

}
static void actual_capture_tests(void){
    _Alignas(16) unsigned char stack[0x170]={0};_Alignas(8) unsigned char lv[0x1310]={0};
    _Alignas(8) unsigned char surface[0x188]={0},draw[8]={0},engine[16]={0},manager[0x110]={0};
    unsigned char before_stack[sizeof stack],before_lv[sizeof lv];
    void *src=malloc(640*480*3),*dst=malloc(800*480*4);F1Call14 c={0};F1Rect14 original;
    assert(src&&dst);memset(src,20,640*480*3);memset(dst,255,800*480*4);
    storeptr(lv,0,0xb9a9d8);storeptr(lv,0xb0,(uintptr_t)manager);
    storeptr(manager,0,0xb8f358);storeptr(manager,0x108,(uintptr_t)surface+0x58);storeptr(lv,0x188,(uintptr_t)src);
    store32(lv,0x190,0x3f800000);store32(lv,0x194,0x3f800000);
    storeptr(surface,0,0xb7cf90);storeptr(surface,0x58,0xb7cfc0);storeptr(surface,8,(uintptr_t)draw);storeptr(draw,0,0xb7b7d8);
    store32(surface,0x14,800);store32(surface,0x18,480);storerect(surface,0x20,r(0,0,800,480));
    storeptr(surface,0x38,(uintptr_t)dst);storeptr(stack,0x30,(uintptr_t)surface);
    storeptr(stack,0x38,(uintptr_t)lv);storeptr(stack,0x168,(uintptr_t)engine);
    store32(engine,4,640);store32(engine,8,480);storerect(stack,0xa0,r(0,0,640,480));
    store32(stack,0xb8,640);store32(stack,0xbc,480);store32(stack,0xc4,640);store32(stack,0xc8,480);
    store32(stack,0xcc,1920);storeptr(stack,0xd0,(uintptr_t)src);
    storerect(stack,0x110,r(0,0,800,480));storerect(stack,0x128,r(0,0,800,480));
    storerect(stack,0xf8,r(80,0,640,480));original=*(F1Rect14*)(stack+0xf8);
    c.caller_sp=c.caller_fp=(uintptr_t)stack;c.return_pc=0x51ddd0;
    c.args[0]=(uintptr_t)surface;c.args[1]=(uintptr_t)stack+0x110;c.args[4]=(uintptr_t)stack+0xc0;
    c.args[6]=(uintptr_t)stack+0x128;c.args[8]=(uintptr_t)stack+0xf8;
    memcpy(before_stack,stack,sizeof stack);memcpy(before_lv,lv,sizeof lv);
    mode_now=0;fills=0;iq4_f1_after_stock_draw_14(&c);assert(fills==0);
    assert(!memcmp(&original,stack+0xf8,sizeof original));++groups;
    mode_now=1;iq4_f1_after_stock_draw_14(&c);assert(fills==2);
    assert(reported_code==2&&reported_fills==2&&reported_calls==2&&reported_valid);
    assert(!memcmp(stack,before_stack,sizeof stack)&&!memcmp(lv,before_lv,sizeof lv));++groups;
    {int x,y,k;size_t j;const int kh=640*24/65,ky=(480-kh)/2;
     for(j=0;j<640*480*3;++j)assert(((unsigned char*)src)[j]==20);
     for(y=0;y<480;++y)for(x=0;x<800;++x){
       int masked=x>=80&&x<720&&(y<ky||y>=ky+kh);
       unsigned char *q=(unsigned char*)dst+4*((size_t)y*800+(size_t)x);
       assert(q[0]==255);for(k=1;k<4;++k)assert(q[k]==(masked?89:255));
     }}++groups;
    {unsigned j;for(j=0;j<12;++j){corrupt_table_word=0xb7cf80+j*8;fills=0;
      iq4_f1_after_stock_draw_14(&c);assert(fills==0);}
     for(j=0;j<6;++j){corrupt_table_word=0xb7b7c8+j*8;fills=0;
      iq4_f1_after_stock_draw_14(&c);assert(fills==0);}
     corrupt_table_word=0;
     storeptr(surface,0x58,0xb7c9c0);iq4_f1_after_stock_draw_14(&c);assert(fills==0);
     storeptr(surface,0x58,0xb7cfc0);
     storeptr(manager,0x108,(uintptr_t)surface);iq4_f1_after_stock_draw_14(&c);assert(fills==0);
     storeptr(manager,0x108,(uintptr_t)surface+0x58);
    }++groups;
    {/* Unknown/base object: only its +0 may be safely read; ASan proves that
       * rejection occurs before accessing the LCD +58 subobject. */
     _Alignas(8) unsigned char base[8]={0};storeptr(base,0,0xb7b780);
     storeptr(stack,0x30,(uintptr_t)base);c.args[0]=(uintptr_t)base;
     iq4_f1_after_stock_draw_14(&c);assert(fills==0);
     storeptr(base,0,0xb7c990);iq4_f1_after_stock_draw_14(&c);assert(fills==0);
     storeptr(stack,0x30,(uintptr_t)surface);c.args[0]=(uintptr_t)surface;
    }++groups;
    fills=0;c.return_pc=0x51ddcc;iq4_f1_after_stock_draw_14(&c);assert(fills==0);c.return_pc=0x51ddd0;
    c.args[8]+=8;iq4_f1_after_stock_draw_14(&c);assert(fills==0);c.args[8]-=8;
    c.caller_fp+=16;iq4_f1_after_stock_draw_14(&c);assert(fills==0);c.caller_fp-=16;++groups;
    store32(lv,0x1b8,1);fills=0;iq4_f1_after_stock_draw_14(&c);assert(fills==0);
    /* A real stock skipped BL never calls this function; no retained last-frame
     * paint or child callback exists. This defensive countdown rejects misuse. */
    store32(lv,0x1b8,0);mode_now=4;iq4_f1_after_stock_draw_14(&c);assert(fills==2);
    fills=0;store32(engine,4,1280);iq4_f1_after_stock_draw_14(&c);
    assert(fills==0&&reported_code==34&&reported_valid);store32(engine,4,640);
    store32(lv,0x1b0,180);c.args[5]=180;iq4_f1_after_stock_draw_14(&c);
    assert(fills==0&&reported_code==38&&reported_valid);store32(lv,0x1b0,0);c.args[5]=0;
    store32(lv,0x190,0x40000000);iq4_f1_after_stock_draw_14(&c);
    assert(fills==0&&reported_code==35&&reported_valid);store32(lv,0x190,0x3f800000);
    storerect(stack,0x128,r(0,0,600,480));iq4_f1_after_stock_draw_14(&c);
    assert(fills==0&&reported_code==37&&reported_valid);storerect(stack,0x128,r(0,0,800,480));
    c.caller_fp+=16;iq4_f1_after_stock_draw_14(&c);
    assert(fills==0&&reported_code==11&&!reported_valid);c.caller_fp-=16;
    fills=0;mode_now=0;iq4_f1_after_stock_draw_14(&c);assert(fills==0);++groups;
    assert(reported_code==0&&!reported_valid&&reported_calls>0);
    free(src);free(dst);
}
int main(void){core_tests();actual_capture_tests();
    printf("{\"owned_host_groups\":%u,\"passed\":true,\"target_executed\":false}\n",groups);return 0;}
