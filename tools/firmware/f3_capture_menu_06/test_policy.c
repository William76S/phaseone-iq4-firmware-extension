#include "policy.h"
#include "../../../src/codec/export_geometry.h"
#include <assert.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
static void* update(void*p){uintptr_t field=(uintptr_t)p;
 for(uint32_t i=0;i<50000;++i){if(field<2)assert(iq4_f3_mode_set_for_card_on_ui_06(10+(uint32_t)field,i%3));
  else if(field==2)assert(iq4_f3_scale_set_on_ui_01(i%6));else assert(iq4_f3_quality_set_on_ui_03(i%100+1));}
 if(field<2)assert(iq4_f3_mode_set_for_card_on_ui_06(10+(uint32_t)field,field?F3_RAW_JPEG:F3_JPEG_ONLY));
 else if(field==2)assert(iq4_f3_scale_set_on_ui_01(F3_LONG384001));else assert(iq4_f3_quality_set_on_ui_03(87));return 0;
}
int main(void){unsigned groups=0;struct F3SettingsSnapshot06 all,immutable;
 assert(iq4_f3_settings_snapshot_06(&all)&&all.sd_mode==F3_RAW&&all.xqd_mode==F3_RAW&&all.size_mode==0&&all.quality==95);++groups;
 for(unsigned sd=0;sd<3;++sd)for(unsigned xqd=0;xqd<3;++xqd)for(unsigned size=0;size<6;++size){
  assert(iq4_f3_mode_set_for_card_on_ui_06(10,sd)&&iq4_f3_mode_set_for_card_on_ui_06(11,xqd)&&iq4_f3_scale_set_on_ui_01(size));
  assert(iq4_f3_settings_snapshot_06(&immutable));
  for(unsigned id=10;id<=11;++id){struct F3SettingsSnapshot04 s;assert(iq4_f3_settings_for_card_06(&immutable,id,&s));assert(s.mode==(id==10?sd:xqd)&&s.size_mode==size&&s.quality==95);}
  assert(iq4_f3_quality_set_on_ui_03(100)&&iq4_f3_mode_set_for_card_on_ui_06(10,(sd+1)%3)&&iq4_f3_mode_set_for_card_on_ui_06(11,(xqd+1)%3));
  struct F3SettingsSnapshot04 original;assert(iq4_f3_settings_for_card_06(&immutable,11,&original)&&original.mode==xqd&&original.quality==95);
  assert(iq4_f3_quality_set_on_ui_03(95));++groups;
 }
 assert(iq4_f3_settings_snapshot_06(&all));struct F3SettingsSnapshot04 out={99,99,99},before=out;
 assert(!iq4_f3_settings_for_card_06(&all,2,&out)&&!memcmp(&out,&before,sizeof out));assert(!iq4_f3_settings_for_card_06(&all,4,&out));
 assert(!iq4_f3_mode_set_for_card_on_ui_06(2,1)&&!iq4_f3_mode_set_for_card_on_ui_06(4,2)&&!iq4_f3_mode_set_for_card_on_ui_06(12,1)&&!iq4_f3_mode_set_for_card_on_ui_06(11,3));
 struct F3SettingsSnapshot06 bad=all;bad.quality=0;assert(!iq4_f3_settings_for_card_06(&bad,11,&out));bad=all;bad.xqd_mode=3;assert(!iq4_f3_settings_for_card_06(&bad,10,&out));++groups;
 assert(iq4_f3_mode_set_for_card_on_ui_06(11,F3_JPEG_ONLY)&&iq4_f3_mode_set_on_ui_01(F3_RAW));assert(iq4_f3_settings_snapshot_04(&out)&&out.mode==F3_RAW);
 struct F3PolicySlot01 raw={0};assert(iq4_f3_policy_begin_01(&raw,1,2,3,640,480)&&raw.policy.mode==F3_RAW&&!raw.policy.want_jpeg);
 assert(iq4_f3_settings_snapshot_06(&all)&&all.xqd_mode==F3_JPEG_ONLY);++groups;
 assert(iq4_f3_mode_set_for_card_on_ui_06(10,F3_RAW_JPEG)&&iq4_f3_scale_set_on_ui_01(F3_75_PERCENT01));struct F3PolicySlot01 odd={0};
 assert(iq4_f3_policy_begin_01(&odd,1,2,3,139,101)&&odd.policy.output_width==104&&odd.policy.output_height==76);
 struct F3CapturePolicy01 saved=odd.policy;assert(iq4_f3_mode_set_for_card_on_ui_06(10,F3_RAW)&&iq4_f3_scale_set_on_ui_01(0));struct F3CapturePolicy01 read;
 assert(iq4_f3_policy_read_01(&odd,1,2,3,&read)&&!memcmp(&read,&saved,sizeof read));assert(iq4_f3_policy_finish_01(&odd,1,2,3,F3_IO_UNKNOWN));assert(!iq4_f3_policy_finish_01(&odd,1,2,3,F3_IO_DONE));++groups;
 pthread_t threads[4];for(uintptr_t i=0;i<4;++i)assert(!pthread_create(threads+i,0,update,(void*)i));
 for(unsigned i=0;i<20000;++i){assert(iq4_f3_settings_snapshot_06(&all));struct F3SettingsSnapshot04 sd,xqd;
  assert(iq4_f3_settings_for_card_06(&all,10,&sd)&&iq4_f3_settings_for_card_06(&all,11,&xqd));assert(sd.size_mode==xqd.size_mode&&sd.quality==xqd.quality);
 }
 for(unsigned i=0;i<4;++i)assert(!pthread_join(threads[i],0));assert(iq4_f3_settings_snapshot_06(&all)&&all.sd_mode==2&&all.xqd_mode==1&&all.size_mode==4&&all.quality==87);++groups;
 printf("{\"policy_groups\":%u,\"atomic_4writer_concurrency\":true,\"snapshot_is_native_ownership\":false,\"target_executed\":false}\n",groups);return 0;
}
