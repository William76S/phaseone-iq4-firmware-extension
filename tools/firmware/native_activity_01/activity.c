#include "activity.h"
#include <stdatomic.h>
_Static_assert(sizeof(uintptr_t)==8&&ATOMIC_LLONG_LOCK_FREE==2,"AArch64 lock-free own gate");
static uint64_t current;static uintptr_t owner;
#define HOLD UINT64_C(8)
#define GEN_MAX (UINT64_MAX>>4)
static int actor(uint32_t a){return a==IQ4_ACTIVITY_JPEG01||a==IQ4_ACTIVITY_MOVIE01;}
static int match(const struct Iq4ActivityLease01*l,uint64_t*word){
 if(!l||!l->owner||!actor((uint32_t)(l->word&7))||(l->word&HOLD)||!(l->word>>4))return IQ4_ACTIVITY_REJECTED01;
 uint64_t a=__atomic_load_n(&current,__ATOMIC_ACQUIRE);uintptr_t p=__atomic_load_n(&owner,__ATOMIC_ACQUIRE);
 uint64_t b=__atomic_load_n(&current,__ATOMIC_ACQUIRE);
 if(a!=b||(a&~HOLD)!=l->word||p!=l->owner)return IQ4_ACTIVITY_REJECTED01;
 *word=a;return a&HOLD?IQ4_ACTIVITY_HELD01:IQ4_ACTIVITY_OK01;
}
int iq4_activity_try_01(uint32_t a,const void*p,struct Iq4ActivityLease01*out){
 if(!actor(a)||!p||!out)return IQ4_ACTIVITY_REJECTED01;
 uint64_t before=__atomic_load_n(&current,__ATOMIC_ACQUIRE);
 for(unsigned i=0;i<8;++i){if(before&7)return before&HOLD?IQ4_ACTIVITY_HELD01:IQ4_ACTIVITY_BUSY01;
  if((before&HOLD)||(before>>4)==GEN_MAX)return IQ4_ACTIVITY_REJECTED01;
  uint64_t next=(((before>>4)+1)<<4)|a;
  if(__atomic_compare_exchange_n(&current,&before,next,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)){
   __atomic_store_n(&owner,(uintptr_t)p,__ATOMIC_RELEASE);*out=(struct Iq4ActivityLease01){next,(uintptr_t)p};return IQ4_ACTIVITY_OK01;
  }
 }return IQ4_ACTIVITY_BUSY01;
}
int iq4_activity_valid_01(const struct Iq4ActivityLease01*l){uint64_t w;return match(l,&w);}
int iq4_activity_hold_01(const struct Iq4ActivityLease01*l){uint64_t w;int r=match(l,&w);if(r!=IQ4_ACTIVITY_OK01)return r;
 return __atomic_compare_exchange_n(&current,&w,w|HOLD,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)?IQ4_ACTIVITY_HELD01:IQ4_ACTIVITY_REJECTED01;
}
int iq4_activity_release_01(const struct Iq4ActivityLease01*l){uint64_t w;int r=match(l,&w);if(r!=IQ4_ACTIVITY_OK01)return r;
 /* Do not clear owner after this CAS: a later generation could already have
  * acquired and written its owner. Idle snapshots intentionally omit it. */
 return __atomic_compare_exchange_n(&current,&w,w&~UINT64_C(15),0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE)?IQ4_ACTIVITY_OK01:IQ4_ACTIVITY_REJECTED01;
}
int iq4_activity_snapshot_01(struct Iq4ActivitySnapshot01*out){if(!out)return IQ4_ACTIVITY_REJECTED01;
 for(unsigned i=0;i<8;++i){uint64_t a=__atomic_load_n(&current,__ATOMIC_ACQUIRE),b=__atomic_load_n(&current,__ATOMIC_ACQUIRE);if(a!=b)continue;
  uint32_t id=(uint32_t)(a&7);if((id&&!actor(id))||(!id&&(a&HOLD)))return IQ4_ACTIVITY_REJECTED01;
  *out=(struct Iq4ActivitySnapshot01){a>>4,id,(uint32_t)((a&HOLD)!=0)};return IQ4_ACTIVITY_OK01;
 }return IQ4_ACTIVITY_BUSY01;
}
#ifdef IQ4_ACTIVITY_SYNTHETIC_HOST
void iq4_activity_fixture_reset_01(uint64_t g){__atomic_store_n(&owner,0,__ATOMIC_RELEASE);__atomic_store_n(&current,g<<4,__ATOMIC_RELEASE);}
#endif
