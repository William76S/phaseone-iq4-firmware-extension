#include "gallery.h"
#include "geometry.h"
#include "pins.h"
#include "../stock_jpeg_decode_55/decode.h"
#include "../stock_storage_router_55/gallery_lease.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>

/* The only records owned here have real .JPG names and JPEG presence 16.
 * The registry is independent of the native RAW/card flag byte. Sorting may
 * change an index; every consumer resolves the native name/node again. */
struct Entry55 {
 uintptr_t catalog,node;uint32_t card,state,width,height,orientation;
 char name[13],raw_name[13],path[260];
};
static Entry55 entries[1024];
static uintptr_t bound_catalog;
static uint32_t held;
static int getHeld(){return __atomic_load_n(&held,__ATOMIC_ACQUIRE)!=0;}
static void setHeld(){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
static uintptr_t catalog55(){return __atomic_load_n(&bound_catalog,__ATOMIC_ACQUIRE);}
struct Image55 {uint32_t format,width,height,stride;uintptr_t pixels;};
static_assert(sizeof(Image55)==24,"native ImageRGB layout");
struct Rect55 {uintptr_t vptr;int32_t x,y,width,height;};
static_assert(sizeof(Rect55)==24,"native Rectangle layout");
static int degrees(uint32_t orientation,uint32_t*out){
 switch(orientation){case 1:*out=0;return 1;case 3:*out=180;return 1;
 case 6:*out=90;return 1;case 8:*out=270;return 1;default:return 0;}
}
#ifdef IQ4_JPEG_GALLERY_TEST
extern "C" uintptr_t iq4_gallery_test_call_55(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t);
#endif
static uintptr_t call(uintptr_t f,uintptr_t a=0,uintptr_t b=0,uintptr_t c=0,
 uintptr_t d=0,uintptr_t e=0,uintptr_t g=0,uintptr_t h=0){
#ifdef IQ4_JPEG_GALLERY_TEST
 return iq4_gallery_test_call_55(f,a,b,c,d,e,g,h);
#else
 return ((uintptr_t(*)(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t))f)(a,b,c,d,e,g,h);
#endif
}
static int rd(uintptr_t p,void*out,size_t n){return p>=4096&&n&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(nullptr,p,out,n)==1;}
template<class T>static int stable(uintptr_t p,T*out){T second;return rd(p,out,sizeof(T))&&rd(p,&second,sizeof(T))&&!memcmp(out,&second,sizeof(T));}
template<class T>static void put(uintptr_t p,T v){memcpy((void*)p,&v,sizeof v);}
class Lock55 {alignas(8) unsigned char value[32];bool owns;public:
 explicit Lock55(uintptr_t mutex):value{},owns(false){call(0x411bc0,(uintptr_t)value,mutex);owns=true;}
 ~Lock55(){if(owns)try{call(0x411bf4,(uintptr_t)value);}catch(...){setHeld();}}
};
class Lease55 {uint32_t card;bool owns;public:
 explicit Lease55(uint32_t c):card(c),owns(false){int rc=iq4_stock_jpeg_gallery_card_enter_55(c);owns=rc==1;if(rc<0)setHeld();}
 ~Lease55(){if(owns&&iq4_stock_jpeg_gallery_card_leave_55(card)!=1)setHeld();}
 bool good()const{return owns&&!getHeld()&&iq4_stock_jpeg_gallery_card_guard_55(card)==1;}
};
static int name13(uintptr_t p,char out[13]){
 if(!rd(p,out,13))return 0;unsigned n=0;while(n<13&&out[n]){
  const unsigned char c=(unsigned char)out[n];if(c<'!'||c>126||c=='/'||c=='\\')return 0;++n;
 }return n>4&&n<13;
}
static int jpeg_name(const char*s){unsigned n=0;while(n<13&&s[n])++n;return n>4&&n<13&&!memcmp(s+n-4,".JPG",5);}
static int to_jpeg(const char*s,char out[13]){
 memcpy(out,s,13);unsigned n=0;while(n<13&&out[n])++n;
 if(n<=4||n>=13||memcmp(out+n-4,".IIQ",5))return 0;memcpy(out+n-4,".JPG",5);return 1;
}
static int catalog_shape(uintptr_t cat,uintptr_t*map=nullptr,uint32_t*count=nullptr){
 uintptr_t vt,ifm,back,vec;uint32_t n,max;
 if(!stable(cat,&vt)||vt!=0xb7ece0||!stable(cat+0x328,&ifm)||
    !stable(ifm,&vt)||vt!=0xb7f960||!stable(ifm+0xfa8,&back)||back!=cat||
    !stable(cat+0x1a8,&max)||!max||max>65535||!stable(cat+0x1b8,&n)||n>max||
    !stable(cat+0x1b0,&vec)||!vec||call(0x48f4bc,vec)<n)return 0;
 if(map)*map=vec;if(count)*count=n;return 1;
}
static uintptr_t record(uintptr_t cat,uint32_t index,uintptr_t node=0){
 uintptr_t vec,p,actual;uint32_t count;
 if(!catalog_shape(cat,&vec,&count)||index>=count)return 0;
 p=call(0x48f4f0,vec,index);if(!p||!stable(p+0x20,&actual)||(node&&actual!=node))return 0;
 return p;
}
static int card_fs(uintptr_t cat,uint32_t card,uintptr_t*fs,uintptr_t*relative){
 uintptr_t p,vt,path;char root[32];const char*expected=card==11?"/run/media/xqdcard/":"/run/media/sdcard/";
 if((card!=10&&card!=11)||!stable(cat+(card==11?0x7d0:0x7a0),&p)||
    !stable(p,&vt)||vt!=0xd91450||!rd(p+0x15,root,sizeof root)||
    memcmp(root,expected,strlen(expected)+1)||!stable(cat+(card==11?0x7e0:0x7b0),&path))return 0;
 *fs=p;if(relative)*relative=path;return 1;
}
static int resolved(uintptr_t cat,uint32_t card,const char*name,char out[260]){
 uintptr_t fs,dir;char relative[260],directory[220];
 if(!card_fs(cat,card,&fs,&dir)||!rd(dir,directory,sizeof directory)||!memchr(directory,0,sizeof directory))return 0;
 size_t dn=strlen(directory),nn=strlen(name);if(dn+nn+2>sizeof relative)return 0;
 memcpy(relative,directory,dn);relative[dn]='/';memcpy(relative+dn+1,name,nn+1);
 /* Resolve through the original FS current directory. No guessed DCIM path. */
 memset(out,0,260);if(call(0x827348,fs,(uintptr_t)relative,(uintptr_t)out)!=1)return 0;
 const char*root=card==11?"/run/media/xqdcard/":"/run/media/sdcard/";
 return !memcmp(out,root,strlen(root))&&memchr(out,0,260)&&strstr(out,"/DCIM/")&&strstr(out,".JPG");
}
static Entry55*find(uintptr_t cat,const char*name,uintptr_t node=0){
 for(auto&e:entries)if(e.state&&e.catalog==cat&&!memcmp(e.name,name,13)&&(!node||!e.node||e.node==node))return &e;
 return nullptr;
}
static Entry55*vacant(){for(auto&e:entries)if(!e.state)return &e;return nullptr;}
struct Guard55 {uintptr_t cat,node,rec,cancel;uint32_t card,index;char name[13],path[260];bool preparing;};
/* Caller explicitly owns cat+1c0.  No I/O/card wait occurs under this lock. */
static int guard_locked55(void*v){
 auto*g=(Guard55*)v;uint32_t index;char name[13];uintptr_t p;uint8_t flags;
 uint8_t stopped=0;
 if(getHeld()||(g->cancel&&(!stable(g->cancel,&stopped)||stopped))||
    !stable(g->node+0xd8,&index)||index!=g->index||
    !(p=record(g->cat,index,g->node))||p!=g->rec||!name13(p,name)||
    memcmp(name,g->name,13)||!stable(p+0xe,&flags)||
    (g->preparing?!(flags&6):((flags&6)||!(flags&16))))return 0;
 return 1;
}
static int guard55(void*v){
 auto*g=(Guard55*)v;char path[260];
 if(getHeld()||iq4_stock_jpeg_gallery_card_guard_55(g->card)!=1)return 0;
 /* Preparing uses a distinct real .JPG name, while the native record is IIQ. */
 if(g->preparing){char jpg[13];if(!to_jpeg(g->name,jpg)||!resolved(g->cat,g->card,jpg,path))return 0;}
 else if(!resolved(g->cat,g->card,g->name,path))return 0;
 if(memcmp(path,g->path,260))return 0;
 try{Lock55 lock(g->cat+0x1c0);return guard_locked55(v);}catch(...){setHeld();return 0;}
}
static int snapshot(uintptr_t cat,uintptr_t node,Guard55*g,Entry55*out){
 uint32_t index;uintptr_t p;char name[13];uint8_t flags;uint16_t attr;
 if(!stable(node+0xd8,&index)||!(p=record(cat,index,node))||!name13(p,name)||!jpeg_name(name)||
    !stable(p+0xe,&flags)||(flags&6)||!(flags&16)||!stable(p+0x10,&attr)||(attr&1))return 0;
 auto*e=find(cat,name,node);if(!e||e->state!=1)return 0;if(!e->node)e->node=node;*out=*e;out->node=node;
 *g={};g->cat=cat;g->node=node;g->rec=p;g->card=e->card;g->index=index;
 memcpy(g->name,name,13);memcpy(g->path,e->path,260);return 1;
}
extern "C" int iq4_stock_jpeg_gallery_is_photo_55(uintptr_t cat,uintptr_t node){
 if(getHeld()||cat!=catalog55())return 0;try{Lock55 lock(cat+0x1c0);Guard55 g;Entry55 e;return snapshot(cat,node,&g,&e);}catch(...){setHeld();return 0;}
}
static int pool_image(uintptr_t descriptor,size_t capacity,Image55*out){
 uint32_t actual;uintptr_t owner_buffer;
 if(descriptor<0x20||!stable(descriptor,out)||out->format!=0||!out->pixels||
    !stable(descriptor+0x18,&actual)||actual!=capacity||
    !stable(descriptor+0x20,&owner_buffer)||owner_buffer!=out->pixels||
    capacity<3||capacity>32u*1024u*1024u)return 0;
 /* Capacity is from the actual native pool/request, never JPEG dimensions. */
 return out->pixels<=UINTPTR_MAX-capacity;
}
static int decode_image(Guard55*,uintptr_t,size_t,uint32_t,uint32_t,const int32_t*,Iq4JpegDecodeResult55*,uint32_t=0);
static int thumbnail(Guard55*g,uintptr_t node){
 alignas(8) uintptr_t handle[2]={};bool initialized=false;int good=0;
 try{call(0x48dce8,(uintptr_t)handle,node);initialized=true;
  uintptr_t pool=call(0x48dd9c,(uintptr_t)handle),vt;uint32_t capacity;
  if(pool&&stable(pool,&vt)&&vt==0xdb5500&&stable(pool+0x38,&capacity)&&capacity==160000){
   Iq4JpegDecodeResult55 image={};good=decode_image(g,pool+0x20,capacity,180,180,nullptr,&image);
   if(good){float scale=(float)image.source_width/image.width;memcpy((void*)(pool+0x48),&scale,4);put<uint8_t>(pool+8,1);}
  }
  call(0x48dd4c,(uintptr_t)handle);initialized=false;
 }catch(...){setHeld();if(initialized)try{call(0x48dd4c,(uintptr_t)handle);}catch(...){setHeld();}return 0;}
 return good;
}
extern "C" int iq4_stock_jpeg_gallery_metadata_55(uintptr_t cat,uintptr_t node,uint32_t){
 if(getHeld()||cat!=catalog55())return -2;
 try{Guard55 g;Entry55 e;{Lock55 lock(cat+0x1c0);if(!snapshot(cat,node,&g,&e))return -2;}
  Lease55 lease(e.card);if(!lease.good())return 0;
  Iq4JpegDecodeResult55 meta={};int rc=iq4_stock_jpeg_probe_file_55(g.path,guard55,&g,&meta);
  uint32_t angle;
  if(rc< -1)setHeld();if(rc!=1||!degrees(meta.source_orientation,&angle)||!guard55(&g)||!thumbnail(&g,node))return 0;
  {Lock55 lock(cat+0x1c0);if(!guard_locked55(&g))return 0;
   memcpy((void*)(node+0x25),e.name,13);put<uint32_t>(node+0x38,meta.source_width);
   put<uint32_t>(node+0x3c,meta.source_height);put<uint32_t>(node+0x70,angle);
   /* Unknown EXIF stays at the factory node defaults. No RAW metadata is
    * fabricated for a JPEG file. Its true image dimensions drive the LCD. */
   put<uint8_t>(node+0x24,1);
  }
  uintptr_t ifm;if(stable(cat+0x328,&ifm))call(0x70f2f8,ifm+0x6c0);return 1;
 }catch(...){setHeld();return 0;}
}
static int gray_image(Guard55*g,uintptr_t descriptor,uintptr_t rgb_descriptor,
 uint32_t width,uint32_t height){
 Image55 gray,rgb;uint32_t capacity;uintptr_t allocated;
 uintptr_t pool=rgb_descriptor-0x20;
 if(descriptor!=pool+0x70||!stable(0xf62208,&capacity)||!capacity||
    !stable(pool+0x88,&allocated)||!stable(descriptor,&gray)||gray.format!=9||
    !gray.pixels||gray.pixels!=allocated||(uint64_t)width*height>capacity||
    !stable(rgb_descriptor,&rgb)||rgb.width!=width||rgb.height!=height||rgb.stride<width*3)return 0;
 for(uint32_t y=0;y<height;++y){if(!guard55(g))return 0;for(uint32_t x=0;x<width;++x){
  const uint8_t*p=(const uint8_t*)(rgb.pixels+(size_t)y*rgb.stride+3u*x);
  ((uint8_t*)gray.pixels)[(size_t)y*width+x]=(uint8_t)((77u*p[0]+150u*p[1]+29u*p[2]+128u)>>8);
 }}
 gray.width=width;gray.height=height;gray.stride=width;
 memcpy((void*)descriptor,&gray,sizeof gray);return 1;
}
static uintptr_t enqueue(uintptr_t queue,uintptr_t request,bool final){
 const uintptr_t original=final?0x48fff8:0x490288;
 uintptr_t node=0,image=0,cancel=0,context=0;uint32_t capacity=0,maxw=0,maxh=0;Guard55 g;Entry55 e;
 const unsigned node_off=final?0x58:0x50,cap_off=0x2c,image_off=final?0x48:0x40;
 if(!stable(request+node_off,&node)||!node||!catalog55())return call(original,queue,request);
 try{bool owned;{Lock55 lock(catalog55()+0x1c0);owned=snapshot(catalog55(),node,&g,&e);}
  if(!owned)return call(original,queue,request);
  /* An owned JPEG always produces a terminal native reply, even on error.
   * Never put it into a RAW worker whose reader rejects JPEG file magic. */
  uint8_t success=0;
  if(stable(catalog55()+0x4d0,&context)&&queue==context+(final?8:0x3b8)&&
     stable(request+cap_off,&capacity)&&stable(request+image_off,&image)&&
     stable(request+(final?0x60:0x58),&cancel)&&cancel==context+0x788&&
     stable(request+(final?0x68:0x7c),&maxw)&&stable(request+(final?0x6c:0x80),&maxh)){
   Lease55 lease(e.card);uint8_t stopped=1;int32_t crop[4];uint32_t angle=0;
   g.cancel=cancel;
   bool valid=true;
   if(final){Rect55 input={};float requested=0;uint32_t actual=0;
    valid=stable(request+8,&input)&&input.vptr==0xb73b98&&
      stable(request+0x24,&requested)&&degrees(e.orientation,&actual)&&
      (requested==0.0f||requested==(float)actual||(actual==270&&requested==-90.0f));
    if(valid){angle=requested==0.0f?0:actual;Iq4JpegGalleryRoi55 source={},display={};
     display={(uint32_t)input.x,(uint32_t)input.y,(uint32_t)input.width,(uint32_t)input.height};
     valid=input.x>=0&&input.y>=0&&input.width>0&&input.height>0&&
       iq4_jpeg_gallery_inverse_roi_55(e.width,e.height,angle,&display,&source)==1;
     Rect55 output={0xb73b98,(int32_t)source.x,(int32_t)source.y,(int32_t)source.width,(int32_t)source.height};
     crop[0]=output.x;crop[1]=output.y;crop[2]=output.width;crop[3]=output.height;
    }
   }
   if(valid&&lease.good()&&stable(cancel,&stopped)&&!stopped){
    Iq4JpegDecodeResult55 result={};
    if(decode_image(&g,image,capacity,maxw,maxh,final?crop:nullptr,&result,angle)){
     uintptr_t gray;
     if(final||(stable(request+0x48,&gray)&&gray_image(&g,gray,image,result.width,result.height))){
      if(!final){put<uint32_t>(request+0x18,result.source_width);put<uint32_t>(request+0x1c,result.source_height);
       const float one=1.0f;memcpy((void*)(request+0x6c),&one,4);memcpy((void*)(request+0x70),&one,4);memcpy((void*)(request+0x74),&one,4);put<uint8_t>(request+0x78,0);}
      success=1;
     }
    }
   }
  }
  put<uint8_t>(request,success);
  if(!context){setHeld();return 0;}return call(original,context+(final?0x1e0:0x5a0),request);
 }catch(...){setHeld();return 0;}
}
extern "C" uintptr_t iq4_stock_jpeg_gallery_preview_enqueue_55(uintptr_t queue,uintptr_t request){return enqueue(queue,request,false);}
extern "C" uintptr_t iq4_stock_jpeg_gallery_final_enqueue_55(uintptr_t queue,uintptr_t request){return enqueue(queue,request,true);}
static int decode_image(Guard55*g,uintptr_t descriptor,size_t capacity,
 uint32_t maxw,uint32_t maxh,const int32_t*crop,Iq4JpegDecodeResult55*out,uint32_t angle){
 Image55 image;if(!pool_image(descriptor,capacity,&image)||!maxw||!maxh||maxw>3840||maxh>3840)return 0;
 if(angle!=0&&angle!=90&&angle!=180&&angle!=270)return 0;
 if(angle==90||angle==270){uint32_t swap=maxw;maxw=maxh;maxh=swap;}
 uint32_t stride=maxw*3;if((size_t)stride*maxh>capacity){maxh=(uint32_t)(capacity/stride);if(!maxh)return 0;}
 int rc=crop?iq4_stock_jpeg_decode_crop_file_55(g->path,crop[0],crop[1],crop[2],crop[3],
   (uint8_t*)image.pixels,capacity,stride,maxw,maxh,guard55,g,out):
   iq4_stock_jpeg_decode_file_55(g->path,(uint8_t*)image.pixels,capacity,stride,maxw,maxh,guard55,g,out);
 if(rc< -1)setHeld();if(rc!=1||!guard55(g))return 0;
 if(angle){
  const uint32_t w=out->width,h=out->height,dw=(angle==180?w:h),dh=(angle==180?h:w);
  const size_t bytes=(size_t)dw*dh*3;if(bytes>capacity||bytes>32u*1024u*1024u)return 0;
  /* Only the already IDCT-reduced LCD image is transposed.  No source-sized
   * RGB allocation is made, including when a 37MP JPEG is being zoomed. */
  uint8_t*scratch=nullptr;try{scratch=new uint8_t[bytes];}catch(...){return 0;}
  bool good=iq4_jpeg_gallery_rotate_rgb_55((const uint8_t*)image.pixels,capacity,stride,w,h,angle,scratch,bytes,guard55,g)==1;
  for(uint32_t y=0;y<dh&&good;++y){if(!guard55(g)){good=false;break;}
   memcpy((void*)(image.pixels+(size_t)y*dw*3),scratch+(size_t)y*dw*3,(size_t)dw*3);
  }
  delete[]scratch;if(!good)return 0;out->width=dw;out->height=dh;stride=dw*3;
 }
 image.format=0;image.width=out->width;image.height=out->height;image.stride=stride;
 memcpy((void*)descriptor,&image,sizeof image);return 1;
}
extern "C" int iq4_stock_jpeg_gallery_prepare_retire_55(uintptr_t cat,uintptr_t node,uint32_t index,uint32_t card){
 if(!iq4_stock_jpeg_only_gallery_bound_55()||cat!=catalog55())return 0;
 try{Lease55 lease(card);if(!lease.good())return getHeld()?-1:0;
  char raw[13],jpg[13],path[260];Guard55 g={};
  {Lock55 lock(cat+0x1c0);uintptr_t p=record(cat,index,node);uint8_t flags;
   if(!p||!name13(p,raw)||!to_jpeg(raw,jpg)||!stable(p+0xe,&flags)||!(flags&6))return 0;
   g.cat=cat;g.node=node;g.rec=p;g.index=index;g.card=card;g.preparing=true;
   memcpy(g.name,raw,13);
  }
  if(!resolved(cat,card,jpg,path))return 0;memcpy(g.path,path,260);
  /* Complete the real on-card entropy stream before any RAW inode is retired.
   * A private 180x180 display scratch never touches an existing RAW thumbnail
   * or allocates a source-sized RGB image.  File and row guards take the
   * catalog mutex only briefly; no mutex spans decoding or native RAW clear. */
  Iq4JpegDecodeResult55 meta={};uint8_t*scratch=nullptr;
  try{scratch=new uint8_t[180u*180u*3u];}catch(...){return 0;}
  int rc=iq4_stock_jpeg_decode_file_55(path,scratch,180u*180u*3u,180u*3u,
    180,180,guard55,&g,&meta);delete[]scratch;
  if(rc< -1){setHeld();return -1;}
  uint32_t angle;if(rc!=1||!meta.width||!meta.height||meta.rows!=meta.height||
    !degrees(meta.source_orientation,&angle)||!guard55(&g))return 0;
  Lock55 lock(cat+0x1c0);if(!guard_locked55(&g))return 0;
  Entry55*e=find(cat,jpg,node);if(e&&(e->node!=node||e->card!=card||memcmp(e->raw_name,raw,13)))return 0;
  if(!e)e=vacant();if(!e)return 0;
  Entry55 prepared={};prepared.catalog=cat;prepared.node=node;prepared.card=card;prepared.state=2;
  prepared.width=meta.source_width;prepared.height=meta.source_height;prepared.orientation=meta.source_orientation;
  memcpy(prepared.name,jpg,13);memcpy(prepared.raw_name,raw,13);memcpy(prepared.path,path,260);*e=prepared;return 1;
 }catch(...){setHeld();return -1;}
}
extern "C" int iq4_stock_jpeg_gallery_commit_retire_55(uintptr_t cat,uintptr_t node,uint32_t index,uint32_t card){
 if(getHeld()||cat!=catalog55())return -1;
 try{Lock55 lock(cat+0x1c0);uintptr_t p=record(cat,index,node);char raw[13],jpg[13];uint8_t flags;uint16_t attr;
  if(!p||!name13(p,raw)||!to_jpeg(raw,jpg)||!stable(p+0xe,&flags)||(flags&6)||!stable(p+0x10,&attr))return -1;
  Entry55*e=find(cat,jpg,node);if(!e||e->state!=2||e->node!=node||e->card!=card||memcmp(e->raw_name,raw,13))return -1;
  uint32_t angle;if(!degrees(e->orientation,&angle))return -1;
  /* No file I/O/fallible decoding follows this exact ownership check. The
   * primary published JPEG replaces this retired RAW photo's native name. */
  memcpy((void*)p,e->name,13);put<uint8_t>(p+0xe,16);put<uint16_t>(p+0x10,(uint16_t)(attr&~1u));
  memcpy((void*)(node+0x25),e->name,13);put<uint32_t>(node+0x38,e->width);put<uint32_t>(node+0x3c,e->height);
  put<uint32_t>(node+0x70,angle);
  call(0x48da14,node);call(0x48d9e4,node);
  put<uint8_t>(node+0x24,0);e->state=1;return 1;
 }catch(...){setHeld();return -1;}
}
static int scan_guard(void*v){uint32_t card=*(uint32_t*)v;return !getHeld()&&iq4_stock_jpeg_gallery_card_guard_55(card)==1;}
static int insert_jpeg(uintptr_t cat,uint32_t card,const char*name,
 uintptr_t file_entry){
 uintptr_t map,p;uint32_t count,max;char path[260];
 if(!resolved(cat,card,name,path))return 0;
 /* File probing never holds the native catalog mutex. */
 Iq4JpegDecodeResult55 meta={};int rc=iq4_stock_jpeg_probe_file_55(path,scan_guard,&card,&meta);
 uint32_t angle;if(rc< -1){setHeld();return 0;}if(rc!=1||!degrees(meta.source_orientation,&angle)||!scan_guard(&card))return 0;
 Lock55 lock(cat+0x1c0);
 if(!catalog_shape(cat,&map,&count)||!stable(cat+0x1a8,&max))return 0;
 /* Preserve any original RAW+JPEG record.  Its renderer, metadata and
  * native filename/flags remain entirely original. */
 char raw[13];memcpy(raw,name,13);size_t n=strlen(raw);memcpy(raw+n-4,".IIQ",5);
 for(uint32_t i=0;i<count;++i){char existing[13];uint8_t flags;
  p=call(0x48f4f0,map,i);if(!name13(p,existing)||!stable(p+0xe,&flags))return 0;
  if(!memcmp(existing,raw,13)&&(flags&6))return 1;
  if(!memcmp(existing,name,13)){
   Entry55*e=find(cat,name);if(!e||e->card!=card||memcmp(e->path,path,260))return 0;
   put<uint8_t>(p+0xe,(uint8_t)(flags|16));return 1;
  }
 }
 Entry55*e=vacant();uint16_t attributes;uintptr_t node;
 if(!e||count>=max||count>=call(0x48f4bc,map))return 0;
 p=call(0x48f4f0,map,count);if(!p||!stable(p+0x10,&attributes)||attributes||
    !stable(p+0x20,&node)||node)return 0;
 /* Only a verified real JPEG can become a genuine new catalog record. */
 Entry55 next={};next.catalog=cat;next.card=card;next.state=1;
 next.width=meta.source_width;next.height=meta.source_height;next.orientation=meta.source_orientation;
 memcpy(next.name,name,13);memcpy(next.path,path,260);
 uint32_t timestamp=(uint32_t)call(0x709be4,file_entry+0x110);
 uint32_t creation=(uint32_t)call(0x49037c,cat+0x4e0,0);
 /* Native's unused tail slot is already zeroed, so preserve unknown fields.
  * Keep the stock 0x20 attribute; bit0 is the native prune eligibility mask
  * (487990/48aef4), which must be unset for a real JPEG-only record. */
 memcpy((void*)p,name,13);put<uint8_t>(p+0xe,16);put<uint16_t>(p+0x10,0x20);
 put<uint32_t>(p+0x14,timestamp);put<uint32_t>(p+0x18,creation);*e=next;
 call(0x48ae68,cat,count+1);return 2;
}
static int scan_card(uintptr_t cat,uint32_t card){
 Lease55 lease(card);if(!lease.good())return 0;
 uintptr_t fs,dir,vt;char directory[220],wildcard[260];
 if(!card_fs(cat,card,&fs,&dir)||!rd(dir,directory,sizeof directory)||!memchr(directory,0,sizeof directory)||
    !stable(fs,&vt)||vt!=0xd91450)return 0;
 size_t n=strlen(directory);if(n+5>sizeof wildcard)return 0;
 memcpy(wildcard,directory,n);memcpy(wildcard+n,"/*.*",5);
 alignas(8) unsigned char file[0x150]={};bool constructed=false,search=false;int added=0;
 try{call(0x48df80,(uintptr_t)file);constructed=true;
  search=true;int next=(int)call(0x826010,fs,(uintptr_t)wildcard,(uintptr_t)file);
  for(unsigned visits=0;next==1&&visits<65536&&lease.good();++visits){
   char name[13];uint8_t isdir=file[0x108];uint32_t bytes;memcpy(&bytes,file+0x104,4);
   if(!isdir&&bytes>64&&name13((uintptr_t)file,name)&&jpeg_name(name)){
    int rc=insert_jpeg(cat,card,name,(uintptr_t)file);if(rc==2)++added;
   }
   next=(int)call(0x826080,fs,(uintptr_t)file);
  }
  call(0x826388,fs,(uintptr_t)file);search=false;
  call(0x48f36c,(uintptr_t)file);constructed=false;
  if(added){Lock55 lock(cat+0x1c0);call(0x48b828,cat);} /* native sort updates real node indices */
 }catch(...){setHeld();if(search)try{call(0x826388,fs,(uintptr_t)file);}catch(...){setHeld();}
  if(constructed)try{call(0x48f36c,(uintptr_t)file);}catch(...){setHeld();}return -1;
 }
 return added;
}
static int pins55(){
 unsigned char data[64];for(const auto&p:JpegGalleryPins55)for(size_t off=0;off<p.bytes;off+=sizeof data){
  size_t n=p.bytes-off;if(n>sizeof data)n=sizeof data;
  if(!rd(p.va+off,data,n)||memcmp(data,p.data+off,n))return 0;
 }
#ifndef IQ4_JPEG_GALLERY_TEST
 for(const auto&p:JpegGalleryHookPins55){uint32_t opcode;int64_t delta=(int64_t)p.target-(int64_t)p.va;
  if((delta&3)||delta<-(INT64_C(1)<<27)||delta>=(INT64_C(1)<<27)||
     !stable(p.va,&opcode)||opcode!=(p.opcode|((uint32_t)(delta>>2)&0x3ffffff)))return 0;
 }
#endif
 return iq4_stock_jpeg_decoder_bound_55()==1;
}
extern "C" int iq4_stock_jpeg_gallery_bind_55(uintptr_t cat){
 if(getHeld()||!pins55())return 0;
 try{Lock55 lock(cat+0x1c0);if(!catalog_shape(cat))return 0;
  if(catalog55()&&catalog55()!=cat)return 0;__atomic_store_n(&bound_catalog,cat,__ATOMIC_RELEASE);
 }catch(...){setHeld();return 0;}
 /* XQD is preferred when two cards contain the exact same JPEG basename.
  * An SD-only camera retains a genuine SD JPEG record with card 10. */
 scan_card(cat,11);if(!getHeld())scan_card(cat,10);return !getHeld();
}
extern "C" int iq4_stock_jpeg_only_gallery_bound_55(void){
 uintptr_t cat=__atomic_load_n(&bound_catalog,__ATOMIC_ACQUIRE);
 if(getHeld()||!cat||!pins55())return 0;
 try{Lock55 lock(cat+0x1c0);return catalog_shape(cat);}catch(...){setHeld();return 0;}
}
extern "C" uintptr_t iq4_stock_jpeg_gallery_card_refresh_55(uintptr_t cat){
 if(cat==catalog55()&&!getHeld()){scan_card(cat,11);if(!getHeld())scan_card(cat,10);}
 return call(0x487ab8,cat);
}
