#include "../f3_save_coordinator_06/coordinator.h"
#include "../f3_native_executor_03/executor.h"
#include "../f3_saved_raw_capture_03/capture03.h"
#include "saved_route.hpp"
#include "../f3_save_coordinator_06/public_raw.h"
#include "../f3_gallery_source_snapshot_01/gallery.hpp"
#include "../f3_native_render_02/native_binding.hpp"
#include "../f3_native_render_02/completion.hpp"
#include "../f3_native_render_02/persistent_pool.hpp"
#include "../f3_file_arena_01/arena.h"
#include "../f3_stream_export_04/stream_export.h"
#include "../f3_saved_raw_capture_01/native_factory.h"
#include <cstring>
#include <new>
namespace {
namespace D=iq4::source_dependencies_01;
namespace G=iq4::gallery_source_01;
namespace R=iq4::raw_file_source_01;
namespace N=iq4::native_render_02;
struct Retain06 {};
struct Config {
 F3CardRead05 memory{};F3LinkedContract06 contract{};Iq4JpegApi jpeg{};
 F3Posix files{};F3CaptureDirectories01 directories{};F3ArenaApi arenas{};
 F3LeaseCalls05 requests{};F3CardIo05 card_io{};G::NativeMutexApi mutex{};
 N::NativeApi render{};N::NativePoolApi pool{};R::NativeApi reader{};R::ObjectApi objects{};R::FileOps source_io{};
 uint64_t arena_bytes=0;uint32_t installed=0,attempted=0;
} config;
struct Job {
 uint64_t generation=0;uint32_t phase=0,status=F3_REJECTED,failure=0;bool hold=false,manual=false;
 F3CoordinatorSettings06 settings{};Iq4ActivityLease01 activity{};
 F3CapturedRaw01*captured=nullptr;D::Snapshot dependencies{};G::Snapshot gallery{};G::Guard catalog_guard{};
 uintptr_t filesystem=0;char native_directory[256]{},leaf[64]{};F3PublicRaw06 public_raw{};
 F3Card05 manual_card{};F3Card05*card=nullptr;int own_parent=-1,retained_parent=-1;
 F3Fs ledger{};F3Session save_session{};F3ExportStream03 export_stream{};Iq4StreamResult encoder{};
 F3Arena source_arena{},render_arena{};void*source_base=nullptr;void*render_base=nullptr;
 bool source_loan=false,render_loan=false,pool_loan=false,reader_live=false,bundle_live=false,render_live=false;
 uint64_t pool_token=0;N::PoolLease pool{};N::CombinedCompletion completion{};
 alignas(16) unsigned char reader_storage[R::ReaderBytes]{};
 alignas(R::ReaderStage) unsigned char reader_object[sizeof(R::ReaderStage)]{};
 alignas(R::SourceBundle) unsigned char bundle_object[sizeof(R::SourceBundle)]{};
 alignas(N::Session) unsigned char render_object[sizeof(N::Session)]{};
 R::ReaderStage*reader=nullptr;R::SourceBundle*bundle=nullptr;N::Session*render=nullptr;
 R::FileInfo info{};R::Candidate candidate{};R::Buffers buffers{};
 uint8_t*payload=nullptr;uint64_t payload_capacity=0;uint8_t*row_states=nullptr;uint8_t cancel=0;
 alignas(16) uint8_t scratch[F3_STREAM_SCRATCH]{};
} job;
uint64_t sequence=0;uint32_t reservation=0;
F3CoordinatorView06 publication{};
D::Memory memory(){return {config.memory.context,config.memory.read};}
void publish(Job&j){
 __atomic_store_n(&publication.generation,j.generation,__ATOMIC_RELEASE);
#define PUB(field,value) __atomic_store_n(&publication.field,uint32_t(value),__ATOMIC_RELEASE)
 PUB(phase,j.phase);PUB(status,j.status);PUB(failure_step,j.failure);PUB(requested_mode,j.settings.mode);
 PUB(size_mode,j.settings.size_mode);PUB(width,j.export_stream.geometry.output_width);PUB(height,j.export_stream.geometry.output_height);
 PUB(jpeg_published,j.export_stream.checked.result.saved.published);PUB(raw_removed,j.status==F3_JPEG_ONLY_DONE);PUB(hold,j.hold);
#undef PUB
}
void hold(Job&j){j.hold=true;j.phase=5;j.status=F3_UNKNOWN_HOLD;
 if(j.card)f3_card_hold_05(j.card);if(j.captured)f3_capture_hold_01(j.captured);
 if(j.activity.word)iq4_activity_hold_01(&j.activity);publish(j);}
bool rd(uintptr_t p,void*out,size_t n){return p&&n&&p<=UINTPTR_MAX-n&&config.memory.read&&config.memory.read(config.memory.context,p,out,n)==1;}
bool word(uintptr_t p,uintptr_t&v){uintptr_t b=0;return rd(p,&v,8)&&rd(p,&b,8)&&v==b;}
bool worker(const F3ExecutorOwner01&o){
 uintptr_t current=0,vt=0,outer=0,ifm=0,back=0;
 try{current=reinterpret_cast<uintptr_t>(config.mutex.current_native_thread());}catch(...){return false;}
 return current==o.queue&&word(current,vt)&&vt==0xb805c0&&word(current+0x1a8,outer)&&outer==o.outer_ifm&&
  word(outer,vt)&&vt==0xb7f960&&word(outer+0xfa8,ifm)&&ifm==o.ifm&&ifm==job.dependencies.ifm&&
  word(ifm,vt)&&vt==0xb7ece0&&word(ifm+0x328,back)&&back==outer&&o.native_tid;
}
bool contract(){return __atomic_load_n(&config.installed,__ATOMIC_ACQUIRE)&&config.contract.verify_current_linked_elf&&
 config.contract.verify_current_linked_elf(config.contract.context)==1;}
bool same(const F3FdStat&a,const F3FdStat&b){return a.device==b.device&&a.inode==b.inode&&a.size==b.size&&
 a.mode==b.mode&&a.nlink==b.nlink&&a.mtime_sec==b.mtime_sec&&a.mtime_nsec==b.mtime_nsec;}
bool file_same(const R::FileStamp&a,const R::FileStamp&b){return a.device==b.device&&a.inode==b.inode&&a.bytes==b.bytes&&
 a.mode==b.mode&&a.mtime_seconds==b.mtime_seconds&&a.mtime_nanoseconds==b.mtime_nanoseconds&&
 a.ctime_seconds==b.ctime_seconds&&a.ctime_nanoseconds==b.ctime_nanoseconds&&a.read_only&&b.read_only;}
bool source_held(void*v,const void*input,void*tags,uint64_t identity){auto&j=*static_cast<Job*>(v);
 if(j.hold||!j.card||!f3_card_valid_05(j.card)||D::recheck(memory(),j.dependencies)!=D::Result::Ok){hold(j);throw Retain06{};}
 R::FileStamp stamp{};int fd=j.reader?j.reader->held_native_fd():-1;
 if(identity!=j.generation||!j.bundle||input!=j.bundle->raw_input()||tags!=j.bundle->owned_tags()||
  fd<0||!config.source_io.stat(fd,stamp)||!file_same(stamp,j.info.stamp)){hold(j);throw Retain06{};}
 return true;
}
bool next_request(const F3CoordinatorSettings06&s){return s.mode<=F3_JPEG_ONLY&&s.size_mode<=5&&s.quality>=1&&s.quality<=100;}
bool hash_leaf(Job&j,int fd,const char*leaf,const F3FdStat&expected,const char*sha){
 F3FdStat a{},b{},p{};if(!f3_card_valid_05(j.card)||config.files.stat_fd(fd,&a).value||
 config.files.stat_leaf(j.ledger.raw_dir,leaf,&p).value||!same(a,expected)||!same(a,p))return false;
 F4Sha h;char out[65];f4_sha_init(&h);for(uint64_t off=0;off<a.size;){uint64_t remaining=a.size-off;uint32_t n=remaining>sizeof(j.scratch)?sizeof(j.scratch):uint32_t(remaining);
  if(!f3_card_valid_05(j.card)){hold(j);return false;}auto r=config.files.read_at(fd,j.scratch,n,off);
  if(!f3_card_valid_05(j.card)||r.value!=n){hold(j);return false;}f4_sha_update(&h,j.scratch,n);off+=n;}
 if(config.files.read_at(fd,j.scratch,1,a.size).value!=0){hold(j);return false;}
 f4_sha_end(&h,out);return !std::memcmp(out,sha,65)&&config.files.stat_fd(fd,&b).value==0&&same(a,b)&&
 config.files.stat_leaf(j.ledger.raw_dir,leaf,&p).value==0&&same(b,p)&&f3_card_valid_05(j.card);
}
/* Actual renderer cleanup is checked by cleanup() before this second stage. */
bool discard_public(Job&j){
 if(j.manual||!j.captured)return false;
 auto guard=f3_card_guard_05(j.card);
 int result=f3_public_discard_06(&j.public_raw,&config.files,&guard,j.ledger.epoch,j.ledger.raw_dir,
  j.generation,j.captured,j.export_stream.checked.result.saved.published,j.scratch,sizeof(j.scratch));
 if(result==F3_PUBLIC_HOLD06){hold(j);return false;}
 if(result==F3_PUBLIC_REMOVED06){j.status=F3_JPEG_ONLY_DONE;return true;}return false;
}
bool cleanup(Job&j){
 if(j.hold)return false;
 // Session.run normally performed checked native joins/dtors before returning.
 if(j.render_live){auto s=j.render->state();if(s.quarantined||s.sink_active||s.settings_alive||s.generator_alive||s.rgb32_alive||s.planar_alive||s.join_needed||s.receipt_active||s.source_held){hold(j);return false;}j.render_live=false;}
 if(j.pool_loan){if(N::persistent_pool_02().release_after_join(j.pool_token)!=N::Result::Ok){hold(j);return false;}j.pool_loan=false;}
 if(j.bundle_live){if(j.bundle->cleanup()!=R::SourceResult::Ok){hold(j);return false;}j.bundle_live=false;}
 // JPEG-only discard occurs only after all actual render workers/objects and
 // borrowed native tag/input objects ended. Native Reader/card/source remain held.
 if(j.status==F3_JPEG_WITH_RAW&&!j.manual&&j.settings.mode==F3_JPEG_ONLY){discard_public(j);if(j.hold)return false;}
 if(j.reader_live){if(j.reader->shutdown()!=R::Result::Ok){hold(j);return false;}j.reader_live=false;}
 if(j.render_loan){if(f3_arena_end_loan_01(&j.render_arena)!=F3_ARENA_OK){hold(j);return false;}j.render_loan=false;}
 if(j.render_arena.state>=F3_ARENA_CREATED&&j.render_arena.state<=F3_ARENA_MAPPED){if(f3_arena_release_01(&j.render_arena)!=F3_ARENA_OK){hold(j);return false;}}
 if(j.source_loan){if(f3_arena_end_loan_01(&j.source_arena)!=F3_ARENA_OK){hold(j);return false;}j.source_loan=false;}
 if(j.source_arena.state>=F3_ARENA_CREATED&&j.source_arena.state<=F3_ARENA_MAPPED){if(f3_arena_release_01(&j.source_arena)!=F3_ARENA_OK){hold(j);return false;}}
 if(j.ledger.raw_fd>=0){if(!f3_fs_release_raw_03(&j.ledger)){hold(j);return false;}}
 if(j.own_parent>=0){if(config.files.close(j.own_parent).value){hold(j);return false;}j.own_parent=-1;}
 if(j.manual&&j.card&&j.card->state==2){if(f3_card_finish_05(j.card)!=F3_CARD_OK){hold(j);return false;}}
 return true;
}
bool open_parent(Job&j,const char*relative){
 int dir=j.card->raw_dir;if(!relative[0]){j.own_parent=-1;j.ledger.raw_dir=dir;return true;}
 char component[256];size_t start=0,len=std::strlen(relative);
 for(size_t i=0;i<=len;++i)if(i==len||relative[i]=='/'){
  size_t n=i-start;if(!n||n>=sizeof(component))return false;std::memcpy(component,relative+start,n);component[n]=0;
  auto r=config.directories.open_child(dir,component);if(r.value<0)return false;
  int next=int(r.value);if(j.own_parent>=0&&config.files.close(j.own_parent).value){j.retained_parent=j.own_parent;j.own_parent=next;hold(j);return false;}
  j.own_parent=next;dir=next;start=i+1;}
 j.ledger.raw_dir=dir;return true;
}
const R::Entry*entry(const R::FileInfo&i,uint32_t tag){for(uint32_t n=0;n<i.count;++n)if(i.entries[n].tag==tag)return i.entries+n;return nullptr;}
bool source_buffers(Job&j){
 uint64_t ceiling=0;if(!iq4_f3_codec8_read_ceiling_02(j.info.geometry.total_width,&ceiling))return false;
 auto cal=entry(j.info,0x110);auto profile=entry(j.info,0x548);
 if(!cal||!cal->bytes||cal->bytes>INT32_MAX||(profile&&profile->bytes>INT32_MAX))return false;
 uint64_t payload=uint64_t(j.info.geometry.payload_bytes)+ceiling,rows=uint64_t(j.info.geometry.total_height)*4,
  black=(uint64_t(j.info.geometry.total_width)+j.info.geometry.total_height)*4,prof=profile?profile->bytes:0;
 const uint64_t lengths[]={payload,rows,black,cal->bytes,prof,j.info.geometry.total_height};
 uint64_t total=0,offsets[6]{};for(unsigned i=0;i<6;++i){total=(total+31)&~uint64_t(31);offsets[i]=total;if(lengths[i]>F3_ARENA_MAX_BYTES-total)return false;total+=lengths[i];}
 total=(total+4095)&~uint64_t(4095);if(!total||total>F3_ARENA_MAX_BYTES)return false;
 auto guard=f3_card_guard_05(j.card);uint64_t epoch=guard.actual_epoch(guard.context);
 if(f3_arena_create_01(&j.source_arena,&config.arenas,&guard,j.ledger.raw_dir,epoch,j.generation,j.generation*2,total,j.scratch,sizeof(j.scratch))!=F3_ARENA_OK)return false;
 uint64_t mapped=0;if(f3_arena_loan_01(&j.source_arena,&j.source_base,&mapped)!=F3_ARENA_OK)return false;j.source_loan=true;
 auto b=static_cast<uint8_t*>(j.source_base);j.payload=b+offsets[0];j.payload_capacity=payload;
 // The codec's actual bounded speculative read span is owned and initialized.
 std::memset(j.payload+j.info.geometry.payload_bytes,0,ceiling);
 j.buffers={reinterpret_cast<uint32_t*>(b+offsets[1]),j.info.geometry.total_height,b+offsets[2],uint32_t(black),b+offsets[3],cal->bytes,prof?b+offsets[4]:nullptr,uint32_t(prof)};
 j.row_states=b+offsets[5];return mapped==total;
}
f3_result sink(void*v,const f3_plane*p){auto&j=*static_cast<Job*>(v);
 if(!p||!j.card||!f3_card_valid_05(j.card)||p->identity!=j.generation||p->bytes_per_pixel!=4){hold(j);throw Retain06{};}
 F3ExportRequest03 request{};request.rotation=0;request.size_mode=j.settings.size_mode;request.quality=int(j.settings.quality);
 auto&x=request.job;x.boot_epoch=j.card->raw_mount;x.capture_id=j.generation;x.mode=j.manual?F3_RAW_JPEG:j.settings.mode;
 x.purpose=j.manual?F3_MANUAL_EXISTING_RAW:F3_NEW_CAPTURE;x.newly_created_raw_stage=0;
 x.source_raw_width=p->width;x.source_raw_height=p->height;x.render_source_kind=1;
 Iq4ExportGeometry g{};if(iq4_export_geometry(p->width,p->height,0,j.settings.size_mode,&g)!=IQ4_EXPORT_GEOMETRY_OK)return F3_BAD_DIMENSIONS;
 x.render_width=x.output_width=g.output_width;x.render_height=x.output_height=g.output_height;
 x.raw={j.ledger.raw_stat.device,j.ledger.raw_stat.inode,j.ledger.epoch,j.generation,j.ledger.raw_stat.size};x.render_source=x.raw;
 j.save_session.boot_epoch=x.boot_epoch;auto ports=f3_fs_ports_03(&j.ledger);
 if(!f3_export_stream_begin_03(&j.export_stream,&j.save_session,&request,&ports,F3_STREAM_MAX_BYTES,j.scratch,sizeof(j.scratch))){
  if(j.save_session.hold||j.export_stream.checked.state==3){hold(j);throw Retain06{};}return F3_NATIVE_FAILURE;}
 Iq4Rgb32Input input{p->allocation+p->plane_offset,size_t(p->allocation_bytes-p->plane_offset),size_t(p->stride),p->width,p->height,int(j.settings.quality)};
 auto r=f3_export_stream_encode_03(&j.export_stream,&config.jpeg,&input,&j.encoder);
 if(!r||r->saved.status==F3_UNKNOWN_HOLD||j.save_session.hold||j.ledger.hold){hold(j);throw Retain06{};}
 j.status=r->saved.status;j.failure=r->saved.failure_step;return r->saved.published&&r->saved.status==F3_JPEG_WITH_RAW?F3_OK:F3_NATIVE_FAILURE;
}
bool initialize_job(const F3CoordinatorSettings06&s,const Iq4ActivityLease01&a){
 if(!contract()||!next_request(s)||iq4_activity_valid_01(&a)!=IQ4_ACTIVITY_OK01)return false;
 uint32_t expected=0;if(!__atomic_compare_exchange_n(&reservation,&expected,1,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return false;
 if(sequence>=UINT64_MAX/2){__atomic_store_n(&reservation,0,__ATOMIC_RELEASE);return false;}
 // Prior known end destroyed no native object automatically. All owners were
 // explicitly ended; placement of our own POD/control objects is now legal.
 new(&job)Job{};job.ledger.raw_fd=job.ledger.write_fd=job.ledger.read_fd=-1;
 job.generation=++sequence;job.phase=2;job.settings=s;job.activity=a;return true;
}
/* Executor BUSY/REJECTED are exact no-enqueue returns: no Notify, Run or
 * borrowed activity transfer occurred. End only this prepared POD job; leave
 * the capture's actual RAW/card/activity to its original checked SD cleanup.
 * Unknown, queued timeout, live own resources and owner changes retain all. */
int saved_result_07(Job&j,int executor_result){
 if(executor_result==F3_EXEC_OK01)return 1;
 if(executor_result!=F3_EXEC_BUSY01&&executor_result!=F3_EXEC_REJECTED01){hold(j);return 0;}
 if(j.hold||j.manual||j.phase!=2||!j.captured||j.card!=j.captured->card||!j.card||j.card->hold||j.card->state!=2||
  j.captured->hold||j.captured->state!=F3_CAPTURE_SAVED01||
  j.activity.word!=j.captured->activity.word||j.activity.owner!=j.captured->activity.owner||
  iq4_activity_valid_01(&j.activity)!=IQ4_ACTIVITY_OK01||j.catalog_guard.live||j.catalog_guard.hold||
  j.reader_live||j.bundle_live||j.render_live||j.pool_loan||j.source_loan||j.render_loan||
  j.reader||j.bundle||j.render||j.source_base||j.render_base||j.source_arena.state||j.render_arena.state||
  j.own_parent>=0||j.retained_parent>=0||j.ledger.bound||j.ledger.raw_fd>=0||j.ledger.read_fd>=0||j.ledger.write_fd>=0||
  j.export_stream.checked.state||j.save_session.in_progress||j.save_session.hold){hold(j);return 0;}
 j.phase=4;j.status=F3_FAILED_RAW_RETAINED;j.failure=20;publish(j);
 __atomic_store_n(&reservation,0,__ATOMIC_RELEASE);return 1;
}
int refusal(Job&j){if(j.catalog_guard.hold){hold(j);return F3_COORD_UNKNOWN06;}j.phase=4;j.status=F3_REJECTED;publish(j);__atomic_store_n(&reservation,0,__ATOMIC_RELEASE);return F3_COORD_REJECTED06;}
}
extern "C" int f3_coordinator_install_native_06(const F3CardRead05*m,const F3LinkedContract06*p,const Iq4JpegApi*codec,uint64_t bytes){
 if(__atomic_load_n(&config.attempted,__ATOMIC_ACQUIRE)||!m||!m->read||!p||p->verification_kind!=1||p->cpp_unwind_target_accepted||
 !p->verify_current_linked_elf||p->review_sha256[64]||!codec||!codec->binding_abi_verified||
 !bytes||(bytes&4095)||bytes>F3_ARENA_MAX_BYTES)return 0;
 for(unsigned i=0;i<64;++i)if(!((p->review_sha256[i]>='0'&&p->review_sha256[i]<='9')||(p->review_sha256[i]>='a'&&p->review_sha256[i]<='f')))return 0;
 const bool linked_verified=p->verify_current_linked_elf(p->context)==1;
 if(!linked_verified)return 0;uint32_t unattempted=0;
 if(!__atomic_compare_exchange_n(&config.attempted,&unattempted,1,false,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return 0;config.memory=*m;config.contract=*p;config.jpeg=*codec;config.arena_bytes=bytes;
 if(!G::native_factory(memory(),config.mutex)||N::bind_native_render_02(m->read,m->context,linked_verified,config.render,config.pool)!=N::Result::Ok||
  N::bind_native_source_02(m->read,m->context,linked_verified,config.reader,config.objects)!=N::Result::Ok||
  N::bind_native_file_ops_02(m->read,m->context,config.source_io)!=N::Result::Ok)return 0;
 f3_fs_linux_api_03(&config.files);f3_capture_linux_directories_01(&config.directories);f3_arena_linux_api_01(&config.arenas);
 f3_card_native_calls_05(&config.requests);f3_card_linux_io_05(&config.card_io);
 if(!f3_capture_install_native_01(m,f3_coordinator_saved_callback_06,nullptr))return 0;
 __atomic_store_n(&config.installed,1,__ATOMIC_RELEASE);return 1;
}
extern "C" int f3_coordinator_ready_06(void){return __atomic_load_n(&config.installed,__ATOMIC_ACQUIRE)&&!__atomic_load_n(&publication.hold,__ATOMIC_ACQUIRE)&&contract()?1:0;}
extern "C" int f3_coordinator_manual_prepare_06(uintptr_t ifm,int32_t index,const F3CoordinatorSettings06*s,const F3ExecutorReservation01*r,void**out){
 if(out)*out=nullptr;if(!out||!s||!r||!r->sequence||!initialize_job(*s,r->activity))return F3_COORD_REJECTED06;
 job.manual=true;auto result=G::snapshot(memory(),config.mutex,job.catalog_guard,ifm,index,job.gallery);
 if(result!=G::Result::Ok)return refusal(job);job.dependencies=job.gallery.dependencies;job.filesystem=job.gallery.filesystem;
 std::memcpy(job.native_directory,job.gallery.directory,sizeof job.native_directory);std::memcpy(job.leaf,job.gallery.leaf,sizeof job.gallery.leaf);
 job.settings.mode=F3_RAW_JPEG;*out=&job;publish(job);return F3_COORD_KNOWN_ENDED06;
}
extern "C" int f3_coordinator_saved_prepare_06(F3CapturedRaw01*c,void**out){
 if(out)*out=nullptr;if(!out||!c||c->hold||c->state!=F3_CAPTURE_SAVED01||!c->exclusive_created||!c->store_success||!c->close_success||!c->writer_bound||c->writer_fd>=0||!c->card||c->raw_fd<0)return F3_COORD_REJECTED06;
 F3CoordinatorSettings06 s{c->ticket.policy.mode,c->ticket.policy.size_mode,c->ticket.policy.quality};
 if(!initialize_job(s,c->activity))return F3_COORD_REJECTED06;job.captured=c;job.card=c->card;job.filesystem=c->native_fs;
 int deps=f3_capture_dependencies_03(c,&job.dependencies);
 if(deps==F3_CAPTURE_PROOF_HOLD03){hold(job);return F3_COORD_UNKNOWN06;}
 if(deps!=F3_CAPTURE_PROOF_OK03||D::recheck(memory(),job.dependencies)!=D::Result::Ok)return refusal(job);
 const char*p="DCIM/";unsigned n=0;while(*p)job.native_directory[n++]=*p++;for(unsigned i=0;c->directory[i]&&n<255;++i)job.native_directory[n++]=c->directory[i];job.native_directory[n]=0;
 std::memcpy(job.leaf,c->leaf,sizeof c->leaf);*out=&job;publish(job);return F3_COORD_KNOWN_ENDED06;
}
extern "C" int f3_coordinator_worker_run_06(void*ticket,const F3ExecutorOwner01*owner){
 if(ticket!=&job||!owner||job.phase!=2||job.hold||!worker(*owner)||!contract()||iq4_activity_valid_01(&job.activity)!=IQ4_ACTIVITY_OK01){if(ticket==&job)hold(job);return -1;}
 auto&j=job;j.phase=3;publish(j);bool successful=false;
 try{
  if(j.manual){
   if(G::recheck(memory(),config.mutex,j.catalog_guard,j.gallery)!=G::Result::Ok){if(j.catalog_guard.hold)throw Retain06{};j.failure=1;throw 0;}
   auto cr=f3_card_begin_05(&j.manual_card,&config.memory,&config.requests,&config.card_io,j.gallery.filesystem_id,j.gallery.filesystem_id);
   j.card=&j.manual_card;if(cr==F3_CARD_UNKNOWN)throw Retain06{};if(cr!=F3_CARD_OK){j.failure=2;throw 0;}
  }
  if(!j.card||!f3_card_valid_05(j.card)||j.card->fs[0]!=j.filesystem)throw Retain06{};
  char relative[256];if(!G::relative_directory(j.native_directory,relative)){j.failure=3;throw 0;}
  if(j.manual){if(!open_parent(j,relative)){if(j.hold)throw Retain06{};j.failure=4;throw 0;}}
  else j.ledger.raw_dir=j.captured->parent_dir;
  const int parent=j.ledger.raw_dir;auto guard=f3_card_guard_05(j.card);uint64_t epoch=guard.actual_epoch(guard.context);
  if(!f3_fs_prepare_03(&j.ledger,&config.files,&guard,parent,parent,epoch,j.generation,j.generation)){j.failure=5;throw 0;}
  auto opened=config.files.open_leaf(parent,j.leaf,0);if(opened.value<0){j.failure=6;throw 0;}F3File raw{};
  if(!f3_fs_manual_raw_03(&j.ledger,j.leaf,int(opened.value),&raw)){j.ledger.raw_fd=int(opened.value);if(j.ledger.hold)throw Retain06{};j.failure=7;throw 0;}
  if(j.captured&&!hash_leaf(j,j.ledger.raw_fd,j.leaf,j.captured->final_stat,j.captured->sha256)){if(j.hold)throw Retain06{};j.failure=8;throw 0;}
  R::ConstructorInputs inputs{};if(D::constructor_inputs(memory(),j.dependencies,j.filesystem,inputs)!=D::Result::Ok){j.failure=9;throw 0;}
  j.reader=new(j.reader_object)R::ReaderStage(config.reader);j.reader_live=true;
  if(j.reader->construct(j.reader_storage,sizeof j.reader_storage,inputs)!=R::Result::Ok)throw Retain06{};
  if(j.reader->open(j.native_directory,std::strlen(j.native_directory),j.leaf,std::strlen(j.leaf))!=R::Result::Ok)throw Retain06{};
  int fd=j.reader->held_native_fd();if(fd<0||R::inspect_saved_iiq(config.source_io,fd,j.info)!=R::SourceResult::Ok){j.failure=10;throw 0;}
  if(j.info.stamp.device!=raw.device||j.info.stamp.inode!=raw.inode||j.info.stamp.bytes!=raw.bytes){j.failure=11;throw 0;}
  if(!source_buffers(j)){if(j.source_arena.hold)throw Retain06{};j.failure=12;throw 0;}
  if(j.reader->read_candidate(j.payload,j.info.geometry.payload_bytes,j.candidate)!=R::Result::Ok)throw Retain06{};
  j.bundle=new(j.bundle_object)R::SourceBundle(config.objects);j.bundle_live=true;
  if(j.bundle->build(config.source_io,fd,j.info,*j.reader,j.candidate,j.buffers)!=R::SourceResult::Ok){if(j.bundle->quarantined())throw Retain06{};j.failure=13;throw 0;}
  auto p=N::persistent_pool_02().initialize(config.pool,config.memory.read,config.memory.context);
  if(p==N::Result::Hold)throw Retain06{};if(p!=N::Result::Ok){j.failure=14;throw 0;}
  p=N::persistent_pool_02().acquire(j.pool,j.pool_token);if(p==N::Result::Hold)throw Retain06{};if(p!=N::Result::Ok){j.failure=15;throw 0;}j.pool_loan=true;
  N::Attempt attempt{};if(N::bounded_attempt(j.candidate,config.arena_bytes,attempt)!=N::Result::Ok||config.arena_bytes<attempt.lower_bound){j.failure=16;throw 0;}
  if(f3_arena_create_01(&j.render_arena,&config.arenas,&guard,parent,epoch,j.generation,j.generation*2+1,config.arena_bytes,j.scratch,sizeof j.scratch)!=F3_ARENA_OK){if(j.render_arena.hold)throw Retain06{};j.failure=17;throw 0;}
  uint64_t mapped=0;if(f3_arena_loan_01(&j.render_arena,&j.render_base,&mapped)!=F3_ARENA_OK)throw Retain06{};j.render_loan=true;
  auto sensor=entry(j.info,0x103);if(!sensor||sensor->type!=4||sensor->bytes!=4||!sensor->value){j.failure=18;throw 0;}
  j.completion.read=config.memory.read;j.completion.read_context=config.memory.context;j.completion.payload_allocation_bytes=j.payload_capacity;
  j.completion.row_states=j.row_states;j.completion.row_states_bytes=j.candidate.total_height;
  j.render=new(j.render_object)N::Session(config.render,j.completion.callbacks());j.render_live=true;
  N::SourceLease source{j.bundle,j.candidate,j.generation,&j,source_held};
  p=j.render->run(source,j.pool,sensor->value,static_cast<uint8_t*>(j.render_base),mapped,&j.cancel,sink,&j);
  if(p==N::Result::Hold||j.render->state().quarantined||j.hold)throw Retain06{};
  successful=p==N::Result::Ok&&j.status==F3_JPEG_WITH_RAW;
  if(!successful&&j.status!=F3_FAILED_RAW_RETAINED){j.status=F3_FAILED_RAW_RETAINED;j.failure=19;}
 }catch(const Retain06&){hold(j);return -1;}catch(int){if(j.hold)return -1;j.status=F3_FAILED_RAW_RETAINED;}
 catch(...){hold(j);return -1;}
 if(!cleanup(j)){hold(j);return -1;}j.phase=4;publish(j);__atomic_store_n(&reservation,0,__ATOMIC_RELEASE);return successful?1:0;
}
static int saved_ended_08(int result){return saved_result_07(job,result);}
static void saved_retain_08(F3CapturedRaw01*c){
 if(c)f3_capture_hold_01(c);if(job.captured==c)hold(job);iq4_f3_executor_hold_01();
}
extern "C" int f3_coordinator_saved_callback_06(void*,F3CapturedRaw01*c){
 // Reserve the sole mailbox before placing our sole Job. The proof carries
 // producer03's actual per-card receipt and shared group activity, never a
 // guess that two policy modes imply two completed native destinations.
 const F3SavedDispatch08 dispatch={iq4_f3_executor_begin_saved_on_native_03,
  f3_coordinator_saved_prepare_06,iq4_f3_executor_invoke_reserved_saved_on_native_03,
  iq4_f3_executor_cancel_saved_on_native_03,saved_ended_08,saved_retain_08,f3_coordinator_worker_run_06};
 return f3_saved_route_08(c,dispatch);
}
extern "C" int f3_coordinator_view_06(F3CoordinatorView06*out){
 if(!out)return 0;out->generation=__atomic_load_n(&publication.generation,__ATOMIC_ACQUIRE);
#define GET(field) out->field=__atomic_load_n(&publication.field,__ATOMIC_ACQUIRE)
 GET(phase);GET(status);GET(failure_step);GET(requested_mode);GET(size_mode);GET(width);GET(height);GET(jpeg_published);GET(raw_removed);GET(hold);
#undef GET
 return 1;
}
