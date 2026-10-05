#include "coordinator.cpp"
#include <cassert>
#include <cstdio>
#include <initializer_list>
static unsigned capture_holds,card_holds,activity_holds;static int actual_activity=IQ4_ACTIVITY_OK01;
extern "C" {
void f3_card_hold_05(F3Card05*c){++card_holds;c->hold=1;c->state=4;}
void f3_capture_hold_01(F3CapturedRaw01*c){++capture_holds;c->hold=1;}
int iq4_activity_hold_01(const Iq4ActivityLease01*){++activity_holds;return IQ4_ACTIVITY_OK01;}
int iq4_activity_valid_01(const Iq4ActivityLease01*){return actual_activity;}
}
static F3CapturedRaw01 captured;static F3Card05 card;
static void setup(){new(&job)Job{};captured={};card={};card.state=2;captured.card=&card;captured.state=F3_CAPTURE_SAVED01;captured.raw_fd=100;captured.parent_dir=101;captured.activity={1,(uintptr_t)&captured};
 job.generation=5;job.phase=2;job.captured=&captured;job.card=&card;job.activity=captured.activity;job.ledger.raw_fd=job.ledger.read_fd=job.ledger.write_fd=-1;reservation=1;publication={};capture_holds=card_holds=activity_holds=0;actual_activity=IQ4_ACTIVITY_OK01;}
static void retained(){assert(job.hold&&card.hold&&captured.hold&&reservation==1&&captured.raw_fd==100&&captured.parent_dir==101&&activity_holds==1);}
int inherited_no_enqueue_07(){unsigned cases=0;
 for(int result: {F3_EXEC_BUSY01,F3_EXEC_REJECTED01}){setup();assert(saved_result_07(job,result)==1);assert(job.phase==4&&job.status==F3_FAILED_RAW_RETAINED&&job.failure==20&&reservation==0&&!job.hold&&!captured.hold&&!card.hold&&captured.raw_fd==100&&captured.parent_dir==101&&job.activity.word==1);assert(!capture_holds&&!card_holds&&!activity_holds);++cases;}
 for(int result: {int(F3_EXEC_UNKNOWN01),99}){setup();job.reader_live=job.pool_loan=true;assert(saved_result_07(job,result)==0);retained();assert(job.reader_live&&job.pool_loan);++cases;}
 for(unsigned bad=0;bad<6;++bad){setup();switch(bad){case 0:job.render_loan=true;break;case 1:job.catalog_guard.live=true;break;case 2:job.activity.word=2;break;case 3:job.ledger.bound=1;break;case 4:job.export_stream.checked.state=4;break;case 5:actual_activity=IQ4_ACTIVITY_HELD01;break;}
  assert(saved_result_07(job,F3_EXEC_BUSY01)==0);retained();++cases;}
 setup();job.phase=4;job.status=F3_JPEG_WITH_RAW;reservation=0;assert(saved_result_07(job,F3_EXEC_OK01)==1&&job.status==F3_JPEG_WITH_RAW&&job.phase==4&&reservation==0&&!capture_holds&&!card_holds&&!activity_holds);++cases;
 printf("{\"groups\":%u,\"actual_saved_callback_routing_body\":true,\"no_RAW_file_or_lease_release_in_callback\":true,\"target_executed\":false}\n",cases);return 0;
}
