#include "../../src/recording/mjpeg_avi.hpp"
#include <cerrno>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <sys/stat.h>
#include <unistd.h>

using namespace iq4::recording;
using iq4::runtime::Frame;
namespace {
unsigned passed=0,failed=0;
void check(bool v,const char* why="check failed"){if(!v)throw std::runtime_error(why);}
void test(const std::string& name,const std::function<void()>& f){try{f();++passed;std::cout<<"PASS "<<name<<'\n';}catch(const std::exception& e){++failed;std::cerr<<"FAIL "<<name<<": "<<e.what()<<'\n';}}
template<class F>void rejects(F f){bool caught=false;try{f();}catch(const std::exception&){caught=true;}check(caught,"error expected");}
std::vector<std::uint8_t> read(const std::string& path){std::ifstream in(path,std::ios::binary);check(bool(in),"cannot read test input");return {std::istreambuf_iterator<char>(in),{}};}
void write(const std::string& path,const std::vector<std::uint8_t>& b){std::ofstream out(path,std::ios::binary);out.write(reinterpret_cast<const char*>(b.data()),b.size());check(bool(out));}
std::uint64_t remaining=std::numeric_limits<std::uint64_t>::max();
ssize_t limitedWrite(int fd,const void* p,std::size_t n){if(!remaining){errno=ENOSPC;return -1;}n=std::min<std::uint64_t>(n,remaining);const auto result=::write(fd,p,n);if(result>0)remaining-=result;return result;}
ssize_t failPatch(int,const void*,std::size_t,off_t){errno=EIO;return -1;}
int failSync(int){errno=EIO;return -1;}
int directoryFailSync(int fd){struct stat st{};check(::fstat(fd,&st)==0);if(S_ISDIR(st.st_mode)){errno=EIO;return -1;}return ::fsync(fd);}
int unsupportedRename(int,const char*,int,const char*){errno=ENOTSUP;return -1;}
Frame packet(const std::vector<std::uint8_t>& bytes,unsigned i){return {bytes,static_cast<std::int64_t>((std::uint64_t(i)*1000000000ULL+15)/30),std::uint64_t(100+i)};}
}
int main(int argc,char** argv){
    if(argc!=3){std::cerr<<"usage: test_recording <host-jpeg-fixtures> <fresh-output-directory>\n";return 2;}
    const std::string fixtures=argv[1],directory=argv[2];std::filesystem::create_directories(directory);
    std::vector<std::vector<std::uint8_t>> frames;for(unsigned i=1;i<=12;++i){char leaf[40];std::snprintf(leaf,sizeof(leaf),"host_fixture_%02u.jpg",i);frames.push_back(read(fixtures+"/"+leaf));}
    auto opts=[&](const std::string& prefix){AviOptions o;o.directory=directory;o.prefix=prefix;o.width=96;o.height=64;return o;};
    test("Recorder writes 12 exact JPEG packets then indexed exclusive AVI",[&]{
        auto b=std::make_unique<MjpegAviBackend>(opts("normal"));auto* backend=b.get();iq4::runtime::Recorder r(2,1024*1024,std::move(b));check(r.start());
        for(unsigned i=0;i<frames.size();++i){check(r.submit(packet(frames[i],i)));check(r.consume_one());}check(r.stop());check(r.state()==iq4::runtime::State::Idle);check(r.counters().encoded==12);check(backend->publication()==Publication::Complete);check(backend->packetCount()==12);check(backend->maxPtsDeviationNs()==0);
        check(std::filesystem::exists(directory+"/normal_1.avi"));check(!std::filesystem::exists(directory+"/normal_1.avi.iq4rec.partial"));
    });
    test("second Recorder run selects another final name",[&]{MjpegAviBackend b(opts("repeat"));for(unsigned i=0;i<2;++i){b.prepare();b.encode(packet(frames[0],0));b.finalize();}check(std::filesystem::exists(directory+"/repeat_1.avi")&&std::filesystem::exists(directory+"/repeat_2.avi"));});
    test("irregular source PTS rejected instead of silently becoming CFR",[&]{
        auto b=std::make_unique<MjpegAviBackend>(opts("irregular"));auto* backend=b.get();iq4::runtime::Recorder r(2,1024*1024,std::move(b));check(r.start());check(r.submit(packet(frames[0],0)));check(r.consume_one());auto bad=packet(frames[1],1);bad.pts_ns+=3000000;check(r.submit(bad));check(!r.consume_one());check(r.state()==iq4::runtime::State::Error);check(r.error().find("CFR")!=std::string::npos);check(!std::filesystem::exists(directory+"/irregular_1.avi"));
        auto recovery=opts("irregular_recovered");std::string final;check(recoverPartial(backend->temporaryLeaf(),recovery,final)==1);
    });
    test("explicit small CFR tolerance retains original timestamp deviation",[&]{auto o=opts("tolerance");o.ptsToleranceNs=100000;MjpegAviBackend b(o);b.prepare();b.encode(packet(frames[0],0));auto frame=packet(frames[1],1);frame.pts_ns+=50000;b.encode(frame);b.finalize();check(b.maxPtsDeviationNs()==50000);});
    test("owned packets and identical static JPEG do not synthesize extra frames",[&]{MjpegAviBackend b(opts("identical"));b.prepare();for(unsigned i=0;i<3;++i)b.encode(packet(frames[0],i));b.finalize();check(b.packetCount()==3);});
    test("aborted 7-packet segment recovers to NEW output unchanged source",[&]{MjpegAviBackend b(opts("aborted"));b.prepare();for(unsigned i=0;i<7;++i)b.encode(packet(frames[i],i));const auto partial=b.temporaryLeaf();b.abort();b.abort();const auto original=read(directory+"/"+partial);std::string final;check(recoverPartial(partial,opts("aborted_recovered"),final)==7);check(read(directory+"/"+partial)==original);check(final=="aborted_recovered_1.avi");});
    test("short writes and ENOSPC mid-packet retain complete prefix for recovery",[&]{
        auto o=opts("disk_full");o.fileOps.write=limitedWrite;remaining=std::numeric_limits<std::uint64_t>::max();MjpegAviBackend b(o);b.prepare();for(unsigned i=0;i<5;++i)b.encode(packet(frames[i],i));remaining=19;rejects([&]{b.encode(packet(frames[5],5));});b.abort();remaining=std::numeric_limits<std::uint64_t>::max();const auto original=read(directory+"/"+b.temporaryLeaf());std::string final;check(recoverPartial(b.temporaryLeaf(),opts("disk_full_recovered"),final)==5);check(read(directory+"/"+b.temporaryLeaf())==original);
    });
    test("header patch EIO retains fully written packets for recovery",[&]{auto o=opts("patch_error");o.fileOps.pwrite=failPatch;MjpegAviBackend b(o);b.prepare();for(unsigned i=0;i<4;++i)b.encode(packet(frames[i],i));rejects([&]{b.finalize();});b.abort();std::string final;check(recoverPartial(b.temporaryLeaf(),opts("patch_recovered"),final)==4);});
    test("file sync EIO never publishes final name",[&]{auto o=opts("sync_error");o.fileOps.sync=failSync;MjpegAviBackend b(o);b.prepare();b.encode(packet(frames[0],0));rejects([&]{b.finalize();});check(b.publication()==Publication::Sealed);b.abort();check(!std::filesystem::exists(directory+"/sync_error_1.avi"));std::string final;check(recoverPartial(b.temporaryLeaf(),opts("sync_recovered"),final)==1);});
    test("unsupported exclusive rename refuses success with partial intact",[&]{auto o=opts("rename_unsupported");o.fileOps.renameExclusive=unsupportedRename;MjpegAviBackend b(o);b.prepare();b.encode(packet(frames[0],0));rejects([&]{b.finalize();});b.abort();check(std::filesystem::exists(directory+"/"+b.temporaryLeaf()));check(!std::filesystem::exists(directory+"/rename_unsupported_1.avi"));});
    test("post-rename directory EIO reports visible but unconfirmed durability",[&]{auto o=opts("dirsync_error");o.fileOps.sync=directoryFailSync;MjpegAviBackend b(o);b.prepare();b.encode(packet(frames[0],0));rejects([&]{b.finalize();});check(b.publication()==Publication::FinalNameVisible);check(std::filesystem::exists(directory+"/dirsync_error_1.avi"));b.abort();});
    test("exclusive rename refuses raced final/symlink without overwrite",[&]{
        const std::uint8_t bytes[]={1,2,3};ExclusiveFile f(directory,"collision.avi");f.append(bytes,3);write(directory+"/collision.avi",{8,9});rejects([&]{f.publish();});check(read(directory+"/collision.avi")==std::vector<std::uint8_t>({8,9}));check(std::filesystem::exists(directory+"/collision.avi.iq4rec.partial"));rejects([&]{f.append(bytes,3);});
        std::filesystem::create_symlink("collision.avi",directory+"/symlink.avi");rejects([&]{ExclusiveFile g(directory,"symlink.avi");});
    });
    test("visible final file cannot be patched/written after durability failure",[&]{
        FileOps ops;ops.sync=directoryFailSync;ExclusiveFile f(directory,"visible_guard.avi",ops);const std::uint8_t bytes[]={1,2,3};f.append(bytes,3);rejects([&]{f.publish();});check(f.publication()==Publication::FinalNameVisible);const auto original=read(directory+"/visible_guard.avi");rejects([&]{f.append(bytes,3);});rejects([&]{f.patch(0,bytes,3);});rejects([&]{f.publish();});check(read(directory+"/visible_guard.avi")==original);
    });
    test("JPEG corruption/CRC causes recovery to stop before damaged pair",[&]{MjpegAviBackend b(opts("crc"));b.prepare();for(unsigned i=0;i<3;++i)b.encode(packet(frames[i],i));b.abort();auto data=read(directory+"/"+b.temporaryLeaf());const std::uint8_t marker[]={'m','o','v','i'};const auto at=std::search(data.begin(),data.end(),marker,marker+4);check(at!=data.end());const auto jpeg=std::size_t(at-data.begin())+12;data.at(jpeg+15)^=1;write(directory+"/crc_bad.avi.iq4rec.partial",data);std::string final;rejects([&]{recoverPartial("crc_bad.avi.iq4rec.partial",opts("crc_recovered"),final);});});
    test("wrong JPEG dimensions/non-JPEG/duplicate PTS rejected",[&]{auto o=opts("bad_dimensions");o.width=1920;MjpegAviBackend b(o);b.prepare();rejects([&]{b.encode(packet(frames[0],0));});b.abort();MjpegAviBackend p(opts("bad_packet"));p.prepare();rejects([&]{p.encode({{1,2,3},0,{}});});p.abort();MjpegAviBackend t(opts("duplicate_pts"));t.prepare();t.encode(packet(frames[0],0));rejects([&]{t.encode(packet(frames[1],0));});t.abort();});
    test("capacity limit stops without writing oversized packet",[&]{auto o=opts("budget");o.maxFileBytes=1024;MjpegAviBackend b(o);b.prepare();rejects([&]{b.encode(packet(frames[0],0));});b.abort();check(std::filesystem::file_size(directory+"/"+b.temporaryLeaf())<1024);});
    test("unsupported input partial header/path/config refused",[&]{rejects([&]{ExclusiveFile f(directory,"../bad.avi");});rejects([&]{ExclusiveFile f(std::string(directory)+std::string("\0extra",6),"bad.avi");});auto o=opts("bad_cfg");o.ptsToleranceNs=100000000;rejects([&]{MjpegAviBackend b(o);});std::string result;rejects([&]{recoverPartial("normal_1.avi",opts("wrong_partial"),result);});});
    auto mkvOpts=[&](const std::string& prefix){MatroskaOptions o;o.directory=directory;o.prefix=prefix;o.width=96;o.height=64;return o;};
    const std::vector<std::int64_t> vfrPts={1000000000,1031000123,1067000456,1100123789,1185000789,1200000901,1249010234,1298888888,1333333333,1400056789,1457777777,1512345678};
    test("Matroska Recorder preserves 12 irregular source PTS without FPS declaration",[&]{
        auto b=std::make_unique<MjpegMatroskaBackend>(mkvOpts("vfr"));auto* backend=b.get();iq4::runtime::Recorder r(2,1024*1024,std::move(b));check(r.start());
        for(unsigned i=0;i<frames.size();++i){check(r.submit({frames[i],vfrPts[i],std::uint64_t(i+100)}));check(r.consume_one());}check(r.stop());check(backend->packetCount()==12&&backend->publication()==Publication::Complete);
    });
    test("Matroska aborted clusters recover original irregular timestamps",[&]{MjpegMatroskaBackend b(mkvOpts("mkv_abort"));b.prepare();for(unsigned i=0;i<5;++i)b.encode({frames[i],vfrPts[i],std::uint64_t(i+100)});b.abort();const auto before=read(directory+"/"+b.temporaryLeaf());std::string final;check(recoverMatroskaPartial(b.temporaryLeaf(),mkvOpts("mkv_abort_recovered"),final)==5);check(read(directory+"/"+b.temporaryLeaf())==before);});
    test("Matroska ENOSPC tail truncation recovers complete clusters only",[&]{auto o=mkvOpts("mkv_disk_full");o.fileOps.write=limitedWrite;remaining=std::numeric_limits<std::uint64_t>::max();MjpegMatroskaBackend b(o);b.prepare();for(unsigned i=0;i<3;++i)b.encode({frames[i],vfrPts[i],{}});remaining=19;rejects([&]{b.encode({frames[3],vfrPts[3],{}});});b.abort();remaining=std::numeric_limits<std::uint64_t>::max();std::string final;check(recoverMatroskaPartial(b.temporaryLeaf(),mkvOpts("mkv_disk_recovered"),final)==3);});
    test("Matroska bad PTS cannot repeat or reverse a frame",[&]{MjpegMatroskaBackend b(mkvOpts("mkv_bad_pts"));b.prepare();b.encode({frames[0],vfrPts[0],{}});rejects([&]{b.encode({frames[1],vfrPts[0],{}});});b.abort();std::string final;check(recoverMatroskaPartial(b.temporaryLeaf(),mkvOpts("mkv_bad_pts_recovered"),final)==1);});
    test("Matroska directory sync failure cannot report final success",[&]{auto o=mkvOpts("mkv_dirsync");o.fileOps.sync=directoryFailSync;MjpegMatroskaBackend b(o);b.prepare();b.encode({frames[0],vfrPts[0],{}});rejects([&]{b.finalize();});check(b.publication()==Publication::FinalNameVisible);b.abort();check(std::filesystem::exists(directory+"/mkv_dirsync_1.mkv"));});
    test("existing files from restart are skipped without overwriting originals",[&]{
        const auto original=read(directory+"/normal_1.avi");MjpegAviBackend b(opts("normal"));b.prepare();check(b.finalLeaf()=="normal_2.avi");b.encode(packet(frames[0],0));b.finalize();check(read(directory+"/normal_1.avi")==original);
        const auto mkvOriginal=read(directory+"/vfr_1.mkv");MjpegMatroskaBackend m(mkvOpts("vfr"));m.prepare();check(m.finalLeaf()=="vfr_2.mkv");m.encode({frames[0],vfrPts[0],{}});m.finalize();check(read(directory+"/vfr_1.mkv")==mkvOriginal);
    });
    test("Recorder source_lost finalizes buffered real JPEG packet ownership",[&]{auto b=std::make_unique<MjpegMatroskaBackend>(mkvOpts("source_lost"));auto* backend=b.get();iq4::runtime::Recorder r(2,1024*1024,std::move(b));check(r.start());check(r.submit({frames[0],vfrPts[0],{}}));check(r.submit({frames[1],vfrPts[1],{}}));r.source_lost();check(r.state()==iq4::runtime::State::Error);check(backend->publication()==Publication::Complete&&backend->packetCount()==2);check(r.reset_error());check(r.state()==iq4::runtime::State::Idle);});
    std::cout<<"RESULT_JSON {\"level\":\"host_validation\",\"camera_control\":false,\"hardware_fps_claimed\":false,\"passed\":"<<passed<<",\"failed\":"<<failed<<"}\n";
    return failed?1:0;
}
