#include "../../src/display/ratio_mask_display.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned groups,mode=1,opacity=65,fill_count;
static F1Rect16 fills[4];
unsigned iq4_f1_mode_get_01(void){return mode;}
unsigned iq4_f1_opacity_get_01(void){return opacity;}
void iq4_f1_report_16(unsigned c,const F1Facts16*f,unsigned n){(void)c;(void)f;(void)n;}
uintptr_t iq4_f1_fixture_table_word_16(uintptr_t a){
 static const uintptr_t lcd[12]={0,0xb7d030,0x485e54,0x485eb4,0x4865a0,0x486da4,
 UINTPTR_MAX-0x57,0xb7d030,0x485eac,0x485edc,0x486738,0x486db8};
 static const uintptr_t draw[6]={0,0xb7b7b8,0x47e798,0x47f378,0x47ee78,0x47e9d0};
 if(a>=0xb7cf80&&a<0xb7cfe0)return lcd[(a-0xb7cf80)/8];
 assert(a>=0xb7b7c8&&a<0xb7b7f8);return draw[(a-0xb7b7c8)/8];
}
void iq4_f1_fixture_fill_16(void*s,const F1Rect16*b,const F1Rect16*c,const F1Color16*k){
 assert(s&&fill_count<4&&b->w>0&&b->h>0&&b->x>=c->x&&b->y>=c->y);
 assert(b->x+b->w<=c->x+c->w&&b->y+b->h<=c->y+c->h&&k->alpha==166);
 fills[fill_count++]=*b;
}
static F1Rect16 rect(int x,int y,int w,int h){F1Rect16 r={0xb73b98,x,y,w,h};return r;}
static uint32_t bits(float f){uint32_t n;memcpy(&n,&f,4);return n;}
static F1Facts16 base(void){
 F1Facts16 f={0};f.destination=f.clip=f.surface_bounds=rect(0,0,800,480);
 f.projected=rect(80,0,640,480);f.roi=rect(0,0,1280,960);
 f.source_w=f.locked_w=f.requested_w=640;f.source_h=f.locked_h=f.requested_h=480;
 f.engine_w=1280;f.engine_h=960;f.stride=1920;
 f.surface_pitch=800;f.surface_height=480;f.scale_bits=f.normal_scale_bits=bits(2);
 f.surface_vt=0xb7cf90;f.screen_vt=0xb7cfc0;f.draw_vt=0xb7b7d8;
 f.provider_matches_surface=f.native_tables_valid=1;
 f.source_pixels=0x10000000;f.surface_pixels=0x20000000;return f;
}
static void project(F1Facts16*f){
 float sx=(float)f->destination.w/f->source_w,sy=(float)f->destination.h/f->source_h;
 float s=sx<sy?sx:sy;
 int w=(int)(f->source_w*s),h=(int)(f->source_h*s);
 f->projected=rect(f->destination.x+(f->destination.w-w)/2,f->destination.y+(f->destination.h-h)/2,w,h);
}
static int marked(const F1Plan16*p,int x,int y){unsigned i,n=0;
 for(i=0;i<p->count;i++){const F1Rect16*r=&p->bands[i];
 if(x>=r->x&&x<r->x+r->w&&y>=r->y&&y<r->y+r->h)n++;}
 assert(n<=1);return n;
}
static int endpoint(int edge,int b,int full,int ro,int rw,int samples,int skip,int count,int out,int extent){
 __int128 den=(__int128)b*rw*count;
 __int128 num=((__int128)edge*full-(__int128)ro*b)*samples;
 num-=(__int128)skip*b*rw;num*=extent;
 __int128 q=num/den;if(num%den<0)q--;
 q+=out;if(q<out)q=out;if(q>out+extent)q=out+extent;return (int)q;
}
/* Independent wide rational oracle, checking every LCD pixel. Stock clipping
 * is modeled from frozen native instructions; no target execution claimed. */
static void check(F1Facts16 f,unsigned m){
 F1Plan16 p;float s=(float)f.destination.w/f.source_w,sy=(float)f.destination.h/f.source_h;
 float normal;int wx=f.projected.x,wy=f.projected.y,sw=f.source_w,sh=f.source_h,xskip=0,yskip=0;
 int ww,wh,bw,bh,bkw,bkh,bx,by,l,t,r,b,x,y;unsigned n[]={0,65,16,3,1,4,6,21},d[]={0,24,9,2,1,5,7,9};
 if(sy<s)s=sy;
 if(wx<f.clip.x){xskip=(int)((float)(f.clip.x-wx)/s);sw-=xskip;wx=f.clip.x;}
 if(wy<f.clip.y){yskip=(int)((float)(f.clip.y-wy)/s);sh-=yskip;wy=f.clip.y;}
 if(wx+sw*s>f.clip.x+f.clip.w)sw=(int)((float)(f.clip.x+f.clip.w-wx)/s);
 if(wy+sh*s>f.clip.y+f.clip.h)sh=(int)((float)(f.clip.y+f.clip.h-wy)/s);
 ww=(int)(sw*s);wh=(int)(sh*s);
 assert(iq4_f1_plan_16(&f,m,&p)==F1_DRAW16);
 memcpy(&normal,&f.normal_scale_bits,4);
 bw=(int)((float)f.engine_w/normal);bh=(int)((float)f.engine_h/normal);
 normal=(float)bw/f.requested_w;sy=(float)bh/f.requested_h;if(sy<normal)normal=sy;
 bw=(int)(f.requested_w*normal);bh=(int)(f.requested_h*normal);bkw=bw;bkh=bh;
 if((long long)bw*d[m]>(long long)bh*n[m])bkw=bh*(int)n[m]/(int)d[m];else bkh=bw*(int)d[m]/(int)n[m];
 bx=(bw-bkw)/2;by=(bh-bkh)/2;
 l=endpoint(bx,bw,f.engine_w,f.roi.x,f.roi.w,f.source_w,xskip,sw,wx,ww);
 r=endpoint(bx+bkw,bw,f.engine_w,f.roi.x,f.roi.w,f.source_w,xskip,sw,wx,ww);
 t=endpoint(by,bh,f.engine_h,f.roi.y,f.roi.h,f.source_h,yskip,sh,wy,wh);
 b=endpoint(by+bkh,bh,f.engine_h,f.roi.y,f.roi.h,f.source_h,yskip,sh,wy,wh);
 /* Normal-view path intentionally retains already accepted projected pixels. */
 if(f.roi.x==0&&f.roi.y==0&&f.roi.w==f.engine_w&&f.roi.h==f.engine_h&&
 f.scale_bits==f.normal_scale_bits&&xskip==0&&yskip==0){
 bkw=f.projected.w;bkh=f.projected.h;
 if((long long)bkw*d[m]>(long long)bkh*n[m])bkw=bkh*(int)n[m]/(int)d[m];else bkh=bkw*(int)d[m]/(int)n[m];
 l=f.projected.x+(f.projected.w-bkw)/2;r=l+bkw;
 t=f.projected.y+(f.projected.h-bkh)/2;b=t+bkh;
 }
 for(y=0;y<480;y++)for(x=0;x<800;x++){
 int fresh=x>=wx&&x<wx+ww&&y>=wy&&y<wy+wh;
 int want=fresh&&(x<l||x>=r||y<t||y>=b);
 assert(marked(&p,x,y)==want);
 }
 ++groups;
}
enum F1Reason16 iq4_f1_plan_legacy(const F1Facts16*,unsigned,F1Plan16*);
static void legacy(void){
 F1Facts16 f;F1Plan16 a,b;unsigned m,j;
 for(j=0;j<3;j++)for(m=0;m<=7;m++){
  f=base();
  if(j==1){f.engine_w=14204;f.engine_h=10652;f.roi=rect(0,0,14204,10652);
   f.scale_bits=f.normal_scale_bits=bits(22);f.destination=rect(77,0,645,484);project(&f);}
  if(j==2){f.destination=rect(8,6,687,499);project(&f);}
  assert(iq4_f1_plan_16(&f,m,&a)==iq4_f1_plan_legacy(&f,m,&b));
  assert(a.count==b.count&&!memcmp(a.bands,b.bands,sizeof a.bands));++groups;
 }
 f=base();f.roi=rect(0,240,640,480);f.scale_bits=bits(1);
 assert(iq4_f1_plan_legacy(&f,4,&a)!=F1_DRAW16&&a.count==0);
 assert(iq4_f1_plan_16(&f,4,&a)==F1_DRAW16&&a.count==1);++groups;
}
static void geometry(void){
 unsigned m;F1Facts16 f;F1Plan16 p;
 for(m=1;m<=7;m++){
 f=base();check(f,m);
 f.roi=rect(320,240,640,480);f.scale_bits=bits(1);check(f,m);
 f.roi=rect(0,0,640,480);check(f,m);
 f.roi=rect(640,480,640,480);check(f,m);
 f.roi=rect(0,240,640,480);check(f,m);
 f.roi=rect(320,0,640,480);check(f,m);
 f=base();f.scale_bits=bits(1);f.destination=rect(-240,-240,1280,960);project(&f);check(f,m);
 f=base();f.roi=rect(320,240,640,480);f.scale_bits=bits(1);f.destination=rect(-20,-25,803,611);project(&f);check(f,m);
 f.destination=rect(65,31,687,499);project(&f);check(f,m);
 f.animation_active=1;check(f,m);
 f=base();f.roi=rect(0,0,80,60);f.scale_bits=bits(.25);f.source_w=f.locked_w=80;
 f.source_h=f.locked_h=60;f.stride=240;project(&f);check(f,m);
 f=base();f.engine_w=14204;f.engine_h=10652;f.roi=rect(0,0,14204,10652);
 f.scale_bits=f.normal_scale_bits=bits(22);f.destination=rect(77,0,645,484);project(&f);check(f,m);
 f.roi=rect(0,0,7102,5326);f.scale_bits=bits(11);check(f,m);
 f.roi=rect(7102,5326,7102,5326);check(f,m);
 f.roi=rect(3551,2663,7102,5326);check(f,m);
 }
 f=base();f.roi=rect(320,240,640,480);f.scale_bits=bits(1);
 assert(iq4_f1_plan_16(&f,1,&p)==F1_DRAW16&&p.count==2);
 assert(p.bands[0].x==80&&p.bands[0].y==0&&p.bands[0].w==640&&p.bands[0].h==4);
 assert(p.bands[1].y==476&&p.bands[1].h==4);++groups;
 /* Central zoom may genuinely have no visible composition boundary. */
 assert(iq4_f1_plan_16(&f,4,&p)==F1_DRAW16&&p.count==0);++groups;
 f.roi=rect(0,240,640,480);assert(iq4_f1_plan_16(&f,4,&p)==F1_DRAW16&&p.count==1);
 assert(p.bands[0].x==80&&p.bands[0].w==160&&p.bands[0].h==480);++groups;
 f=base();f.countdown=1;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);++groups;
 f=base();f.scale_bits=0x7fc00000;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);++groups;
 f=base();f.normal_scale_bits=0;assert(iq4_f1_plan_16(&f,1,&p)==F1_ZOOM16);++groups;
 f=base();f.roi=rect(640,0,641,480);assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);++groups;
 f=base();f.roi=rect(-1,0,640,480);assert(iq4_f1_plan_16(&f,1,&p)==F1_SOURCE16);++groups;
 f=base();f.rotation=180;assert(iq4_f1_plan_16(&f,1,&p)==F1_ROTATION16);++groups;
 f=base();f.source_pixels=f.surface_pixels;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);++groups;
 f=base();f.surface_vt=0xb7b780;assert(iq4_f1_plan_16(&f,1,&p)==F1_SURFACE16);++groups;
 f=base();f.projected.w--;assert(iq4_f1_plan_16(&f,1,&p)==F1_COVERAGE16);++groups;
 assert(iq4_f1_plan_16(&f,0,&p)==F1_OFF16&&p.count==0);++groups;
}
static void s32(unsigned char*p,size_t o,uint32_t v){memcpy(p+o,&v,4);}
static void sptr(unsigned char*p,size_t o,uintptr_t v){memcpy(p+o,&v,sizeof v);}
static void sr(unsigned char*p,size_t o,F1Rect16 v){memcpy(p+o,&v,sizeof v);}
static void ingress(void){
 _Alignas(16) unsigned char stack[0x170]={0};_Alignas(8) unsigned char lv[0x1310]={0};
 _Alignas(8) unsigned char surface[0x188]={0},draw[8]={0},engine[0x60]={0},manager[0x110]={0};
 unsigned char before[sizeof stack],lv_before[sizeof lv];
 unsigned char *source=malloc(640*480*3),*screen=malloc(800*480*4);F1Call16 c={0};
 assert(source&&screen);memset(source,23,640*480*3);memset(screen,100,800*480*4);
 sptr(lv,0,0xb9a9d8);sptr(lv,0xb0,(uintptr_t)manager);sptr(lv,0x188,(uintptr_t)source);
 s32(lv,0x190,bits(1));s32(lv,0x194,bits(2));
 sptr(manager,0,0xb8f358);sptr(manager,0x108,(uintptr_t)surface+0x58);
 sptr(surface,0,0xb7cf90);sptr(surface,0x58,0xb7cfc0);sptr(surface,8,(uintptr_t)draw);
 sptr(draw,0,0xb7b7d8);s32(surface,0x14,800);s32(surface,0x18,480);
 sr(surface,0x20,rect(0,0,800,480));sptr(surface,0x38,(uintptr_t)screen);
 sptr(stack,0x30,(uintptr_t)surface);sptr(stack,0x38,(uintptr_t)lv);sptr(stack,0x168,(uintptr_t)engine);
 s32(engine,4,1280);s32(engine,8,960);s32(engine,0x58,640);s32(engine,0x5c,480);
 sr(stack,0xa0,rect(0,240,640,480));s32(stack,0xb8,640);s32(stack,0xbc,480);
 s32(stack,0xc4,640);s32(stack,0xc8,480);s32(stack,0xcc,1920);sptr(stack,0xd0,(uintptr_t)source);
 sr(stack,0x110,rect(0,0,800,480));sr(stack,0x128,rect(0,0,800,480));sr(stack,0xf8,rect(80,0,640,480));
 c.caller_sp=c.caller_fp=(uintptr_t)stack;c.return_pc=0x51ddd0;
 c.args[0]=(uintptr_t)surface;c.args[1]=(uintptr_t)stack+0x110;c.args[4]=(uintptr_t)stack+0xc0;
 c.args[6]=(uintptr_t)stack+0x128;c.args[8]=(uintptr_t)stack+0xf8;
 memcpy(before,stack,sizeof stack);memcpy(lv_before,lv,sizeof lv);mode=4;fill_count=0;
 iq4_f1_after_stock_draw_16(&c);assert(fill_count==1&&fills[0].x==80&&fills[0].w==160);
 assert(!memcmp(stack,before,sizeof stack)&&!memcmp(lv,lv_before,sizeof lv));
 for(size_t n=0;n<640*480*3;n++)assert(source[n]==23);
 ++groups;mode=0;fill_count=0;iq4_f1_after_stock_draw_16(&c);assert(fill_count==0);++groups;
 free(source);free(screen);
}
int main(void){legacy();geometry();ingress();printf("{\"groups\":%u,\"passed\":true,\"target_executed\":false,\"camera_access\":false}\n",groups);return 0;}
