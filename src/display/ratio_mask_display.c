#include "ratio_mask_display.h"

_Static_assert(sizeof(F1Rect16)==24,"native Rectangle size");
_Static_assert(offsetof(F1Rect16,x)==8,"native Rectangle coordinates");
_Static_assert(sizeof(F1Image16)==24 && offsetof(F1Image16,pixels)==16,"native Image");
_Static_assert(sizeof(F1Color16)==4,"native Color");
_Static_assert(sizeof(F1Call16)==96 && offsetof(F1Call16,caller_sp)==0x48 &&
    offsetof(F1Call16,return_pc)==0x58,"assembly capture layout");

#define RECT_VT ((uintptr_t)0xb73b98)
#define LCD_SURFACE_VT ((uintptr_t)0xb7cf90)
#define LCD_SCREEN_VT ((uintptr_t)0xb7cfc0)
#define DRAW_VT ((uintptr_t)0xb7b7d8)
#define LV_VT ((uintptr_t)0xb9a9d8)
#define NATIVE_FILL ((uintptr_t)0x46f370)
extern unsigned iq4_f1_opacity_get_01(void);

static int shape(const F1Rect16 *r) {
    return r->vt==RECT_VT && r->w>0 && r->h>0 && r->w<=65535 && r->h<=65535 &&
        r->x>=-65535 && r->x<=65535 && r->y>=-65535 && r->y<=65535 &&
        (int64_t)r->x+r->w<=2147483647 &&
        (int64_t)r->y+r->h<=2147483647;
}
static int same(const F1Rect16 *a,const F1Rect16 *b) {
    return a->vt==b->vt && a->x==b->x && a->y==b->y && a->w==b->w && a->h==b->h;
}
static int contains(const F1Rect16 *a,const F1Rect16 *b) {
    return shape(a)&&shape(b)&&b->x>=a->x&&b->y>=a->y&&
        (int64_t)b->x+b->w<=(int64_t)a->x+a->w&&
        (int64_t)b->y+b->h<=(int64_t)a->y+a->h;
}
static int disjoint(uintptr_t a,uint64_t an,uintptr_t b,uint64_t bn) {
    if(!a||!b||!an||!bn||an>UINTPTR_MAX-a||bn>UINTPTR_MAX-b)return 0;
    return a+an<=b||b+bn<=a;
}
static int positive_finite(uint32_t bits) {
    return bits>0 && bits<0x7f800000u;
}
static void clear_plan(F1Plan16 *p) {
    unsigned i;p->count=0;
    for(i=0;i<4;++i){p->bands[i].vt=RECT_VT;p->bands[i].x=p->bands[i].y=0;
        p->bands[i].w=p->bands[i].h=0;}
}
static void append(F1Plan16 *p,int32_t x,int32_t y,int32_t w,int32_t h) {
    F1Rect16 *r;if(w<=0||h<=0)return;
    r=&p->bands[p->count++];r->vt=RECT_VT;r->x=x;r->y=y;r->w=w;r->h=h;
}
/* Compute (edge/base * complete_extent - roi_origin) / roi_extent,
 * expressed in source samples, minus stock left/top skipped samples, then
 * projected into the exact written output. Bounds are <=65535; products fit
 * signed64. Clamp to the visible output interval before making rectangles. */
static int32_t map_edge(int32_t edge,int32_t base,int32_t complete,
                        int32_t origin,int32_t extent,int32_t samples,
                        int32_t skipped,int32_t visible_samples,
                        int32_t out_origin,int32_t out_extent) {
    int64_t den=(int64_t)base*extent;
    int64_t num=((int64_t)edge*complete-(int64_t)origin*base)*samples;
    num-=(int64_t)skipped*den;
    /* Reduction before the final multiplication bounds both products. */
    int64_t whole=num/den,rem=num%den;
    int64_t out_num=whole*out_extent;
    int64_t out_rem=rem*out_extent;
    int64_t out_den=den*visible_samples;
    /* whole*out_extent/visible_samples plus rem is evaluated as a single
     * exact rational after first reducing whole by visible_samples. */
    int64_t q=out_num/visible_samples,r=out_num%visible_samples;
    int64_t tail=r*den+out_rem;
    q+=tail/out_den;
    if(tail%out_den<0)--q;
    q+=out_origin;
    if(q<out_origin)q=out_origin;
    if(q>(int64_t)out_origin+out_extent)q=(int64_t)out_origin+out_extent;
    return (int32_t)q;
}

enum F1Reason16 iq4_f1_plan_16(const F1Facts16 *f,unsigned mode,F1Plan16 *p) {
    int32_t ow,oh,pw,ph,kx,ky,kw,kh,xskip,yskip;uint32_t rn,rd;
    float sx,sy,scale;F1Rect16 expected,written;uint64_t source_bytes,dest_bytes;
    int32_t sw,sh;
    if(!p)return F1_SHAPE16;clear_plan(p);
    if(mode==0)return F1_OFF16;
    if(mode>7)return F1_BAD_MODE16;
    if(!f||!shape(&f->destination)||!shape(&f->projected)||!shape(&f->clip)||
       !shape(&f->roi)||!shape(&f->surface_bounds))return F1_SHAPE16;
    /* The sampled RGB frame belongs to the locked ROI. Config+4/+8 is the
     * complete coordinate domain; local LV requested output stays at +58/+5c.
     * A zoom frame may use a smaller ROI and fewer actual samples. Producer
     * caps its output by the requested pair (787850..78786c). */
    if(f->format!=0||f->source_w<=0||f->source_h<=0||f->source_w>65535||
       f->source_h>65535||f->stride!=f->source_w*3||
       f->locked_w!=f->source_w||f->locked_h!=f->source_h||
       f->engine_w<=0||f->engine_h<=0||f->engine_w>65535||f->engine_h>65535||
       f->requested_w<=0||f->requested_h<=0||f->requested_w>65535||f->requested_h>65535||
       f->source_w>f->requested_w||f->source_h>f->requested_h||
       f->roi.x<0||f->roi.y<0||
       (int64_t)f->roi.x+f->roi.w>f->engine_w||
       (int64_t)f->roi.y+f->roi.h>f->engine_h)
        return F1_SOURCE16;
    if(!positive_finite(f->scale_bits)||!positive_finite(f->normal_scale_bits)||
       f->countdown)return F1_ZOOM16;
    /* This first payload closes the exact 47552c forward-write arm. Other
     * quarter-turns keep factory rendering and hide this overlay until their
     * reverse-anchor clipping contract is independently closed. */
    if(f->rotation!=0)
        return F1_ROTATION16;
    /* The production LCD ctor installs the derived vtables after Surface ctor.
     * Base Surface and HDMI are intentionally not accepted. These exact bounds
     * are the proven LCD allocation (800*480*4); no inference from LV source. */
    if(f->surface_vt!=LCD_SURFACE_VT||f->screen_vt!=LCD_SCREEN_VT||
       f->provider_matches_surface!=1||f->native_tables_valid!=1||
       f->draw_vt!=DRAW_VT||f->surface_pitch!=800||f->surface_height!=480||
       f->surface_pitch<=0||f->surface_height<=0||f->surface_pitch>65535||
       f->surface_height>65535||f->surface_bounds.x!=0||f->surface_bounds.y!=0||
       f->surface_bounds.w!=f->surface_pitch||
       f->surface_bounds.h!=f->surface_height||
       (uint64_t)f->surface_pitch*f->surface_height>536870911u)
        return F1_SURFACE16;
    source_bytes=(uint64_t)f->stride*f->source_h;
    dest_bytes=(uint64_t)f->surface_pitch*f->surface_height*4;
    if(source_bytes>2147483647u||
       !disjoint(f->source_pixels,source_bytes,f->surface_pixels,dest_bytes))
        return F1_SURFACE16;
    ow=(f->rotation==90||f->rotation==270)?f->source_h:f->source_w;
    oh=(f->rotation==90||f->rotation==270)?f->source_w:f->source_h;
    /* Native 476e6c projection: binary32 fit/min/truncation. The LCD may
     * clip a negative projected origin during pan or a zoom transition. */
    sx=(float)f->destination.w/(float)ow;
    sy=(float)f->destination.h/(float)oh;scale=sx<sy?sx:sy;
    pw=(int32_t)((float)ow*scale);ph=(int32_t)((float)oh*scale);
    expected.vt=RECT_VT;expected.w=pw;expected.h=ph;
    expected.x=f->destination.x+(f->destination.w-pw)/2;
    expected.y=f->destination.y+(f->destination.h-ph)/2;
    if(pw<=0||ph<=0||!same(&expected,&f->projected)||
       !contains(&f->surface_bounds,&f->clip)||
       expected.x>=f->clip.x+f->clip.w||expected.y>=f->clip.y+f->clip.h||
       expected.x+pw<=f->clip.x||expected.y+ph<=f->clip.y)
        return F1_COVERAGE16;
    /* Mirror stock 47552c's source offset and four-sided truncating clip,
     * followed by 47f910's output dimensions. Geometric intersection alone
     * can include a row the stock scaler never redrew. */
    sw=ow;sh=oh;xskip=0;yskip=0;written=expected;
    if(written.x<f->clip.x){
        xskip=(int32_t)((float)(f->clip.x-written.x)/scale);
        sw-=xskip;written.x=f->clip.x;
    }
    if(written.y<f->clip.y){
        yskip=(int32_t)((float)(f->clip.y-written.y)/scale);
        sh-=yskip;written.y=f->clip.y;
    }
    if((float)written.x+(float)sw*scale>(float)(f->clip.x+f->clip.w))
        sw=(int32_t)((float)(f->clip.x+f->clip.w-written.x)/scale);
    if((float)written.y+(float)sh*scale>(float)(f->clip.y+f->clip.h))
        sh=(int32_t)((float)(f->clip.y+f->clip.h-written.y)/scale);
    if(sw<=0||sh<=0||xskip<0||yskip<0||sw>ow-xskip||sh>oh-yskip)
        return F1_COVERAGE16;
    written.w=(int32_t)((float)sw*scale);written.h=(int32_t)((float)sh*scale);
    if(!contains(&f->clip,&written)||!contains(&f->surface_bounds,&written))
        return F1_COVERAGE16;
    rn=mode==1?65u:mode==2?16u:mode==3?3u:mode==4?1u:mode==5?4u:mode==6?6u:21u;
    rd=mode==1?24u:mode==2?9u:mode==3?2u:mode==4?1u:mode==5?5u:mode==6?7u:9u;
    if(f->rotation==90||f->rotation==270){uint32_t t=rn;rn=rd;rd=t;}
    if(f->roi.x==0&&f->roi.y==0&&f->roi.w==f->engine_w&&
       f->roi.h==f->engine_h&&f->scale_bits==f->normal_scale_bits&&
       xskip==0&&yskip==0){
        /* Preserve the user-accepted normal-view pixel boundaries exactly. */
        kw=pw;kh=ph;
        if((int64_t)pw*rd>(int64_t)ph*rn)kw=(int32_t)((int64_t)ph*rn/rd);
        else kh=(int32_t)((int64_t)pw*rd/rn);
        if(kw<=0||kh<=0)return F1_COVERAGE16;
        kx=expected.x+(pw-kw)/2;ky=expected.y+(ph-kh)/2;
    }else{
        int32_t dw,dh,bw,bh,bkw,bkh,bx,by,ex,ey;
        float normal;
        __builtin_memcpy(&normal,&f->normal_scale_bits,sizeof normal);
        /* Derive the same complete-frame projection used by original normal
         * fit, independent of the currently zoomed ROI. No cached frame or
         * assumption that the zoom viewport is a new composition frame. */
        sx=(float)f->engine_w/normal;sy=(float)f->engine_h/normal;
        if(!(sx>=1.0f&&sy>=1.0f&&sx<=65535.0f&&sy<=65535.0f))
            return F1_ZOOM16;
        dw=(int32_t)sx;dh=(int32_t)sy;
        sx=(float)dw/(float)f->requested_w;
        sy=(float)dh/(float)f->requested_h;normal=sx<sy?sx:sy;
        bw=(int32_t)((float)f->requested_w*normal);
        bh=(int32_t)((float)f->requested_h*normal);
        bkw=bw;bkh=bh;
        if((int64_t)bw*rd>(int64_t)bh*rn)bkw=(int32_t)((int64_t)bh*rn/rd);
        else bkh=(int32_t)((int64_t)bw*rd/rn);
        if(bw<=0||bh<=0||bkw<=0||bkh<=0)return F1_COVERAGE16;
        bx=(bw-bkw)/2;by=(bh-bkh)/2;
        /* Map full-frame ratio edges to sensor/config coordinates, through
         * this locked ROI and source samples, then through actual clipped
         * scaler output. Signed floor division handles edges off screen. */
        kx=map_edge(bx,bw,f->engine_w,f->roi.x,f->roi.w,ow,xskip,sw,
                    written.x,written.w);
        ex=map_edge(bx+bkw,bw,f->engine_w,f->roi.x,f->roi.w,ow,xskip,sw,
                    written.x,written.w);
        ky=map_edge(by,bh,f->engine_h,f->roi.y,f->roi.h,oh,yskip,sh,
                    written.y,written.h);
        ey=map_edge(by+bkh,bh,f->engine_h,f->roi.y,f->roi.h,oh,yskip,sh,
                    written.y,written.h);
        kw=ex-kx;kh=ey-ky;
        if(kw<0||kh<0)return F1_COVERAGE16;
    }
    /* The keep rectangle may be wholly outside the visible viewport. The
     * difference below yields one full band in that case, never stale pixels.
     * Intersect/clamp before constructing rectangles to avoid huge extents. */
    {int32_t right=kx+kw,bottom=ky+kh,left=kx,top=ky;
     if(left<written.x)left=written.x;
     if(top<written.y)top=written.y;
     if(left>written.x+written.w)left=written.x+written.w;
     if(top>written.y+written.h)top=written.y+written.h;
     if(right>written.x+written.w)right=written.x+written.w;
     if(bottom>written.y+written.h)bottom=written.y+written.h;
     if(right<written.x)right=written.x;
     if(bottom<written.y)bottom=written.y;
     if(right<left)right=left;if(bottom<top)bottom=top;
     append(p,written.x,written.y,written.w,top-written.y);
     append(p,written.x,bottom,written.w,written.y+written.h-bottom);
     append(p,written.x,top,left-written.x,bottom-top);
     append(p,right,top,written.x+written.w-right,bottom-top);}
    return F1_DRAW16;
}

static uint32_t u32(uintptr_t p) {uint32_t v;__builtin_memcpy(&v,(const void*)p,4);return v;}
#ifdef IQ4_F1_DISPLAY16_HOST
/* Only pinned stock vtable constants are routed to owned host fixtures.
 * Actual stack/object reads stay owned-memory reads; target uses no fixture. */
extern uintptr_t iq4_f1_fixture_table_word_16(uintptr_t);
#endif
static uintptr_t ptr(uintptr_t p) {
    uintptr_t v;
#ifdef IQ4_F1_DISPLAY16_HOST
    if((p>=0xb7cf80&&p<0xb7cfe0)||(p>=0xb7b7c8&&p<0xb7b7f8))
        return iq4_f1_fixture_table_word_16(p);
#endif
    __builtin_memcpy(&v,(const void*)p,sizeof v);return v;
}
static int lcd_tables(void) {
    static const uintptr_t lcd[12]={0,0xb7d030,0x485e54,0x485eb4,0x4865a0,0x486da4,
        UINTPTR_MAX-0x57,0xb7d030,0x485eac,0x485edc,0x486738,0x486db8};
    static const uintptr_t draw[6]={0,0xb7b7b8,0x47e798,0x47f378,0x47ee78,0x47e9d0};
    unsigned i;
    for(i=0;i<12;++i)if(ptr(0xb7cf80+i*8)!=lcd[i])return 0;
    for(i=0;i<6;++i)if(ptr(0xb7b7c8+i*8)!=draw[i])return 0;
    return 1;
}
static F1Rect16 rect(uintptr_t p) {F1Rect16 r;__builtin_memcpy(&r,(const void*)p,sizeof r);return r;}

#ifdef IQ4_F1_DISPLAY16_HOST
/* Own-memory fixture only; never linked into target payload. */
extern void iq4_f1_fixture_fill_16(void*,const F1Rect16*,const F1Rect16*,const F1Color16*);
#endif
void iq4_f1_after_stock_draw_16(const F1Call16 *c) {
    unsigned mode=iq4_f1_mode_get_01(),opacity=iq4_f1_opacity_get_01(),i;uintptr_t s,lv,surface,engine,draw,manager,provider;
    F1Facts16 f;F1Plan16 plan;F1Color16 black={0,0,0,0};
    enum F1Reason16 reason;
    if(mode==0||mode>7||opacity>100u||!c){return;}
    s=c->caller_sp;
    /* Exact BL provenance plus native on-stack objects. No fake external owner.
     * The stack belongs to the active original LV callback for this call only. */
    if(c->return_pc!=0x51ddd0||!s||(s&15)||c->caller_fp!=s||
       c->args[1]!=s+0x110||c->args[4]!=s+0xc0||c->args[6]!=s+0x128||
       c->args[8]!=s+0xf8||c->args[2]!=0||c->args[3]!=0||c->args[7]!=0){return;}
    surface=ptr(s+0x30);lv=ptr(s+0x38);
    if(!surface||!lv||(surface&7)||(lv&7)||surface!=c->args[0]||ptr(lv)!=LV_VT){return;}
    /* Classify the inherited LCD object before reading its +58 IScreen or
     * any vtable slots. Manager owns the very same IScreen subobject. */
    if(ptr(surface)!=LCD_SURFACE_VT){return;}
    manager=ptr(lv+0xb0);
    if(!manager||(manager&7)||ptr(manager)!=0xb8f358||surface>UINTPTR_MAX-0x58){return;}
    provider=ptr(manager+0x108);
    if(provider!=surface+0x58||ptr(provider)!=LCD_SCREEN_VT){return;}
    engine=ptr(s+0x168);draw=ptr(surface+8);
    if(!engine||!draw||(engine&3)||(draw&7)){return;}
    f.destination=rect(c->args[1]);f.projected=rect(c->args[8]);
    f.clip=rect(c->args[6]);f.roi=rect(s+0xa0);f.surface_bounds=rect(surface+0x20);
    f.format=(int32_t)u32(s+0xc0);f.source_w=(int32_t)u32(s+0xc4);
    f.source_h=(int32_t)u32(s+0xc8);f.stride=(int32_t)u32(s+0xcc);
    f.source_pixels=ptr(s+0xd0);f.surface_pixels=ptr(surface+0x38);
    if(!f.source_pixels||f.source_pixels!=ptr(lv+0x188)){return;}
    f.locked_w=(int32_t)u32(s+0xb8);f.locked_h=(int32_t)u32(s+0xbc);
    f.engine_w=(int32_t)u32(engine+4);f.engine_h=(int32_t)u32(engine+8);
    f.requested_w=(int32_t)u32(engine+0x58);f.requested_h=(int32_t)u32(engine+0x5c);
    f.surface_pitch=(int32_t)u32(surface+0x14);f.surface_height=(int32_t)u32(surface+0x18);
    f.surface_vt=ptr(surface);f.screen_vt=ptr(provider);f.draw_vt=ptr(draw);
    if(f.draw_vt!=DRAW_VT){return;}
    f.provider_matches_surface=1;f.native_tables_valid=(uint32_t)lcd_tables();
    f.rotation=(uint32_t)c->args[5];
    if(f.rotation!=u32(lv+0x1b0)){return;}
    f.scale_bits=u32(lv+0x190);f.normal_scale_bits=u32(lv+0x194);
    f.animation_active=*(const uint8_t*)(lv+0x138);f.countdown=u32(lv+0x1b8);
    reason=iq4_f1_plan_16(&f,mode,&plan);
    if(reason!=F1_DRAW16)return;
    /* Integer round-to-nearest percent to native alpha. Each source redraw
     * precedes this hook, so blending never uses a cached masked frame. */
    black.alpha=(uint8_t)((opacity*255u+50u)/100u);
    if(!black.alpha){return;}
    for(i=0;i<plan.count;++i) {
#ifdef IQ4_F1_DISPLAY16_HOST
        iq4_f1_fixture_fill_16((void*)surface,&plan.bands[i],&f.clip,&black);
#else
        ((void(*)(void*,const F1Rect16*,const F1Rect16*,const F1Color16*))NATIVE_FILL)
            ((void*)surface,&plan.bands[i],&f.clip,&black);
#endif
    }
    
}
