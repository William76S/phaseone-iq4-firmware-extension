#pragma once
#include <cstddef>
#include <cstdint>
namespace iq4::ordinary_capture_01 {
struct Memory {void*context;int(*read)(void*,uintptr_t,void*,size_t);};
struct Identity {
 uintptr_t pool=0,node=0,metadata_resource=0,metadata=0,raw_resource=0;
 uint32_t capture_number=0,black_control=0;
};
// This is project RAM bookkeeping, never a replacement vendor queue or lease.
class Guard {
public:
 static constexpr unsigned Capacity=64;
 uint64_t begin(Memory,uintptr_t capture_manager,uintptr_t pool,uintptr_t node) noexcept;
 void before_queue_unlock(Memory,uintptr_t guard,uintptr_t queue,uintptr_t link,uint32_t native_result) noexcept;
 void complete(uint64_t token,bool original_returned_normally) noexcept;
 bool consume(Memory,uintptr_t actual_raw_manager,uintptr_t actual_node) noexcept;
 void invalidate(uintptr_t node) noexcept;
private:
 struct Slot {Identity id;uint64_t token=0,epoch=0;uint32_t state=0;};
 Slot slots_[Capacity]{};uint32_t lock_=0;uint64_t epoch_=1,serial_=0;
 bool enter() noexcept;
 void leave() noexcept;
 void purge() noexcept;
};
bool original_prefixes(Memory) noexcept;
} // namespace iq4::ordinary_capture_01
