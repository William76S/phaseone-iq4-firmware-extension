#include "../f3_stock_jpeg_xqd_01/stock.h"
#include "../f3_stock_jpeg_xqd_01/settings.h"
#include "../f3_stock_half_export_01/half.h"
#include "../stock_storage_router_55/router.h"
#include "../stock_storage_router_55/settings.h"
#include "../stock_storage_router_55/backend.h"
#include "../stock_storage_router_55/status.h"
#include "../stock_new_raw_receipt_55/receipt.h"
#include "../f3_stock_half_export_01/half_settings.h"
#include "../f3_stock_half_export_01/quality.h"
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
static uintptr_t viewmodel,sequence_group,ice;static uintptr_t task,group[2],power[2],fs[2],ifm,encoder,sp,array,catalog,processing_worker,node,map_entry,cancel;
static uint64_t tid=77;static const char*scenario;static unsigned stock_encodes,half_encodes,wait_timeout,half_save_fail,pending_clears;static Iq4StockHalfSettings half_saved={0,65,1};static unsigned catalog_flags=2,catalog_scans;static int present[2]={0,1};static unsigned sd_mode=0,backup_mode=1,capture_busy,pending,backup_pending,settings_fail,gallery=1,receipt_active,receipt_lock,reported_mask,ended_ok,receipt_retired;static Iq4Storage55Settings format_saved={2,65,1};static unsigned mode,size_mode,published,stored;static int publish_result=1;static Iq4StockJpegSettings saved={0,65,1};
static uintptr_t alloc(size_t n){void*p=calloc(1,n);assert(p);ranges.push_back({(uintptr_t)p,n});return(uintptr_t)p;}
static void fixture_put(uintptr_t p,uintptr_t v,size_t n=8){memcpy((void*)p,&v,n);}static uintptr_t fixture_get(uintptr_t p,size_t n=8){uintptr_t v=0;memcpy(&v,(void*)p,n);return v;}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){if(p==processing_worker+UINT64_C(0x65547918)&&n==8){memcpy(out,&ice,8);return 1;}for(auto s:segments)if(p>=s.va&&p+n<=s.va+s.n){memcpy(out,image.data()+s.off+p-s.va,n);if(p==0xf55e18&&n==32)memcpy((char*)out+16,fs,8);if(p==0xf55e38&&n==32)memcpy((char*)out+16,fs+1,8);return 1;}for(auto r:ranges)if(p>=r.a&&p+n<=r.a+r.n){memcpy(out,(void*)p,n);return 1;}return 0;}
extern "C" uint64_t iq4_native_current_tid_01(void){return tid;}
extern "C" Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_load_01(Iq4StockJpegSettings*out){*out=saved;return IQ4_STOCK_JPEG_SETTINGS_OK;}
extern "C" Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_save_01(const Iq4StockJpegSettings*in){saved=*in;return IQ4_STOCK_JPEG_SETTINGS_OK;}
extern "C" int iq4_stock_jpeg_probe_mount_01(const char*,int(*guard)(void)){return guard();}
extern "C" int iq4_stock_jpeg_publish_01(const char*root,const char*name,const void*p,uint32_t n,int(*guard)(void)){assert(!strcmp(root,"/run/media/xqdcard/")||!strcmp(root,"/run/media/sdcard/"));assert(!strcmp(name,"DCIM/100PHASE/IMG0001.JPG"));assert(n==24&&((const unsigned char*)p)[0]==255&&guard()==1);++published;if(!strcmp(scenario,"mirror_failure")&&!strcmp(root,"/run/media/sdcard/"))return 0;return publish_result;}

extern "C" Iq4Storage55SettingsResult iq4_storage55_settings_load_01(Iq4Storage55Settings*out){*out=format_saved;return IQ4_STORAGE55_SETTINGS_OK;}
extern "C" Iq4Storage55SettingsResult iq4_storage55_settings_save_01(const Iq4Storage55Settings*in){if(settings_fail)return IQ4_STORAGE55_SETTINGS_IO;format_saved=*in;return IQ4_STORAGE55_SETTINGS_OK;}
extern "C" int iq4_stock_storage_normalize_sd_55(uintptr_t vm,uintptr_t sd,uintptr_t xqd){assert(vm==viewmodel&&sd==group[0]&&xqd==group[1]);if(present[0]&&!present[1])sd_mode=5;return 1;}
extern "C" int iq4_stock_jpeg_gallery_bind_55(uintptr_t cat){assert(cat==catalog);return (int)gallery;}
extern "C" int iq4_stock_jpeg_gallery_prepare_retire_55(uintptr_t,uintptr_t,uint32_t,uint32_t){return 1;}
extern "C" int iq4_stock_jpeg_gallery_commit_retire_55(uintptr_t,uintptr_t,uint32_t,uint32_t){return 1;}
extern "C" int iq4_stock_jpeg_only_gallery_bound_55(){return (int)gallery;}
extern "C" int iq4_new_raw_bind_55(const Iq4NewRawOps55*p){assert(p->xqd_fs==fs[1]&&p->sd_fs==fs[0]&&p->read&&p->policy&&p->catalog&&p->removed);return 1;}
extern "C" int iq4_new_raw_settings_enter_55(){if(receipt_lock||receipt_active)return 0;receipt_lock=1;return 1;}
extern "C" void iq4_new_raw_settings_leave_55(){assert(receipt_lock);receipt_lock=0;}
extern "C" int iq4_new_raw_backup_suppressed_55(uintptr_t,uint32_t){return 1;}
extern "C" uint32_t iq4_new_raw_active_55(){return receipt_active;}
extern "C" int iq4_new_raw_policy_55(uintptr_t n,uint32_t index,Iq4NewRawPolicy55*out){assert(n==node&&index==1);uint32_t format;assert(iq4_stock_storage_capture_format_55(&format));*out={format,half_saved.mode,sd_mode,0,0,1};return 1;}
extern "C" int iq4_new_raw_acquire_55(uintptr_t n,uint32_t index,const Iq4NewRawPolicy55*p,uint32_t raw,uint32_t jpeg,Iq4NewRawTicket55*t){assert(n==node&&index==1&&raw==catalog_flags&&p->format==format_saved.mode&&(jpeg&6));t->serial=9;receipt_active=1;return 1;}
extern "C" int iq4_new_raw_publication_55(Iq4NewRawTicket55 t,uint32_t mask){assert(t.serial==9);reported_mask=mask;return 1;}
extern "C" int iq4_new_raw_end_55(Iq4NewRawTicket55 t,int ok){assert(t.serial==9);ended_ok=(unsigned)ok;++receipt_retired;receipt_active=0;return ok&&format_saved.mode==1?IQ4_NEW_RAW_OK55:IQ4_NEW_RAW_KEPT55;}
extern "C" Iq4StockHalfSettingsResult iq4_stock_half_settings_load_01(Iq4StockHalfSettings*out){*out=half_saved;return IQ4_STOCK_HALF_SETTINGS_OK;}
extern "C" Iq4StockHalfSettingsResult iq4_stock_half_settings_save_01(const Iq4StockHalfSettings*in){if(half_save_fail)return IQ4_STOCK_HALF_SETTINGS_IO;half_saved=*in;return IQ4_STOCK_HALF_SETTINGS_OK;}
extern "C" Iq4Jpeg82BindStatus01 iq4_native_jpeg82_bind_01(const uint8_t*,Iq4Jpeg82ReadExact01,void*,Iq4JpegApi*out){*out={};out->api_version=82;out->compressor_struct_bytes=584;out->binding_abi_verified=1;return IQ4_JPEG82_BOUND_STATIC_ABI_01;}
extern "C" Iq4HalfJpegStatus01 iq4_half_jpeg_encode_01(const Iq4JpegApi*a,const Iq4HalfArgb01*p,uint8_t*out,size_t capacity,int quality,int(*guard)(void*),void*ctx,Iq4HalfJpegResult01*r){
 assert(a->binding_abi_verified&&p->width==7102&&p->height==5326&&p->format==5&&quality==100&&capacity==104857600&&guard(ctx)==1);++half_encodes;*r={};
 if(!strcmp(scenario,"encode_failure")){r->status=IQ4_HALF_JPEG_CAPACITY_01;return r->status;}
 memset(out,0,24);out[0]=255;out[1]=216;out[22]=255;out[23]=217;r->status=IQ4_HALF_JPEG_OK_01;r->rows=5326;r->jpeg_bytes=24;r->destroy_calls=1;return r->status;
}
extern "C" uintptr_t iq4_stock_half_ifm_wait_02(uintptr_t,uint32_t,uintptr_t);
extern "C" uintptr_t iq4_stock_half_inner_wait_55(uintptr_t,uint32_t,uintptr_t,uintptr_t);
extern "C" uintptr_t iq4_stock_jpeg_test_call(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t c,uintptr_t d,uintptr_t e,uintptr_t f,uintptr_t g){
 if(pc==0x8e0928){assert(a==task&&b==group[0]&&c==ifm&&d==power[0]&&e==power[1]&&f==fs[0]);fixture_put(task,0xdbce40);fixture_put(task+0x1b0,fs[0]);fixture_put(task+0x1b8,16,4);fixture_put(task+0x1c8,b);fixture_put(task+0x1d0,c);fixture_put(task+0x1d8,d);fixture_put(task+0x1e0,e);fixture_put(task+0x1e8,0,4);fixture_put(task+0x1ec,0,4);fixture_put(task+0x1f0,encoder);fixture_put(power[0]+0x70,0xdbc878);fixture_put(power[1]+0x70,0xdbc878);return 0;}
 if(pc==0x74e454){assert(b==11&&c==1);return fs[1];}
 if(pc==0x8ca3ec){assert((a==power[1]||a==power[0])&&fixture_get(a+0x78)==0);fixture_put(a+0x78,b);return 1;}
 if(pc==0x8ca888){unsigned i=a==power[1];assert(a==power[i]&&b<2&&c==6000);fixture_put(a+0x17c,fixture_get(a+0x17c,4)|(1u<<b),4);fixture_put(a+0x320,1,4);return 0;}
 if(pc==0x8ca708){assert(a==power[0]||a==power[1]);fixture_put(a+0x17c,fixture_get(a+0x17c,4)&~(1u<<b),4);return 1;}
 if(pc==0x411bc0){assert(b==catalog+0x1c0);return 0;}if(pc==0x411bf4)return 0;
 if(pc==0x493994){assert(a==catalog&&b==16);catalog_flags&=~16u;return 0;}
 if(pc==0x493598){assert(a==catalog&&b==0xb7e920&&c==1024&&d==16);++catalog_scans;return 0;}
 if(pc==0x5e8c20){assert(a==group[0]+0xe8);return mode;}if(pc==0x5e8c54){assert(a==group[0]+0xe8&&b<=2);mode=(unsigned)b;return 0;}
 if(pc==0x5e7350){assert(a==group[0]+0x2a8);return size_mode;}if(pc==0x5e7384){assert(a==group[0]+0x2a8&&b<=1);size_mode=(unsigned)b;return 0;}
 if(pc==0x41497c){if(a==sequence_group+0x298)return capture_busy;assert(a==group[0]+0x468||a==group[1]+0x468);return present[a==group[1]+0x468];}
 if(pc==0x495448){assert(a==viewmodel+0x1d8);return sd_mode;}
 if(pc==0x5e7fb8){assert(a==group[0]+0x1c8);return backup_mode;}
 if(pc==0x5e7fec){assert(a==group[0]+0x1c8&&b<=2);backup_mode=(unsigned)b;return 0;}
 if(pc==0x8e3d38){assert(a==ifm);return backup_pending;}
 if(pc==0x8e2590){assert(a==ifm);return pending;}
 if(pc==0x8e25b0){assert(a==ifm&&b==1);return iq4_stock_jpeg_pending_clear_guard_55(catalog,(uint32_t)b,256);}
 if(pc==0x48793c){assert(a==catalog&&b==1&&c==256);++pending_clears;pending=0;return 0;}
 if(pc==0x496df4){assert(a==ifm&&b==1);return catalog_flags;}
 if(pc==0x525034){assert(a==group[1]+0xdc8||a==group[0]+0xdc8);return 1024*1024*1024;}
 if(pc==0x48f4f0){assert(a==catalog+0x100&&b==1);return map_entry;}
 if(pc==0x713a18){assert((a==task&&c==0x55)||(a==0x777&&c==sp+0x128));wait_timeout=(unsigned)b;return 1;}
 if(pc==0x98d8a8){assert(a==encoder&&b&&c==4000&&d==3000&&e==100&&f==task+0x1f8&&g==104857600);++stock_encodes;unsigned char*p=(unsigned char*)f;memset(p,0,24);p[0]=255;p[1]=216;p[22]=255;p[23]=217;return 24;}
 if(pc==0x827348){assert(a==fs[1]||a==fs[0]);strcpy((char*)c,(char*)(a+0x15));strcat((char*)c,(char*)b);return 1;}
 if(pc==0x8e1f7c){assert(a==task&&!strcmp((char*)b,"IMG0001"));strcpy((char*)(task+0x64001f8),"DCIM/100PHASE/IMG0001.JPG");return 1;}
 if(pc==0x8e17c8||pc==0x8e1264){const unsigned out=fixture_get(task+0x1d8)==power[1],source=fixture_get(task+0x1e0)==power[1];assert(a==task&&b==1&&fixture_get(task+0x1b0)==fs[out]&&fixture_get(task+0x1e8,4)==(out?1u:0u)&&fixture_get(task+0x1ec,4)==(source?0u:1u));
  assert(iq4_stock_jpeg_presence_01(group[0]+0x468)==1&&iq4_stock_jpeg_free_space_01(group[0]+0xdc8)>1048575);
  for(unsigned i=0;i<2;++i)fixture_put(power[i]+0x17c,0,4);
  fixture_put(power[out]+0x17c,1u<<(out?1u:0u),4);fixture_put(power[source]+0x17c,fixture_get(power[source]+0x17c,4)|(1u<<(source?0u:1u)),4);fixture_put(power[out]+0x320,1,4);fixture_put(power[source]+0x320,1,4);
  if(!strcmp(scenario,"native_exception")){for(unsigned i=0;i<2;++i)fixture_put(power[i]+0x17c,0,4);throw std::runtime_error("native worker unwind fixture");}
  if(strncmp(scenario,"half_",5)==0){
   assert(iq4_stock_half_ifm_wait_02(task,10000,0x55)==1&&wait_timeout==90000);
   fixture_put(sp+0x78,catalog);fixture_put(sp+0x74,1,4);fixture_put(sp+0x360,node);
   assert(iq4_stock_half_inner_wait_55(0x777,10000,sp+0x128,sp)==1&&wait_timeout==60000);
   fixture_put(sp+0x74,0,4);assert(iq4_stock_half_inner_wait_55(0x777,10000,sp+0x128,sp)==1&&wait_timeout==10000);fixture_put(sp+0x74,1,4);
   Iq4HalfScope01 scope={processing_worker,processing_worker+0x2d8,processing_worker+UINT64_C(0x65547968),sp+0x100,processing_worker+0x2c0,cancel,node,57,14204,10652};
   Iq4HalfLease01 lease={};tid=99;assert(iq4_stock_half_acquire_01(&scope,&lease)==1);
   Iq4HalfRenderReceipt01 receipt={};receipt.status=IQ4_HALF_RENDER_INCOMPLETE_01;receipt.entered=1;receipt.stages=3;receipt.joins=3;receipt.terminal=0;receipt.settings_restored=1;
   lease.finish(lease.context,&scope,&receipt);tid=77;pending=1;
  }
  char base[32]={};strcpy(base,"IMG0001");ranges.push_back({(uintptr_t)base,sizeof base});unsigned char pixels[1]={0};int r=iq4_stock_jpeg_encode_write_01(task,base,pixels,4000,3000);ranges.pop_back();
  if(r)++stored;for(unsigned i=0;i<2;++i)fixture_put(power[i]+0x17c,0,4);return r?0:5;
 }
 assert(!"unexpected native fixture call");return 0;
}

#define IQ4_STOCK_JPEG_TEST 1
#include "runtime.cpp"
static void arm_trace(){
 active=1;held=0;job_thread=tid=77;half_choice=1;half_gate=0;last_failure=0;half_entry_seen=0;
 half_transaction={};half_transaction.state=HALF_ARMED;half_transaction.task=task;
 half_transaction.node=node;half_transaction.index=1;half_transaction.processing_id=57;
 strcpy(half_transaction.base,"IMG0001");fixture_put(map_entry+0x20,node);
 strcpy((char*)(node+0x25),"IMG0001.IIQ");
}
static void assert_trace(uint32_t reason){
 uint32_t stage=99,detail=99;assert(iq4_stock_jpeg_last_failure_55(&stage,&detail));
 assert(stage==(reason?IQ4_JPEG_FAILURE_HALF_MATCH55:0)&&detail==reason);
 assert(half_transaction.state==HALF_ARMED&&!half_gate&&!held);
}
static void trace_cases(){
 arm_trace();assert(!iq4_stock_half_entry_trace_58(processing_worker+8,node,57,IQ4_HALF_ENTRY_GEOMETRY58));assert_trace(0);assert(!half_entry_seen);
 assert(!iq4_stock_half_entry_trace_58(processing_worker,node+8,57,IQ4_HALF_ENTRY_GEOMETRY58));assert_trace(0);assert(!half_entry_seen);
 const uint32_t reasons[]={IQ4_HALF_ENTRY_ABI58,IQ4_HALF_ENTRY_GEOMETRY58,IQ4_HALF_ENTRY_ROTATION58,IQ4_HALF_ENTRY_CANCEL58,IQ4_HALF_ENTRY_PINS58,IQ4_HALF_ENTRY_BUSY58};
 for(auto reason:reasons){arm_trace();assert(iq4_stock_half_entry_trace_58(processing_worker,node,57,reason));assert_trace(reason);assert(half_entry_seen);
  assert(iq4_stock_half_entry_trace_58(processing_worker,node,57,IQ4_HALF_ENTRY_CANCEL58));assert_trace(reason);}
 arm_trace();half_gate=1;assert(iq4_stock_half_entry_trace_58(processing_worker,node,57,0)&&half_gate==1);half_gate=0;assert_trace(0);
 arm_trace();assert(iq4_stock_half_entry_trace_58(processing_worker,node,56,IQ4_HALF_ENTRY_GEOMETRY58));assert_trace(IQ4_HALF_ENTRY_UID58);
 arm_trace();half_transaction.state=HALF_HOLD;assert(!iq4_stock_half_entry_trace_58(processing_worker,node,57,IQ4_HALF_ENTRY_ABI58));assert(half_transaction.state==HALF_HOLD&&!last_failure);
 Iq4HalfScope01 scope={processing_worker,processing_worker+0x2d8,processing_worker+UINT64_C(0x65547968),sp+0x100,processing_worker+0x2c0,cancel,node,57,14204,10652};Iq4HalfLease01 lease={};
 arm_trace();scope.photo_index=56;assert(!iq4_stock_half_acquire_01(&scope,&lease));assert_trace(IQ4_HALF_ENTRY_UID58);scope.photo_index=57;
 arm_trace();fixture_put(map_entry+0x20,node+8);assert(!iq4_stock_half_acquire_01(&scope,&lease));assert_trace(IQ4_HALF_ENTRY_CATALOG58);
 arm_trace();strcpy((char*)(node+0x25),"CHANGED.IIQ");assert(!iq4_stock_half_acquire_01(&scope,&lease));assert_trace(IQ4_HALF_ENTRY_BASENAME58);
 arm_trace();tid=0;assert(!iq4_stock_half_acquire_01(&scope,&lease));assert(half_transaction.state==HALF_FAILED);assert((uint32_t)last_failure==IQ4_HALF_ENTRY_THREAD58);
 arm_trace();assert(iq4_stock_half_entry_trace_58(processing_worker,node,57,0));assert(iq4_stock_half_acquire_01(&scope,&lease));
 Iq4HalfRenderReceipt01 render={};render.status=IQ4_HALF_RENDER_INCOMPLETE_01;render.settings_restored=1;
 lease.finish(lease.context,&scope,&render);assert((uint32_t)(last_failure>>32)==IQ4_JPEG_FAILURE_HALF_RENDER55&&half_transaction.state==HALF_FAILED);
 half_end();assert(half_transaction.state==HALF_IDLE&&!half_gate&&!held);
 arm_trace();half_transaction.state=HALF_DIAG;half_end();assert(half_transaction.state==HALF_HOLD&&held&&!half_gate);
 arm_trace();half_write(task,"IMG0001");assert_trace(IQ4_HALF_ENTRY_NOT_REACHED58);
 arm_trace();assert(iq4_stock_half_entry_trace_58(processing_worker,node,57,0));half_write(task,"IMG0001");assert_trace(IQ4_HALF_ENTRY_UNCLAIMED58);
 arm_trace();half_transaction.state=HALF_COMPLETE;assert(!iq4_stock_half_entry_trace_58(processing_worker,node,57,IQ4_HALF_ENTRY_ABI58));assert(half_transaction.state==HALF_COMPLETE&&!last_failure);
 arm_trace();half_entry_seen=1;half_transaction.state=HALF_IDLE;assert(half_begin(task,1)&&!half_entry_seen&&half_transaction.state==HALF_ARMED&&!half_gate);
 half_end();assert(half_transaction.state==HALF_IDLE&&!held);
 puts("PASS finite runtime trace transitions; nativeFS/codec/catalog fixtures explicit");
}

int main(int argc,char**argv){scenario=argc>1?argv[1]:"half";FILE*f=fopen("analysis/firmware/extracted/P1Linux_6.03.21.bin","rb");assert(f);fseek(f,0,SEEK_END);long n=ftell(f);rewind(f);image.resize((size_t)n);assert(fread(image.data(),1,image.size(),f)==image.size());fclose(f);
 uint64_t phoff;uint16_t esz,count;memcpy(&phoff,image.data()+32,8);memcpy(&esz,image.data()+54,2);memcpy(&count,image.data()+56,2);for(unsigned i=0;i<count;++i){const unsigned char*p=image.data()+phoff+i*esz;uint32_t type;uint64_t off,va,bytes;memcpy(&type,p,4);memcpy(&off,p+8,8);memcpy(&va,p+16,8);memcpy(&bytes,p+32,8);if(type==1)segments.push_back({(uintptr_t)va,(size_t)bytes,(size_t)off});}
 task=alloc(0x64003f0);ifm=alloc(0x1000);catalog=alloc(0x800);ice=alloc(0x800);fixture_put(catalog+0x4d0,ice);fixture_put(ifm,0xb7f960);fixture_put(ifm+0xfa8,catalog);fixture_put(catalog,0xb7ece0);fixture_put(catalog+0x328,ifm);processing_worker=alloc(0x1000);fixture_put(processing_worker,0xd854c8);node=alloc(0x100);fixture_put(node+0xdc,57,4);strcpy((char*)(node+0x25),"IMG0001.IIQ");map_entry=alloc(40);fixture_put(map_entry+0x20,node);cancel=alloc(1);fixture_put(catalog+0x1b8,2,4);fixture_put(catalog+0x1b0,catalog+0x100);encoder=alloc(0x480);fixture_put(encoder,0xdce100);sp=alloc(0x2100);fixture_put(sp+0x600,processing_worker);fixture_put(sp+0x1c10,ice);viewmodel=alloc(0x400);fixture_put(viewmodel,0xbbd068);fixture_put(sp+0x1af0,viewmodel);sequence_group=alloc(0x500);fixture_put(sequence_group,0xbd0a38);fixture_put(sequence_group+0x298,0x9f18e0);fixture_put(sp+0x1c88,sequence_group);array=alloc(24);fixture_put(sp+0x460,0x1234);fixture_put(sp+0x1b00,array);
 for(unsigned i=0;i<2;++i){group[i]=alloc(0x1400);fixture_put(group[i],0xbca228);fixture_put(group[i]+0x13f3,i?2:4,1);if(i==0)fixture_put(group[i]+0x1c8,0xbca8c8);power[i]=alloc(0x400);fixture_put(power[i],0xdb6628);fixture_put(power[i]+0x80,0xdbcf98);fixture_put(power[i]+0x68,i?0x9f3fe8:0x9f4000);fs[i]=alloc(0x218);fixture_put(fs[i],0xd91450);strcpy((char*)(fs[i]+0x15),i?"/run/media/xqdcard/":"/run/media/sdcard/");}fixture_put(array+8,group[1]);fixture_put(array+16,group[0]);fixture_put(catalog+0x7a0,fs[0]);fixture_put(catalog+0x7d0,fs[1]);
 fixture_put(viewmodel+0x1c8,group[0]+8);fixture_put(viewmodel+0x2b8,group[0]+0xe8);fixture_put(viewmodel+0x2c8,group[0]+0x1c8);
 if(!strcmp(scenario,"sd_only")){present[0]=1;present[1]=0;catalog_flags=4;}
 if(!strcmp(scenario,"archive")||!strcmp(scenario,"mirror_failure")||!strcmp(scenario,"jpeg_only")){present[0]=present[1]=1;catalog_flags=6;sd_mode=4;}
 if(!strcmp(scenario,"jpeg_only")){format_saved.mode=1;catalog_flags=2;}
 if(strncmp(scenario,"half_",5)==0)half_saved.mode=1;
 if(!present[0])fixture_put(power[0]+0x178,1,1);
 iq4_stock_jpeg_ctor_01(task,group[0],ifm,power[0],power[1],fs[0],sp);assert(iq4_stock_jpeg_bound_01());assert(iq4_stock_jpeg_destination_get_01()==11);assert(mode==1);uint32_t value=99;assert(iq4_stock_xqd_format_get_55(&value)&&value==format_saved.mode);
 if(!strcmp(scenario,"format_busy")){capture_busy=1;assert(!iq4_stock_xqd_format_set_55(0));}
 else if(!strcmp(scenario,"pending_busy")){pending=1;assert(!iq4_stock_xqd_format_set_55(0));}
 else if(!strcmp(scenario,"receipt_busy")){receipt_active=1;assert(!iq4_stock_xqd_format_set_55(0));}
 else if(!strcmp(scenario,"save_failure")){settings_fail=1;assert(!iq4_stock_xqd_format_set_55(0));assert(mode==1);}
 else if(!strcmp(scenario,"archive_all_reject")){sd_mode=4;backup_mode=2;backup_pending=1;assert(!iq4_stock_xqd_format_set_55(1));uint32_t stage,detail;assert(iq4_stock_jpeg_last_failure_55(&stage,&detail)&&stage==8&&detail==2&&iq4_stock_jpeg_bound_01());}
 else if(!strcmp(scenario,"archive_all_normalize")){sd_mode=4;backup_mode=2;assert(iq4_stock_xqd_format_set_55(1)&&backup_mode==1&&format_saved.mode==1&&mode==1);assert(iq4_stock_xqd_format_get_55(&value)&&value==1);}
 else if(!strcmp(scenario,"jpeg_gate")){gallery=0;assert(!iq4_stock_xqd_format_set_55(1));}
 else if(!strcmp(scenario,"native_exception")){try{(void)iq4_stock_jpeg_4k_01(task,1);assert(0);}catch(const std::runtime_error&){}assert(receipt_retired==1&&!receipt_active&&!published&&!iq4_stock_jpeg_bound_01());}
 else if(!strcmp(scenario,"half_render_failure")){
  int r=iq4_stock_jpeg_4k_01(task,1);assert(r==5&&pending_clears==1&&!pending&&!published&&!stored&&catalog_flags==2);
  uint32_t stage,detail;assert(iq4_stock_jpeg_last_failure_55(&stage,&detail)&&stage==IQ4_JPEG_FAILURE_HALF_RENDER55&&detail==IQ4_HALF_RENDER_INCOMPLETE_01);
  assert(ended_ok==0&&receipt_retired==1&&!receipt_active&&iq4_stock_jpeg_bound_01());
 }
 else{int r=iq4_stock_jpeg_4k_01(task,1);const unsigned want=(sd_mode==4)?2u:1u;assert(r==(!strcmp(scenario,"mirror_failure")?5:0)&&published==want&&stored==!!strcmp(scenario,"mirror_failure"));assert(reported_mask==(!strcmp(scenario,"mirror_failure")?2u:sd_mode==4?6u:present[1]?2u:4u));assert(receipt_retired==1&&!receipt_active);if(!strcmp(scenario,"sd_only"))assert(fixture_get(task+0x1e0)==power[0]&&fixture_get(task+0x1ec,4)==1);
  uint32_t stage,detail;assert(iq4_stock_jpeg_last_failure_55(&stage,&detail));
  if(!strcmp(scenario,"mirror_failure")){assert(pending_clears==1&&stage==IQ4_JPEG_FAILURE_CARD55&&detail==10);}
  else assert(!pending_clears&&!stage&&!detail);
 }
 if(strstr(scenario,"busy")||!strcmp(scenario,"save_failure")||!strcmp(scenario,"jpeg_gate")||!strcmp(scenario,"archive_all_reject")){assert(iq4_stock_xqd_format_get_55(&value)&&value==2&&!published&&mode==1);}
 trace_cases();
 printf("PASS router %s actual runtime; nativeFS/codec/receipt/normalizer are explicit fixtures\n",scenario);for(auto r:ranges)free((void*)r.a);
}
