#include "mjpeg_avi.hpp"
#include <algorithm>
#include <cerrno>
#include <cstdio>
#include <cstring>
#include <fcntl.h>
#include <limits>
#include <stdexcept>
#include <sys/stat.h>
#include <unistd.h>
#ifdef __linux__
#include <sys/syscall.h>
#endif

namespace iq4::recording {
namespace {
class FileError final:public std::runtime_error{public:FileError(const char* action,int e):std::runtime_error(std::string(action)+": "+std::strerror(e)),code(e){}int code;};
[[noreturn]] void ioError(const char* action){throw FileError(action,errno);}
void leaf(const std::string& value) {
    if(value.empty()||value.size()>150||value=="."||value==".."||value.find_first_of("/\\")!=std::string::npos||value.find('\0')!=std::string::npos)
        throw std::invalid_argument("invalid recording leaf name");
}
int renameExclusive(int fromFd,const char* from,int toFd,const char* to) {
#ifdef __APPLE__
    return ::renameatx_np(fromFd,from,toFd,to,RENAME_EXCL);
#elif defined(__linux__) && defined(SYS_renameat2)
    // Linux UAPI RENAME_NOREPLACE=1; no assumed firmware call address/ABI.
    return static_cast<int>(::syscall(SYS_renameat2,fromFd,from,toFd,to,1u));
#else
    (void)fromFd;(void)from;(void)toFd;(void)to;errno=ENOTSUP;return -1;
#endif
}
void u16(std::vector<std::uint8_t>& b,std::uint16_t v){b.push_back(v&255);b.push_back(v>>8);}
void u32(std::vector<std::uint8_t>& b,std::uint32_t v){for(unsigned i=0;i<4;++i)b.push_back((v>>(8*i))&255);}
void u64(std::vector<std::uint8_t>& b,std::uint64_t v){for(unsigned i=0;i<8;++i)b.push_back((v>>(8*i))&255);}
void tag(std::vector<std::uint8_t>& b,const char* s){b.insert(b.end(),s,s+4);}
void set32(std::vector<std::uint8_t>& b,std::size_t at,std::uint32_t v){for(unsigned i=0;i<4;++i)b.at(at+i)=(v>>(8*i))&255;}
std::uint32_t read32(const std::uint8_t* p){return std::uint32_t(p[0])|std::uint32_t(p[1])<<8|std::uint32_t(p[2])<<16|std::uint32_t(p[3])<<24;}
std::uint64_t read64(const std::uint8_t* p){return std::uint64_t(read32(p))|std::uint64_t(read32(p+4))<<32;}
std::uint32_t crcUpdate(std::uint32_t crc,const std::uint8_t* bytes,std::size_t n){for(std::size_t i=0;i<n;++i){crc^=bytes[i];for(unsigned b=0;b<8;++b)crc=(crc>>1)^((crc&1)?0xedb88320u:0);}return crc;}
std::vector<std::uint8_t> makeHeader(const AviOptions& o,std::size_t& moviSize,std::size_t& moviType,std::size_t& total,std::size_t& length,std::size_t& mainBuf,std::size_t& streamBuf) {
    std::vector<std::uint8_t> b;tag(b,"RIFF");u32(b,0);tag(b,"AVI ");
    tag(b,"LIST");const auto hdrlSize=b.size();u32(b,0);tag(b,"hdrl");
    tag(b,"avih");u32(b,56);u32(b,static_cast<std::uint32_t>((1000000ULL*o.rateDenominator+o.rateNumerator/2)/o.rateNumerator));
    u32(b,0);u32(b,0);u32(b,0x10);total=b.size();u32(b,0);u32(b,0);u32(b,1);mainBuf=b.size();u32(b,0);u32(b,o.width);u32(b,o.height);for(int i=0;i<4;++i)u32(b,0);
    tag(b,"LIST");const auto strlSize=b.size();u32(b,0);tag(b,"strl");
    tag(b,"strh");u32(b,56);tag(b,"vids");tag(b,"MJPG");u32(b,0);u16(b,0);u16(b,0);u32(b,0);u32(b,o.rateDenominator);u32(b,o.rateNumerator);u32(b,0);
    length=b.size();u32(b,0);streamBuf=b.size();u32(b,0);u32(b,0xffffffff);u32(b,0);u16(b,0);u16(b,0);u16(b,static_cast<std::uint16_t>(o.width));u16(b,static_cast<std::uint16_t>(o.height));
    tag(b,"strf");u32(b,40);u32(b,40);u32(b,o.width);u32(b,o.height);u16(b,1);u16(b,24);tag(b,"MJPG");u32(b,o.width*o.height*3);for(int i=0;i<4;++i)u32(b,0);
    set32(b,strlSize,static_cast<std::uint32_t>(b.size()-strlSize-4));
    // Identifies our recoverable format without relying on filenames alone.
    tag(b,"JUNK");u32(b,16);const char marker[]="IQ4_AVI_MJPEG_v1";b.insert(b.end(),marker,marker+16);
    set32(b,hdrlSize,static_cast<std::uint32_t>(b.size()-hdrlSize-4));
    tag(b,"LIST");moviSize=b.size();u32(b,0);moviType=b.size();tag(b,"movi");return b;
}
void validate(const AviOptions& o){
    leaf(o.prefix);if(o.prefix.size()>100||o.directory.empty()||o.directory.find('\0')!=std::string::npos)throw std::invalid_argument("invalid recording directory/prefix");
    if(!o.width||!o.height||o.width>16384||o.height>16384||!o.rateNumerator||!o.rateDenominator||o.rateNumerator>240000||o.rateDenominator>100000)
        throw std::invalid_argument("invalid AVI geometry/rational playback rate");
    const auto period=1000000000ULL*o.rateDenominator/o.rateNumerator;
    if(period<1000000||o.ptsToleranceNs<0||std::uint64_t(o.ptsToleranceNs)>period/4||o.maxFileBytes<1024||o.maxFileBytes>0xffffffffULL||!o.maxFrames||o.maxFrames>1000000||!o.maxPacketBytes||o.maxPacketBytes>128u*1024*1024)
        throw std::invalid_argument("invalid AVI capacity/timestamp tolerance");
}
void jpegDimensions(const std::vector<std::uint8_t>& b,unsigned width,unsigned height){
    if(b.size()<16||b[0]!=0xff||b[1]!=0xd8||b[b.size()-2]!=0xff||b.back()!=0xd9)throw std::invalid_argument("complete JPEG SOI/EOI required");
    bool found=false;std::size_t pos=2;
    while(pos+1<b.size()){
        if(b[pos++]!=0xff)throw std::invalid_argument("invalid JPEG marker before scan");
        while(pos<b.size()&&b[pos]==0xff)++pos;if(pos==b.size())break;
        const auto m=b[pos++];if(m==0xda)break;if(m==0xd9)break;
        if(m==0xd8||m==0x01||(m>=0xd0&&m<=0xd7))continue;
        if(pos+2>b.size())throw std::invalid_argument("truncated JPEG segment");
        const auto n=unsigned(b[pos])*256+b[pos+1];if(n<2||n>b.size()-pos)throw std::invalid_argument("invalid JPEG segment length");
        if(m==0xc0){if(n<8||b[pos+2]!=8||(b[pos+7]!=1&&b[pos+7]!=3))throw std::invalid_argument("8-bit grayscale/RGB baseline JPEG required");
            if(unsigned(b[pos+3])*256+b[pos+4]!=height||unsigned(b[pos+5])*256+b[pos+6]!=width)throw std::invalid_argument("JPEG dimensions differ from configured AVI");found=true;}
        else if(m>=0xc1&&m<=0xcf&&m!=0xc4&&m!=0xc8&&m!=0xcc)throw std::invalid_argument("non-baseline JPEG is not supported by this first AVI backend");
        pos+=n;
    }
    if(!found)throw std::invalid_argument("JPEG baseline SOF missing");
}
struct ReadFile{int fd=-1;~ReadFile(){if(fd>=0)::close(fd);}};
bool readAt(int fd,std::uint64_t offset,void* data,std::size_t count){auto* p=static_cast<std::uint8_t*>(data);while(count){const auto n=::pread(fd,p,count,static_cast<off_t>(offset));if(n<0&&errno==EINTR)continue;if(n<0)ioError("read partial AVI");if(n==0)return false;offset+=n;p+=n;count-=std::size_t(n);}return true;}
}

ExclusiveFile::ExclusiveFile(std::string directory,std::string name,FileOps ops):ops_(ops),final_(std::move(name)){
    leaf(final_);if(directory.empty()||directory.find('\0')!=std::string::npos)throw std::invalid_argument("invalid recording directory");
    temporary_=final_+".iq4rec.partial";
    if(!ops_.write)ops_.write=::write;if(!ops_.pwrite)ops_.pwrite=::pwrite;if(!ops_.sync)ops_.sync=::fsync;if(!ops_.renameExclusive)ops_.renameExclusive=renameExclusive;
    directoryFd_=::open(directory.c_str(),O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);if(directoryFd_<0)ioError("open recording directory");
    struct stat st{};if(::fstatat(directoryFd_,final_.c_str(),&st,AT_SYMLINK_NOFOLLOW)==0){close();errno=EEXIST;ioError("final AVI already exists");}
    if(errno!=ENOENT){const int saved=errno;close();errno=saved;ioError("check final AVI name");}
    fileFd_=::openat(directoryFd_,temporary_.c_str(),O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC,0600);
    if(fileFd_<0){const int saved=errno;close();errno=saved;ioError("create exclusive recording temporary");}
}
ExclusiveFile::~ExclusiveFile(){close();}
void ExclusiveFile::close() noexcept{if(fileFd_>=0){::close(fileFd_);fileFd_=-1;}if(directoryFd_>=0){::close(directoryFd_);directoryFd_=-1;}}
void ExclusiveFile::append(const void* data,std::size_t count){
    if(publication_!=Publication::Temporary||fileFd_<0||(!data&&count))throw std::logic_error("recording output cannot be written in current state");
    const auto* p=static_cast<const std::uint8_t*>(data);while(count){const auto n=ops_.write(fileFd_,p,count);if(n<0&&errno==EINTR)continue;if(n<=0){if(n==0)errno=EIO;ioError("write recording temporary");}p+=n;count-=std::size_t(n);size_+=n;}
}
void ExclusiveFile::patch(std::uint64_t offset,const void* data,std::size_t count){
    if(publication_!=Publication::Temporary||fileFd_<0||offset>size_||count>size_-offset||(!data&&count))throw std::logic_error("invalid recording header patch");
    const auto* p=static_cast<const std::uint8_t*>(data);while(count){const auto n=ops_.pwrite(fileFd_,p,count,static_cast<off_t>(offset));if(n<0&&errno==EINTR)continue;if(n<=0){if(n==0)errno=EIO;ioError("patch recording header");}p+=n;count-=std::size_t(n);offset+=n;}
}
void ExclusiveFile::publish(){
    if(publication_!=Publication::Temporary||fileFd_<0)throw std::logic_error("recording output already sealed/visible");
    publication_=Publication::Sealed;
    if(ops_.sync(fileFd_)!=0)ioError("sync completed recording temporary");
    const int oldFd=fileFd_;fileFd_=-1;if(::close(oldFd)!=0)ioError("close completed recording temporary");
    if(ops_.renameExclusive(directoryFd_,temporary_.c_str(),directoryFd_,final_.c_str())!=0)ioError("exclusive recording rename unsupported or failed");
    publication_=Publication::FinalNameVisible;
    if(ops_.sync(directoryFd_)!=0)ioError("recording visible but directory durability unconfirmed");
    publication_=Publication::Complete;
}

MjpegAviBackend::MjpegAviBackend(AviOptions options):options_(std::move(options)){validate(options_);}
MjpegAviBackend::~MjpegAviBackend(){abort();}
void MjpegAviBackend::prepare(){
    if(file_)throw std::logic_error("AVI backend already prepared");
    index_.clear();largestPacket_=0;firstPts_=0;lastPts_=-1;lastSequence_.reset();maxPtsDeviationNs_=0;failed_=false;publication_=Publication::Temporary;
    for(unsigned attempt=0;attempt<1024;++attempt){
        finalLeaf_=options_.prefix+"_"+std::to_string(++nameCounter_)+".avi";temporaryLeaf_=finalLeaf_+".iq4rec.partial";
        try{file_=std::make_unique<ExclusiveFile>(options_.directory,finalLeaf_,options_.fileOps);break;}
        catch(const FileError& error){if(error.code!=EEXIST)throw;}
    }
    if(!file_)throw std::runtime_error("recording filename search limit exhausted; choose a new prefix");
    header_=makeHeader(options_,moviSizeOffset_,moviTypeOffset_,totalFramesOffset_,streamLengthOffset_,mainBufferOffset_,streamBufferOffset_);
    try{file_->append(header_.data(),header_.size());}catch(...){failed_=true;throw;}
}
void MjpegAviBackend::encode(const runtime::Frame& f){
    if(!file_||failed_)throw std::logic_error("AVI backend unavailable");
    try{
        if(f.bytes.size()>options_.maxPacketBytes||index_.size()>=options_.maxFrames)throw std::runtime_error("AVI packet/frame budget exceeded");
        jpegDimensions(f.bytes,options_.width,options_.height);
        if(f.pts_ns<0||f.pts_ns<=lastPts_)throw std::invalid_argument("JPEG packet PTS must be real and strictly increasing");
        if(f.source_sequence&&lastSequence_&&*f.source_sequence<=*lastSequence_)throw std::invalid_argument("source sequence must increase when available");
        if(index_.empty())firstPts_=f.pts_ns;
        const auto ticks=std::uint64_t(index_.size())*options_.rateDenominator;
        const auto whole=ticks/options_.rateNumerator;
        if(whole>std::uint64_t(std::numeric_limits<std::int64_t>::max())/1000000000ULL)throw std::invalid_argument("AVI timestamp duration overflow");
        const auto step=whole*1000000000ULL+((ticks%options_.rateNumerator)*1000000000ULL+options_.rateNumerator/2)/options_.rateNumerator;
        if(step>std::uint64_t(std::numeric_limits<std::int64_t>::max()-firstPts_))throw std::invalid_argument("AVI timestamp duration overflow");
        const auto expected=firstPts_+static_cast<std::int64_t>(step);const auto deviation=f.pts_ns>=expected?f.pts_ns-expected:expected-f.pts_ns;
        if(deviation>options_.ptsToleranceNs)throw std::runtime_error("input PTS cannot be expressed by configured CFR AVI; VFR/another verified mode required");
        const auto chunkSize=8+f.bytes.size()+(f.bytes.size()%2)+44;
        const auto finishedSize=file_->size()+chunkSize+8+(index_.size()+1)*16;
        if(finishedSize>options_.maxFileBytes)throw std::runtime_error("AVI segment byte budget reached; stop/recover this segment before a new recording");
        const auto offset=file_->size()-moviTypeOffset_;std::vector<std::uint8_t> chunk;tag(chunk,"00dc");u32(chunk,static_cast<std::uint32_t>(f.bytes.size()));file_->append(chunk.data(),chunk.size());file_->append(f.bytes.data(),f.bytes.size());
        if(f.bytes.size()%2){const std::uint8_t zero=0;file_->append(&zero,1);}
        std::vector<std::uint8_t> timing;tag(timing,"JUNK");u32(timing,36);tag(timing,"IQ4T");u32(timing,1);u64(timing,static_cast<std::uint64_t>(f.pts_ns));u64(timing,f.source_sequence.value_or(0));u32(timing,f.source_sequence?1:0);u32(timing,static_cast<std::uint32_t>(f.bytes.size()));
        const auto crc=crcUpdate(crcUpdate(0xffffffffu,f.bytes.data(),f.bytes.size()),timing.data()+8,32);u32(timing,~crc);file_->append(timing.data(),timing.size());
        index_.push_back({static_cast<std::uint32_t>(offset),static_cast<std::uint32_t>(f.bytes.size())});lastPts_=f.pts_ns;lastSequence_=f.source_sequence;largestPacket_=std::max(largestPacket_,static_cast<std::uint32_t>(f.bytes.size()));maxPtsDeviationNs_=std::max(maxPtsDeviationNs_,deviation);
    }catch(...){failed_=true;throw;}
}
void MjpegAviBackend::finalize(){
    if(!file_||failed_||index_.empty())throw std::logic_error("cannot finalize empty/failed AVI");
    try{
        const auto moviEnd=file_->size();std::vector<std::uint8_t> idx;tag(idx,"idx1");u32(idx,static_cast<std::uint32_t>(index_.size()*16));for(const auto e:index_){tag(idx,"00dc");u32(idx,0x10);u32(idx,e.offset);u32(idx,e.length);}file_->append(idx.data(),idx.size());
        set32(header_,4,static_cast<std::uint32_t>(file_->size()-8));set32(header_,moviSizeOffset_,static_cast<std::uint32_t>(moviEnd-moviSizeOffset_-4));set32(header_,totalFramesOffset_,static_cast<std::uint32_t>(index_.size()));set32(header_,streamLengthOffset_,static_cast<std::uint32_t>(index_.size()));set32(header_,mainBufferOffset_,largestPacket_);set32(header_,streamBufferOffset_,largestPacket_);
        file_->patch(0,header_.data(),header_.size());file_->publish();publication_=file_->publication();file_.reset();
    }catch(...){failed_=true;if(file_)publication_=file_->publication();throw;}
}
void MjpegAviBackend::abort() noexcept{if(file_){publication_=file_->publication();file_->close();file_.reset();}}

std::size_t recoverPartial(const std::string& source,AviOptions options,std::string& finalLeaf){
    validate(options);leaf(source);const std::string suffix=".iq4rec.partial";if(source.size()<suffix.size()||source.substr(source.size()-suffix.size())!=suffix)throw std::invalid_argument("only IQ4 recording partial leaf accepted");
    ReadFile directory;directory.fd=::open(options.directory.c_str(),O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);if(directory.fd<0)ioError("open recovery directory");
    ReadFile input;input.fd=::openat(directory.fd,source.c_str(),O_RDONLY|O_NOFOLLOW|O_CLOEXEC);if(input.fd<0)ioError("open read-only recording partial");struct stat st{};if(::fstat(input.fd,&st)!=0)ioError("stat recording partial");if(!S_ISREG(st.st_mode)||st.st_size<0||std::uint64_t(st.st_size)>options.maxFileBytes)throw std::invalid_argument("invalid/oversized recording partial");
    std::size_t ms,mt,tf,sl,mb,sb;auto expected=makeHeader(options,ms,mt,tf,sl,mb,sb);auto actual=expected;
    if(!readAt(input.fd,0,actual.data(),actual.size()))throw std::runtime_error("partial header incomplete; no complete frames recoverable");
    for(auto at:{std::size_t(4),ms,tf,sl,mb,sb})set32(actual,at,0);
    if(actual!=expected)throw std::invalid_argument("partial is not this AVI format/options; refusing reinterpretation");
    MjpegAviBackend output(options);output.prepare();std::uint64_t offset=expected.size();std::size_t count=0;
    while(offset+8<=std::uint64_t(st.st_size)){
        std::uint8_t chunk[8];if(!readAt(input.fd,offset,chunk,8)||std::memcmp(chunk,"00dc",4)!=0)break;const auto n=read32(chunk+4);
        if(n>options.maxPacketBytes||n<16)break;const auto next=offset+8+n+(n%2);std::uint8_t timing[44];if(next+44>std::uint64_t(st.st_size)||!readAt(input.fd,next,timing,44))break;
        if(std::memcmp(timing,"JUNK",4)||read32(timing+4)!=36||std::memcmp(timing+8,"IQ4T",4)||read32(timing+12)!=1||read32(timing+36)!=n||(read32(timing+32)&~1u))break;
        runtime::Frame frame;frame.bytes.resize(n);if(!readAt(input.fd,offset+8,frame.bytes.data(),n))break;const auto pts=read64(timing+16);if(pts>std::uint64_t(std::numeric_limits<std::int64_t>::max()))break;frame.pts_ns=static_cast<std::int64_t>(pts);if(read32(timing+32)&1u)frame.source_sequence=read64(timing+24);
        if(~crcUpdate(crcUpdate(0xffffffffu,frame.bytes.data(),frame.bytes.size()),timing+8,32)!=read32(timing+40))break;
        output.encode(frame);++count;offset=next+44;
    }
    if(!count){output.abort();throw std::runtime_error("no complete JPEG/timestamp pairs recoverable");}
    output.finalize();finalLeaf=output.finalLeaf();return count;
}
namespace {
void be(std::vector<std::uint8_t>& b,std::uint64_t value,unsigned length){for(unsigned i=length;i>0;--i)b.push_back((value>>(8*(i-1)))&255);}
std::uint64_t readBe(const std::uint8_t* p,unsigned n){std::uint64_t v=0;for(unsigned i=0;i<n;++i)v=(v<<8)|p[i];return v;}
void ebmlSize(std::vector<std::uint8_t>& b,std::uint64_t value,unsigned length=0){if(!length){length=1;while(length<8&&value>=(1ULL<<(7*length))-1)++length;}if(value>=(1ULL<<(7*length))-1)throw std::invalid_argument("EBML size overflow");be(b,value|(1ULL<<(7*length)),length);}
void element(std::vector<std::uint8_t>& b,unsigned id,unsigned idLength,const std::vector<std::uint8_t>& content){be(b,id,idLength);ebmlSize(b,content.size());b.insert(b.end(),content.begin(),content.end());}
void uintElement(std::vector<std::uint8_t>& b,unsigned id,unsigned idLength,std::uint64_t value,unsigned length=1){std::vector<std::uint8_t> v;be(v,value,length);element(b,id,idLength,v);}
void stringElement(std::vector<std::uint8_t>& b,unsigned id,unsigned idLength,const std::string& value){element(b,id,idLength,{value.begin(),value.end()});}
AviOptions storageOptions(const MatroskaOptions& m){AviOptions a;a.directory=m.directory;a.prefix=m.prefix;a.width=m.width;a.height=m.height;a.maxFileBytes=m.maxFileBytes;a.maxFrames=m.maxFrames;a.maxPacketBytes=m.maxPacketBytes;a.fileOps=m.fileOps;return a;}
std::vector<std::uint8_t> mkvHeader(const MatroskaOptions& o,std::size_t& sizeOffset,std::size_t& start){
    std::vector<std::uint8_t> b,ebml;uintElement(ebml,0x4286,2,1);uintElement(ebml,0x42f7,2,1);uintElement(ebml,0x42f2,2,4);uintElement(ebml,0x42f3,2,8);stringElement(ebml,0x4282,2,"matroska");uintElement(ebml,0x4287,2,4);uintElement(ebml,0x4285,2,2);element(b,0x1a45dfa3,4,ebml);
    be(b,0x18538067,4);sizeOffset=b.size();be(b,0x01ffffffffffffffULL,8);start=b.size();
    std::vector<std::uint8_t> info;uintElement(info,0x2ad7b1,3,1);stringElement(info,0x4d80,2,"iq4-mjpeg-host-0.2");stringElement(info,0x5741,2,"iq4-mjpeg-host-0.2");element(b,0x1549a966,4,info);
    std::vector<std::uint8_t> track,video,tracks;uintElement(track,0xd7,1,1);uintElement(track,0x73c5,2,1);uintElement(track,0x83,1,1);uintElement(track,0x9c,1,0);stringElement(track,0x86,1,"V_MJPEG");uintElement(video,0xb0,1,o.width,2);uintElement(video,0xba,1,o.height,2);element(track,0xe0,1,video);element(tracks,0xae,1,track);element(b,0x1654ae6b,4,tracks);
    return b;
}
}
MjpegMatroskaBackend::MjpegMatroskaBackend(MatroskaOptions o):options_(std::move(o)){validate(storageOptions(options_));}
MjpegMatroskaBackend::~MjpegMatroskaBackend(){abort();}
void MjpegMatroskaBackend::prepare(){
    if(file_)throw std::logic_error("Matroska backend already prepared");count_=0;lastPts_=-1;firstPts_=0;lastSequence_.reset();failed_=false;publication_=Publication::Temporary;
    for(unsigned attempt=0;attempt<1024;++attempt){finalLeaf_=options_.prefix+"_"+std::to_string(++nameCounter_)+".mkv";temporaryLeaf_=finalLeaf_+".iq4rec.partial";try{file_=std::make_unique<ExclusiveFile>(options_.directory,finalLeaf_,options_.fileOps);break;}catch(const FileError& error){if(error.code!=EEXIST)throw;}}
    if(!file_)throw std::runtime_error("Matroska filename search limit exhausted; choose a new prefix");
    const auto h=mkvHeader(options_,segmentSizeOffset_,segmentStart_);try{file_->append(h.data(),h.size());}catch(...){failed_=true;throw;}
}
void MjpegMatroskaBackend::encode(const runtime::Frame& f){
    if(!file_||failed_)throw std::logic_error("Matroska backend unavailable");
    try{
        if(f.bytes.size()>options_.maxPacketBytes||count_>=options_.maxFrames)throw std::runtime_error("Matroska packet/frame budget exceeded");jpegDimensions(f.bytes,options_.width,options_.height);
        if(f.pts_ns<0||f.pts_ns<=lastPts_)throw std::invalid_argument("Matroska source PTS must strictly increase");if(f.source_sequence&&lastSequence_&&*f.source_sequence<=*lastSequence_)throw std::invalid_argument("source sequence must increase");
        if(!count_)firstPts_=f.pts_ns;
        if(file_->size()+f.bytes.size()+73>options_.maxFileBytes)throw std::runtime_error("Matroska segment byte budget reached");
        std::vector<std::uint8_t> prefix;be(prefix,0x1f43b675,4);ebmlSize(prefix,f.bytes.size()+61,8);uintElement(prefix,0xe7,1,static_cast<std::uint64_t>(f.pts_ns-firstPts_),8);be(prefix,0xa3,1);ebmlSize(prefix,f.bytes.size()+4,8);prefix.insert(prefix.end(),{0x81,0,0,0x80});
        std::vector<std::uint8_t> timing;tag(timing,"IQ4T");u32(timing,1);u64(timing,static_cast<std::uint64_t>(f.pts_ns));u64(timing,f.source_sequence.value_or(0));u32(timing,f.source_sequence?1:0);u32(timing,static_cast<std::uint32_t>(f.bytes.size()));u32(timing,~crcUpdate(crcUpdate(0xffffffffu,f.bytes.data(),f.bytes.size()),timing.data(),32));
        std::vector<std::uint8_t> journal;element(journal,0xec,1,timing);file_->append(prefix.data(),prefix.size());file_->append(f.bytes.data(),f.bytes.size());file_->append(journal.data(),journal.size());++count_;lastPts_=f.pts_ns;lastSequence_=f.source_sequence;
    }catch(...){failed_=true;throw;}
}
void MjpegMatroskaBackend::finalize(){
    if(!file_||failed_||!count_)throw std::logic_error("cannot finalize empty/failed Matroska");
    try{std::vector<std::uint8_t> size;ebmlSize(size,file_->size()-segmentStart_,8);file_->patch(segmentSizeOffset_,size.data(),size.size());file_->publish();publication_=file_->publication();file_.reset();}catch(...){failed_=true;if(file_)publication_=file_->publication();throw;}
}
void MjpegMatroskaBackend::abort() noexcept{if(file_){publication_=file_->publication();file_->close();file_.reset();}}
std::size_t recoverMatroskaPartial(const std::string& source,MatroskaOptions options,std::string& final){
    validate(storageOptions(options));leaf(source);const std::string suffix=".iq4rec.partial";if(source.size()<suffix.size()||source.substr(source.size()-suffix.size())!=suffix)throw std::invalid_argument("recording partial leaf required");
    ReadFile directory;directory.fd=::open(options.directory.c_str(),O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);if(directory.fd<0)ioError("open Matroska recovery directory");ReadFile input;input.fd=::openat(directory.fd,source.c_str(),O_RDONLY|O_NOFOLLOW|O_CLOEXEC);if(input.fd<0)ioError("open read-only Matroska partial");struct stat st{};if(::fstat(input.fd,&st)!=0)ioError("stat Matroska partial");if(!S_ISREG(st.st_mode)||st.st_size<0||std::uint64_t(st.st_size)>options.maxFileBytes)throw std::invalid_argument("invalid Matroska partial size");
    std::size_t sizeOffset,start;const auto expected=mkvHeader(options,sizeOffset,start);auto h=expected;if(!readAt(input.fd,0,h.data(),h.size()))throw std::runtime_error("incomplete Matroska header");std::copy(expected.begin()+sizeOffset,expected.begin()+sizeOffset+8,h.begin()+sizeOffset);if(h!=expected)throw std::invalid_argument("Matroska partial header/options mismatch");
    MjpegMatroskaBackend output(options);output.prepare();std::uint64_t offset=h.size();std::size_t count=0;std::uint64_t firstPts=0;
    while(offset+12<=std::uint64_t(st.st_size)){
        std::uint8_t header[12];if(!readAt(input.fd,offset,header,12)||readBe(header,4)!=0x1f43b675||header[4]!=1)break;const auto n=readBe(header+5,7);if(n<77||n>options.maxPacketBytes+61||n>std::uint64_t(st.st_size)-offset-12)break;
        std::vector<std::uint8_t> cluster(static_cast<std::size_t>(n));if(!readAt(input.fd,offset+12,cluster.data(),cluster.size()))break;const auto* p=cluster.data();
        if(p[0]!=0xe7||p[1]!=0x88||p[10]!=0xa3||p[11]!=1||p[19]!=0x81||p[20]!=0||p[21]!=0||p[22]!=0x80)break;const auto jpegSize=readBe(p+12,7);if(jpegSize<20||jpegSize-4!=n-61)break;const auto packetSize=static_cast<std::size_t>(jpegSize-4);const auto* t=p+23+packetSize;
        if(t[0]!=0xec||t[1]!=0xa4||std::memcmp(t+2,"IQ4T",4)||read32(t+6)!=1||read32(t+30)!=packetSize||(read32(t+26)&~1u))break;
        if(~crcUpdate(crcUpdate(0xffffffffu,p+23,packetSize),t+2,32)!=read32(t+34))break;const auto pts=read64(t+10);if(pts>std::uint64_t(std::numeric_limits<std::int64_t>::max()))break;if(!count)firstPts=pts;if(pts<firstPts||readBe(p+2,8)!=pts-firstPts)break;
        runtime::Frame frame;frame.bytes.assign(p+23,p+23+packetSize);frame.pts_ns=static_cast<std::int64_t>(pts);if(read32(t+26)&1u)frame.source_sequence=read64(t+18);output.encode(frame);++count;offset+=12+n;
    }
    if(!count){output.abort();throw std::runtime_error("no complete Matroska JPEG/timestamp pairs recoverable");}output.finalize();final=output.finalLeaf();return count;
}
} // namespace iq4::recording
