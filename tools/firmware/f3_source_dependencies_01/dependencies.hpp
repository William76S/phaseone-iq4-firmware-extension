#pragma once
#include "../f3_raw_file_source_01/reader_stage.hpp"
#include <cstddef>
#include <cstdint>

namespace iq4::source_dependencies_01 {
// Borrowed process-lifetime dependencies only. This does not open, modify,
// borrow the File, decode arena, rows, or parser buffers of the original Reader.
struct Memory {
 void* context;
 int (*read)(void*,std::uintptr_t,void*,std::size_t);
};
enum class Result { Ok, InvalidMemory, WrongImage, InvalidOwner, Changing,
                   InvalidDependencies };
struct Snapshot {
 std::uintptr_t ifm=0, original_reader=0;
 void* module_a=nullptr;
 void* module_b=nullptr;
 void* metadata_a=nullptr;
 void* metadata_b=nullptr;
 void* metadata_c=nullptr;
};
// Actual IFM passed by the original Gallery/native caller; no global-current
// selection or guessed singleton. IFM primary VT and original Reader identity
// are checked against the fixed User. Prefix checks do not replace deployment
// whole-User identity or the caller's actual serialized process/source lifetime.
Result snapshot_from_ifm(Memory,std::uintptr_t actual_ifm,Snapshot&) noexcept;
// Called at the exact RawManager+48=node acquisition boundary, before fanout.
// Verifies the still-current node and RawManager+38 -> NodeManager+320 -> IFM.
Result snapshot_from_raw_manager(Memory,std::uintptr_t actual_manager,
                                std::uintptr_t actual_node,Snapshot&) noexcept;
// Converts the observed pointers to the frozen Source01 constructor inputs.
// Filesystem is the actual held card FS; never the original Reader's mutable FS.
Result constructor_inputs(Memory,const Snapshot&,std::uintptr_t held_filesystem,
                         raw_file_source_01::ConstructorInputs&) noexcept;
Result recheck(Memory,const Snapshot&) noexcept;
bool original_prefixes(Memory) noexcept;
} // namespace iq4::source_dependencies_01
