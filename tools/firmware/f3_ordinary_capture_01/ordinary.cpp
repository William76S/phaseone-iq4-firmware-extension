#include "ordinary.hpp"
#include "pins.inc"
#include <cstring>
namespace iq4::ordinary_capture_01 {
namespace {
bool ptr(uintptr_t p,size_t span){return p&&!(p&7)&&p<=UINTPTR_MAX-span;}
bool twice(Memory m,uintptr_t p,void*out,size_t n){
 unsigned char b[64];return m.read&&p&&n&&n<=sizeof(b)&&p<=UINTPTR_MAX-n&&
 m.read(m.context,p,out,n)==1&&m.read(m.context,p,b,n)==1&&!std::memcmp(out,b,n);
}
template<class T>bool get(Memory m,uintptr_t p,T&v){return twice(m,p,&v,sizeof(v));}
bool same(const Identity&a,const Identity&b){return a.pool==b.pool&&a.node==b.node&&
 a.metadata_resource==b.metadata_resource&&a.metadata==b.metadata&&
 a.raw_resource==b.raw_resource&&a.capture_number==b.capture_number&&a.black_control==b.black_control;}
bool linked_tail(Memory m,uintptr_t queue,uintptr_t link,uintptr_t node){
 uintptr_t head=0,tail=0,next=~uintptr_t(0),back=0,seen[Guard::Capacity]{};
 if(!get(m,queue+8,head)||!ptr(head,16)||!get(m,queue+0x10,tail)||tail!=link||
    !get(m,link,next)||next||!get(m,link+8,back)||back!=node)return false;
 uintptr_t cursor=head;
 for(unsigned count=0;count<Guard::Capacity;++count){
  if(!ptr(cursor,16))return false;
  for(unsigned i=0;i<count;++i)if(seen[i]==cursor)return false;
  seen[count]=cursor;
  if(cursor==link){uintptr_t h=0,t=0;return get(m,queue+8,h)&&h==head&&get(m,queue+16,t)&&t==tail;}
  if(!get(m,cursor,cursor))return false;
 }
 return false;
}
bool inspect(Memory m,uintptr_t pool,uintptr_t node,Identity&out){
 Identity a{};uintptr_t vt=0;uint8_t first_black=255;
 if(!ptr(pool,0x328)||!ptr(node,0x98)||!get(m,pool,vt)||vt!=0xdb4980)return false;
 a.pool=pool;a.node=node;
 if(!get(m,node+0x90,a.metadata_resource)||!ptr(a.metadata_resource,0x48)||
    !get(m,a.metadata_resource+0x40,a.metadata)||!ptr(a.metadata,0x24e8)||
    !get(m,node+0x88,a.raw_resource)||!ptr(a.raw_resource,0x48)||
    !get(m,a.metadata+0xb8,a.capture_number)||
    !get(m,a.metadata+0x484,a.black_control)||a.black_control>4||
    !get(m,a.metadata+0x490,first_black)||first_black)return false;
 out=a;return true;
}
bool classify(Memory m,uintptr_t cm,uintptr_t pool,uintptr_t node,Identity&out){
 uintptr_t p=0,production=0;uint8_t enabled=255,veto=255,first_black=255;uint32_t control=~0u,number=0,compare=~0u;
 if(!ptr(cm,0x8100)||!get(m,cm+0x2090,p)||p!=pool||!get(m,cm+0x2098,p)||p!=node||
    !get(m,cm+0x80f8,production)||!ptr(production,0x148c)||
    !get(m,production+0x1a0,enabled)||enabled||
    !get(m,production+0x1488,compare)||compare||
    !get(m,cm+0xc08,veto)||veto||!get(m,cm+0x2708,first_black)||first_black||
    !get(m,cm+0x26fc,control)||control>4||!get(m,cm+0x2330,number))return false;
 Identity a{},b{};
 if(!inspect(m,pool,node,a)||!inspect(m,pool,node,b)||!same(a,b)||a.black_control!=control||a.capture_number!=number)return false;
 // Recheck mutable native owners after the complete identity read.
 uint8_t enabled2=255,veto2=255,first2=255;uint32_t control2=~0u,number2=0,compare2=~0u;
 if(!get(m,cm+0x2090,p)||p!=pool||!get(m,cm+0x2098,p)||p!=node||
    !get(m,cm+0x80f8,p)||p!=production||!get(m,production+0x1a0,enabled2)||enabled2||
    !get(m,production+0x1488,compare2)||compare2||!get(m,cm+0xc08,veto2)||veto2||
    !get(m,cm+0x2708,first2)||first2||!get(m,cm+0x26fc,control2)||control2!=control||
    !get(m,cm+0x2330,number2)||number2!=number)return false;
 out=a;return true;
}
}
bool Guard::enter() noexcept {
 uint32_t empty=0;if(__atomic_compare_exchange_n(&lock_,&empty,1,false,__ATOMIC_ACQUIRE,__ATOMIC_RELAXED))return true;
 // A missed invalidation must not leave an old positive receipt behind. No wait
 // in a native camera task. Contention invalidates the current receipt epoch.
 __atomic_add_fetch(&epoch_,1,__ATOMIC_ACQ_REL);return false;
}
void Guard::leave() noexcept {__atomic_store_n(&lock_,0,__ATOMIC_RELEASE);}
void Guard::purge() noexcept {auto e=__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE);for(auto&s:slots_)if(s.state&&s.epoch!=e)s={};}
uint64_t Guard::begin(Memory m,uintptr_t cm,uintptr_t pool,uintptr_t node) noexcept {
 if(!enter())return 0;uint64_t token=0;auto e=__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE);purge();
 // Every observation of this enqueue invalidates an older use of the address,
 // even if this observation turns out to be calibration or unreadable.
 for(auto&s:slots_)if(s.state&&s.id.node==node)s={};
 try {Identity id{};if(classify(m,cm,pool,node,id)&&serial_!=UINT64_MAX&&__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE)==e){
  for(auto&s:slots_)if(!s.state){token=++serial_;s={id,token,e,1};break;}
 }}catch(...){token=0;}
 leave();return token;
}
void Guard::complete(uint64_t token,bool normal) noexcept {
 if(!token||!enter())return;purge();for(auto&s:slots_)if(s.state&&s.token==token){if(!normal||s.state!=2)s={};break;}leave();
}
void Guard::before_queue_unlock(Memory m,uintptr_t guard,uintptr_t queue,uintptr_t link,uint32_t native_result) noexcept {
 if(!enter())return;purge();auto epoch=__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE);
 for(auto&s:slots_){if(s.state==1&&s.id.pool<=UINTPTR_MAX-0x98&&s.id.pool+0x98==queue&&
    s.id.node<=UINTPTR_MAX-0x78&&s.id.node+0x78==link){
  bool accepted=false;try{uintptr_t mutex=0;Identity id{};
   accepted=native_result==1&&ptr(queue,0x90)&&get(m,guard,mutex)&&mutex==queue+0x20&&
     linked_tail(m,queue,link,s.id.node)&&
     inspect(m,s.id.pool,s.id.node,id)&&same(id,s.id)&&__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE)==epoch;
  }catch(...){accepted=false;}if(accepted)s.state=2;else s={};break;
 }}
 leave();
}
void Guard::invalidate(uintptr_t node) noexcept {
 if(!node||!enter())return;purge();for(auto&s:slots_)if(s.state&&s.id.node==node)s={};leave();
}
bool Guard::consume(Memory m,uintptr_t manager,uintptr_t node) noexcept {
 if(!enter())return false;purge();bool accepted=false;auto epoch=__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE);
 for(auto&s:slots_){if(s.state&&s.id.node==node){
  // Remove even a pending, mismatched or unreadable receipt. A later pointer
  // reuse may not turn a failed lookup into a successful export.
  Slot receipt=s;s={};
  try {uintptr_t current=0,pool=0;Identity a{},b{};
   accepted=receipt.state==2&&ptr(manager,0x50)&&get(m,manager+0x48,current)&&current==node&&
    get(m,manager+0x38,pool)&&pool==receipt.id.pool&&inspect(m,pool,node,a)&&same(a,receipt.id)&&
    inspect(m,pool,node,b)&&same(a,b)&&get(m,manager+0x48,current)&&current==node&&
    get(m,manager+0x38,pool)&&pool==receipt.id.pool&&__atomic_load_n(&epoch_,__ATOMIC_ACQUIRE)==epoch;
  }catch(...){accepted=false;}break;
 }}
 leave();return accepted;
}
bool original_prefixes(Memory m) noexcept {
 try {unsigned char b[64];for(const auto&p:OrdinaryPins01)if(p.bytes>sizeof(b)||!twice(m,p.va,b,p.bytes)||std::memcmp(b,p.data,p.bytes))return false;return true;}catch(...){return false;}
}
} // namespace iq4::ordinary_capture_01
