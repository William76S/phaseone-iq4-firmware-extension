/* 6.03.61: stock 4K only; retain the 55 storage/receipt/gallery contract. */
#include "../f3_stock_jpeg_xqd_01/stock.h"
#include "../f3_stock_jpeg_xqd_01/settings.h"
#include "../jpeg_binding_fix_57/stock_pins_57.h"
#include "size.h"
#include "../f3_stock_half_export_01/quality.h"
#include "../native_runtime_01/self_read.h"
#include "../stock_storage_router_55/router.h"
#include "../stock_storage_router_55/settings.h"
#include "../stock_storage_router_55/plan.h"
#include "../stock_storage_router_55/backend.h"
#include "../stock_storage_router_55/gallery_lease.h"
#include "../stock_storage_router_55/status.h"
#include "../stock_storage_router_55/router_pins_55.h"
#include "../stock_jpeg_gallery_55/gallery.h"
#include "../stock_new_raw_receipt_55/receipt.h"
#include <string.h>
struct Binding {uintptr_t task,group[2],fs[2],power[2],ifm;uint32_t native_out,source,extra_out,sd_source;uintptr_t viewmodel;};
static Binding binding;
static uint32_t bound,destination=10,active,job_destination=10,held,catalog_epoch;
static uint64_t job_thread;
static uint32_t source_card=11,format_choice,policy_generation=1,receipt_bound;
static uintptr_t native_sequence;
static Iq4NewRawTicket55 raw_ticket;
static Iq4NewRawPolicy55 job_policy;
static uintptr_t job_node;static uint32_t job_index;
static uint64_t last_failure;
static struct PendingScope55 {uintptr_t node;uint32_t index,active,applied;uint64_t tid;uintptr_t catalog;} pending_scope;
static void failure(uint32_t stage,uint32_t detail){uint64_t empty=0;
 (void)__atomic_compare_exchange_n(&last_failure,&empty,((uint64_t)stage<<32)|detail,0,__ATOMIC_RELEASE,__ATOMIC_RELAXED);}
extern "C" int iq4_stock_jpeg_last_failure_55(uint32_t*stage,uint32_t*detail){
 if(!stage||!detail||!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return 0;const uint64_t value=__atomic_load_n(&last_failure,__ATOMIC_ACQUIRE);
 *stage=(uint32_t)(value>>32);*detail=(uint32_t)value;return 1;
}
static struct DeleteScope55 {uintptr_t node;uint32_t index,active,applied;uint64_t tid;} deleting;
static Iq4StoragePlan55 job_plan;
static uint32_t publishing_card,jpeg_published_mask;
static struct GalleryLease55 {uint32_t state,card,owned,exclusive;uint64_t tid;} gallery_lease;
static int own_job();
static int capture_idle();
static int bind_receipt();
static int receipt_backup_quiet(void*,uintptr_t,uintptr_t,uint32_t);
extern "C" int iq4_new_raw_open_55(const char*,int,unsigned);
extern "C" uintptr_t iq4_stock_delete_lookup_wrapper_55(uintptr_t,uint32_t);
extern "C" int iq4_stock_jpeg_only_gallery_bound_55(void);
extern "C" int iq4_stock_jpeg_probe_mount_01(const char*,int(*)(void));
static uint32_t probe_card;
static const char client_name[]="Iq4StockJpegXQD01";
static const char sd_source_name[]="Iq4StorageSourceSD55";
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
static int pins(){unsigned char data[64];for(const auto&p:StorageRouterPins55)for(size_t off=0;off<p.bytes;off+=sizeof data){size_t n=p.bytes-off;if(n>sizeof data)n=sizeof data;if(!rd(p.va+off,data,n)||memcmp(data,p.data+off,n))return 0;}for(const auto&p:StockHalfStockPins57)for(size_t off=0;off<p.bytes;off+=sizeof data){size_t n=p.bytes-off;if(n>sizeof data)n=sizeof data;if(!rd(p.va+off,data,n)||memcmp(data,p.data+off,n))return 0;}

#ifndef IQ4_STOCK_JPEG_TEST
 uint32_t opcode;
 const int64_t raw_open_delta=(int64_t)(uintptr_t)iq4_new_raw_open_55-INT64_C(0x825fcc);
 if((raw_open_delta&3)||raw_open_delta<-(INT64_C(1)<<27)||raw_open_delta>=(INT64_C(1)<<27)||!scalar(0x825fcc,&opcode)||
  opcode!=(UINT32_C(0x94000000)|((uint32_t)(raw_open_delta>>2)&0x3ffffff)))return 0;
 const int64_t pending_delta=(int64_t)(uintptr_t)iq4_stock_jpeg_pending_clear_guard_55-INT64_C(0x497630);
 if((pending_delta&3)||pending_delta<-(INT64_C(1)<<27)||pending_delta>=(INT64_C(1)<<27)||!scalar(0x497630,&opcode)||
  opcode!=(UINT32_C(0x94000000)|((uint32_t)(pending_delta>>2)&0x3ffffff)))return 0;
 const int64_t remove_delta=(int64_t)(uintptr_t)iq4_stock_delete_lookup_wrapper_55-INT64_C(0x496f28);
 if((remove_delta&3)||remove_delta<-(INT64_C(1)<<27)||remove_delta>=(INT64_C(1)<<27)||!scalar(0x496f28,&opcode)||
  opcode!=(UINT32_C(0x94000000)|((uint32_t)(remove_delta>>2)&0x3ffffff)))return 0;
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
 return __atomic_load_n(&bound,__ATOMIC_ACQUIRE)&&word(binding.task,&v)&&v==0xdbce40&&word(binding.task+0x1c8,&p)&&p==binding.group[0]&&word(binding.task+0x1d0,&p)&&p==binding.ifm&&word(binding.task+0x1e0,&p)&&p==binding.power[source_card==11]&&scalar(binding.task+0x1ec,&a)&&a==(source_card==11?binding.source:binding.sd_source)&&group_shape(binding.group[0],4)&&group_shape(binding.group[1],2)&&fs_shape(0,binding.fs[0])&&fs_shape(1,binding.fs[1])&&power_shape(0,binding.native_out,(const char*)0xdbc878,0)&&power_shape(1,binding.source,(const char*)0xdbc878,0)&&power_shape(1,binding.extra_out,client_name,0)&&power_shape(0,binding.sd_source,sd_source_name,0)&&scalar(binding.task+0x1b8,&b)&&b==16;
}
static int leases_clear(){uint32_t sd,xqd;if(!scalar(binding.power[0]+0x17c,&sd)||!scalar(binding.power[1]+0x17c,&xqd))return 0;return !(sd&((1u<<binding.native_out)|(1u<<binding.sd_source)))&&!(xqd&((1u<<binding.source)|(1u<<binding.extra_out)));}
static void route(uint32_t card){unsigned i=card==11;put(binding.task+0x1b0,binding.fs[i]);put(binding.task+0x1d8,binding.power[i]);put32(binding.task+0x1e8,i?binding.extra_out:binding.native_out);}
static void source_route(uint32_t card){const unsigned i=card==11;put(binding.task+0x1e0,binding.power[i]);put32(binding.task+0x1ec,i?binding.source:binding.sd_source);__atomic_store_n(&source_card,card,__ATOMIC_RELEASE);}
static int viewmodel_shape(){uintptr_t vt,event;return word(binding.viewmodel,&vt)&&vt==0xbbd068&&word(binding.viewmodel+0x1c8,&event)&&event==binding.group[0]+8&&word(binding.viewmodel+0x2b8,&event)&&event==binding.group[0]+0xe8&&word(binding.viewmodel+0x2c8,&event)&&event==binding.group[0]+0x1c8;}
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
static int release_probe(unsigned i,uint32_t token){uint32_t mask;if(!scalar(binding.power[i]+0x17c,&mask))return 0;if(!(mask&(1u<<token)))return 1;call(0x8ca708,binding.power[i],token);return scalar(binding.power[i]+0x17c,&mask)&&!(mask&(1u<<token));}
/* Internal single-job route preparation, not a product Destination setting. */
static int prepare_route(uint32_t card,uint32_t source){
 if((card!=10&&card!=11)||(source!=10&&source!=11)||!own_job()||!iq4_stock_jpeg_bound_01())return 0;
 const uint32_t before=iq4_stock_jpeg_destination_get_01();
 if(card==before&&source==source_card&&catalog_epoch==card)return 1;
 if(!leases_clear())return 0;unsigned i=card==11;uint32_t token=i?binding.extra_out:binding.native_out;uintptr_t catalog;
 int ok=0,mutated=0;try{if(selected_catalog(&catalog)){
  uint32_t result=(uint32_t)call(0x8ca888,binding.power[i],token,6000);probe_card=card;
  if(result==0&&rescan_guard()&&iq4_stock_jpeg_probe_mount_01(i?"/run/media/xqdcard/":"/run/media/sdcard/",rescan_guard)==1){
   route(card);source_route(source);__atomic_store_n(&destination,card,__ATOMIC_RELEASE);mutated=1;
   {CatalogLock lock(catalog+0x1c0);call(0x493994,catalog,16);}
   if(!held&&rescan_guard()){call(0x493598,catalog,0xb7e920,1024,16);ok=!held&&rescan_guard();}
  }
  if(!release_probe(i,token))__atomic_store_n(&held,1,__ATOMIC_RELEASE);
  if(ok&&!held)__atomic_store_n(&catalog_epoch,card,__ATOMIC_RELEASE);
 }}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 if(mutated&&!ok)__atomic_store_n(&held,1,__ATOMIC_RELEASE);probe_card=0;return ok&&!held;
}
static int backup_clients_quiet(){
 for(unsigned i=0;i<2;++i){uintptr_t vt,name;uint32_t mask;unsigned matched=0;
  if(!word(binding.power[i],&vt)||vt!=0xdb6628||!scalar(binding.power[i]+0x17c,&mask))return 0;
  for(unsigned client=0;client<32;++client){if(!word(binding.power[i]+0x70+8*client,&name))return 0;
   if(name==0xdbcf98){++matched;if(mask&(1u<<client))return 0;}
  }
  if(matched!=1)return 0;
 }
 return 1;
}
static int backup_mode_read(uint32_t*out){uintptr_t vt,getter,setter;
 if(!out||!word(binding.group[0]+0x1c8,&vt)||vt!=0xbca8c8||
  !word(vt+0x40,&getter)||getter!=0x5e7fb8||!word(vt+0x48,&setter)||setter!=0x5e7fec)return 0;
 const uint32_t mode=(uint32_t)call(getter,binding.group[0]+0x1c8);if(mode>2)return 0;*out=mode;return 1;
}
static int backup_restore(uint32_t mode){call(0x5e7fec,binding.group[0]+0x1c8,mode);uint32_t observed;return backup_mode_read(&observed)&&observed==mode;}
static int archive_prepare_only(uint32_t*changed){
 *changed=0;const uint32_t storage=(uint32_t)call(0x495448,binding.viewmodel+0x1d8);
 if(storage>5)return 0;if(storage!=4)return 1;uint32_t mode;if(!backup_mode_read(&mode))return 0;
 if(mode<=1)return 1;
 /* Original All -> New is a reversible native setting change, admitted only
  * under the format/capture lock with no pending copy and no source/output
  * BackupStorage token. Neither pending bits nor old pictures are erased. */
 if(!capture_idle()||iq4_new_raw_active_55()||call(0x8e3d38,binding.ifm)||!backup_clients_quiet())return 0;
 *changed=2;if(!backup_restore(1)||call(0x8e3d38,binding.ifm)||!backup_clients_quiet()||!capture_idle())return 0;
 return 1;
}
static int archive_allows_only(){
 if(!viewmodel_shape())return 0;const uint32_t storage=(uint32_t)call(0x495448,binding.viewmodel+0x1d8);
 if(storage>5)return 0;if(storage!=4)return 1;
 uintptr_t vt,getter;if(!word(binding.group[0]+0x1c8,&vt)||vt!=0xbca8c8||
  !word(vt+0x40,&getter)||getter!=0x5e7fb8)return 0;
 const uint32_t backup=(uint32_t)call(getter,binding.group[0]+0x1c8);return backup<=1?1:0;
}
extern "C" int iq4_stock_storage_capture_format_55(uint32_t*out){
 if(!out||!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return 0;
 const uint32_t value=__atomic_load_n(&format_choice,__ATOMIC_ACQUIRE);if(value>2)return 0;*out=value;return 1;
}
extern "C" int iq4_stock_xqd_format_get_55(uint32_t*out){
 if(!out||!iq4_stock_jpeg_bound_01()||!receipt_bound||!viewmodel_shape()||!iq4_stock_storage_capture_format_55(out))return 0;
 try{return *out!=1||archive_allows_only();}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
}
extern "C" int iq4_stock_xqd_format_set_55(uint32_t value){
 if(value>2||!iq4_stock_jpeg_bound_01()||!viewmodel_shape()||!receipt_bound||
    (value==1&&!iq4_stock_jpeg_only_gallery_bound_55())||!capture_idle()||!iq4_new_raw_settings_enter_55())return 0;
 /* Exact pending-256 count is the original 8e2590/49746c query. An Off
  * notification clears pending JPEG work, so a nonempty queue is busy. */
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_new_raw_settings_leave_55();return 0;}
 int ok=0;uint32_t backup_changed=0;uint32_t old=__atomic_load_n(&format_choice,__ATOMIC_ACQUIRE);
 try{if(capture_idle()&&!iq4_new_raw_active_55()&&leases_clear()&&call(0x8e2590,binding.ifm)==0){
  const uint32_t target=value?1u:0u;
  if(iq4_stock_storage_normalize_sd_55(binding.viewmodel,binding.group[0],binding.group[1])==1&&
    (value!=1||archive_prepare_only(&backup_changed))){
  call(0x5e8c54,binding.group[0]+0xe8,target);
  if(call(0x5e8c20,binding.group[0]+0xe8)==target){
   Iq4Storage55Settings setting={value,65,1};ok=iq4_storage55_settings_save_01(&setting)==IQ4_STORAGE55_SETTINGS_OK;
   if(ok){__atomic_store_n(&format_choice,value,__ATOMIC_RELEASE);__atomic_add_fetch(&policy_generation,1,__ATOMIC_RELEASE);}
   else{call(0x5e8c54,binding.group[0]+0xe8,old?1u:0u);
    if(call(0x5e8c20,binding.group[0]+0xe8)!=(old?1u:0u))__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
  }
  }else if(value==1)__atomic_store_n(&last_failure,((uint64_t)IQ4_JPEG_FAILURE_ARCHIVE55<<32)|2u,__ATOMIC_RELEASE);
  if(!ok&&backup_changed&&!backup_restore(backup_changed))__atomic_store_n(&held,1,__ATOMIC_RELEASE);
 }}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 __atomic_store_n(&active,0,__ATOMIC_RELEASE);iq4_new_raw_settings_leave_55();return ok;
}
extern "C" int iq4_stock_jpeg_mode_get_01(uint32_t*out){if(!out||!iq4_stock_jpeg_bound_01())return 0;try{uint32_t v=(uint32_t)call(0x5e8c20,binding.group[0]+0xe8);if(v>2)return 0;*out=v;return 1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
extern "C" int iq4_stock_jpeg_size_get_01(uint32_t*out){if(!out||!iq4_stock_jpeg_bound_01())return 0;try{uint32_t v=(uint32_t)call(0x5e7350,binding.group[0]+0x2a8);if(v!=1)return 0;*out=v;return 1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
static int set_native(uintptr_t event,uintptr_t getter,uintptr_t setter,uint32_t value){if(!iq4_stock_jpeg_bound_01())return 0;uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;int ok=0;if(!leases_clear()){__atomic_store_n(&active,0,__ATOMIC_RELEASE);return 0;}try{call(setter,event,value);ok=call(getter,event)==value;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}__atomic_store_n(&active,0,__ATOMIC_RELEASE);return ok;}
extern "C" int iq4_stock_jpeg_mode_set_01(uint32_t v){return v<=2&&set_native(binding.group[0]+0xe8,0x5e8c20,0x5e8c54,v);}
extern "C" int iq4_stock_jpeg_size_set_01(uint32_t v){return v==1&&set_native(binding.group[0]+0x2a8,0x5e7350,0x5e7384,v);}
extern "C" int iq4_stock_jpeg_extended_size_get_02(uint32_t*out){
 if(!out||!iq4_stock_jpeg_bound_01())return 0;uint32_t native;
 if(!iq4_stock_jpeg_size_get_01(&native)||native!=1)return 0;
 *out=0;return 1;
}
extern "C" int iq4_stock_jpeg_extended_size_set_02(uint32_t choice){
 if(choice!=0||!iq4_stock_jpeg_bound_01()||!receipt_bound||
    !capture_idle()||!iq4_new_raw_settings_enter_55())return 0;
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){iq4_new_raw_settings_leave_55();return 0;}
 int ok=0;try{if(capture_idle()&&!iq4_new_raw_active_55()&&leases_clear()&&call(0x8e2590,binding.ifm)==0){
  call(0x5e7384,binding.group[0]+0x2a8,1);
  ok=call(0x5e7350,binding.group[0]+0x2a8)==1;
  if(ok)__atomic_add_fetch(&policy_generation,1,__ATOMIC_RELEASE);
 }}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 __atomic_store_n(&active,0,__ATOMIC_RELEASE);iq4_new_raw_settings_leave_55();return ok;
}

extern "C" int iq4_stock_jpeg_quality_get_02(uint32_t*out){
 uintptr_t encoder,vt,fn;if(!out||!iq4_stock_jpeg_bound_01()||
  !word(binding.task+0x1f0,&encoder)||!word(encoder,&vt)||vt!=0xdce100||
  !word(vt+0x20,&fn)||fn!=0x98d8a8)return 0;
 *out=100;return 1;
}
static int capture_idle(){uintptr_t vt,fn;
 return word(native_sequence,&vt)&&vt==0xbd0a38&&word(native_sequence+0x298,&vt)&&
  vt==0x9f18e0&&word(vt+0x40,&fn)&&fn==0x41497c&&call(fn,native_sequence+0x298)==0;
}
extern "C" int iq4_stock_storage_normalize_idle_55(void){
 try{return !__atomic_load_n(&held,__ATOMIC_ACQUIRE)&&identities()&&viewmodel_shape()&&
  receipt_bound&&capture_idle()&&__atomic_load_n(&active,__ATOMIC_ACQUIRE)==0&&
  iq4_new_raw_active_55()==0&&leases_clear()&&call(0x8e2590,binding.ifm)==0&&
  capture_idle();
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
}
extern "C" int iq4_stock_jpeg_gallery_card_guard_55(uint32_t card){
 try{if(__atomic_load_n(&gallery_lease.state,__ATOMIC_ACQUIRE)!=2||gallery_lease.card!=card||
   !gallery_lease.tid||gallery_lease.tid!=iq4_native_current_tid_01()||held||!identities())return 0;
  const unsigned i=card==11;const uint32_t token=i?binding.extra_out:binding.native_out;
  return (card==10||card==11)&&power_shape(i,token,i?client_name:(const char*)0xdbc878,1)&&
   call(0x41497c,binding.group[i]+0x468)==1;
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
}
static int gallery_probe_guard(){return iq4_stock_jpeg_gallery_card_guard_55(gallery_lease.card);}
extern "C" int iq4_stock_jpeg_gallery_card_leave_55(uint32_t card){
 if(__atomic_load_n(&gallery_lease.state,__ATOMIC_ACQUIRE)!=2||gallery_lease.card!=card||
  gallery_lease.tid!=iq4_native_current_tid_01())return 0;
 int ok=1;const unsigned i=card==11;const uint32_t token=i?binding.extra_out:binding.native_out;
 try{if(gallery_lease.owned&&!release_probe(i,token))ok=-1;}catch(...){ok=-1;}
 if(ok<0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);
 const unsigned exclusive=gallery_lease.exclusive;__atomic_store_n(&gallery_lease.state,0,__ATOMIC_RELEASE);
 if(exclusive)__atomic_store_n(&active,0,__ATOMIC_RELEASE);return ok;
}
extern "C" int iq4_stock_jpeg_gallery_card_enter_55(uint32_t card){
 if((card!=10&&card!=11)||!iq4_stock_jpeg_bound_01())return 0;
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&gallery_lease.state,&zero,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 const bool own=own_job();gallery_lease.exclusive=0;gallery_lease.owned=0;
 if(!own){zero=0;if(!__atomic_compare_exchange_n(&active,&zero,2,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){
   __atomic_store_n(&gallery_lease.state,0,__ATOMIC_RELEASE);return 0;}
  gallery_lease.exclusive=1;
 }
 gallery_lease.card=card;gallery_lease.tid=iq4_native_current_tid_01();
 __atomic_store_n(&gallery_lease.state,2,__ATOMIC_RELEASE);
 int result=0;try{const unsigned i=card==11;const uint32_t token=i?binding.extra_out:binding.native_out;uint32_t mask;
  if(gallery_lease.tid&&(own||(capture_idle()&&iq4_new_raw_active_55()==0&&call(0x8e2590,binding.ifm)==0))&&
   scalar(binding.power[i]+0x17c,&mask)){
   if(mask&(1u<<token)){
    /* A foreign card-owner token is never adopted. Only the active writer's
     * own output token can be borrowed. Source uses a different native bit. */
    if(own&&card==job_destination)result=gallery_probe_guard();
   }else{
    gallery_lease.owned=1;
    if(call(0x8ca888,binding.power[i],token,6000)==0&&gallery_probe_guard()&&
     iq4_stock_jpeg_probe_mount_01(i?"/run/media/xqdcard/":"/run/media/sdcard/",gallery_probe_guard)==1)
     result=gallery_probe_guard();
   }
  }
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);result=-1;}
 if(result==1)return 1;const int retired=iq4_stock_jpeg_gallery_card_leave_55(card);
 return result<0||retired<0?-1:0;
}
extern "C" uintptr_t iq4_stock_jpeg_pending_clear_guard_55(uintptr_t cat,uint32_t index,uint32_t mask){
 if(__atomic_load_n(&pending_scope.active,__ATOMIC_ACQUIRE)==2&&pending_scope.tid==iq4_native_current_tid_01()){
  uintptr_t map,entry,node;if(cat!=pending_scope.catalog||mask!=256||index!=pending_scope.index||!word(cat+0x1b0,&map))return 0;
  entry=call(0x48f4f0,map,index);if(!entry||!word(entry+0x20,&node)||node!=pending_scope.node)return 0;
  pending_scope.applied=1;
 }
 return call(0x48793c,cat,index,mask);
}
static int failed_pending_retire(){
 if(!own_job()||held||!job_node||!leases_clear())return 0;
 uintptr_t node,cat;char base[33]={};if(!selected_catalog(&cat)||!catalog_photo((int)job_index,&node,base)||node!=job_node)return 0;
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&pending_scope.active,&zero,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 pending_scope.node=job_node;pending_scope.catalog=cat;pending_scope.index=job_index;pending_scope.applied=0;pending_scope.tid=iq4_native_current_tid_01();
 int ok=0;try{if(pending_scope.tid){__atomic_store_n(&pending_scope.active,2,__ATOMIC_RELEASE);
  call(0x8e25b0,binding.ifm,job_index);__atomic_store_n(&pending_scope.active,1,__ATOMIC_RELEASE);ok=pending_scope.applied;
 }}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 __atomic_store_n(&pending_scope.active,0,__ATOMIC_RELEASE);return ok;
}
static int receipt_read(void*ctx,uintptr_t p,void*out,size_t n){return ctx==&binding&&rd(p,out,n);}
static int receipt_policy(void*ctx,Iq4NewRawPolicy55*out){
 if(ctx!=&binding||!out||!bound||held||!viewmodel_shape())return 0;
 const uint32_t mode=(uint32_t)call(0x495448,binding.viewmodel+0x1d8);
 const uint32_t format=__atomic_load_n(&format_choice,__ATOMIC_ACQUIRE);
 const uint32_t size=0; /* The sole extension choice is stock 4K. */
 if(mode>5||format>2)return 0;
 *out={format,size,mode,0,0,__atomic_load_n(&policy_generation,__ATOMIC_ACQUIRE)};return 1;
}
static int receipt_catalog(void*ctx,uintptr_t node,uint32_t index,const char*base,uint32_t raw_mask,int after_cleanup){
 if(ctx!=&binding||!node||!base||(raw_mask&~6u)||!iq4_stock_jpeg_bound_01())return 0;
 uintptr_t observed;char name[33]={};if(!catalog_photo((int)index,&observed,name)||observed!=node||strcmp(name,base))return 0;
 const uint32_t flags=(uint32_t)call(0x496df4,binding.ifm,index);if((flags&raw_mask)!=raw_mask)return 0;
 if(!after_cleanup)return 1;
 /* Until the exact original asynchronous Archive consumer has retired,
  * source/output token cleanup alone cannot permit source RAW removal. */
 if(!leases_clear()||
  (job_policy.sd_mode==4&&(iq4_new_raw_backup_suppressed_55(node,index)!=1||
   receipt_backup_quiet(ctx,binding.ifm,node,index)!=1)))return 0;
 if(job_policy.format!=1)return 1;uintptr_t cat;if(!selected_catalog(&cat))return 0;
 const int prepare=iq4_stock_jpeg_gallery_prepare_retire_55(cat,node,index,job_destination);
 if(prepare<0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);return prepare==1;
}
extern "C" int iq4_stock_delete_lookup_guard_55(uintptr_t entry,uint32_t index){
 /* Original 496e90 already holds catalog+1c0. A refusal replays its current
  * entry+e byte instead of clearing a possibly different photo's RAW flag. */
 if(__atomic_load_n(&deleting.active,__ATOMIC_ACQUIRE)!=2||
    deleting.tid!=iq4_native_current_tid_01())return 1;
 uintptr_t node;if(index!=deleting.index||!word(entry+0x20,&node)||node!=deleting.node)return 0;
 deleting.applied=1;return 1;
}
static int receipt_removed(void*ctx,uintptr_t node,uint32_t index,uint32_t raw_mask){
 if(ctx!=&binding||!node||!raw_mask||(raw_mask&~6u)||!leases_clear())return 0;
 uintptr_t actual;char base[33]={};if(!catalog_photo((int)index,&actual,base)||actual!=node)return 0;
 uint32_t zero=0;if(!__atomic_compare_exchange_n(&deleting.active,&zero,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;
 int ok=0;try{const uint32_t before=(uint32_t)call(0x496df4,binding.ifm,index);
  deleting.node=node;deleting.index=index;deleting.applied=0;deleting.tid=iq4_native_current_tid_01();
  if(deleting.tid){__atomic_store_n(&deleting.active,2,__ATOMIC_RELEASE);
   call(0x496e90,binding.ifm,index,raw_mask);
   __atomic_store_n(&deleting.active,1,__ATOMIC_RELEASE);
   ok=deleting.applied&&catalog_photo((int)index,&actual,base)&&actual==node&&
       (uint32_t)call(0x496df4,binding.ifm,index)==(before&~raw_mask);
   if(ok&&!(before&~raw_mask&6u)){uintptr_t cat;if(!selected_catalog(&cat))ok=0;
    else{const int committed=iq4_stock_jpeg_gallery_commit_retire_55(cat,node,index,job_destination);
     ok=committed==1;if(committed<0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
   }
  }
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
 __atomic_store_n(&deleting.active,0,__ATOMIC_RELEASE);return ok;
}
static int receipt_backup_quiet(void*ctx,uintptr_t ifm,uintptr_t node,uint32_t index){
 if(ctx!=&binding||ifm!=binding.ifm||!node||!iq4_stock_jpeg_bound_01())return 0;
 uintptr_t backup_vt,getter;
 if(!word(binding.group[0]+0x1c8,&backup_vt)||backup_vt!=0xbca8c8||
  !word(backup_vt+0x40,&getter)||getter!=0x5e7fb8||call(getter,binding.group[0]+0x1c8)>1)return 0;
 /* Original named client quiescence is checked again before every delete. */
 if(!backup_clients_quiet())return 0;
 uintptr_t cat,map,entry,actual;uint32_t count;uint8_t flags;uint16_t pending;
 if(!selected_catalog(&cat))return 0;CatalogLock lock(cat+0x1c0);
 if(!scalar(cat+0x1b8,&count)||index>=count||!word(cat+0x1b0,&map))return 0;
 entry=call(0x48f4f0,map,index);
 return entry&&word(entry+0x20,&actual)&&actual==node&&rd(entry+0xe,&flags,1)&&
  (flags&6u)==2u&&rd(entry+0x10,&pending,2)&&!(pending&0x80u);
}
static int bind_receipt(){Iq4NewRawOps55 ops={&binding,receipt_read,receipt_policy,receipt_catalog,receipt_removed,binding.fs[1],binding.fs[0],receipt_backup_quiet};return iq4_new_raw_bind_55(&ops)==1;}
extern "C" void iq4_stock_jpeg_ctor_01(uintptr_t task,uintptr_t sd,uintptr_t ifm,uintptr_t sd_power,uintptr_t xqd_power,uintptr_t sd_fs,uintptr_t main_sp){
 /* Preserve the original constructor, including native unwind, first. */
 call(0x8e0928,task,sd,ifm,sd_power,xqd_power,sd_fs);
 try{uintptr_t registry,array,xqd,vt;uint32_t a,b;Binding candidate={};
  if(bound||!main_sp||!pins()||!word(main_sp+0x460,&registry)||!word(main_sp+0x1b00,&array)||!word(array+8,&xqd)||!group_shape(sd,4)||!group_shape(xqd,2)||!word(task,&vt)||vt!=0xdbce40||!scalar(task+0x1e8,&a)||!scalar(task+0x1ec,&b)||a>=32||b>=32)return;
  candidate.task=task;candidate.group[0]=sd;candidate.group[1]=xqd;candidate.ifm=ifm;candidate.power[0]=sd_power;candidate.power[1]=xqd_power;candidate.fs[0]=sd_fs;candidate.fs[1]=call(0x74e454,registry,11,1);candidate.native_out=a;candidate.source=b;if(!word(main_sp+0x1af0,&candidate.viewmodel)||!word(main_sp+0x1c88,&native_sequence))return;
  if(!fs_shape(0,sd_fs)||!fs_shape(1,candidate.fs[1]))return;binding=candidate;if(!viewmodel_shape())return;
  if(!power_shape(0,a,(const char*)0xdbc878,0)||!power_shape(1,b,(const char*)0xdbc878,0))return;
  /* One independent output client on the existing shared XQDWrite owner. */
  binding.extra_out=(uint32_t)call(0x8ca3ec,xqd_power,(uintptr_t)client_name);
  if(binding.extra_out==binding.source||!power_shape(1,binding.extra_out,client_name,0))return;
  binding.sd_source=(uint32_t)call(0x8ca3ec,sd_power,(uintptr_t)sd_source_name);
  if(binding.sd_source==binding.native_out||!power_shape(0,binding.sd_source,sd_source_name,0))return;
  Iq4Storage55Settings cfg={0,65,1};int state=iq4_storage55_settings_load_01(&cfg);
  if(state==IQ4_STORAGE55_SETTINGS_ABSENT){uint32_t original=(uint32_t)call(0x5e8c20,sd+0xe8);if(original>2)return;cfg.mode=original?2:0;}
  else if(state!=IQ4_STORAGE55_SETTINGS_OK)return;
  /* Cold JPEG-only can bind its true gallery only after our actual card
   * clients and receipt provider exist. Keep factory RAW storage available
   * while that finite bind runs; never rewrite the saved format on refusal. */
  format_choice=cfg.mode==1?0u:cfg.mode;call(0x5e7384,binding.group[0]+0x2a8,1);route(11);source_route(11);
  call(0x5e8c54,sd+0xe8,format_choice?1:0);if(call(0x5e8c20,sd+0xe8)!=(format_choice?1u:0u))return;
  __atomic_store_n(&destination,11,__ATOMIC_RELEASE);__atomic_store_n(&bound,1,__ATOMIC_RELEASE);
  if(!capture_idle()||!bind_receipt()){__atomic_store_n(&bound,0,__ATOMIC_RELEASE);return;}receipt_bound=1;
  uintptr_t cat;const int gallery_ready=selected_catalog(&cat)?iq4_stock_jpeg_gallery_bind_55(cat):0;
  if(cfg.mode==1){if(gallery_ready!=1||!iq4_stock_jpeg_only_gallery_bound_55()){
    failure(IQ4_JPEG_FAILURE_HOLD55,1);__atomic_store_n(&held,1,__ATOMIC_RELEASE);return;}
   __atomic_store_n(&format_choice,1,__ATOMIC_RELEASE);if(!archive_allows_only()){
    failure(IQ4_JPEG_FAILURE_ARCHIVE55,2);return;}call(0x5e8c54,sd+0xe8,1);
   if(call(0x5e8c20,sd+0xe8)!=1){failure(IQ4_JPEG_FAILURE_HOLD55,2);__atomic_store_n(&held,1,__ATOMIC_RELEASE);}
  }
 }catch(...){/* Binding never owns a request. Stock constructor remains usable. */__atomic_store_n(&bound,0,__ATOMIC_RELEASE);}
}
class Job {bool installed,returned;public:
 Job():installed(false),returned(false){}
 bool start(uintptr_t task,int index){uint32_t zero=0;if(task!=binding.task||!iq4_stock_jpeg_bound_01()||!__atomic_compare_exchange_n(&active,&zero,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return false;
  __atomic_store_n(&last_failure,UINT64_C(0),__ATOMIC_RELEASE);job_node=0;
  job_thread=iq4_native_current_tid_01();if(!job_thread){__atomic_store_n(&active,0,__ATOMIC_RELEASE);return false;}installed=true;
  uintptr_t photo;char base[33]={};if(!catalog_photo(index,&photo,base))return false;job_node=photo;job_index=(uint32_t)index;
  const bool captured=iq4_new_raw_policy_55(photo,(uint32_t)index,&job_policy)==1;
  if(!captured&&!receipt_policy(&binding,&job_policy))return false;
  const uint32_t format=job_policy.format;if(!format||job_policy.size!=0)return false;
  if(format==1&&!archive_allows_only()){failure(IQ4_JPEG_FAILURE_ARCHIVE55,2);return false;}
  const uint32_t sd_mode=job_policy.sd_mode;
  uint32_t present=0;for(unsigned i=0;i<2;++i){uintptr_t flag=call(0x41497c,binding.group[i]+0x468);if(flag>1)return false;present|=(uint32_t)flag<<i;}
  const uint32_t raw_flags=(uint32_t)call(0x496df4,binding.ifm,(uint32_t)index);
  if(!iq4_storage_plan_55(format,sd_mode,present,raw_flags,&job_plan)||!job_plan.jpeg_mask)return false;
  if(!prepare_route(job_plan.primary_card,job_plan.source_card))return false;
  job_destination=job_plan.primary_card;publishing_card=jpeg_published_mask=0;raw_ticket={};
  if(captured){const uint32_t native_jpeg_mask=((job_plan.jpeg_mask&1)?4u:0u)|((job_plan.jpeg_mask&2)?2u:0u);
   const int acquired=iq4_new_raw_acquire_55(photo,(uint32_t)index,&job_policy,raw_flags,native_jpeg_mask,&raw_ticket);
   if(format==1&&acquired!=1)return false;
  }else if(format==1)return false;
  return true;
 }
 void finish(){returned=true;}
 ~Job(){if(installed){if(!returned)__atomic_store_n(&held,1,__ATOMIC_RELEASE);job_thread=0;__atomic_store_n(&active,0,__ATOMIC_RELEASE);}}
};
static int retire_raw_ticket(int result,int allow_delete){
 if(!raw_ticket.serial)return result;
 const uint32_t mask=((jpeg_published_mask&1)?4u:0u)|((jpeg_published_mask&2)?2u:0u);
 const int published=iq4_new_raw_publication_55(raw_ticket,mask);
 const bool cleanup=leases_clear();
 const int ended=iq4_new_raw_end_55(raw_ticket,allow_delete&&result==0&&published==1&&cleanup&&
                  (job_policy.format!=1||iq4_stock_jpeg_only_gallery_bound_55()));
 /* Zero means no retirement was proven (e.g. the receipt lock is busy).
  * Keep the ticket and stop further jobs instead of losing its owners. */
 if(ended<=0){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 5;}
 raw_ticket={};if(job_policy.format==1&&ended!=IQ4_NEW_RAW_OK55)return 5;
 return result;
}
static int job(uintptr_t pc,uintptr_t task,int index){
 if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return (int)call(pc,task,(uintptr_t)index);
 Job scope;if(!scope.start(task,index)){if(own_job()&&job_node&&!held)(void)failed_pending_retire();scope.finish();return 3;}
 try{int r=(int)call(pc,task,(uintptr_t)index);
  r=retire_raw_ticket(r,1);if(r>=2){if(held)failure(IQ4_JPEG_FAILURE_HOLD55,0);
   else if(!failed_pending_retire())failure(IQ4_JPEG_FAILURE_PENDING55,0);}
  scope.finish();return r;}
 catch(...){try{(void)retire_raw_ticket(5,0);}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);}throw;}
}
extern "C" int iq4_stock_jpeg_thumbnail_01(uintptr_t task,int index){return job(0x8e1264,task,index);}
extern "C" int iq4_stock_jpeg_4k_01(uintptr_t task,int index){return job(0x8e17c8,task,index);}
static int own_job(){return active==1&&job_thread&&job_thread==iq4_native_current_tid_01();}
extern "C" uint32_t iq4_stock_jpeg_presence_01(uintptr_t original){uintptr_t event=original;if(own_job()&&job_destination==11&&original==binding.group[0]+0x468)event=binding.group[1]+0x468;return(uint32_t)call(0x41497c,event);}
extern "C" uint64_t iq4_stock_jpeg_free_space_01(uintptr_t original){uintptr_t event=original;if(own_job()&&job_destination==11&&original==binding.group[0]+0xdc8)event=binding.group[1]+0xdc8;return(uint64_t)call(0x525034,event);}
static int write_guard(){try{unsigned i=(publishing_card?publishing_card:job_destination)==11?1:0;uintptr_t p;uint32_t c;return own_job()&&!held&&identities()&&word(binding.task+0x1b0,&p)&&p==binding.fs[i]&&word(binding.task+0x1d8,&p)&&p==binding.power[i]&&scalar(binding.task+0x1e8,&c)&&c==(i?binding.extra_out:binding.native_out)&&power_shape(source_card==11,source_card==11?binding.source:binding.sd_source,source_card==11?(const char*)0xdbc878:sd_source_name,1)&&power_shape(i,c,i?client_name:(const char*)0xdbc878,1)&&call(0x41497c,binding.group[i]+0x468)==1;}catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}}
static int publish_card(uintptr_t task,const char*base,uint32_t count,uint32_t card){
 const unsigned i=card==11;const uint32_t token=i?binding.extra_out:binding.native_out;
 const bool mirror=card!=job_destination;int result=0;bool requested=false;
 try{
  if(mirror){if(!write_guard())return 0;uint32_t mask;
   if(!scalar(binding.power[i]+0x17c,&mask)||(mask&(1u<<token)))return 0;
   if(call(0x8ca888,binding.power[i],token,6000)!=0)return 0;requested=true;
   route(card);publishing_card=card;
  }
  if(write_guard()&&(call(0x8e1f7c,task,(uintptr_t)base)&255)&&write_guard()){
   char relative[256],root[256],resolved[256];
   if(rd(task+0x64001f8,relative,sizeof relative)&&memchr(relative,0,sizeof relative)&&
      rd(binding.fs[i]+0x15,root,sizeof root)&&memchr(root,0,sizeof root)&&
      (call(0x827348,binding.fs[i],(uintptr_t)relative,(uintptr_t)resolved)&255)&&memchr(resolved,0,sizeof resolved)){
    const size_t prefix=strlen(root);if(strlen(resolved)>=prefix&&!memcmp(resolved,root,prefix))
     result=iq4_stock_jpeg_publish_01(root,resolved+prefix,(const void*)(task+0x1f8),count,write_guard);
   }
  }
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);result=-1;}
 if(mirror){
  /* The original call's output fields and requester are restored before its
   * own cleanup. The independent mirror lease never adopts its client bit. */
  route(job_destination);publishing_card=0;
  if(requested)try{if(!release_probe(i,token)){__atomic_store_n(&held,1,__ATOMIC_RELEASE);result=-1;}}
   catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);result=-1;}
 }
 if(result<0)__atomic_store_n(&held,1,__ATOMIC_RELEASE);
 if(result!=1)failure(IQ4_JPEG_FAILURE_CARD55,(uint32_t)(result<0?2:card));
 if(result==1)jpeg_published_mask|=1u<<i;return result==1;
}
static int publish_buffer(uintptr_t task,const char*base,uint32_t count){
 const uintptr_t pixels=task+0x1f8;unsigned char marker[2];
 if(count<4||count>104857600||!rd(pixels,marker,2)||marker[0]!=0xff||marker[1]!=0xd8||
  !rd(pixels+count-2,marker,2)||marker[0]!=0xff||marker[1]!=0xd9||!write_guard())return 0;
 if(!publish_card(task,base,count,job_destination))return 0;
 const uint32_t peer=job_destination==11?10:11;
 if((job_plan.jpeg_mask&(1u<<(peer-10)))&&!publish_card(task,base,count,peer))return 0;
 return jpeg_published_mask==job_plan.jpeg_mask;
}
extern "C" int iq4_stock_jpeg_encode_write_01(uintptr_t task,const char*base,const void*rgb,uint32_t w,uint32_t h){
 if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE))return(int)call(0x8e1d70,task,(uintptr_t)base,(uintptr_t)rgb,w,h);
 if(task!=binding.task||!base||!rgb||!w||!h||w>7680||h>7680||!write_guard())return 0;
 try{uintptr_t encoder,vt,fn;if(!word(task+0x1f0,&encoder)||!word(encoder,&vt)||vt!=0xdce100||!word(vt+0x20,&fn)||fn!=0x98d8a8)return 0;
  const uintptr_t pixels=task+0x1f8;int count=(int)call(fn,encoder,(uintptr_t)rgb,w,h,100,pixels,104857600u);
  return count>0?publish_buffer(task,base,(uint32_t)count):0;
 }catch(...){__atomic_store_n(&held,1,__ATOMIC_RELEASE);return 0;}
}
