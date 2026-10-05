#include "inherited_no_enqueue_07.inc"
#include <vector>
static std::vector<int> events;
static int begin_result,prepare_result,invoke_result,cancel_result;
static unsigned executor_holds;
static bool null_ticket;
static unsigned dependency_calls;
static int dependency_result;
static bool dependency_current;
extern "C" void iq4_f3_executor_hold_01(void){++executor_holds;}
extern "C" int f3_capture_dependencies_03(const F3CapturedRaw01*c,D::Snapshot*out){assert(c==&captured);++dependency_calls;out->ifm=0x12000;out->original_reader=0x14000;return dependency_result;}
namespace iq4::source_dependencies_01 {
Result recheck(Memory,const Snapshot&s)noexcept{return dependency_current&&s.ifm==0x12000&&s.original_reader==0x14000?Result::Ok:Result::Changing;}
Result snapshot_from_raw_manager(Memory,uintptr_t,uintptr_t,Snapshot&)noexcept{assert(false&&"late current-node dependency lookup must not occur");return Result::InvalidOwner;}
}
static int linked_fixture(void*){return 1;}
static int begin(F3CapturedRaw01*c,F3ExecutorSavedReservation03*r){assert(c==&captured);events.push_back(1);r->mailbox.sequence=77;return begin_result;}
static int prepare(F3CapturedRaw01*c,void**p){assert(c==&captured);events.push_back(2);
 if(prepare_result==F3_COORD_UNKNOWN06)hold(job);
 if(prepare_result==F3_COORD_BUSY06||prepare_result==F3_COORD_REJECTED06){job.phase=4;reservation=0;}
 *p=null_ticket?nullptr:&job;return prepare_result;}
static int run(void*,const F3ExecutorOwner01*){assert(false);return -1;}
static int invoke(const F3ExecutorTask01*t,F3CapturedRaw01*c,const F3ExecutorSavedReservation03*r){
 assert(c==&captured&&r->mailbox.sequence==77&&t->ticket==&job&&t->run==run&&t->sequence==77&&!t->ui_completion_event);events.push_back(3);
 if(invoke_result==F3_EXEC_OK01){job.phase=4;reservation=0;job.status=F3_JPEG_WITH_RAW;}
 return invoke_result;}
static int cancel(F3CapturedRaw01*c,const F3ExecutorSavedReservation03*r){assert(c==&captured&&r->mailbox.sequence==77);events.push_back(4);return cancel_result;}
static int ended(int r){events.push_back(5);return saved_ended_08(r);}
static void retain(F3CapturedRaw01*c){events.push_back(6);saved_retain_08(c);}
static const F3SavedDispatch08 dispatch{begin,prepare,invoke,cancel,ended,retain,run};
static void reset_route(){setup();events.clear();executor_holds=0;null_ticket=false;begin_result=F3_EXEC_OK01;prepare_result=F3_COORD_KNOWN_ENDED06;invoke_result=cancel_result=F3_EXEC_OK01;}
int main(){inherited_no_enqueue_07();unsigned count=0;
 for(int refusal: {int(F3_EXEC_BUSY01),int(F3_EXEC_REJECTED01)}){reset_route();begin_result=refusal;
  assert(f3_saved_route_08(&captured,dispatch)==1&&events==std::vector<int>{1}&&job.phase==2&&reservation==1&&!executor_holds&&!capture_holds&&!activity_holds);++count;}
 for(int unknown: {int(F3_EXEC_UNKNOWN01),99}){reset_route();begin_result=unknown;assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,6}));assert(job.hold&&captured.hold&&card.hold&&executor_holds==1&&captured.raw_fd==100);++count;}
 for(int refusal: {int(F3_COORD_BUSY06),int(F3_COORD_REJECTED06)}){reset_route();prepare_result=refusal;
  assert(f3_saved_route_08(&captured,dispatch)==1&&events==std::vector<int>({1,2,4})&&!capture_holds&&!activity_holds&&!executor_holds&&captured.raw_fd==100);++count;}
 for(int unknown: {int(F3_COORD_UNKNOWN06),99}){reset_route();prepare_result=unknown;
  assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,2,6})&&captured.hold&&job.hold&&executor_holds==1&&reservation==1);++count;}
 for(int cancel_failure: {int(F3_EXEC_UNKNOWN01),int(F3_EXEC_REJECTED01)}){reset_route();prepare_result=F3_COORD_REJECTED06;cancel_result=cancel_failure;
  assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,2,4,6})&&job.hold&&captured.hold&&executor_holds==1);++count;}
 reset_route();null_ticket=true;assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,2,6})&&job.hold&&executor_holds==1);++count;
 for(int refusal: {int(F3_EXEC_BUSY01),int(F3_EXEC_REJECTED01)}){reset_route();invoke_result=refusal;
  assert(f3_saved_route_08(&captured,dispatch)==1&&events==std::vector<int>({1,2,3,5,4})&&reservation==0&&job.status==F3_FAILED_RAW_RETAINED&&!executor_holds&&!capture_holds&&!activity_holds);++count;}
 reset_route();invoke_result=F3_EXEC_REJECTED01;cancel_result=F3_EXEC_UNKNOWN01;
 assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,2,3,5,4,6})&&job.hold&&captured.hold&&executor_holds==1);++count;
 for(int unknown: {int(F3_EXEC_UNKNOWN01),99}){reset_route();invoke_result=unknown;
  assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,2,3,5})&&job.hold&&captured.hold&&reservation==1&&!executor_holds);++count;}
 reset_route();assert(f3_saved_route_08(&captured,dispatch)==1&&events==std::vector<int>({1,2,3,5})&&job.phase==4&&job.status==F3_JPEG_WITH_RAW&&!job.hold&&!executor_holds);++count;
 // An admission failure for card B must not mutate the unrelated card A Job.
 reset_route();F3CapturedRaw01 b=captured;job.captured=&b;begin_result=F3_EXEC_UNKNOWN01;
 assert(f3_saved_route_08(&captured,dispatch)==0&&events==std::vector<int>({1,6})&&captured.hold&&!job.hold&&!card.hold&&reservation==1&&executor_holds==1);++count;
 unsigned prepare_cases=0;
 for(unsigned fault=0;fault<5;++fault){reset_route();config.installed=1;config.contract.verify_current_linked_elf=linked_fixture;
  captured.exclusive_created=captured.store_success=captured.close_success=captured.writer_bound=1;captured.writer_fd=-1;captured.ticket.policy={F3_RAW_JPEG,2,93};std::strcpy(captured.directory,"100PHASE");std::strcpy(captured.leaf,"P0000001.IIQ");captured.native_fs=0x16000;
  reservation=fault==4?1:0;dependency_calls=0;dependency_current=fault!=3;dependency_result=fault==1?F3_CAPTURE_PROOF_REJECTED03:fault==2?F3_CAPTURE_PROOF_HOLD03:F3_CAPTURE_PROOF_OK03;
  void*ticket=reinterpret_cast<void*>(1);int r=f3_coordinator_saved_prepare_06(&captured,&ticket);
  if(fault==0){assert(r==F3_COORD_KNOWN_ENDED06&&ticket==&job&&job.captured==&captured&&job.card==&card&&job.dependencies.ifm==0x12000&&job.filesystem==0x16000&&job.settings.mode==F3_RAW_JPEG&&job.settings.size_mode==2&&job.settings.quality==93&&!strcmp(job.native_directory,"DCIM/100PHASE")&&!strcmp(job.leaf,"P0000001.IIQ"));}
  else if(fault==2){assert(r==F3_COORD_UNKNOWN06&&!ticket&&job.hold&&captured.hold&&card.hold&&reservation==1);}
  else{assert(r==F3_COORD_REJECTED06&&!ticket&&!job.hold&&!captured.hold&&!card.hold&&reservation==(fault==4?1u:0u));}
  assert(dependency_calls==(fault==4?0u:1u)&&captured.raw_fd==100&&captured.parent_dir==101);++prepare_cases;
 }
 printf("{\"focused_route_groups\":%u,\"actual_saved_prepare_groups\":%u,\"inherited_no_enqueue_groups\":11,\"actual_route_and_retention_bodies\":true,\"dispatch_callbacks_are_host_fixtures\":true,\"target_executed\":false}\n",count,prepare_cases);
}
