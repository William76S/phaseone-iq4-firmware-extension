#include "../f3_native_render_02/persistent_pool.hpp"
#include "../native_runtime_01/self_read.h"
#include <cstring>
static unsigned pool_detail01;
extern "C" unsigned iq4_f3_pool_detail_01(){return __atomic_load_n(&pool_detail01,__ATOMIC_ACQUIRE);}
static void detail01(unsigned n){__atomic_store_n(&pool_detail01,n,__ATOMIC_RELEASE);}
namespace iq4::native_render_02 {
struct PoolLock {unsigned* word;bool owned;
 explicit PoolLock(unsigned& w):word(&w),owned(!__atomic_exchange_n(word,1u,__ATOMIC_ACQUIRE)){}
 ~PoolLock(){if(owned)__atomic_store_n(word,0u,__ATOMIC_RELEASE);}};
static PersistentPool process_pool;
PersistentPool& persistent_pool_02() noexcept{return process_pool;}
bool PersistentPool::snapshot(bool started) const {
 unsigned char header[0x18];const auto p=reinterpret_cast<std::uintptr_t>(storage_);
 if(!read_||read_(context_,p,header,sizeof header)!=1){detail01(10);return false;}
 std::uintptr_t array=0;std::uint32_t count=0,stack=0,priority=0;
 std::memcpy(&array,header,8);std::memcpy(&count,header+8,4);std::memcpy(&stack,header+12,4);std::memcpy(&priority,header+16,4);
 if(array<4096||array>UINTPTR_MAX-24){detail01(11);return false;}
 if(count!=3){detail01(12);return false;}if(stack!=4096){detail01(13);return false;}if(priority!=1){detail01(14);return false;}if(header[20]!=1){detail01(15);return false;}
 std::uintptr_t previous[3]={};
 for(unsigned i=0;i<3;++i){std::uintptr_t worker=0,vt=0;std::uint32_t index=0;unsigned char running=0;
  if(read_(context_,array+i*8,&worker,8)!=1||worker<4096||worker>UINTPTR_MAX-0x360){detail01(20+i*10);return false;}
  if(read_(context_,worker,&vt,8)!=1||vt!=0xc24fd0){detail01(21+i*10);return false;}
  if(read_(context_,worker+0x338,&index,4)!=1||index!=i){detail01(22+i*10);return false;}
  if(started&&(read_(context_,worker+0x158,&running,1)!=1||running!=1)){detail01(23+i*10);return false;}
  for(unsigned j=0;j<i;++j)if(worker<previous[j]+0x360&&previous[j]<worker+0x360){detail01(24+i*10);return false;}
  previous[i]=worker;
 }return true;
}
Result PersistentPool::initialize(NativePoolApi api,Iq4DecodeRead02 read,void* context){
 PoolLock lock(lock_word_);if(!lock.owned)return Result::Busy;
 if(quarantined_)return Result::Hold;if(attempted_)return started_?Result::Ok:Result::Hold;
 if(!read||!api.construct||!api.start||!api.join||!api.exact_static_abi_and_runtime_bytes||!api.cpp_unwind_verified)return Result::Unbound;
 api_=api;read_=read;context_=context;attempted_=true;
 try{
  // Original ICE ctor uses exactly count3/priority1/stack4096. Distinct fixed
  // name and distinct native object: never reuse the original shared ICE pool.
  detail01(1);api_.construct(storage_,"IQ4_F3_Own",3,1,4096);constructed_=true;detail01(2);
  if(!snapshot(false)){quarantined_=true;return Result::Hold;}
  detail01(3);api_.start(storage_);detail01(4);if(!snapshot(true)){quarantined_=true;return Result::Hold;}
  started_=true;detail01(5);return Result::Ok;
 }catch(...){quarantined_=true;return Result::Hold;}
}
Result PersistentPool::acquire(PoolLease& out,std::uint64_t& token){
 PoolLock lock(lock_word_);if(!lock.owned){out={};token=0;return Result::Busy;}
 out={};token=0;if(quarantined_)return Result::Hold;if(!started_)return Result::Unbound;if(leased_)return Result::Busy;
 if(!snapshot(true)||sequence_==UINT64_MAX){quarantined_=true;return Result::Hold;}
 const auto tid=iq4_native_current_tid_01();if(!tid)return Result::Unbound;
 leased_=true;token_=++sequence_;thread_=tid;out={storage_,this,held};token=token_;return Result::Ok;
}
bool PersistentPool::held(void* context,const void* p){auto& self=*static_cast<PersistentPool*>(context);
 PoolLock lock(self.lock_word_);if(!lock.owned)return false;
 return self.leased_&&!self.quarantined_&&self.started_&&p==self.storage_&&self.thread_==iq4_native_current_tid_01()&&self.snapshot(true);}
Result PersistentPool::release_after_join(std::uint64_t token){
 PoolLock lock(lock_word_);if(!lock.owned)return Result::Busy;
 if(quarantined_)return Result::Hold;if(!leased_||!token||token!=token_||thread_!=iq4_native_current_tid_01())return Result::Argument;
 try{if(!snapshot(true)){quarantined_=true;return Result::Hold;}api_.join(storage_);
  if(!snapshot(true)){quarantined_=true;return Result::Hold;}leased_=false;thread_=0;return Result::Ok;
 }catch(...){quarantined_=true;return Result::Hold;}
}
}
