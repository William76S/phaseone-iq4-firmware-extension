#include "source_builder.hpp"
#include <array>
#include <cassert>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <unistd.h>
#include <vector>
using namespace iq4::raw_file_source_01;
namespace {
struct Tag { std::uint32_t kind=0,value=0,bytes=0; const void* blob=nullptr; };
using Map = std::map<std::uint32_t,Tag>;
std::map<void*, std::unique_ptr<Map>> maps;
std::map<void*, std::vector<std::uint32_t>> vectors;
FileOps io = host_posix_file_ops();
FileInfo opened_info;
int fd_for_open=-1, reads=0, closes=0, destroys=0, groups=0;
bool short_payload=false, bad_tell=false, fail_close=false, throw_destroy=false;
bool throw_push=false, throw_input_destroy=false;
alignas(16) std::array<std::uint8_t,ReaderBytes> storage;
std::uintptr_t fs = 0x55;
std::vector<std::uint8_t> payload(4096), black(4096), calibration(4096), profile(4096);
std::vector<std::uint32_t> rows(21520);
template<class T> void put(void* p,std::size_t off,T v){std::memcpy(static_cast<std::uint8_t*>(p)+off,&v,sizeof v);}
const Entry* entry(const FileInfo& f,std::uint32_t tag){for(std::uint32_t i=0;i<f.count;++i)if(f.entries[i].tag==tag)return f.entries+i;return nullptr;}
std::uint32_t endian(const std::uint8_t* p,bool big){return big?(std::uint32_t(p[0])<<24|std::uint32_t(p[1])<<16|std::uint32_t(p[2])<<8|p[3]):(std::uint32_t(p[3])<<24|std::uint32_t(p[2])<<16|std::uint32_t(p[1])<<8|p[0]);}
void ctor(void* p,void*,void* filesystem,void*,void*,void*,void*){
 std::memset(p,0,ReaderBytes);put(p,0x62c10,std::uintptr_t(0x44));put(p,0x62c18,filesystem);
}
bool open_native(void* p,const char*,const char*,bool extra,bool flag){
 assert(extra&&!flag);if(inspect_saved_iiq(io,fd_for_open,opened_info)!=SourceResult::Ok)return false;
 auto* fmt=static_cast<std::uint8_t*>(p)+CaptureFormatOffset;const auto& g=opened_info.geometry;
 const std::uint32_t values[]={g.total_width,g.total_height,g.left,g.top,g.valid_width,g.valid_height};
 for(unsigned i=0;i<6;++i)put(fmt,i*4,values[i]);
 put(fmt,0x40,opened_info.raw_format);put(fmt,0xd030,std::uint32_t(opened_info.base?4:3));
 put(fmt,0x24d8,static_cast<std::uint8_t*>(p)+0x20);put(fmt,0xeaec,std::uint32_t(7));
 put(p,PayloadLengthOffset,g.payload_bytes);put(p,0x62c20,std::int32_t(fd_for_open));put(p,0x62c24,std::uint8_t(1));
 const auto* r=entry(opened_info,0x21c);std::uint8_t tmp[0x15040];assert(r&&r->bytes<=sizeof tmp);
 assert(io.pread(fd_for_open,tmp,r->bytes,opened_info.base+r->value)==r->bytes);
 for(std::uint32_t i=0;i<g.total_height;++i)put(p,0x20+i*4,endian(tmp+i*4,opened_info.big_endian));
 const auto* w=entry(opened_info,0x107);assert(w);assert(io.pread(fd_for_open,tmp,12,opened_info.base+w->value)==12);
 for(unsigned i=0;i<3;++i)put(fmt,0x4c+i*4,endian(tmp+i*4,opened_info.big_endian));
 const std::uint32_t fields[][2]={{0x103,0x7c},{0x105,0x214},{0x20b,0x204},{0x20c,0x208},{0x21e,0x22c},{0x222,0x234},{0x21d,0x200}};
 for(const auto& field:fields){auto* e=entry(opened_info,field[0]);if(e)put(fmt,field[1],e->value);}
 put(fmt,0x27c,entry(opened_info,0x110)->bytes);
 put(fmt,0xbc,1.0f);put(fmt,0x20c,1.0f);return true;
}
bool is_open(void* p){return static_cast<std::uint8_t*>(p)[0x62c24]==1;}
bool close_native(void* p){++closes;put(p,0x62c24,std::uint8_t(0));return !fail_close;}
void dtor(void*){++destroys;if(throw_destroy)throw 1;}
std::uint32_t read_native(void*,void* p,std::uint32_t n){++reads;auto r=io.pread(fd_for_open,p,n,opened_info.payload_offset);assert(::lseek(fd_for_open,static_cast<off_t>(opened_info.payload_offset+n-(bad_tell?1:0)),SEEK_SET)>=0);return r<0?0:static_cast<std::uint32_t>(r)-(short_payload?1:0);}
std::uint32_t codec(void*){return opened_info.geometry.capture_codec;}
NativeApi native(){return {ctor,dtor,open_native,close_native,is_open,read_native,codec,true,true,0x44,0x55};}
ConstructorInputs inputs(){return {nullptr,&fs,nullptr,nullptr,nullptr,nullptr};}
void map_ctor(void* p){maps[p]=std::make_unique<Map>();}
void map_dtor(void* p){assert(maps.erase(p)==1);}
void* map_index(void* p,const std::uint32_t* key){return &(*maps.at(p))[*key];}
void tag_u32(void* p,std::uint32_t v){auto* t=static_cast<Tag*>(p);t->kind=1;t->value=v;}
void tag_float(void* p,float v){std::uint32_t bits;std::memcpy(&bits,&v,4);tag_u32(p,bits);}
void tag_blob(void* p,const void* b,std::uint32_t n){auto* t=static_cast<Tag*>(p);t->kind=2;t->blob=b;t->bytes=n;}
void input_ctor(void* p){std::memset(p,0,48);vectors[p]={};}
void input_dtor(void* p){if(throw_input_destroy)throw 1;assert(vectors.erase(p)==1);}
void push(void* p,const std::uint32_t* value){if(throw_push)throw 1;auto* key=static_cast<std::uint8_t*>(p)-8;auto& v=vectors.at(key);v.push_back(*value);put(p,0,v.data());put(p,8,v.data()+v.size());put(p,16,v.data()+v.capacity());}
ObjectApi objects(){return {map_ctor,map_dtor,map_index,tag_u32,tag_float,tag_blob,input_ctor,input_dtor,push,true,true};}
Buffers buffers(){return {rows.data(),static_cast<std::uint32_t>(rows.size()),black.data(),static_cast<std::uint32_t>(black.size()),calibration.data(),static_cast<std::uint32_t>(calibration.size()),profile.data(),static_cast<std::uint32_t>(profile.size())};}
void check(bool v,const char* label){if(!v){std::cerr<<label<<'\n';std::abort();}++groups;}
struct Session{
 ReaderStage stage{native()};Candidate candidate{};FileInfo info{};
 explicit Session(const std::string& p){fd_for_open=::open(p.c_str(),O_RDONLY);assert(fd_for_open>=0);assert(stage.construct(storage.data(),storage.size(),inputs())==Result::Ok);assert(stage.open(nullptr,0,"fixture",7)==Result::Ok);assert(inspect_saved_iiq(io,fd_for_open,info)==SourceResult::Ok);assert(stage.read_candidate(payload.data(),payload.size(),candidate)==Result::Ok);}
 ~Session(){if(stage.state()!=State::Quarantined)assert(stage.shutdown()==Result::Ok);::close(fd_for_open);fd_for_open=-1;maps.clear();vectors.clear();short_payload=bad_tell=fail_close=throw_destroy=throw_push=throw_input_destroy=false;}
};
std::int64_t short_rows(int fd,void* p,std::uint32_t n,std::uint64_t off){auto r=io.pread(fd,p,n,off);return n==24&&r>0?r-1:r;}
std::int64_t short_profile(int fd,void* p,std::uint32_t n,std::uint64_t off){auto r=io.pread(fd,p,n,off);return off==2252&&r>0?r-1:r;}
}
int main(int argc,char** argv){
 assert(argc>=2);std::string path=std::string(argv[1])+"/little.iiq";
 {ReaderStage s(native());check(s.open(nullptr,0,"x",1)==Result::InvalidState,"unconstructed open");}
 {auto api=native();api.exact_image_and_layout_verified=false;ReaderStage s(api);check(s.construct(storage.data(),storage.size(),inputs())==Result::InvalidApi,"unverified ABI rejected");}
 {ReaderStage s(native());check(s.construct(storage.data()+1,storage.size()-1,inputs())==Result::InvalidStorage,"unaligned storage rejected");}
 {ReaderStage s(native());assert(s.construct(storage.data(),storage.size(),inputs())==Result::Ok);std::string name(256,'x');check(s.open(nullptr,0,name.c_str(),name.size())==Result::InvalidPath,"native snprintf truncation prevented");assert(s.shutdown()==Result::Ok);}
 {ReaderStage s(native());assert(s.construct(storage.data(),storage.size(),inputs())==Result::Ok);const char name[]={'x','\0','y','\0'};check(s.open(nullptr,0,name,3)==Result::InvalidPath,"embedded NUL rejected");assert(s.shutdown()==Result::Ok);}
 {int fd=::open(path.c_str(),O_RDWR);FileInfo f;check(inspect_saved_iiq(io,fd,f)==SourceResult::InvalidOwner,"write fd rejected");::close(fd);}
 const std::pair<const char*,SourceResult> malformed[]={{"duplicate.iiq",SourceResult::DuplicateTag},{"raw-outside.iiq",SourceResult::InvalidRange},{"crop-outside.iiq",SourceResult::InvalidGeometry},{"unknown-format.iiq",SourceResult::InvalidGeometry},{"multi-directory.iiq",SourceResult::InvalidDirectory},{"truncated.iiq",SourceResult::ShortRead}};
 for(const auto& m:malformed){int fd=::open((std::string(argv[1])+"/"+m.first).c_str(),O_RDONLY);FileInfo f;check(inspect_saved_iiq(io,fd,f)==m.second,m.first);::close(fd);}
 for(const char* name:{"little.iiq","big.iiq","tiff.iiq"}){
  Session s(std::string(argv[1])+"/"+name);SourceBundle source(objects());
  check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::Ok,"complete encoded section with owned native input/tags");
  auto* tags=static_cast<Map*>(nullptr);for(auto& m:maps)tags=m.second.get();assert(tags);
  check(source.ready_encoded_full_section()&&source.raw_input()&&source.owned_tags(),"ready only after exact source read");
  std::array<std::uint8_t,4096> stack_noise{};stack_noise.fill(0xa5);
  const auto wb=tags->at(0x107);const std::uint32_t expected[]={0x3f800000,0x40000000,0x3f000000};
  check(wb.bytes==12&&std::memcmp(wb.blob,expected,12)==0,"WB pointer remains owned after return");
  check(tags->at(0x25a).blob==black.data()&&tags->at(0x26a).blob==black.data()+24&&tags->at(0x110).blob==calibration.data(),"native blobs borrow retained exclusive buffers");
  check(rows[5]==80&&black[2]==1&&black[3]==0,"BE rows and native U16 black byte order");
  check(source.profile().bytes==profile.data()&&source.profile().length==8&&source.profile().builtin_slot_zero,"owned embedded profile selects native slot0 only by first byte");
  check(source.cleanup()==SourceResult::Ok&&!source.raw_input()&&maps.empty()&&vectors.empty(),"source native cleanup");
 }
 {Session s(std::string(argv[1])+"/no-profile.iiq");SourceBundle source(objects());auto b=buffers();b.profile=nullptr;b.profile_capacity=0;check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,b)==SourceResult::Ok&&source.profile().bytes==nullptr&&source.profile().builtin_slot_zero,"no profile section follows native default0 branch");assert(source.cleanup()==SourceResult::Ok);}
 {Session s(std::string(argv[1])+"/custom-profile.iiq");SourceBundle source(objects());check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::Ok&&!source.profile().builtin_slot_zero&&std::memcmp(source.profile().bytes,"PROFILE!",8)==0,"nonzero embedded profile retained for real generator parser, not silently defaulted");assert(source.cleanup()==SourceResult::Ok);}
 {Session s(path);auto before=reads;ReaderStage unused(native());Candidate c;check(s.stage.read_candidate(payload.data(),1,c)==Result::InvalidState&&reads==before,"read cannot repeat after candidate");}
 {fd_for_open=::open(path.c_str(),O_RDONLY);ReaderStage s(native());assert(s.construct(storage.data(),storage.size(),inputs())==Result::Ok);assert(s.open(nullptr,0,"x",1)==Result::Ok);auto before=reads;Candidate c;check(s.read_candidate(payload.data(),95,c)==Result::CapacityExceeded&&reads==before&&c.payload==nullptr,"capacity before native assert/read");assert(s.shutdown()==Result::Ok);::close(fd_for_open);}
 {fd_for_open=::open(path.c_str(),O_RDONLY);ReaderStage s(native());assert(s.construct(storage.data(),storage.size(),inputs())==Result::Ok);assert(s.open(nullptr,0,"x",1)==Result::Ok);short_payload=true;Candidate c;check(s.read_candidate(payload.data(),payload.size(),c)==Result::ShortRead&&c.payload==nullptr,"short native fullpayload read rejected");short_payload=false;assert(s.shutdown()==Result::Ok);::close(fd_for_open);}
 {Session s(path);SourceBundle source(objects());auto f=s.info;f.stamp.inode++;check(source.build(io,fd_for_open,f,s.stage,s.candidate,buffers())==SourceResult::FileChanged,"source inode changed");}
 {Session s(path);SourceBundle source(objects());check(source.build(io,fd_for_open+1,s.info,s.stage,s.candidate,buffers())==SourceResult::InvalidOwner,"same native held fd mandatory");}
 {Session s(path);SourceBundle source(objects());payload[10]^=1;check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::PayloadMismatch,"native wrong section cannot claim complete");}
 {Session s(path);SourceBundle source(objects());assert(::lseek(fd_for_open,1,SEEK_CUR)>0);check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::MetadataMismatch,"native ignored seek error caught by end offset");}
 {Session s(path);SourceBundle source(objects());put(storage.data(),0x20+4,std::uint32_t(0));check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::MetadataMismatch,"partial native row read/row mismatch");}
 {Session s(path);SourceBundle source(objects());auto short_io=io;short_io.pread=short_rows;check(source.build(short_io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::ShortRead,"short row read not hidden by native bool");}
 {Session s(path);SourceBundle source(objects());auto b=buffers();b.calibration_capacity=15;check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,b)==SourceResult::CapacityExceeded,"calibration exact bounded reservation");}
 {Session s(path);SourceBundle source(objects());auto b=buffers();b.profile_capacity=7;check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,b)==SourceResult::CapacityExceeded,"profile exact bounded reservation");}
 {Session s(path);SourceBundle source(objects());auto short_io=io;short_io.pread=short_profile;check(source.build(short_io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::ShortRead,"short profile read rejected independent of native helper bool");}
 {Session s(path);SourceBundle source(objects());auto b=buffers();b.black=payload.data();check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,b)==SourceResult::InvalidOwner,"no RAW mutation by black temporary overlap");}
 {Session s(path);SourceBundle source(objects());put(storage.data(),CaptureFormatOffset+0xbc,std::uint32_t(0x7fc00000));check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::MetadataMismatch&&maps.empty(),"nonfinite native field rejected before tag map mutation");}
 {Session s(path);SourceBundle source(objects());put(storage.data(),CaptureFormatOffset+0x208,std::uint32_t(0));check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::MetadataMismatch,"tag20c uses native208 rather than unrelated210 field");}
 {Session s(path);SourceBundle source(objects());put(storage.data(),CaptureFormatOffset+0x27c,std::uint32_t(1));check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::MetadataMismatch,"native calibration length must match whole file section");}
 {Session s(path);SourceBundle source(objects());throw_push=true;check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::NativeException&&source.quarantined()&&!source.raw_input(),"native vector allocation exception quarantines live native objects");check(source.cleanup()==SourceResult::NativeCleanupFailed&&!maps.empty()&&!vectors.empty(),"no unsafe destroy retry after partial native operation");}
 {Session s(path);SourceBundle source(objects());assert(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::Ok);throw_input_destroy=true;check(source.cleanup()==SourceResult::NativeCleanupFailed&&source.quarantined()&&!source.raw_input()&&!maps.empty(),"native input destroy exception holds dependent map buffers");}
 {Session s(path);fail_close=true;const auto before=destroys;check(s.stage.shutdown()==Result::CloseFailed&&s.stage.state()==State::Quarantined&&destroys==before,"false close even cleared open flag retains native reader");check(s.stage.shutdown()==Result::InvalidState,"no unsafe repeated native close");}
 {Session s(path);throw_destroy=true;check(s.stage.shutdown()==Result::NativeException&&s.stage.state()==State::Quarantined,"throwing native destructor quarantined");}
 if(argc==3){
  int fd=::open(argv[2],O_RDONLY);FileInfo f;
  check(inspect_saved_iiq(io,fd,f)==SourceResult::Ok,"actual saved IIQ metadata inspection");
  check(f.geometry.total_width==14308&&f.geometry.total_height==10760&&f.geometry.valid_width==14204&&f.geometry.valid_height==10652&&f.payload_offset==512&&f.geometry.payload_bytes==159899952,"actual full RAW distinct from TIFF640x480");
  ::close(fd);
  payload.resize(f.geometry.payload_bytes);black.resize((f.geometry.total_width+f.geometry.total_height)*4);calibration.resize(entry(f,0x110)->bytes);
  Session s(argv[2]);SourceBundle source(objects());
  check(source.build(io,fd_for_open,s.info,s.stage,s.candidate,buffers())==SourceResult::Ok,"actual full encoded section validated with mock native reader/functions only");
  check(rows[0]==0&&rows[10759]==159889516&&source.profile().length==8&&source.profile().builtin_slot_zero,"actual full row table and profile finite checks");
  check(source.cleanup()==SourceResult::Ok,"actual source host mock objects cleaned");
 }
 std::cout<<"{\"groups\":"<<groups<<",\"host_only\":true,\"native_vendor_code_executed\":false,\"camera_accessed\":false}"<<std::endl;
}
