#pragma once
#include "native_binding.hpp"
namespace iq4::native_render_02 {
class PersistentPool final {
public:
 PersistentPool()=default;
 PersistentPool(const PersistentPool&)=delete;PersistentPool& operator=(const PersistentPool&)=delete;
 // This instance's storage must itself remain until process termination. No
 // native shutdown/dtor has been proved; no destructor frees original workers.
 Result initialize(NativePoolApi,Iq4DecodeRead02,void*);
 Result acquire(PoolLease&,std::uint64_t& token);
 Result release_after_join(std::uint64_t token);
 bool quarantined() const noexcept {return quarantined_;}
private:
 static bool held(void*,const void*);
 bool snapshot(bool require_started) const;
 NativePoolApi api_{};Iq4DecodeRead02 read_=nullptr;void* context_=nullptr;
 bool attempted_=false,constructed_=false,started_=false,quarantined_=false,leased_=false;
 std::uint64_t sequence_=0,token_=0,thread_=0;
 unsigned lock_word_=0;
 alignas(16) unsigned char storage_[0x18]{};
};
// The production instance is permanently retained. No native per-process
// destructor is registered; its trivial C++ storage destructor frees nothing.
PersistentPool& persistent_pool_02() noexcept;
}
