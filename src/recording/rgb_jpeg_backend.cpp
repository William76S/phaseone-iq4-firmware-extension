#include "rgb_jpeg_backend.hpp"
#include <limits>
#include <stdexcept>
#include <string>

namespace iq4::recording {
RgbJpegBackend::RgbJpegBackend(RgbJpegOptions o,Iq4JpegApi a,std::unique_ptr<runtime::Backend> backend)
    :options_(o),api_(a),downstream_(std::move(backend)) {
    if(!downstream_)throw std::invalid_argument("RGB JPEG downstream backend required");
}
RgbJpegBackend::~RgbJpegBackend(){abort();}
void RgbJpegBackend::prepare(){
    if(state_!=State::Idle)throw std::logic_error("RGB JPEG session already active");
    state_=State::Preparing;
    try {
        if(api_.binding_abi_verified!=1||(api_.api_version!=80&&api_.api_version!=82)
            ||api_.compressor_struct_bytes!=sizeof(jpeg_compress_struct)
            ||!api_.std_error||!api_.create_compress||!api_.set_defaults||!api_.set_quality
            ||!api_.start_compress||!api_.write_scanlines||!api_.finish_compress||!api_.destroy_compress)
            throw std::invalid_argument("unverified or incomplete JPEG API binding");
        if(!options_.width||!options_.height||options_.width>65500||options_.height>65500
            ||options_.quality<1||options_.quality>100||!options_.maxOutputBytes
            ||options_.maxOutputBytes>128u*1024u*1024u)
            throw std::invalid_argument("invalid explicit RGB JPEG geometry/quality/output budget");
        const std::size_t row=std::size_t(options_.width)*3;
        if(options_.stride<row||(options_.height>1&&options_.stride>(std::numeric_limits<std::size_t>::max()-row)/(options_.height-1)))
            throw std::invalid_argument("invalid explicit RGB JPEG stride");
        requiredInputBytes_=std::size_t(options_.height-1)*options_.stride+row;
        if(options_.maxInputBytes<requiredInputBytes_)
            throw std::invalid_argument("RGB JPEG input byte budget cannot contain the described frame");
        packet_.bytes.resize(options_.maxOutputBytes); // sole JPEG allocation, before card prepare
        lastResult_={};
        downstreamArmed_=true; // also cleans up a partially failed downstream prepare
        downstream_->prepare();
        state_=State::Ready;
    } catch(...) {abort();throw;}
}
void RgbJpegBackend::encode(const runtime::Frame& source){
    if(state_!=State::Ready)throw std::logic_error("RGB JPEG backend is not ready");
    state_=State::Encoding;
    try {
        if(source.bytes.size()<requiredInputBytes_||source.bytes.size()>options_.maxInputBytes)
            throw std::invalid_argument("owned RGB frame violates explicit byte bounds");
        if(source.pts_ns<0)throw std::invalid_argument("source capture PTS must be nonnegative");
        // Shrink for downstream packet framing, restore only within the original
        // allocation on the next frame. There is no per-frame RGB copy or scale.
        packet_.bytes.resize(options_.maxOutputBytes);
        const Iq4JpegInput input{source.bytes.data(),source.bytes.size(),options_.width,options_.height,options_.stride,options_.quality};
        const auto status=iq4_jpeg_encode_bounded(&api_,&input,packet_.bytes.data(),options_.maxOutputBytes,&lastResult_);
        if(status!=IQ4_JPEG_OK)
            throw std::runtime_error("bounded JPEG failed (status "+std::to_string(int(status))+"): "+lastResult_.error);
        packet_.bytes.resize(lastResult_.jpeg_bytes);
        packet_.pts_ns=source.pts_ns;
        packet_.source_sequence=source.source_sequence;
        downstream_->encode(packet_); // synchronous consumer; may not retain a borrowed pointer
        state_=State::Ready;
    } catch(...) {abort();throw;}
}
void RgbJpegBackend::finalize(){
    if(state_!=State::Ready)throw std::logic_error("RGB JPEG backend is not ready to finalize");
    state_=State::Finalizing;
    try {
        downstream_->finalize();
        downstreamArmed_=false;
        std::vector<std::uint8_t>().swap(packet_.bytes);
        packet_.source_sequence.reset();
        state_=State::Idle;
    } catch(...) {abort();throw;}
}
void RgbJpegBackend::abort() noexcept {
    if(downstreamArmed_){downstreamArmed_=false;downstream_->abort();}
    std::vector<std::uint8_t>().swap(packet_.bytes);
    packet_.source_sequence.reset();
    state_=State::Idle;
}
}
