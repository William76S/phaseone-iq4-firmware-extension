#include "plan.h"
#include <assert.h>
#include <stdio.h>
int main(void){struct Iq4StoragePlan55 p;
 assert(iq4_storage_plan_55(2,0,2,2,&p)&&p.primary_card==11&&p.source_card==11&&p.jpeg_mask==2);
 assert(iq4_storage_plan_55(2,1,3,2,&p)&&p.primary_card==11&&p.jpeg_mask==2);
 assert(iq4_storage_plan_55(2,1,3,4,&p)&&p.primary_card==10&&p.source_card==10&&p.jpeg_mask==1);
 assert(iq4_storage_plan_55(2,4,3,6,&p)&&p.primary_card==11&&p.jpeg_mask==3);
 assert(iq4_storage_plan_55(1,4,3,6,&p)&&p.primary_card==11&&p.jpeg_mask==3);
 assert(iq4_storage_plan_55(2,5,3,6,&p)&&p.primary_card==10&&p.source_card==10&&p.jpeg_mask==1);
 assert(iq4_storage_plan_55(1,0,1,4,&p)&&p.primary_card==10&&p.source_card==10&&p.jpeg_mask==1);
 assert(iq4_storage_plan_55(0,2,3,2,&p)&&p.jpeg_mask==0);
 assert(iq4_storage_plan_55(2,2,3,2,&p)&&p.jpeg_mask==3);
 assert(!iq4_storage_plan_55(2,4,3,0,&p));
 assert(!iq4_storage_plan_55(2,5,0,2,&p));
 assert(!iq4_storage_plan_55(3,0,2,2,&p));
 puts("PASS 12 actual RAW-card route decisions; no FS/device fixture");
}
