#include "../f3_stock_jpeg_xqd_01/stock.h"
#include "../f3_stock_jpeg_xqd_01/settings.h"
#include "stock_pins_54.h"
#include "half.h"
#include "quality.h"
#include "half_settings.h"
#include "../f3_native_half_01/half.h"
#include "../f3_native_jpeg8_binding_01/native_jpeg82.h"
#include "half_pins.h"
#include "../native_runtime_01/self_read.h"
#include <string.h>
struct Binding {uintptr_t task,group[2],fs[2],power[2],ifm;uint32_t native_out,source,extra_out;};
static Binding binding;
static uint32_t bound,destination=10,active,job_destination=10,held,catalog_epoch;
static uint64_t job_thread;
static uintptr_t half_worker;
static uint32_t half_choice;
static Iq4JpegApi half_codec;
static uint32_t half_codec_ready;
enum HalfState {HALF_IDLE=0,HALF_ARMED=1,HALF_CLAIMED=2,HALF_ENCODED=3,
                HALF_COMPLETE=4,HALF_FAILED=5,HALF_HOLD=6};
static struct HalfTransaction {
 uintptr_t task,node;int index;uint32_t state;uint64_t processor_tid;
 char base[33];Iq4HalfScope01 scope;Iq4HalfJpegResult01 jpeg;
 Iq4HalfRenderReceipt01 render;
} half_transaction;
static int half_begin(uintptr_t,int);
static void half_end(void);
static int half_write(uintptr_t,const char*);
static int half_available();
static int half_pins_01();
extern "C" uintptr_t iq4_stock_half_ifm_wait_02(uintptr_t,uint32_t,uintptr_t);
extern "C" int iq4_stock_jpeg_probe_mount_01(const char*,int(*)(void));
static uint32_t probe_card;
static const char client_name[]="Iq4StockJpegXQD01";
#ifdef IQ4_STOCK_JPEG_TEST
extern "C" uintptr_t iq4_stock_jpeg_test_call(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t);
#endif
static uintptr_t call(uintptr_t p,uintptr_t a=0,uintptr_t b=0,uintptr_t c=0,uintptr_t d=0,uintptr_t e=0,uintptr_t f=0,uintptr_t g=0){
#ifdef IQ4_STOCK_JPEG_TEST
 return iq4_stock_jpeg_test_call(p,a,b,c,d,e,f,g);
#else
 return ((uintptr_t(*)(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t))p)(a,b,c,d,e,f,g);
#endif
}
static int rd(uintptr_t p,void*out,size_t n){return p>=4096&&n&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(nullptr,p,out,n)==1;}
static int word(uintptr_t p,uintptr_t*out){uintptr_t q;return rd(p,out,8)&&rd(p,&q,8)&&q==*out;}
static int scalar(uintptr_t p,uint32_t*out){uint32_t q;return rd(p,out,4)&&rd(p,&q,4)&&q==*out;}
static void put(uintptr_t p,uintptr_t v){memcpy((void*)p,&v,8);}
static void put32(uintptr_t p,uint32_t v){memcpy((void*)p,&v,4);}
static int pins(){unsigned char data[64];for(const auto&p:StockHalfStockPins54)for(size_t off=0;off<p.bytes;off+=sizeof data){size_t n=p.bytes-off;if(n>sizeof data)n=sizeof data;if(!rd(p.va+off,data,n)||memcmp(data,p.data+off,n))return 0;}
#ifndef IQ4_STOCK_JPEG_TEST
 uint32_t opcode;const int64_t delta=(int64_t)(uintptr_t)iq4_stock_half_ifm_wait_02-INT64_C(0x8e1980);
 if((delta&3)||delta<-(INT64_C(1)<<27)||delta>=(INT64_C(1)<<27)||!scalar(0x8e1980,&opcode)||
  opcode!=(UINT32_C(0x94000000)|((uint32_t)(delta>>2)&0x3ffffff)))return 0;
#endif
 return 1;
}
static int half_pins_01(){
 unsigned char bytes[64];for(const auto&p:HalfCorePins01)for(size_t off=0;off<p.bytes;off+=sizeof bytes){
  size_t n=p.bytes-off;if(n>sizeof bytes)n=sizeof bytes;
  if(!rd(p.va+off,bytes,n)||memcmp(bytes,p.data+off,n))return 0;
 }
#ifndef IQ4_STOCK_JPEG_TEST
 const uintptr_t sites[]={0x7b7ed0,0x91a78c,0x91a964};
 const uintptr_t targets[]={(uintptr_t)iq4_half_preview_wrapper_01,(uintptr_t)iq4_half_join_wrapper_01,(uintptr_t)iq4_half_terminal_wrapper_01};
 for(unsigned i=0;i<3;++i){uint32_t opcode;int64_t delta=(int64_t)targets[i]-(int64_t)sites[i];
  if((delta&3)||delta<-(INT64_C(1)<<27)||delta>=(INT64_C(1)<<27)||!scalar(sites[i],&opcode)||
   opcode!=(UINT32_C(0x94000000)|((uint32_t)(delta>>2)&0x3ffffff)))return 0;
 }
#endif
 return 1;
}
static int group_shape(uintptr_t p,uint8_t flag){uintptr_t vt;uint8_t a,b;return word(p,&vt)&&vt==0xbca228&&rd(p+0x13f3,&a,1)&&rd(p+0x13f3,&b,1)&&a==b&&a==flag;}
static int fs_shape(unsigned i,uintptr_t expected){uint8_t row[32];uintptr_t p,vt;uint32_t id,flag;char a[256],b[256];
 if(!rd(0xf55e18+32*i,row,sizeof row))return 0;memcpy(&id,row,4);memcpy(&p,row+16,8);memcpy(&flag,row+24,4);
 const char*root=i?"/run/media/xqdcard/":"/run/media/sdcard/";
 return id==10+i&&flag==2&&p==expected&&word(p,&vt)&&vt==0xd91450&&rd(p+0x15,a,256)&&rd(p+0x15,b,256)&&!memcmp(a,b,256)&&!memcmp(a,root,strlen(root)+1);
}
static int power_shape(unsigned i,uint32_t client,const char*name,int required){uintptr_t v,n,c;uint8_t disabled;uint32_t mask,ready;
 if(client>=32||!word(binding.power[i],&v)||v!=0xdb6628||!word(binding.power[i]+0x68,&n)||n!=(i?0x9f3fe8:0x9f4000)||!word(binding.power[i]+0x70+8*client,&c)||c!=(uintptr_t)name||!rd(binding.power[i]+0x178,&disabled,1)||(required&&disabled)||!scalar(binding.power[i]+0x17c,&mask)||!scalar(binding.power[i]+0x320,&ready))return 0;
 return !required||((mask&(1u<<client))&&ready==1);
}
static int identities(){uintptr_t v,p;uint32_t a,b;
 return __atomic_load_n(&bound,__ATOMIC_ACQUIRE)&&word(binding.task,&v)&&v==0xdbce40&&word(binding.task+0x1c8,&p)&&p==binding.group[0]&&word(binding.task+0x1d0,&p)&&p==binding.ifm&&word(binding.task+0x1e0,&p)&&p==binding.power[1]&&scalar(binding.task+0x1ec,&a)&&a==binding.source&&group_shape(binding.group[0],4)&&group_shape(binding.group[1],2)&&fs_shape(0,binding.fs[0])&&fs_shape(1,binding.fs[1])&&power_shape(0,binding.native_out,(const char*)0xdbc878,0)&&power_shape(1,binding.source,(const char*)0xdbc878,0)&&power_shape(1,binding.extra_out,client_name,0)&&scalar(binding.task+0x1b8,&b)&&b==16;
}
static int leases_clear(){uint32_t sd,xqd;if(!scalar(binding.power[0]+0x17c,&sd)||!scalar(binding.power[1]+0x17c,&xqd))return 0;return !(sd&(1u<<binding.native_out))&&!(xqd&((1u<<binding.source)|(1u<<binding.extra_out)));}
static void route(uint32_t card){unsigned i=card==11;put(binding.task+0x1b0,binding.fs[i]);put(binding.task+0x1d8,binding.power[i]);put32(binding.task+0x1e8,i?binding.extra_out:binding.native_out);}
extern "C" int iq4_stock_jpeg_bound_01(void){return !__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&identities();}
extern "C" uint32_t iq4_stock_jpeg_destination_get_01(void){return __atomic_load_n(&destination,__ATOMIC_ACQUIRE);}
static int rescan_guard(){try{unsigned i=probe_card==11;uint32_t token=i?binding.extra_out:binding.native_out;return !held&&identities()&&power_shape(i,token,i?client_name:(const char*)0xdbc878,1)&&call(0x41497c,binding.group[i]+0x468)==1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
class CatalogLock {alignas(8) unsigned char storage[32];bool locked;public:
 CatalogLock(uintptr_t p):storage{},locked(false){call(0x411bc0,(uintptr_t)storage,p);locked=true;}
 ~CatalogLock(){if(locked)try{call(0x411bf4,(uintptr_t)storage);}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}}
};
static int selected_catalog(uintptr_t*out){uintptr_t cat,vt,back,fs0,fs1;char path[256];
 if(!word(binding.ifm,&vt)||vt!=0xb7f960||!word(binding.ifm+0xfa8,&cat)||!word(cat,&vt)||vt!=0xb7ece0||!word(cat+0x328,&back)||back!=binding.ifm||!word(cat+0x7a0,&fs0)||!word(cat+0x7d0,&fs1))return 0;
 for(unsigned i=0;i<2;++i){uintptr_t fs_=i?fs1:fs0;const char*expected=i?"/run/media/xqdcard/":"/run/media/sdcard/";if(!word(fs_,&vt)||vt!=0xd91450||!rd(fs_+0x15,path,sizeof path)||memcmp(path,expected,strlen(expected)+1))return 0;}
 *out=cat;return 1;
}
/* This uses the exact original index mapping without its retain wrapper.
 * The queue owns the node when acquire runs. Before that we retain only an
 * identity value plus a copied basename, never dereference an unheld node. */
static int catalog_photo(int index,uintptr_t*out,char base[33]){
 uintptr_t cat,map,entry,node;uint32_t count;if(index<0||!selected_catalog(&cat))return 0;
 CatalogLock lock(cat+0x1c0);
 if(!scalar(cat+0x1b8,&count)||(uint32_t)index>=count||!word(cat+0x1b0,&map))return 0;
 entry=call(0x48f4f0,map,(uint32_t)index);if(!entry||!word(entry+0x20,&node)||!node)return 0;
 unsigned char name[32];if(!rd(node+0x25,name,sizeof name))return 0;
 unsigned n=0;while(n<32&&name[n]&&name[n]!='.'){
  if(name[n]<' '||name[n]=='/'||name[n]=='\\')return 0;base[n]=(char)name[n];++n;
 }
 if(!n||n==32)return 0;base[n]=0;*out=node;return 1;
}
static int half_codec_read(void*,uintptr_t p,uint8_t*out,size_t n){return rd(p,out,n);}
static int half_available(){return half_worker&&__atomic_load_n(&half_codec_ready,__ATOMIC_ACQUIRE)&&half_pins_01();}
static int release_probe(unsigned i,uint32_t token){uint32_t mask;if(!scalar(binding.power[i]+0x17c,&mask))return 0;if(!(mask&(1u<<token)))return 1;call(0x8ca708,binding.power[i],token);return scalar(binding.power[i]+0x17c,&mask)&&!(mask&(1u<<token));}
extern "C" int iq4_stock_jpeg_destination_set_01(uint32_t card){
 if((card!=10&&card!=11)||!iq4_stock_jpeg_bound_01())return 0;uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 uint32_t before=iq4_stock_jpeg_destination_get_01();if(card==before&&__atomic_load_n(&catalog_epoch,__ATOMIC_ACQUIRE)==card){__atomic_store_n(&active,0,__ATOMIC_RELEASE);return 1;}
 int ok=0,mutated=0;unsigned i=card==11;uint32_t token=i?binding.extra_out:binding.native_out;uintptr_t catalog=0;
 try{if(leases_clear()&&selected_catalog(&catalog)){
   uint32_t result=(uint32_t)call(0x8ca888,binding.power[i],token,6000);probe_card=card;
   if(result==0&&rescan_guard()&&iq4_stock_jpeg_probe_mount_01(i?"/run/media/xqdcard/":"/run/media/sdcard/",rescan_guard)==1){
    route(card);__atomic_store_n(&destination,card,__ATOMIC_RELEASE);mutated=1;
    /* Original done bit is global. Rebuild only JPEG bit16 from selected
     * native directory scan, under its own original mutex and original API.
     * Selected fs/path routing is supplied by stock_jpeg_catalog_01 hooks. */
    {CatalogLock lock(catalog+0x1c0);call(0x493994,catalog,16);}
    if(!held&&rescan_guard()){call(0x493598,catalog,0xb7e920,1024,16);Iq4StockJpegSettings value={card-10,65,1};ok=!held&&rescan_guard()&&iq4_stock_jpeg_settings_save_01(&value)==IQ4_STOCK_JPEG_SETTINGS_OK;}
   }
   if(!release_probe(i,token))__atomic_store_n(&held,1,__ATOMIC_RELEASE);if(ok&&!held)__atomic_store_n(&catalog_epoch,card,__ATOMIC_RELEASE);
  }
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 if(mutated&&!ok)__atomic_store_n(&held,1,__ATOMIC_RELEASE);probe_card=0;__atomic_store_n(&active,0,__ATOMIC_RELEASE);return ok&&!held;
}
extern "C" int iq4_stock_jpeg_mode_get_01(uint32_t*out){if(!out||!iq4_stock_jpeg_bound_01())return 0;try{uint32_t v=(uint32_t)call(0x5e8c20,binding.group[0]+0xe8);if(v>2)return 0;*out=v;return 1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
extern "C" int iq4_stock_jpeg_size_get_01(uint32_t*out){if(!out||!iq4_stock_jpeg_bound_01())return 0;try{uint32_t v=(uint32_t)call(0x5e7350,binding.group[0]+0x2a8);if(v>1)return 0;*out=v;return 1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
static int set_native(uintptr_t event,uintptr_t getter,uintptr_t setter,uint32_t value){if(!iq4_stock_jpeg_bound_01())return 0;uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;int ok=0;if(!leases_clear()){__atomic_store_n(&active,0,__ATOMIC_RELEASE);return 0;}try{call(setter,event,value);ok=call(getter,event)==value;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}__atomic_store_n(&active,0,__ATOMIC_RELEASE);return ok;}
extern "C" int iq4_stock_jpeg_mode_set_01(uint32_t v){return v<=2&&set_native(binding.group[0]+0xe8,0x5e8c20,0x5e8c54,v);}
extern "C" int iq4_stock_jpeg_size_set_01(uint32_t v){return v<=1&&set_native(binding.group[0]+0x2a8,0x5e7350,0x5e7384,v);}
extern "C" int iq4_stock_jpeg_extended_size_get_02(uint32_t*out){
 if(!out||!iq4_stock_jpeg_bound_01())return 0;uint32_t native;
 if(!iq4_stock_jpeg_size_get_01(&native)||native!=1)return 0;
 uint32_t choice=__atomic_load_n(&half_choice,__ATOMIC_ACQUIRE);
 if(choice>1||(choice&&!half_available()))return 0;*out=choice;return 1;
}
extern "C" int iq4_stock_jpeg_extended_size_set_02(uint32_t choice){
 if(choice>1||!iq4_stock_jpeg_bound_01()||(choice&&!half_available()))return 0;
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 int ok=0;try{if(leases_clear()&&__atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE)==HALF_IDLE){
  call(0x5e7384,binding.group[0]+0x2a8,1);Iq4StockHalfSettings value={choice,65,1};
  ok=call(0x5e7350,binding.group[0]+0x2a8)==1&&
     iq4_stock_half_settings_save_01(&value)==IQ4_STOCK_HALF_SETTINGS_OK;
  if(ok)__atomic_store_n(&half_choice,choice,__ATOMIC_RELEASE);
 }}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 __atomic_store_n(&active,0,__ATOMIC_RELEASE);return ok;
}
extern "C" int iq4_stock_jpeg_quality_get_02(uint32_t*out){
 uintptr_t encoder,vt,fn;if(!out||!iq4_stock_jpeg_bound_01()||
  !word(binding.task+0x1f0,&encoder)||!word(encoder,&vt)||vt!=0xdce100||
  !word(vt+0x20,&fn)||fn!=0x98d8a8)return 0;
 if(__atomic_load_n(&half_choice,__ATOMIC_ACQUIRE)&&!half_available())return 0;
 *out=100;return 1;
}
extern "C" void iq4_stock_jpeg_ctor_01(uintptr_t task,uintptr_t sd,uintptr_t ifm,uintptr_t sd_power,uintptr_t xqd_power,uintptr_t sd_fs,uintptr_t main_sp){
 /* Preserve the original constructor, including native unwind, first. */
 call(0x8e0928,task,sd,ifm,sd_power,xqd_power,sd_fs);
 try{uintptr_t registry,array,xqd,vt;uint32_t a,b;Binding candidate={};
  if(bound||!main_sp||!pins()||!word(main_sp+0x460,&registry)||!word(main_sp+0x1b00,&array)||!word(array+8,&xqd)||!group_shape(sd,4)||!group_shape(xqd,2)||!word(task,&vt)||vt!=0xdbce40||!scalar(task+0x1e8,&a)||!scalar(task+0x1ec,&b)||a>=32||b>=32)return;
  candidate.task=task;candidate.group[0]=sd;candidate.group[1]=xqd;candidate.ifm=ifm;candidate.power[0]=sd_power;candidate.power[1]=xqd_power;candidate.fs[0]=sd_fs;candidate.fs[1]=call(0x74e454,registry,11,1);candidate.native_out=a;candidate.source=b;
  if(!fs_shape(0,sd_fs)||!fs_shape(1,candidate.fs[1]))return;binding=candidate;uintptr_t worker_vt;if(!word(main_sp+0x600,&half_worker)||!word(half_worker,&worker_vt)||worker_vt!=0xd854c8||!half_pins_01())half_worker=0;
  static const uint8_t original_sha[32]={0x9b,0x61,0x1e,0xfe,0x64,0x06,0x76,0x85,0xb7,0x70,0xba,0x39,0x84,0xae,0x95,0x16,0x84,0xc5,0xa4,0x01,0xf7,0x3f,0x77,0xa0,0x3b,0x31,0x6b,0xe3,0x74,0x03,0x2c,0xdb};
  if(half_worker&&iq4_native_jpeg82_bind_01(original_sha,half_codec_read,nullptr,&half_codec)==IQ4_JPEG82_BOUND_STATIC_ABI_01)__atomic_store_n(&half_codec_ready,1,__ATOMIC_RELEASE);
  if(!power_shape(0,a,(const char*)0xdbc878,0)||!power_shape(1,b,(const char*)0xdbc878,0))return;
  /* One independent output client on the existing shared XQDWrite owner. */
  binding.extra_out=(uint32_t)call(0x8ca3ec,xqd_power,(uintptr_t)client_name);
  if(binding.extra_out==binding.source||!power_shape(1,binding.extra_out,client_name,0))return;
  Iq4StockJpegSettings s={0,65,1};(void)iq4_stock_jpeg_settings_load_01(&s);Iq4StockHalfSettings hs={0,65,1};(void)iq4_stock_half_settings_load_01(&hs);half_choice=half_worker?hs.mode:0;call(0x5e7384,binding.group[0]+0x2a8,1);route(10+s.mode);__atomic_store_n(&destination,10+s.mode,__ATOMIC_RELEASE);__atomic_store_n(&bound,1,__ATOMIC_RELEASE);
 }catch(...){/* Binding never owns a request. Stock constructor remains usable. */__atomic_store_n(&bound,0,__ATOMIC_RELEASE);}
}
class Job {bool installed,returned;public:
 Job():installed(false),returned(false){}
 bool start(uintptr_t task){uint32_t zero=0;if(task!=binding.task||!iq4_stock_jpeg_bound_01()||!__atomic_compare_exchange_n(&active,&zero,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return false;
  job_destination=iq4_stock_jpeg_destination_get_01();unsigned i=job_destination==11;uintptr_t p;uint32_t token;
  if(!word(task+0x1b0,&p)||p!=binding.fs[i]||!word(task+0x1d8,&p)||p!=binding.power[i]||!scalar(task+0x1e8,&token)||token!=(i?binding.extra_out:binding.native_out)){__atomic_store_n(&held,1,__ATOMIC_RELEASE);__atomic_store_n(&active,0,__ATOMIC_RELEASE);return false;}
  job_thread=iq4_native_current_tid_01();if(!job_thread){__atomic_store_n(&active,0,__ATOMIC_RELEASE);return false;}installed=true;return true;
 }
 void finish(){returned=true;}
 ~Job(){if(installed){/* Stock retains requester bits while pending jobs remain.
   * Fields stay on the selected route, so those retained clients remain owned. */
   if(!returned)__atomic_store_n(&held,1,__ATOMIC_RELEASE);job_thread=0;__atomic_store_n(&active,0,__ATOMIC_RELEASE);}}
};
static int job(uintptr_t pc,uintptr_t task,int index){if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return (int)call(pc,task,(uintptr_t)index);uint32_t dest=iq4_stock_jpeg_destination_get_01();if(dest==11&&__atomic_load_n(&catalog_epoch,__ATOMIC_ACQUIRE)!=dest&&!iq4_stock_jpeg_destination_set_01(dest))return 3;Job scope;if(!scope.start(task))return 3;bool half=half_choice&&pc==0x8e17c8;if(half&&!half_begin(task,index)){scope.finish();return 3;}try{int r=(int)call(pc,task,(uintptr_t)index);if(half)half_end();scope.finish();return r;}catch(...){if(half)half_end();throw;}}
extern "C" int iq4_stock_jpeg_thumbnail_01(uintptr_t task,int index){return job(0x8e1264,task,index);}
extern "C" int iq4_stock_jpeg_4k_01(uintptr_t task,int index){return job(0x8e17c8,task,index);}
static int own_job(){return active==1&&job_thread&&job_thread==iq4_native_current_tid_01();}
extern "C" uintptr_t iq4_stock_half_ifm_wait_02(uintptr_t task,uint32_t timeout,uintptr_t callback){
 if(task==binding.task&&own_job()&&__atomic_load_n(&half_choice,__ATOMIC_ACQUIRE)){
  const unsigned state=__atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE);
  if(state==HALF_ARMED||state==HALF_CLAIMED||state==HALF_ENCODED||state==HALF_COMPLETE)timeout=60000;
 }
 return call(0x713a18,task,timeout,callback);
}
static int half_begin(uintptr_t task,int index){
 if(!own_job()||task!=binding.task||!half_available()||
    __atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE)!=HALF_IDLE)return 0;
 uintptr_t node;char base[33]={};if(!catalog_photo(index,&node,base))return 0;
 half_transaction.task=task;half_transaction.node=node;half_transaction.index=index;
 half_transaction.processor_tid=0;half_transaction.scope={};half_transaction.jpeg={};half_transaction.render={};
 memcpy(half_transaction.base,base,sizeof base);
 __atomic_store_n(&half_transaction.state,HALF_ARMED,__ATOMIC_RELEASE);return 1;
}
static int scope_same(const Iq4HalfScope01&a,const Iq4HalfScope01&b){
 return a.worker==b.worker&&a.generator==b.generator&&a.raw_input==b.raw_input&&
  a.settings==b.settings&&a.pool==b.pool&&a.cancel==b.cancel&&a.node==b.node&&
  a.photo_index==b.photo_index&&a.full_width==b.full_width&&a.full_height==b.full_height;
}
static int half_processing_guard(void*context,const Iq4HalfScope01*scope){
 if(context!=&half_transaction||!scope)return -1;
 unsigned state=__atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE);
 if(state!=HALF_CLAIMED&&state!=HALF_ENCODED)return state==HALF_HOLD?-1:0;
 if(__atomic_load_n(&held,__ATOMIC_ACQUIRE)||__atomic_load_n(&active,__ATOMIC_ACQUIRE)!=1)return -1;
 if(!half_transaction.processor_tid||half_transaction.processor_tid!=iq4_native_current_tid_01()||
    !scope_same(half_transaction.scope,*scope))return -1;
 unsigned char cancelled;if(!rd(scope->cancel,&cancelled,1))return -1;
 return cancelled?0:1;
}
static int half_sink_guard(void*context){return half_processing_guard(context,&half_transaction.scope);}
static int half_encode(void*context,const Iq4HalfScope01*scope,const Iq4HalfArgb01*plane,const Iq4HalfRenderReceipt01*render){
 if(!render||half_processing_guard(context,scope)!=1||render->status!=IQ4_HALF_RENDER_OK_01||
  render->entered!=1||render->stages!=3||render->joins!=3||render->terminal!=1||render->render_returned!=1||
  render->width!=7102||render->height!=5326||render->format!=5||!plane||
  plane->width!=7102||plane->height!=5326||plane->stride!=render->stride)return 0;
 const Iq4HalfJpegStatus01 s=iq4_half_jpeg_encode_01(&half_codec,plane,
  (uint8_t*)(half_transaction.task+0x1f8),104857600u,100,half_sink_guard,context,&half_transaction.jpeg);
 if(s==IQ4_HALF_JPEG_HOLD_01){__atomic_store_n(&held,1,__ATOMIC_RELEASE);__atomic_store_n(&half_transaction.state,HALF_HOLD,__ATOMIC_RELEASE);return 0;}
 if(s!=IQ4_HALF_JPEG_OK_01||half_transaction.jpeg.rows!=5326||
    half_transaction.jpeg.jpeg_bytes<4||half_transaction.jpeg.jpeg_bytes>104857600u)return 0;
 uint32_t claimed=HALF_CLAIMED;
 return __atomic_compare_exchange_n(&half_transaction.state,&claimed,HALF_ENCODED,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE);
}
static void half_finish(void*context,const Iq4HalfScope01*scope,const Iq4HalfRenderReceipt01*render){
 if(context!=&half_transaction||!scope||!render||!scope_same(half_transaction.scope,*scope)){
  __atomic_store_n(&held,1,__ATOMIC_RELEASE);__atomic_store_n(&half_transaction.state,HALF_HOLD,__ATOMIC_RELEASE);return;
 }
 half_transaction.render=*render;
 const bool complete=render->status==IQ4_HALF_RENDER_OK_01&&render->entered==1&&
  render->stages==3&&render->joins==3&&render->terminal==1&&render->render_returned==1&&
  render->settings_restored==1&&half_transaction.jpeg.status==IQ4_HALF_JPEG_OK_01&&half_transaction.jpeg.rows==5326;
 uint32_t state=__atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE);
 while(state==HALF_CLAIMED||state==HALF_ENCODED){
  uint32_t next=complete&&state==HALF_ENCODED?HALF_COMPLETE:HALF_FAILED;
  if(render->status==IQ4_HALF_RENDER_EXCEPTION_01){next=HALF_HOLD;__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
  if(__atomic_compare_exchange_n(&half_transaction.state,&state,next,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))break;
 }
}
extern "C" int iq4_stock_half_acquire_01(const Iq4HalfScope01*scope,Iq4HalfLease01*lease){
 if(!scope||!lease||scope->worker!=half_worker||scope->generator!=half_worker+0x2d8||
  scope->raw_input!=half_worker+UINT64_C(0x65547968)||scope->pool!=half_worker+0x2c0||
  scope->full_width!=14204||scope->full_height!=10652||
  __atomic_load_n(&active,__ATOMIC_ACQUIRE)!=1||__atomic_load_n(&held,__ATOMIC_ACQUIRE))return 0;
 /* Claim before reading ANY transaction payload. Otherwise ARMED->IDLE->
  * ARMED could allow a late worker to race a new job's node/index writes. */
 uint32_t armed=HALF_ARMED;if(!__atomic_compare_exchange_n(&half_transaction.state,&armed,HALF_CLAIMED,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 try{uintptr_t node;char base[33]={};if(scope->node!=half_transaction.node||scope->photo_index!=half_transaction.index||
  !catalog_photo(scope->photo_index,&node,base)||node!=scope->node||memcmp(base,half_transaction.base,sizeof base)){
   uint32_t claimed=HALF_CLAIMED;
   (void)__atomic_compare_exchange_n(&half_transaction.state,&claimed,HALF_ARMED,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE);
   return 0;
  }
  half_transaction.scope=*scope;half_transaction.processor_tid=iq4_native_current_tid_01();
  if(!half_transaction.processor_tid){uint32_t claimed=HALF_CLAIMED;
   (void)__atomic_compare_exchange_n(&half_transaction.state,&claimed,HALF_FAILED,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE);return 0;}
  *lease={&half_transaction,half_processing_guard,half_encode,half_finish};return 1;
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);__atomic_store_n(&half_transaction.state,HALF_HOLD,__ATOMIC_RELEASE);return 0;}
}
static void half_end(){
 uint32_t state=__atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE);
 for(;;){
  if(state==HALF_HOLD)return;
  if(state==HALF_CLAIMED||state==HALF_ENCODED){
   if(!__atomic_compare_exchange_n(&half_transaction.state,&state,HALF_HOLD,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))continue;
   /* The original wait returned before the processing lease retired. Never
    * reuse its task buffer, even if that worker subsequently finishes. */
   __atomic_store_n(&held,1,__ATOMIC_RELEASE);return;
  }
  if(__atomic_compare_exchange_n(&half_transaction.state,&state,HALF_IDLE,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return;
 }
}
extern "C" uint32_t iq4_stock_jpeg_presence_01(uintptr_t original){uintptr_t event=original;if(own_job()&&job_destination==11&&original==binding.group[0]+0x468)event=binding.group[1]+0x468;return(uint32_t)call(0x41497c,event);}
extern "C" uint64_t iq4_stock_jpeg_free_space_01(uintptr_t original){uintptr_t event=original;if(own_job()&&job_destination==11&&original==binding.group[0]+0xdc8)event=binding.group[1]+0xdc8;return(uint64_t)call(0x525034,event);}
static int write_guard(){try{unsigned i=job_destination==11?1:0;uintptr_t p;uint32_t c;return own_job()&&!held&&identities()&&word(binding.task+0x1b0,&p)&&p==binding.fs[i]&&word(binding.task+0x1d8,&p)&&p==binding.power[i]&&scalar(binding.task+0x1e8,&c)&&c==(i?binding.extra_out:binding.native_out)&&power_shape(1,binding.source,(const char*)0xdbc878,1)&&power_shape(i,c,i?client_name:(const char*)0xdbc878,1)&&call(0x41497c,binding.group[i]+0x468)==1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
static int publish_buffer(uintptr_t task,const char*base,uint32_t count){
 const uintptr_t pixels=task+0x1f8;unsigned char marker[2];
 if(count<4||count>104857600||!rd(pixels,marker,2)||marker[0]!=0xff||marker[1]!=0xd8||
  !rd(pixels+count-2,marker,2)||marker[0]!=0xff||marker[1]!=0xd9||!write_guard())return 0;
 if(!(call(0x8e1f7c,task,(uintptr_t)base)&255)||!write_guard())return 0;
 char relative[256],root[256],resolved[256];
 if(!rd(task+0x64001f8,relative,sizeof relative)||!memchr(relative,0,sizeof relative)||
  !rd(binding.fs[job_destination==11]+0x15,root,sizeof root)||!memchr(root,0,sizeof root))return 0;
 if(!(call(0x827348,binding.fs[job_destination==11],(uintptr_t)relative,(uintptr_t)resolved)&255)||
  !memchr(resolved,0,sizeof resolved))return 0;
 size_t prefix=strlen(root);if(strlen(resolved)<prefix||memcmp(resolved,root,prefix))return 0;
 int result=iq4_stock_jpeg_publish_01(root,resolved+prefix,(const void*)pixels,count,write_guard);
 if(result<0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);return result==1;
}
static int half_write(uintptr_t task,const char*base){
 if(task!=half_transaction.task||!base||!own_job()||
  __atomic_load_n(&half_transaction.state,__ATOMIC_ACQUIRE)!=HALF_COMPLETE)return 0;
 char observed[32];if(!rd((uintptr_t)base,observed,sizeof observed)||
  !memchr(observed,0,sizeof observed)||strcmp(observed,half_transaction.base))return 0;
 const Iq4HalfJpegResult01&jpeg=half_transaction.jpeg;
 const Iq4HalfRenderReceipt01&render=half_transaction.render;
 if(jpeg.status!=IQ4_HALF_JPEG_OK_01||jpeg.rows!=5326||jpeg.jpeg_bytes<4||
  jpeg.jpeg_bytes>104857600||render.status!=IQ4_HALF_RENDER_OK_01||
  render.settings_restored!=1||render.stages!=3||render.joins!=3||render.terminal!=1||
  render.width!=7102||render.height!=5326||render.format!=5)return 0;
 return publish_buffer(task,base,(uint32_t)jpeg.jpeg_bytes);
}
extern "C" int iq4_stock_jpeg_encode_write_01(uintptr_t task,const char*base,const void*rgb,uint32_t w,uint32_t h){
 if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return(int)call(0x8e1d70,task,(uintptr_t)base,(uintptr_t)rgb,w,h);
 if(task!=binding.task||!base||!rgb||!w||!h||w>7680||h>7680||!write_guard())return 0;
 try{uintptr_t encoder,vt,fn;if(!word(task+0x1f0,&encoder)||!word(encoder,&vt)||vt!=0xdce100||!word(vt+0x20,&fn)||fn!=0x98d8a8)return 0;
  if(half_choice)return half_write(task,base);
  const uintptr_t pixels=task+0x1f8;int count=(int)call(fn,encoder,(uintptr_t)rgb,w,h,100,pixels,104857600u);
  return count>0?publish_buffer(task,base,(uint32_t)count):0;
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
}
