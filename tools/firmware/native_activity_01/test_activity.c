#include "activity.h"
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
static unsigned active,count;static const unsigned iterations=10000;
static void*run(void*p){unsigned which=(unsigned)(uintptr_t)p;struct Iq4ActivityLease01 l;
 for(unsigned i=0;i<iterations;++i){int r;do{r=iq4_activity_try_01(which==1?IQ4_ACTIVITY_JPEG01:IQ4_ACTIVITY_MOVIE01,p,&l);assert(r==0||r==1);}while(r==1);
  assert(iq4_activity_valid_01(&l)==0);assert(__atomic_fetch_add(&active,1,__ATOMIC_ACQ_REL)==0);
  __atomic_fetch_add(&count,1,__ATOMIC_RELAXED);assert(__atomic_fetch_sub(&active,1,__ATOMIC_ACQ_REL)==1);assert(iq4_activity_release_01(&l)==0);
 }return 0;}
int main(void){struct Iq4ActivityLease01 j,m,foreign;struct Iq4ActivitySnapshot01 s;
 assert(iq4_activity_try_01(0,(void*)1,&j)==2&&iq4_activity_try_01(3,0,&j)==2);
 assert(iq4_activity_try_01(3,(void*)1,&j)==0&&iq4_activity_try_01(4,(void*)2,&m)==1);
 foreign=j;foreign.owner=2;assert(iq4_activity_release_01(&foreign)==2);
 assert(iq4_activity_release_01(&j)==0&&iq4_activity_release_01(&j)==2);
 assert(iq4_activity_try_01(4,(void*)2,&m)==0&&iq4_activity_valid_01(&j)==2&&iq4_activity_release_01(&j)==2);
 assert(iq4_activity_hold_01(&m)==3&&iq4_activity_valid_01(&m)==3&&iq4_activity_release_01(&m)==3&&iq4_activity_try_01(3,(void*)1,&j)==3);
 assert(iq4_activity_snapshot_01(&s)==0&&s.actor==4&&s.held==1);
 iq4_activity_fixture_reset_01(UINT64_MAX>>4);assert(iq4_activity_try_01(3,(void*)1,&j)==2);
 iq4_activity_fixture_reset_01(0);pthread_t a,b;assert(!pthread_create(&a,0,run,(void*)1)&&!pthread_create(&b,0,run,(void*)2));assert(!pthread_join(a,0)&&!pthread_join(b,0));
 assert(active==0&&count==2*iterations&&iq4_activity_snapshot_01(&s)==0&&s.actor==0&&s.generation==2*iterations);
 puts("activity finite/stale/foreign/UNKNOWN/exhaustion + 20000 concurrent generations PASS (synthetic)");return 0;}
