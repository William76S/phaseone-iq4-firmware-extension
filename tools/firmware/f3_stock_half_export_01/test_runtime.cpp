#include "../f3_stock_jpeg_xqd_01/stock.h"
#include "../f3_stock_jpeg_xqd_01/settings.h"
#include "half.h"
#include "half_settings.h"
#include "quality.h"
#include "../f3_native_half_01/half.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <vector>
#include <stdexcept>
struct Range{uintptr_t a;size_t n;};struct Seg{uintptr_t va;size_t n,off;};
static std::vector<Range>ranges;static std::vector<Seg>segments;static std::vector<unsigned char>image;
static uintptr_t task,group[2],power[2],fs[2],ifm,encoder,sp,array,catalog,processing_worker,node,map_entry,cancel;
static uint64_t tid=77;static const char*scenario;static unsigned stock_encodes,half_encodes,wait_timeout,half_save_fail;static Iq4HalfScope01 saved_scope;static Iq4HalfLease01 saved_lease;static Iq4StockHalfSettings half_saved={0,65,1};static unsigned catalog_flags=20,catalog_scans;static int present[2]={0,1};static unsigned mode,size_mode,published,stored;static int publish_result=1,retain,throws;static Iq4StockJpegSettings saved={0,65,1};
static uintptr_t alloc(size_t n){void*p=calloc(1,n);assert(p);ranges.push_back({(uintptr_t)p,n});return(uintptr_t)p;}
static void put(uintptr_t p,uintptr_t v,size_t n=8){memcpy((void*)p,&v,n);}static uintptr_t get(uintptr_t p,size_t n=8){uintptr_t v=0;memcpy(&v,(void*)p,n);return v;}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){for(auto s:segments)if(p>=s.va&&p+n<=s.va+s.n){memcpy(out,image.data()+s.off+p-s.va,n);if(p==0xf55e18&&n==32)memcpy((char*)out+16,fs,8);if(p==0xf55e38&&n==32)memcpy((char*)out+16,fs+1,8);return 1;}for(auto r:ranges)if(p>=r.a&&p+n<=r.a+r.n){memcpy(out,(void*)p,n);return 1;}return 0;}
extern "C" uint64_t iq4_native_current_tid_01(void){return tid;}
extern "C" Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_load_01(Iq4StockJpegSettings*out){*out=saved;return IQ4_STOCK_JPEG_SETTINGS_OK;}
extern "C" Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_save_01(const Iq4StockJpegSettings*in){saved=*in;return IQ4_STOCK_JPEG_SETTINGS_OK;}
extern "C" int iq4_stock_jpeg_probe_mount_01(const char*,int(*guard)(void)){return guard();}
extern "C" int iq4_stock_jpeg_publish_01(const char*root,const char*name,const void*p,uint32_t n,int(*guard)(void)){assert(!strcmp(root,iq4_stock_jpeg_destination_get_01()==11?"/run/media/xqdcard/":"/run/media/sdcard/"));assert(!strcmp(name,"DCIM/100PHASE/IMG0001.JPG"));assert(n==24&&((const unsigned char*)p)[0]==255&&guard()==1);++published;return publish_result;}

extern "C" Iq4StockHalfSettingsResult iq4_stock_half_settings_load_01(Iq4StockHalfSettings*out){*out=half_saved;return IQ4_STOCK_HALF_SETTINGS_OK;}
extern "C" Iq4StockHalfSettingsResult iq4_stock_half_settings_save_01(const Iq4StockHalfSettings*in){if(half_save_fail)return IQ4_STOCK_HALF_SETTINGS_IO;half_saved=*in;return IQ4_STOCK_HALF_SETTINGS_OK;}
extern "C" Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t*,Iq4Jpeg82ReadExact01,void*,Iq4JpegApi*out){*out={};out->api_version=82;out->compressor_struct_bytes=584;out->binding_abi_verified=1;return IQ4_JPEG82_BOUND_STATIC_ABI_01;}
extern "C" Iq4HalfJpegStatus01 iq4_half_jpeg_encode_01(const Iq4JpegApi*a,const Iq4HalfArgb01*p,uint8_t*out,size_t capacity,int quality,int(*guard)(void*),void*ctx,Iq4HalfJpegResult01*r){
 assert(a->binding_abi_verified&&p->width==7102&&p->height==5326&&p->format==5&&quality==100&&capacity==104857600&&guard(ctx)==1);++half_encodes;*r={};
 if(!strcmp(scenario,"encode_failure")){r->status=IQ4_HALF_JPEG_CAPACITY_01;return r->status;}
 memset(out,0,24);out[0]=255;out[1]=216;out[22]=255;out[23]=217;r->status=IQ4_HALF_JPEG_OK_01;r->rows=5326;r->jpeg_bytes=24;r->destroy_calls=1;return r->status;
}
extern "C" uintptr_t iq4_stock_half_ifm_wait_02(uintptr_t,uint32_t,uintptr_t);
extern "C" uintptr_t iq4_stock_jpeg_test_call(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t c,uintptr_t d,uintptr_t e,uintptr_t f,uintptr_t g){
 if(pc==0x8e0928){assert(a==task&&b==group[0]&&c==ifm&&d==power[0]&&e==power[1]&&f==fs[0]);put(task,0xdbce40);put(task+0x1b0,fs[0]);put(task+0x1b8,16,4);put(task+0x1c8,b);put(task+0x1d0,c);put(task+0x1d8,d);put(task+0x1e0,e);put(task+0x1e8,0,4);put(task+0x1ec,0,4);put(task+0x1f0,encoder);put(power[0]+0x70,0xdbc878);put(power[1]+0x70,0xdbc878);return 0;}
 if(pc==0x74e454){assert(b==11&&c==1);return fs[1];}
 if(pc==0x8ca3ec){assert(a==power[1]&&get(power[1]+0x78)==0);put(power[1]+0x78,b);return 1;}
 if(pc==0x8ca888){unsigned i=a==power[1];assert(a==power[i]&&b==(i?1u:0u)&&c==6000);put(a+0x17c,get(a+0x17c,4)|(1u<<b),4);put(a+0x320,1,4);return 0;}
 if(pc==0x8ca708){assert(a==power[0]||a==power[1]);put(a+0x17c,get(a+0x17c,4)&~(1u<<b),4);return 1;}
 if(pc==0x411bc0){assert(b==catalog+0x1c0);return 0;}if(pc==0x411bf4)return 0;
 if(pc==0x493994){assert(a==catalog&&b==16);catalog_flags&=~16u;return 0;}
 if(pc==0x493598){assert(a==catalog&&b==0xb7e920&&c==1024&&d==16);++catalog_scans;return 0;}
 if(pc==0x5e8c20){assert(a==group[0]+0xe8);return mode;}if(pc==0x5e8c54){assert(a==group[0]+0xe8&&b<=2);mode=(unsigned)b;return 0;}
 if(pc==0x5e7350){assert(a==group[0]+0x2a8);return size_mode;}if(pc==0x5e7384){assert(a==group[0]+0x2a8&&b<=1);size_mode=(unsigned)b;return 0;}
 if(pc==0x41497c){/* SD absent is intentional: selected XQD preflight must work. */assert(a==group[0]+0x468||a==group[1]+0x468);return present[a==group[1]+0x468];}
 if(pc==0x525034){assert(a==group[1]+0xdc8);return 1024*1024*1024;}
 if(pc==0x48f4f0){assert(a==catalog+0x100&&b==1);return map_entry;}
 if(pc==0x713a18){assert(a==task&&c==0x55);wait_timeout=(unsigned)b;return 1;}
 if(pc==0x98d8a8){assert(a==encoder&&b&&c==4000&&d==3000&&e==100&&f==task+0x1f8&&g==104857600);++stock_encodes;unsigned char*p=(unsigned char*)f;memset(p,0,24);p[0]=255;p[1]=216;p[22]=255;p[23]=217;return 24;}
 if(pc==0x827348){assert(a==fs[1]);strcpy((char*)c,(char*)(fs[1]+0x15));strcat((char*)c,(char*)b);return 1;}
 if(pc==0x8e1f7c){assert(a==task&&!strcmp((char*)b,"IMG0001"));strcpy((char*)(task+0x64001f8),"DCIM/100PHASE/IMG0001.JPG");return 1;}
 if(pc==0x8e17c8||pc==0x8e1264){assert(a==task&&b==1&&get(task+0x1b0)==fs[1]&&get(task+0x1d8)==power[1]&&get(task+0x1e8,4)==1);assert(iq4_stock_jpeg_presence_01(group[0]+0x468)==1&&iq4_stock_jpeg_free_space_01(group[0]+0xdc8)>1048575);
  put(power[1]+0x17c,3,4);put(power[1]+0x320,1,4);if(throws)throw std::runtime_error("native worker unwind fixture");

  assert(iq4_stock_half_ifm_wait_02(task,10000,0x55)==1);
  bool half=strcmp(scenario,"4k");
  if(half){
   Iq4HalfScope01 scope={processing_worker,processing_worker+0x2d8,processing_worker+UINT64_C(0x65547968),sp+0x100,processing_worker+0x2c0,cancel,node,1,14204,10652};
   if(!strcmp(scenario,"mismatch"))scope.node+=16;
   Iq4HalfLease01 lease={};tid=99;int acquired=iq4_stock_half_acquire_01(&scope,&lease);
   if(!strcmp(scenario,"mismatch"))assert(!acquired);
   else{
    assert(acquired==1&&lease.guard(lease.context,&scope)==1);saved_scope=scope;saved_lease=lease;
    if(!strcmp(scenario,"timeout")){tid=77;return 2;}
    Iq4HalfArgb01 plane={(const uint8_t*)0x100000,151343616,28416,7102,5326,5};
    Iq4HalfRenderReceipt01 receipt={};receipt.status=IQ4_HALF_RENDER_OK_01;receipt.entered=1;receipt.stages=3;receipt.joins=3;receipt.terminal=1;receipt.render_returned=1;receipt.width=7102;receipt.height=5326;receipt.stride=28416;receipt.format=5;receipt.native_buffer_bytes=plane.bytes;
    int encoded=lease.encode(lease.context,&scope,&plane,&receipt);
    assert(encoded==!!strcmp(scenario,"encode_failure"));if(!encoded)receipt.status=IQ4_HALF_RENDER_SINK_01;
    receipt.settings_restored=1;lease.finish(lease.context,&scope,&receipt);
   }
   tid=77;
  }
  char base[32]={};strcpy(base,!strcmp(scenario,"wrong_name")?"IMG9999":"IMG0001");ranges.push_back({(uintptr_t)base,sizeof base});
  unsigned char pixels[1]={0};int r=iq4_stock_jpeg_encode_write_01(task,base,pixels,4000,3000);ranges.pop_back();
  if(r)++stored;if(!retain)put(power[1]+0x17c,0,4);return r?0:5;
 }
 assert(!"unexpected native fixture call");return 0;
}
int main(int argc,char**argv){scenario=argc>1?argv[1]:"half";FILE*f=fopen("analysis/firmware/extracted/P1Linux_6.03.21.bin","rb");assert(f);fseek(f,0,SEEK_END);long n=ftell(f);rewind(f);image.resize((size_t)n);assert(fread(image.data(),1,image.size(),f)==image.size());fclose(f);
 uint64_t phoff;uint16_t esz,count;memcpy(&phoff,image.data()+32,8);memcpy(&esz,image.data()+54,2);memcpy(&count,image.data()+56,2);for(unsigned i=0;i<count;++i){const unsigned char*p=image.data()+phoff+i*esz;uint32_t type;uint64_t off,va,bytes;memcpy(&type,p,4);memcpy(&off,p+8,8);memcpy(&va,p+16,8);memcpy(&bytes,p+32,8);if(type==1)segments.push_back({(uintptr_t)va,(size_t)bytes,(size_t)off});}
 task=alloc(0x64003f0);ifm=alloc(0x1000);catalog=alloc(0x800);put(ifm,0xb7f960);put(ifm+0xfa8,catalog);put(catalog,0xb7ece0);put(catalog+0x328,ifm);processing_worker=alloc(0x1000);put(processing_worker,0xd854c8);node=alloc(0x100);strcpy((char*)(node+0x25),"IMG0001.IIQ");map_entry=alloc(40);put(map_entry+0x20,node);cancel=alloc(1);put(catalog+0x1b8,2,4);put(catalog+0x1b0,catalog+0x100);encoder=alloc(0x480);put(encoder,0xdce100);sp=alloc(0x2100);put(sp+0x600,processing_worker);array=alloc(24);put(sp+0x460,0x1234);put(sp+0x1b00,array);
 for(unsigned i=0;i<2;++i){group[i]=alloc(0x1400);put(group[i],0xbca228);put(group[i]+0x13f3,i?2:4,1);power[i]=alloc(0x400);put(power[i],0xdb6628);put(power[i]+0x68,i?0x9f3fe8:0x9f4000);fs[i]=alloc(0x218);put(fs[i],0xd91450);strcpy((char*)(fs[i]+0x15),i?"/run/media/xqdcard/":"/run/media/sdcard/");}put(array+8,group[1]);put(array+16,group[0]);put(catalog+0x7a0,fs[0]);put(catalog+0x7d0,fs[1]);
 put(power[0]+0x178,1,1); /* Inactive SD requester disabled is not a gate for XQD. */
 iq4_stock_jpeg_ctor_01(task,group[0],ifm,power[0],power[1],fs[0],sp);assert(iq4_stock_jpeg_bound_01());assert(iq4_stock_jpeg_destination_get_01()==10);assert(iq4_stock_jpeg_mode_set_01(1)&&iq4_stock_jpeg_size_set_01(1));assert(iq4_stock_jpeg_destination_set_01(11));assert(catalog_flags==4&&catalog_scans==1);

 uint32_t choice=99,quality=0;assert(iq4_stock_jpeg_extended_size_get_02(&choice)&&choice==0);assert(iq4_stock_jpeg_quality_get_02(&quality)&&quality==100);
 if(!strcmp(scenario,"save_failure")){half_save_fail=1;assert(!iq4_stock_jpeg_extended_size_set_02(1));assert(iq4_stock_jpeg_extended_size_get_02(&choice)&&choice==0);}
 else{
  if(strcmp(scenario,"4k"))assert(iq4_stock_jpeg_extended_size_set_02(1));
  int r=iq4_stock_jpeg_4k_01(task,1);
  bool fail=!strcmp(scenario,"mismatch")||!strcmp(scenario,"encode_failure")||!strcmp(scenario,"wrong_name");
  if(!strcmp(scenario,"timeout")){
   assert(r==2&&!iq4_stock_jpeg_bound_01()&&!published&&!stored);assert(iq4_stock_jpeg_4k_01(task,1)==3);
   tid=99;assert(saved_lease.guard(saved_lease.context,&saved_scope)==-1);Iq4HalfRenderReceipt01 done={};done.status=IQ4_HALF_RENDER_CANCELLED_01;done.settings_restored=1;saved_lease.finish(saved_lease.context,&saved_scope,&done);tid=77;
   assert(!iq4_stock_jpeg_bound_01()&&!published&&!stock_encodes);
  }else{assert(r==(fail?5:0)&&published==(fail?0u:1u)&&stored==(fail?0u:1u));assert(wait_timeout==(!strcmp(scenario,"4k")?10000u:60000u));assert(stock_encodes==(!strcmp(scenario,"4k")?1u:0u));}
 }
 printf("PASS runtime %s XQD with SD absent; owned Half callbacks/quality100/RAW retained\n",scenario);for(auto r:ranges)free((void*)r.a);
}
