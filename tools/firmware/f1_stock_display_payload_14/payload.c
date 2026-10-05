#include "payload.h"

_Static_assert(sizeof(F1Rect14)==24,"native Rectangle size");
_Static_assert(offsetof(F1Rect14,x)==8,"native Rectangle coordinates");
_Static_assert(sizeof(F1Image14)==24 && offsetof(F1Image14,pixels)==16,"native Image");
_Static_assert(sizeof(F1Color14)==4,"native Color");
_Static_assert(sizeof(F1Call14)==96 && offsetof(F1Call14,caller_sp)==0x48 &&
    offsetof(F1Call14,return_pc)==0x58,"assembly capture layout");

#define RECT_VT ((uintptr_t)0xb73b98)
#define LCD_SURFACE_VT ((uintptr_t)0xb7cf90)
#define LCD_SCREEN_VT ((uintptr_t)0xb7cfc0)
#define DRAW_VT ((uintptr_t)0xb7b7d8)
#define LV_VT ((uintptr_t)0xb9a9d8)
#define NATIVE_FILL ((uintptr_t)0x46f370)
extern void iq4_f1_report_14(unsigned,const F1Facts14*,unsigned);

static int shape(const F1Rect14 *r) {
    return r->vt==RECT_VT && r->w>0 && r->h>0 && r->w<=65535 && r->h<=65535 &&
        r->x>=0 && r->y>=0 && (int64_t)r->x+r->w<=2147483647 &&
        (int64_t)r->y+r->h<=2147483647;
}
static int same(const F1Rect14 *a,const F1Rect14 *b) {
    return a->vt==b->vt && a->x==b->x && a->y==b->y && a->w==b->w && a->h==b->h;
}
static int contains(const F1Rect14 *a,const F1Rect14 *b) {
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
static void clear_plan(F1Plan14 *p) {
    unsigned i;p->count=0;
    for(i=0;i<4;++i){p->bands[i].vt=RECT_VT;p->bands[i].x=p->bands[i].y=0;
        p->bands[i].w=p->bands[i].h=0;}
}
static void append(F1Plan14 *p,int32_t x,int32_t y,int32_t w,int32_t h) {
    F1Rect14 *r;if(w<=0||h<=0)return;
    r=&p->bands[p->count++];r->vt=RECT_VT;r->x=x;r->y=y;r->w=w;r->h=h;
}

enum F1Reason14 iq4_f1_plan_14(const F1Facts14 *f,unsigned mode,F1Plan14 *p) {
    int32_t ow,oh,pw,ph,kx,ky,kw,kh;uint32_t rn,rd;
    float sx,sy,scale;F1Rect14 expected;uint64_t source_bytes,dest_bytes;
    if(!p)return F1_SHAPE14;clear_plan(p);
    if(mode==0)return F1_OFF14;
    if(mode>4)return F1_BAD_MODE14;
    if(!f||!shape(&f->destination)||!shape(&f->projected)||!shape(&f->clip)||
       !shape(&f->roi)||!shape(&f->surface_bounds))return F1_SHAPE14;
    /* The ROI is in configuration coordinates; the locked Image is in output
     * pixel coordinates. Original 787838..787880 publishes them independently.
     * Require the full configuration ROI and the same actual packed buffer,
     * with equal aspect ratio, without equating their sampling dimensions. */
    if(f->format!=0||f->source_w<=0||f->source_h<=0||f->source_w>65535||
       f->source_h>65535||f->stride!=f->source_w*3||
       f->locked_w!=f->source_w||f->locked_h!=f->source_h||
       f->engine_w<=0||f->engine_h<=0||f->engine_w>65535||f->engine_h>65535||
       (int64_t)f->engine_w*f->source_h!=(int64_t)f->engine_h*f->source_w||
       f->roi.x!=0||f->roi.y!=0||f->roi.w!=f->engine_w||f->roi.h!=f->engine_h)
        return F1_SOURCE14;
    if(!positive_finite(f->scale_bits)||f->scale_bits!=f->normal_scale_bits||
       f->animation_active||f->countdown)return F1_ZOOM14;
    /* This first payload closes the exact 47552c forward-write arm. Other
     * quarter-turns keep factory rendering and hide this overlay until their
     * reverse-anchor clipping contract is independently closed. */
    if(f->rotation!=0)
        return F1_ROTATION14;
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
        return F1_SURFACE14;
    source_bytes=(uint64_t)f->stride*f->source_h;
    dest_bytes=(uint64_t)f->surface_pitch*f->surface_height*4;
    if(source_bytes>2147483647u||
       !disjoint(f->source_pixels,source_bytes,f->surface_pixels,dest_bytes))
        return F1_SURFACE14;
    ow=(f->rotation==90||f->rotation==270)?f->source_h:f->source_w;
    oh=(f->rotation==90||f->rotation==270)?f->source_w:f->source_h;
    /* Exact finite stock 476e6c projection: binary32 divisions, min, truncation.
     * The extra untruncated-end test prevents the actual 47552c source clipping
     * arms; supported RGB24->32bpp selects its original forward-write arm.
     * Nonempty returned Rectangle WITHOUT these tests is not a write receipt. */
    sx=(float)f->destination.w/(float)ow;
    sy=(float)f->destination.h/(float)oh;scale=sx<sy?sx:sy;
    pw=(int32_t)((float)ow*scale);ph=(int32_t)((float)oh*scale);
    expected.vt=RECT_VT;expected.w=pw;expected.h=ph;
    expected.x=f->destination.x+(f->destination.w-pw)/2;
    expected.y=f->destination.y+(f->destination.h-ph)/2;
    if(pw<=0||ph<=0||!same(&expected,&f->projected)||
       !contains(&f->clip,&expected)||!contains(&f->surface_bounds,&expected)||
       (float)expected.x+(float)ow*scale>(float)(f->clip.x+f->clip.w)||
       (float)expected.y+(float)oh*scale>(float)(f->clip.y+f->clip.h)||
       (float)expected.x+(float)ow*scale>(float)f->surface_pitch||
       (float)expected.y+(float)oh*scale>(float)f->surface_height)
        return F1_COVERAGE14;
    rn=mode==1?65u:mode==2?16u:mode==3?3u:1u;
    rd=mode==1?24u:mode==2?9u:mode==3?2u:1u;
    if(f->rotation==90||f->rotation==270){uint32_t t=rn;rn=rd;rd=t;}
    kw=pw;kh=ph;
    if((int64_t)pw*rd>(int64_t)ph*rn)kw=(int32_t)((int64_t)ph*rn/rd);
    else kh=(int32_t)((int64_t)pw*rd/rn);
    if(kw<=0||kh<=0)return F1_COVERAGE14;
    kx=expected.x+(pw-kw)/2;ky=expected.y+(ph-kh)/2;
    /* Disjoint half-open bands, converted to positive native W/H Rectangles.
     * Empty bands NEVER reach the original inclusive endpoint fill function. */
    append(p,expected.x,expected.y,pw,ky-expected.y);
    append(p,expected.x,ky+kh,pw,expected.y+ph-(ky+kh));
    append(p,expected.x,ky,kx-expected.x,kh);
    append(p,kx+kw,ky,expected.x+pw-(kx+kw),kh);
    return F1_DRAW14;
}

static uint32_t u32(uintptr_t p) {uint32_t v;__builtin_memcpy(&v,(const void*)p,4);return v;}
#ifdef IQ4_F1_DISPLAY14_HOST
/* Only pinned stock vtable constants are routed to owned host fixtures.
 * Actual stack/object reads stay owned-memory reads; target uses no fixture. */
extern uintptr_t iq4_f1_fixture_table_word_14(uintptr_t);
#endif
static uintptr_t ptr(uintptr_t p) {
    uintptr_t v;
#ifdef IQ4_F1_DISPLAY14_HOST
    if((p>=0xb7cf80&&p<0xb7cfe0)||(p>=0xb7b7c8&&p<0xb7b7f8))
        return iq4_f1_fixture_table_word_14(p);
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
static F1Rect14 rect(uintptr_t p) {F1Rect14 r;__builtin_memcpy(&r,(const void*)p,sizeof r);return r;}

#ifdef IQ4_F1_DISPLAY14_HOST
/* Own-memory fixture only; never linked into target payload. */
extern void iq4_f1_fixture_fill_14(void*,const F1Rect14*,const F1Rect14*,const F1Color14*);
#endif
void iq4_f1_after_stock_draw_14(const F1Call14 *c) {
    unsigned mode=iq4_f1_mode_get_01(),i;uintptr_t s,lv,surface,engine,draw,manager,provider;
    F1Facts14 f;F1Plan14 plan;F1Color14 black={166,0,0,0};
    enum F1Reason14 reason;
    iq4_f1_report_14(10,NULL,0);
    if(mode==0||mode>4||!c){iq4_f1_report_14(mode==0?0u:11u,NULL,0);return;}
    s=c->caller_sp;
    /* Exact BL provenance plus native on-stack objects. No fake external owner.
     * The stack belongs to the active original LV callback for this call only. */
    if(c->return_pc!=0x51ddd0||!s||(s&15)||c->caller_fp!=s||
       c->args[1]!=s+0x110||c->args[4]!=s+0xc0||c->args[6]!=s+0x128||
       c->args[8]!=s+0xf8||c->args[2]!=0||c->args[3]!=0||c->args[7]!=0){iq4_f1_report_14(11,NULL,0);return;}
    surface=ptr(s+0x30);lv=ptr(s+0x38);
    if(!surface||!lv||(surface&7)||(lv&7)||surface!=c->args[0]||ptr(lv)!=LV_VT){iq4_f1_report_14(12,NULL,0);return;}
    /* Classify the inherited LCD object before reading its +58 IScreen or
     * any vtable slots. Manager owns the very same IScreen subobject. */
    if(ptr(surface)!=LCD_SURFACE_VT){iq4_f1_report_14(13,NULL,0);return;}
    manager=ptr(lv+0xb0);
    if(!manager||(manager&7)||ptr(manager)!=0xb8f358||surface>UINTPTR_MAX-0x58){iq4_f1_report_14(14,NULL,0);return;}
    provider=ptr(manager+0x108);
    if(provider!=surface+0x58||ptr(provider)!=LCD_SCREEN_VT){iq4_f1_report_14(15,NULL,0);return;}
    engine=ptr(s+0x168);draw=ptr(surface+8);
    if(!engine||!draw||(engine&3)||(draw&7)){iq4_f1_report_14(16,NULL,0);return;}
    f.destination=rect(c->args[1]);f.projected=rect(c->args[8]);
    f.clip=rect(c->args[6]);f.roi=rect(s+0xa0);f.surface_bounds=rect(surface+0x20);
    f.format=(int32_t)u32(s+0xc0);f.source_w=(int32_t)u32(s+0xc4);
    f.source_h=(int32_t)u32(s+0xc8);f.stride=(int32_t)u32(s+0xcc);
    f.source_pixels=ptr(s+0xd0);f.surface_pixels=ptr(surface+0x38);
    if(!f.source_pixels||f.source_pixels!=ptr(lv+0x188)){iq4_f1_report_14(17,NULL,0);return;}
    f.locked_w=(int32_t)u32(s+0xb8);f.locked_h=(int32_t)u32(s+0xbc);
    f.engine_w=(int32_t)u32(engine+4);f.engine_h=(int32_t)u32(engine+8);
    f.surface_pitch=(int32_t)u32(surface+0x14);f.surface_height=(int32_t)u32(surface+0x18);
    f.surface_vt=ptr(surface);f.screen_vt=ptr(provider);f.draw_vt=ptr(draw);
    if(f.draw_vt!=DRAW_VT){iq4_f1_report_14(18,NULL,0);return;}
    f.provider_matches_surface=1;f.native_tables_valid=(uint32_t)lcd_tables();
    f.rotation=(uint32_t)c->args[5];
    if(f.rotation!=u32(lv+0x1b0)){iq4_f1_report_14(19,NULL,0);return;}
    f.scale_bits=u32(lv+0x190);f.normal_scale_bits=u32(lv+0x194);
    f.animation_active=*(const uint8_t*)(lv+0x138);f.countdown=u32(lv+0x1b8);
    reason=iq4_f1_plan_14(&f,mode,&plan);
    if(reason!=F1_DRAW14){iq4_f1_report_14(30u+(unsigned)reason,&f,0);return;}
    for(i=0;i<plan.count;++i) {
#ifdef IQ4_F1_DISPLAY14_HOST
        iq4_f1_fixture_fill_14((void*)surface,&plan.bands[i],&f.clip,&black);
#else
        ((void(*)(void*,const F1Rect14*,const F1Rect14*,const F1Color14*))NATIVE_FILL)
            ((void*)surface,&plan.bands[i],&f.clip,&black);
#endif
    }
    iq4_f1_report_14(2,&f,plan.count);
}
