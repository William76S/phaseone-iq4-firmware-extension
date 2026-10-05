#include "payload.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned mode_now,fills,groups;
static unsigned opacity_now=65u;
static unsigned reported_code,reported_calls,reported_fills,reported_valid;
void iq4_f1_report_16(unsigned code,const F1Facts16 *f,unsigned filled) {
    reported_code=code;
    if(code==10) ++reported_calls;
    reported_fills+=filled; reported_valid=f!=NULL;
}
static F1Rect16 actual_bands[4];
static uintptr_t corrupt_table_word;
uintptr_t iq4_f1_fixture_table_word_16(uintptr_t a){
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
unsigned iq4_f1_opacity_get_01(void){return opacity_now;}
void iq4_f1_fixture_fill_16(void *s,const F1Rect16 *b,const F1Rect16 *clip,const F1Color16 *c){
    assert(s&&b->w>0&&b->h>0&&fills<4&&b->vt==0xb73b98);
    assert(b->x>=clip->x&&b->y>=clip->y&&b->x+b->w<=clip->x+clip->w&&b->y+b->h<=clip->y+clip->h);
    assert(c->alpha==(opacity_now*255u+50u)/100u&&c->c1==0&&c->c2==0&&c->c3==0);actual_bands[fills++]=*b;
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
static F1Rect16 r(int x,int y,int w,int h){F1Rect16 a={0xb73b98,x,y,w,h};return a;}
static F1Facts16 normal(void){
    F1Facts16 f={0};f.destination=f.clip=f.surface_bounds=r(0,0,800,480);f.projected=r(80,0,640,480);
    f.roi=r(0,0,640,480);f.source_w=f.locked_w=f.engine_w=f.requested_w=640;
    f.source_h=f.locked_h=f.engine_h=f.requested_h=480;f.stride=1920;f.format=0;
    f.surface_pitch=800;f.surface_height=480;f.scale_bits=f.normal_scale_bits=0x3f800000;
    f.surface_vt=0xb7cf90;f.screen_vt=0xb7cfc0;f.draw_vt=0xb7b7d8;
    f.provider_matches_surface=f.native_tables_valid=1;
    f.source_pixels=0x10000000;f.surface_pixels=0x20000000;return f;
}
static void partitions(F1Plan16 *p,F1Rect16 v,int kw,int kh){
    int64_t area=0;unsigned i,j;assert(p->count<=4);
    for(i=0;i<p->count;++i){F1Rect16 a=p->bands[i];assert(a.w>0&&a.h>0);
        assert(a.x>=v.x&&a.y>=v.y&&a.x+a.w<=v.x+v.w&&a.y+a.h<=v.y+v.h);
        area+=(int64_t)a.w*a.h;
        for(j=0;j<i;++j){F1Rect16 b=p->bands[j];
            assert(a.x+a.w<=b.x||b.x+b.w<=a.x||a.y+a.h<=b.y||b.y+b.h<=a.y);}}
    assert(area==(int64_t)v.w*v.h-(int64_t)kw*kh);
}
static void store32(unsigned char *p,size_t o,uint32_t x){memcpy(p+o,&x,4);}
static void storeptr(unsigned char *p,size_t o,uintptr_t x){memcpy(p+o,&x,sizeof x);}
static void storerect(unsigned char *p,size_t o,F1Rect16 x){memcpy(p+o,&x,sizeof x);}
static void core_tests(void){F1Facts16 f=normal();F1Plan16 p;unsigned m;
    assert(iq4_f1_plan_16(&f,0,&p)==F1_OFF16&&p.count==0);++groups;
    for(m=1;m<=7;++m){int kw=640,kh=480;unsigned n=m==1?65:m==2?16:m==3?3:m==4?1:m==5?4:m==6?6:21;
        unsigned d=m==1?24:m==2?9:m==3?2:m==4?1:m==5?5:m==6?7:9;
        if((int64_t)640*d>(int64_t)480*n)kw=480*(int)n/(int)d;else kh=640*(int)d/(int)n;
        assert(iq4_f1_plan_16(&f,m,&p)==F1_DRAW16);partitions(&p,f.projected,kw,kh);}
    ++groups;
    for(m=1;m<=7;++m) {
        F1Plan16 baseline;F1Facts16 scaled=normal();
        assert(iq4_f1_plan_16(&scaled,m,&baseline)==F1_DRAW16);
        scaled.engine_w=1280;scaled.engine_h=960;scaled.roi=r(0,0,1280,960);
        scaled.scale_bits=scaled.normal_scale_bits=0x40000000;
        assert(iq4_f1_plan_16(&scaled,m,&p)==F1_DRAW16);
        assert(p.count==baseline.count&&!memcmp(p.bands,baseline.bands,sizeof p.bands));
        scaled.roi=r(0,0,640,480);assert(iq4_f1_plan_16(&scaled,m,&p)==F1_SOURCE16);
        scaled.roi=r(1,0,1280,960);assert(iq4_f1_plan_16(&scaled,m,&p)==F1_SOURCE16);
        scaled.engine_h=1024;scaled.roi=r(0,0,1280,1024);
        /* Full config plus the explicit native requested pair is the contract. */
        assert(iq4_f1_plan_16(&scaled,m,&p)==F1_DRAW16);
        scaled.requested_h=512;assert(iq4_f1_plan_16(&scaled,m,&p)==F1_SOURCE16);
    }
    {int32_t invalid[3]={0,-1,65536};unsigned j;
     for(j=0;j<3;++j){f=normal();f.engine_w=invalid[j];assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);}}
    ++groups;
    /* Actual user-reported full config/ROI and RGB: old exact ratio differs640.
     * Scale/destination here are owned fixture values until user reports them. */
    for(m=1;m<=7;++m) {
        F1Plan16 baseline;F1Facts16 actual=normal();
        assert(iq4_f1_plan_16(&actual,m,&baseline)==F1_DRAW16);
        actual.engine_w=14204;actual.engine_h=10652;actual.roi=r(0,0,14204,10652);
        assert((int64_t)actual.engine_w*480-(int64_t)actual.engine_h*640==640);
        assert(iq4_f1_plan_16(&actual,m,&p)==F1_DRAW16);
        assert(p.count==baseline.count&&!memcmp(p.bands,baseline.bands,sizeof p.bands));
        actual.requested_w=639;assert(iq4_f1_plan_16(&actual,m,&p)==F1_SOURCE16);
        actual.requested_w=640;actual.requested_h=479;assert(iq4_f1_plan_16(&actual,m,&p)==F1_SOURCE16);
        actual.requested_h=480;actual.roi.h=10651;assert(iq4_f1_plan_16(&actual,m,&p)==F1_SOURCE16);
    }
    {int32_t bad[4]={0,-1,65536,641};unsigned j;
     for(j=0;j<4;++j){f=normal();f.requested_w=bad[j];assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);}}
    ++groups;
    f=normal();f.scale_bits=0x40000000;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);
    f=normal();f.normal_scale_bits=f.scale_bits=0x7fc00000;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);
    f=normal();f.animation_active=1;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);
    f=normal();f.countdown=1;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);++groups;
    f=normal();f.roi.w=320;assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);
    f=normal();f.engine_w=1280;assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);
    f=normal();f.format=2;assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);
    f=normal();f.stride=2048;assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);++groups;
    f=normal();f.source_pixels=f.surface_pixels;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.surface_pitch=2560;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.draw_vt=1;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);++groups;
    f=normal();f.projected.w=639;assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16);
    f=normal();f.clip.w=639;assert(iq4_f1_plan_16(&f,1,&p)==F1_DRAW16);
    {unsigned j;for(j=0;j<p.count;++j)assert(p.bands[j].x+p.bands[j].w<=639);}
    f=normal();f.clip=r(100,0,700,480);assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16);
    f=normal();f.destination=r(0,0,636,476);f.projected=r(1,0,634,476);
    f.clip=f.projected;assert(iq4_f1_plan_16(&f,1,&p)==F1_DRAW16);
    f.clip=r(0,0,640,480);assert(iq4_f1_plan_16(&f,1,&p)==F1_DRAW16);++groups;
    for(m=90;m<=270;m+=90){f=normal();f.rotation=m;
        assert(iq4_f1_plan_16(&f,1,&p)==F1_ROTATION16&&p.count==0);}
    f=normal();f.rotation=45;assert(iq4_f1_plan_16(&f,1,&p)==F1_ROTATION16);
    assert(iq4_f1_plan_16(&f,9,&p)==F1_BAD_MODE16);++groups;
    f=normal();f.destination=f.projected=f.clip=r(0,0,1,1);
    f.source_w=f.source_h=f.locked_w=f.locked_h=f.engine_w=f.engine_h=f.requested_w=f.requested_h=1;
    f.roi=r(0,0,1,1);f.stride=3;assert(iq4_f1_plan_16(&f,4,&p)==F1_DRAW16&&p.count==0);
    assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16&&p.count==0);++groups;
    f=normal();f.surface_vt=0xb7b780;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16&&p.count==0);
    f=normal();f.surface_vt=0xb7c990;f.screen_vt=0xb7c9c0;
    assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16&&p.count==0);
    f=normal();f.surface_vt=0xb7cf98;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.screen_vt=0xb7c9c0;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);++groups;
    f=normal();f.surface_pitch=640;f.surface_bounds=r(0,0,640,480);
    assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.surface_height=481;f.surface_bounds.h=481;
    assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.provider_matches_surface=0;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);
    f=normal();f.native_tables_valid=0;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);++groups;

}
static void actual_capture_tests(void){
    _Alignas(16) unsigned char stack[0x170]={0};_Alignas(8) unsigned char lv[0x1310]={0};
    _Alignas(8) unsigned char surface[0x188]={0},draw[8]={0},engine[0x60]={0},manager[0x110]={0};
    unsigned char before_stack[sizeof stack],before_lv[sizeof lv];
    void *src=malloc(640*480*3),*dst=malloc(800*480*4);F1Call16 c={0};F1Rect16 original;
    assert(src&&dst);memset(src,20,640*480*3);memset(dst,255,800*480*4);
    storeptr(lv,0,0xb9a9d8);storeptr(lv,0xb0,(uintptr_t)manager);
    storeptr(manager,0,0xb8f358);storeptr(manager,0x108,(uintptr_t)surface+0x58);storeptr(lv,0x188,(uintptr_t)src);
    store32(lv,0x190,0x3f800000);store32(lv,0x194,0x3f800000);
    storeptr(surface,0,0xb7cf90);storeptr(surface,0x58,0xb7cfc0);storeptr(surface,8,(uintptr_t)draw);storeptr(draw,0,0xb7b7d8);
    store32(surface,0x14,800);store32(surface,0x18,480);storerect(surface,0x20,r(0,0,800,480));
    storeptr(surface,0x38,(uintptr_t)dst);storeptr(stack,0x30,(uintptr_t)surface);
    storeptr(stack,0x38,(uintptr_t)lv);storeptr(stack,0x168,(uintptr_t)engine);
    store32(engine,4,640);store32(engine,8,480);store32(engine,0x58,640);store32(engine,0x5c,480);storerect(stack,0xa0,r(0,0,640,480));
    store32(stack,0xb8,640);store32(stack,0xbc,480);store32(stack,0xc4,640);store32(stack,0xc8,480);
    store32(stack,0xcc,1920);storeptr(stack,0xd0,(uintptr_t)src);
    storerect(stack,0x110,r(0,0,800,480));storerect(stack,0x128,r(0,0,800,480));
    storerect(stack,0xf8,r(80,0,640,480));original=*(F1Rect16*)(stack+0xf8);
    c.caller_sp=c.caller_fp=(uintptr_t)stack;c.return_pc=0x51ddd0;
    c.args[0]=(uintptr_t)surface;c.args[1]=(uintptr_t)stack+0x110;c.args[4]=(uintptr_t)stack+0xc0;
    c.args[6]=(uintptr_t)stack+0x128;c.args[8]=(uintptr_t)stack+0xf8;
    memcpy(before_stack,stack,sizeof stack);memcpy(before_lv,lv,sizeof lv);
    mode_now=0;fills=0;iq4_f1_after_stock_draw_16(&c);assert(fills==0);
    assert(!memcmp(&original,stack+0xf8,sizeof original));++groups;
    mode_now=1;iq4_f1_after_stock_draw_16(&c);assert(fills==2);
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
      iq4_f1_after_stock_draw_16(&c);assert(fills==0);}
     for(j=0;j<6;++j){corrupt_table_word=0xb7b7c8+j*8;fills=0;
      iq4_f1_after_stock_draw_16(&c);assert(fills==0);}
     corrupt_table_word=0;
     storeptr(surface,0x58,0xb7c9c0);iq4_f1_after_stock_draw_16(&c);assert(fills==0);
     storeptr(surface,0x58,0xb7cfc0);
     storeptr(manager,0x108,(uintptr_t)surface);iq4_f1_after_stock_draw_16(&c);assert(fills==0);
     storeptr(manager,0x108,(uintptr_t)surface+0x58);
    }++groups;
    {/* Unknown/base object: only its +0 may be safely read; ASan proves that
       * rejection occurs before accessing the LCD +58 subobject. */
     _Alignas(8) unsigned char base[8]={0};storeptr(base,0,0xb7b780);
     storeptr(stack,0x30,(uintptr_t)base);c.args[0]=(uintptr_t)base;
     iq4_f1_after_stock_draw_16(&c);assert(fills==0);
     storeptr(base,0,0xb7c990);iq4_f1_after_stock_draw_16(&c);assert(fills==0);
     storeptr(stack,0x30,(uintptr_t)surface);c.args[0]=(uintptr_t)surface;
    }++groups;
    fills=0;c.return_pc=0x51ddcc;iq4_f1_after_stock_draw_16(&c);assert(fills==0);c.return_pc=0x51ddd0;
    c.args[8]+=8;iq4_f1_after_stock_draw_16(&c);assert(fills==0);c.args[8]-=8;
    c.caller_fp+=16;iq4_f1_after_stock_draw_16(&c);assert(fills==0);c.caller_fp-=16;++groups;
    store32(lv,0x1b8,1);fills=0;iq4_f1_after_stock_draw_16(&c);assert(fills==0);
    /* A real stock skipped BL never calls this function; no retained last-frame
     * paint or child callback exists. This defensive countdown rejects misuse. */
    store32(lv,0x1b8,0);mode_now=4;iq4_f1_after_stock_draw_16(&c);assert(fills==2);
    fills=0;store32(engine,0x58,639);iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==34&&reported_valid);store32(engine,0x58,640);
    fills=0;store32(engine,4,1280);iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==34&&reported_valid);store32(engine,4,640);
    store32(lv,0x1b0,180);c.args[5]=180;iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==38&&reported_valid);store32(lv,0x1b0,0);c.args[5]=0;
    store32(lv,0x190,0x40000000);iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==35&&reported_valid);store32(lv,0x190,0x3f800000);
    storerect(stack,0x128,r(100,0,700,480));iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==37&&reported_valid);storerect(stack,0x128,r(0,0,800,480));
    c.caller_fp+=16;iq4_f1_after_stock_draw_16(&c);
    assert(fills==0&&reported_code==11&&!reported_valid);c.caller_fp-=16;
    fills=0;mode_now=0;iq4_f1_after_stock_draw_16(&c);assert(fills==0);++groups;
    assert(reported_code==0&&!reported_valid&&reported_calls>0);
    /* Endpoints, all UI steps, monotonic levels and switching after a stock
     * redraw: use the actual wrapper helper on isolated owned source/target. */
    mode_now=1;
    {unsigned op,previous=256;int x,y,k;size_t j;
     const int kh=640*24/65,ky=(480-kh)/2;
     for(op=0;op<=100;op+=5) {
        const unsigned expected=(100u==op?0u:255u-(op*255u+50u)/100u);
        opacity_now=op;fills=0;memset(dst,255,800*480*4);
        iq4_f1_after_stock_draw_16(&c);
        assert(fills==(op?2u:0u)&&reported_code==(op?2u:3u)&&reported_valid);
        assert(expected<=previous);previous=expected;
        for(y=0;y<480;++y)for(x=0;x<800;++x){
            const int masked=x>=80&&x<720&&(y<ky||y>=ky+kh);
            const unsigned char *q=(unsigned char*)dst+4*((size_t)y*800+(size_t)x);
            assert(q[0]==255);for(k=1;k<4;++k)assert(q[k]==(masked?expected:255u));
        }
        for(j=0;j<640*480*3;++j)assert(((unsigned char*)src)[j]==20);
     }
     opacity_now=65;fills=0;memset(dst,255,800*480*4);iq4_f1_after_stock_draw_16(&c);
     assert(fills==2&&((unsigned char*)dst)[4*(80+800*0)+1]==89);
     opacity_now=101;fills=0;iq4_f1_after_stock_draw_16(&c);assert(fills==0&&reported_code==11);
     opacity_now=65;
    }++groups;
    free(src);free(dst);
}
static void user_geometry_tests(void) {
    F1Facts16 f=normal();F1Plan16 p;unsigned m,j;size_t n;int x,y,k;
    _Alignas(8) unsigned char surface[0x188]={0};
    unsigned char *canvas=malloc(800*480*4);assert(canvas);
    f.engine_w=14204;f.engine_h=10652;f.roi=r(0,0,14204,10652);
    f.scale_bits=f.normal_scale_bits=0x41b00000;
    f.destination=r(77,0,645,484);f.projected=r(77,0,645,483);
    f.surface_pixels=(uintptr_t)canvas;storeptr(surface,0x38,(uintptr_t)canvas);store32(surface,0x14,800);
    assert(iq4_f1_plan_16(&f,0,&p)==F1_OFF16&&p.count==0);
    for(m=1;m<=7;++m) {
        const int kh[8]={0,238,362,430,483,483,483,276},ky[8]={0,122,60,26,0,0,0,103};
        const int left=m==4?158:m==5?206:m==6?192:77;
        const int right=m==4?641:m==5?592:m==6?606:722;
        F1Color16 black={166,0,0,0};
        memset(canvas,255,800*480*4);memset(canvas+800*479*4,31,800*4);
        assert(iq4_f1_plan_16(&f,m,&p)==F1_DRAW16&&p.count==2);
        fills=0;
        for(j=0;j<p.count;++j) {
            assert(p.bands[j].x>=77&&p.bands[j].x+p.bands[j].w<=722);
            assert(p.bands[j].y>=0&&p.bands[j].y+p.bands[j].h<=479);
            iq4_f1_fixture_fill_16(surface,&p.bands[j],&f.clip,&black);
        }
        for(y=0;y<479;++y)for(x=0;x<800;++x) {
            int masked=x>=77&&x<722&&(x<left||x>=right||y<ky[m]||y>=ky[m]+kh[m]);
            unsigned char *q=canvas+4*((size_t)y*800+(size_t)x);
            assert(q[0]==255);for(k=1;k<4;++k)assert(q[k]==(masked?89:255));
        }
        for(n=800*479*4;n<800*480*4;++n)assert(canvas[n]==31);
        /* Simulated original forward blit covers only its proven479 rows.
         * All changed mask pixels must be inside that write footprint. */
        for(y=0;y<479;++y)memset(canvas+4*((size_t)y*800+77),255,645*4);
        for(n=0;n<800*479*4;++n)assert(canvas[n]==255);
        assert(iq4_f1_plan_16(&f,0,&p)==F1_OFF16&&p.count==0);
    }
    f.clip=r(0,1,800,479);assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16);
    f.clip=r(0,0,800,481);assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16);
    free(canvas);++groups;
}
int main(void){core_tests();actual_capture_tests();user_geometry_tests();
    printf("{\"owned_host_groups\":%u,\"passed\":true,\"target_executed\":false}\n",groups);return 0;}
