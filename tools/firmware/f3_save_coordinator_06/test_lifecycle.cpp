/* Runs the actual coordinator cleanup()/hold() bodies with owned callback
 * faults. All native functions below are explicit host fixtures, never target. */
#include "coordinator.cpp"
#include <cassert>
#include <cstdio>
#include <vector>
static std::vector<int> events;static int failure=0,encode_fault=0,encoder_returned=0;
static bool hit(int e){events.push_back(e);return failure!=e;}
namespace iq4::native_render_02 {
static PersistentPool fixture_pool;
PersistentPool&persistent_pool_02()noexcept{return fixture_pool;}
Result PersistentPool::release_after_join(uint64_t){return hit(1)?Result::Ok:Result::Hold;}
}
namespace iq4::raw_file_source_01 {
SourceResult SourceBundle::cleanup(){return hit(2)?SourceResult::Ok:SourceResult::NativeCleanupFailed;}
Result ReaderStage::shutdown(){return hit(3)?Result::Ok:Result::CloseFailed;}
}
extern "C" {
int f3_card_valid_05(F3Card05*){return 1;}
F3Ports f3_fs_ports_03(F3Fs*){return {};}
Iq4ExportGeometryStatus iq4_export_geometry(uint32_t w,uint32_t h,uint32_t,uint32_t,Iq4ExportGeometry*g){g->output_width=w;g->output_height=h;return IQ4_EXPORT_GEOMETRY_OK;}
int f3_export_stream_begin_03(F3ExportStream03*s,F3Session*,const F3ExportRequest03*,const F3Ports*,uint64_t,uint8_t*,size_t){s->checked.result.saved.status=F3_JPEG_WITH_RAW;return 1;}
const F3StreamResult*f3_export_stream_encode_03(F3ExportStream03*s,const Iq4JpegApi*,const Iq4Rgb32Input*,Iq4StreamResult*){
 if(encode_fault==1)s->checked.result.saved.status=F3_UNKNOWN_HOLD;
 if(encode_fault==2)job.save_session.hold=1;if(encode_fault==3)job.ledger.hold=1;
 encoder_returned=1;return &s->checked.result;
}
void f3_card_hold_05(F3Card05*c){c->hold=1;c->state=4;}
void f3_capture_hold_01(F3CapturedRaw01*c){c->hold=1;}
int iq4_activity_hold_01(const Iq4ActivityLease01*){return IQ4_ACTIVITY_OK01;}
F3ArenaStatus f3_arena_end_loan_01(F3Arena*a){int e=a==&job.render_arena?4:6;if(!hit(e))return F3_ARENA_HOLD;a->loan_active=0;return F3_ARENA_OK;}
F3ArenaStatus f3_arena_release_01(F3Arena*a){int e=a==&job.render_arena?5:7;if(!hit(e))return F3_ARENA_HOLD;a->state=F3_ARENA_RELEASED;return F3_ARENA_OK;}
int f3_fs_release_raw_03(F3Fs*l){if(!hit(8))return 0;l->raw_fd=-1;return 1;}
F3CardOutcome05 f3_card_finish_05(F3Card05*c){if(!hit(10))return F3_CARD_UNKNOWN;c->state=3;return F3_CARD_OK;}
/* This branch is never taken in cleanup fixtures: no JPEG publication. */
F3CardGuard f3_card_guard_05(F3Card05*){return {};}
int f3_public_discard_06(F3PublicRaw06*,const F3Posix*,const F3CardGuard*,uint64_t,int,uint64_t,const F3CapturedRaw01*,uint32_t,uint8_t*,size_t){assert(false);return 0;}
}
static F3SysResult close_parent(int fd){assert(fd==101);return hit(9)?F3SysResult{0,0}:F3SysResult{-1,5};}
int main(){unsigned cases=0;for(int fault=0;fault<=10;++fault){
 new(&job)Job{};F3Card05 card{};card.state=2;job.card=&card;job.manual=true;job.status=F3_FAILED_RAW_RETAINED;
 job.pool_loan=job.bundle_live=job.reader_live=job.render_loan=job.source_loan=true;
 job.bundle=new(job.bundle_object)R::SourceBundle({});job.reader=new(job.reader_object)R::ReaderStage({});
 job.render_arena.state=job.source_arena.state=F3_ARENA_MAPPED;job.ledger.raw_fd=100;job.own_parent=101;
 config.files.close=close_parent;events.clear();failure=fault;
 bool normal=cleanup(job);assert(normal==(fault==0));
 if(!fault){assert((events==std::vector<int>{1,2,3,4,5,6,7,8,9,10}));assert(!job.hold&&job.ledger.raw_fd==-1&&job.own_parent==-1&&card.state==3);}
 else{assert(job.hold&&card.hold&&events.size()==unsigned(fault)&&events.back()==fault);auto count=events.size();assert(!cleanup(job)&&events.size()==count);}
 ++cases;
 }
 new(&job)Job{};job.hold=true;events.clear();assert(!cleanup(job)&&events.empty());++cases;
 new(&job)Job{};job.reader_live=job.bundle_live=job.pool_loan=job.render_live=job.source_loan=job.render_loan=true;
 F3Card05 card{};job.card=&card;job.ledger.raw_fd=100;job.source_base=reinterpret_cast<void*>(0x1000);job.render_base=reinterpret_cast<void*>(0x2000);
 job.activity.word=1;events.clear();bool caught=false;try{sink(&job,nullptr);}catch(const Retain06&){caught=true;}
 assert(caught&&job.hold&&job.reader_live&&job.bundle_live&&job.pool_loan&&job.render_live&&job.source_loan&&job.render_loan&&job.ledger.raw_fd==100&&job.source_base==reinterpret_cast<void*>(0x1000));assert(events.empty());assert(!cleanup(job)&&events.empty());++cases;
 for(int e=1;e<=3;++e){new(&job)Job{};F3Card05 heldcard{};job.card=&heldcard;job.generation=1;job.ledger.raw_fd=100;
  job.reader_live=job.bundle_live=job.render_live=job.source_loan=job.render_loan=job.pool_loan=true;
  unsigned char pixels[48]{};f3_plane plane{pixels,sizeof pixels,0,16,4,3,4,1};encode_fault=e;encoder_returned=0;events.clear();caught=false;
  try{sink(&job,&plane);}catch(const Retain06&){caught=true;}
  assert(encoder_returned&&caught&&job.hold&&events.empty()&&job.ledger.raw_fd==100&&job.reader_live&&job.source_loan&&job.pool_loan);assert(!cleanup(job)&&events.empty());++cases;
 }
 printf("{\"cases\":%u,\"passed\":true,\"actual_coordinator_cleanup_body\":true,\"native_and_file_callbacks_are_fixtures\":true,\"target_executed\":false}\n",cases);
}
