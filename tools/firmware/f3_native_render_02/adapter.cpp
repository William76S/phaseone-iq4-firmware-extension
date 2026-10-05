#include "adapter.hpp"
#include <cstring>
#include <climits>

namespace iq4::native_render_02 {
static bool frame(std::uint32_t w, std::uint32_t h, unsigned bpp, std::uint64_t& out) {
    const std::uint64_t stride = (std::uint64_t(w)*bpp + 31u) & ~std::uint64_t(31u);
    out = stride*h; return out != 0 && out <= INT32_MAX;
}
Result bounded_attempt(const Candidate& c, std::uint64_t mapped, Attempt& out) noexcept {
    out = {};
    if (!c.total_width || !c.total_height || c.total_width > 65500 || c.total_height > 65500 ||
        !c.valid_width || !c.valid_height || c.left > c.total_width || c.top > c.total_height ||
        c.valid_width > c.total_width-c.left || c.valid_height > c.total_height-c.top)
        return Result::Geometry;
    if (!frame(c.total_width,c.total_height,2,out.decoded_reservation) ||
        !frame(c.valid_width,c.valid_height,4,out.rgb32_min) ||
        !frame(c.valid_width,c.valid_height,1,out.planar_min)) return Result::Geometry;
    std::uint64_t rgb16;
    if (!frame(c.valid_width,c.valid_height,6,rgb16)) return Result::Geometry;
    out.rgb16_pair_min = rgb16*2;
    out.core_min = out.rgb32_min+out.planar_min+out.rgb16_pair_min;
    out.lower_bound = PrefixBytes+out.decoded_reservation+out.core_min;
    out.mapped_bytes = mapped;
    // This permits a bounded attempt, including a truthful native capacity
    // rejection. It does not attest that the complete core fits.
    return mapped >= PrefixBytes+out.decoded_reservation ? Result::Ok : Result::Capacity;
}
static bool bound(const NativeApi& a, const Completion& c) {
    return a.original_image_and_abi_verified && a.cpp_unwind_verified &&
        a.settings_construct && a.settings_destroy && a.generator_construct &&
        a.generator_destroy && a.image_construct && a.image_destroy &&
        a.configure_source && a.configure_profile && a.process && a.pool_join &&
        a.image_plane && a.image_width && a.image_height && a.image_stride && a.image_format &&
        c.exact_hooks_and_owner_contract_verified && c.begin && c.end && c.abort_after_join;
}
static bool separate(const void* a,std::uint64_t an,const void* b,std::uint64_t bn) {
    const auto x=reinterpret_cast<std::uintptr_t>(a), y=reinterpret_cast<std::uintptr_t>(b);
    return a&&b&&an&&bn&&an<=UINTPTR_MAX-x&&bn<=UINTPTR_MAX-y&&
        (x+an<=y||y+bn<=x);
}
bool Session::source_held() const {
    return source_.bundle && source_.bundle->ready_encoded_full_section() &&
        !source_.bundle->quarantined() && source_.still_held &&
        source_.still_held(source_.context,source_.bundle->raw_input(),
                          source_.bundle->owned_tags(),source_.identity);
}
bool Session::pool_held() const {
    return pool_.pool && pool_.held_started_exclusive &&
        pool_.held_started_exclusive(pool_.context,pool_.pool);
}
Result Session::cleanup() {
    if (state_.quarantined) return Result::Hold;
    if (state_.sink_active) return Result::Busy;
    try {
        if (state_.join_needed) {
            if (!pool_held()) { state_.quarantined=true; return Result::Hold; }
            api_.pool_join(pool_.pool); state_.join_needed=false;
        }
        if (state_.receipt_active) {
            const auto rc=completion_.abort_after_join(completion_.context,owner_);
            if (rc!=Result::Ok) { state_.quarantined=true; return Result::Hold; }
            state_.receipt_active=false;
        }
        if (state_.planar_alive) { api_.image_destroy(planar_); state_.planar_alive=false; }
        if (state_.rgb32_alive) { api_.image_destroy(rgb32_); state_.rgb32_alive=false; }
        if (state_.generator_alive) { api_.generator_destroy(generator_); state_.generator_alive=false; }
        if (state_.settings_alive) { api_.settings_destroy(settings_); state_.settings_alive=false; }
        state_.source_held=false;
        return Result::Ok;
    } catch (...) { state_.quarantined=true; return Result::Hold; }
}
Result Session::finish(Result r) { return cleanup()==Result::Ok ? r : Result::Hold; }
Result Session::run(SourceLease source, PoolLease pool, std::uint32_t sensor,
                    std::uint8_t* mapped, std::uint64_t bytes, const std::uint8_t* cancel,
                    f3_sync_rgb32_sink sink, void* sink_context) {
    if (state_.quarantined) return Result::Hold;
    if (state_.settings_alive || state_.generator_alive || state_.rgb32_alive ||
        state_.planar_alive || state_.join_needed || state_.source_held || state_.sink_active)
        return Result::Busy;
    if (!bound(api_,completion_)) return Result::Unbound;
    if (!mapped || !cancel || !sink || !source.identity || !sensor ||
        (reinterpret_cast<std::uintptr_t>(mapped)&31u) ||
        bytes > SIZE_MAX || bytes > UINTPTR_MAX-reinterpret_cast<std::uintptr_t>(mapped))
        return Result::Argument;
    source_=source; pool_=pool;
    if (!source_held()) return Result::SourceLost;
    if (!pool_held()) return Result::Argument;
    auto rc=bounded_attempt(source.geometry,bytes,attempt_);
    if (rc!=Result::Ok) return rc;
    if (*cancel) return Result::Incomplete;
    // Native file worker uses built-in slot0 only for an absent/all-zero-leading
    // profile. Reject a nonzero embedded profile until its original parser binds.
    if (!source.bundle->profile().builtin_slot_zero) return Result::UnsupportedProfile;
    const auto* raw=static_cast<const raw_file_source_01::NativeRawInputLayout*>(source.bundle->raw_input());
    if (!raw || raw->format!=8 || raw->payload!=source.geometry.payload ||
        raw->payload_bytes!=source.geometry.payload_bytes || !raw->rows_begin ||
        reinterpret_cast<std::uintptr_t>(raw->rows_end)<reinterpret_cast<std::uintptr_t>(raw->rows_begin) ||
        (reinterpret_cast<std::uintptr_t>(raw->rows_end)-reinterpret_cast<std::uintptr_t>(raw->rows_begin))!=
            std::uint64_t(source.geometry.total_height)*4) return Result::Geometry;
    // Generator ctor writes its 80MiB prefix before decode receipt admission.
    // Reject known source/control aliases before any native constructor runs.
    if (!separate(mapped,bytes,raw->payload,raw->payload_bytes) ||
        !separate(mapped,bytes,raw->rows_begin,std::uint64_t(source.geometry.total_height)*4) ||
        !separate(mapped,bytes,cancel,1) || !separate(mapped,bytes,this,sizeof(*this)) ||
        !separate(mapped,bytes,source.bundle,sizeof(*source.bundle))) return Result::Argument;
    state_.source_held=true;
    owner_={generator_,raw,rgb32_,planar_,settings_,pool.pool,cancel,mapped,bytes,source.identity,source.geometry};
    try {
        std::memset(settings_,0,sizeof settings_);
        api_.settings_construct(settings_); state_.settings_alive=true;
        const float scale=1.0f, w=float(source.geometry.valid_width), h=float(source.geometry.valid_height), zero=0;
        const std::uint32_t format=5, nought=0;
        std::memcpy(settings_,&scale,4); std::memcpy(settings_+4,&w,4);
        std::memcpy(settings_+8,&h,4); std::memcpy(settings_+12,&zero,4);
        std::memcpy(settings_+0x20,&format,4); std::memcpy(settings_+0x30,&nought,4);
        // Original JPEG output-color enum5 is retained; crop uses zero origins.
        // Neither enum5 nor RGB32 pixel-format5 is an sRGB proof.
        std::memcpy(settings_+0x2b8,&nought,4); std::memcpy(settings_+0x2bc,&nought,4);
        std::memcpy(settings_+0x2c0,&source.geometry.valid_width,4);
        std::memcpy(settings_+0x2c4,&source.geometry.valid_height,4);
        settings_[0x291]=1;
        std::memset(generator_,0,sizeof generator_);
        api_.generator_construct(generator_,mapped,bytes); state_.generator_alive=true;
        std::uint64_t cap=0; std::uintptr_t base=0;
        std::memcpy(&cap,generator_+0x198,8); std::memcpy(&base,generator_+0x1a0,8);
        if (cap!=bytes-PrefixBytes || base!=reinterpret_cast<std::uintptr_t>(mapped)+PrefixBytes)
            return finish(Result::Capacity);
        std::memset(rgb32_,0,sizeof rgb32_); api_.image_construct(rgb32_); state_.rgb32_alive=true;
        std::memset(planar_,0,sizeof planar_); api_.image_construct(planar_); state_.planar_alive=true;
        api_.configure_source(generator_,sensor,source.bundle->owned_tags());
        api_.configure_profile(generator_,settings_,0);
        // Profile setup can change native settings; require our finite path after it.
        std::uint32_t s=0, r=0, aux=0, f=0;
        std::memcpy(&s,settings_,4); std::memcpy(&r,settings_+12,4);
        std::memcpy(&aux,settings_+0x30,4); std::memcpy(&f,settings_+0x20,4);
        if (s!=0x3f800000 || r || aux || f!=5 || settings_[0x291]!=1 || !source_held() || !pool_held())
            return finish(Result::SourceLost);
        rc=completion_.begin(completion_.context,owner_);
        if (rc!=Result::Ok) return finish(rc);
        state_.receipt_active=true; state_.join_needed=true;
        const std::uint32_t actual=api_.process(generator_,raw,rgb32_,planar_,settings_,pool.pool,cancel);
        Receipt receipt{};
        rc=completion_.end(completion_.context,owner_,actual,receipt);
        if (receipt.decode_workers_joined && receipt.core_workers_joined) state_.join_needed=false;
        // A successful end retires its actual receipt; a failed end remains owned
        // until abort_after_join confirms all worker callbacks have finished.
        if (rc==Result::Ok) state_.receipt_active=false;
        if (rc!=Result::Ok || actual!=1 || !receipt.reader_returned || !receipt.decoded_rows_complete ||
            !receipt.decode_workers_joined || !receipt.full_r0_core_complete || !receipt.core_workers_joined || *cancel)
            return finish(rc==Result::Ok ? Result::Incomplete : rc);
        if (!source_held() || !pool_held()) return finish(Result::SourceLost);
        const auto* pixels=api_.image_plane(rgb32_);
        const auto iw=api_.image_width(rgb32_), ih=api_.image_height(rgb32_);
        const auto stride=api_.image_stride(rgb32_), fmt=api_.image_format(rgb32_);
        const auto p=reinterpret_cast<std::uintptr_t>(pixels), b=reinterpret_cast<std::uintptr_t>(mapped);
        const std::uint64_t row=std::uint64_t(iw)*4;
        if (!pixels || iw!=source.geometry.valid_width || ih!=source.geometry.valid_height ||
            fmt!=5 || stride<row || p<b || p-b>=bytes ||
            (std::uint64_t(ih)-1)*stride+row > bytes-(p-b)) return finish(Result::Plane);
        const f3_plane plane={mapped,bytes,p-b,stride,iw,ih,4,source.identity};
        state_.sink_active=true;
        const auto sink_result=sink(sink_context,&plane);
        state_.sink_active=false;
        return finish(sink_result==F3_OK ? Result::Ok : Result::Sink);
    } catch (...) {
        // A constructor may have started a native thread or left partial native
        // state before throwing. Do not destroy/retry an incompletely constructed
        // object or release its source/arena. Quarantine retains all owners.
        state_.sink_active=false; state_.quarantined=true; return Result::Hold;
    }
}
} // namespace iq4::native_render_02
