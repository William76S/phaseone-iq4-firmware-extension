#include "plan.h"
int iq4_storage_plan_55(uint32_t format,uint32_t mode,uint32_t present,uint32_t raw,struct Iq4StoragePlan55*out){
 if(!out||format>2||mode>5||present>3)return 0;
 raw&=6;uint32_t available=((raw&4)?1u:0u)|((raw&2)?2u:0u);available&=present;
 if(!available)return 0;
 uint32_t primary;
 if(!(present&2))primary=10;
 else if((present&1)&&mode==5)primary=10;
 else if(mode==1&&!(available&2)&&(available&1))primary=10;
 else primary=11;
 /* Never route to a card merely because it is present: there must be a
  * complete RAW catalog source. Native fallback selects the surviving RAW. */
 if(!(available&(1u<<(primary-10))))primary=(available&2)?11:10;
 uint32_t mask=format?1u<<(primary-10):0;
 if(format&&(present==3)&&(mode==2||mode==3||mode==4))mask=3;
 *out=(struct Iq4StoragePlan55){primary,primary,mask,format,mode,raw};return 1;
}
