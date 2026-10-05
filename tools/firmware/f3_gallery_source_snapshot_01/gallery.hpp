#pragma once
#include "../f3_source_dependencies_01/dependencies.hpp"
namespace iq4::gallery_source_01 {
using source_dependencies_01::Memory;
enum class Result {Ok,Argument,Unbound,Owner,Changing,Index,NotFile,Path,Hold};
struct NativeMutexApi {
 void(*construct_guard)(void*,void*)=nullptr;
 void(*destroy_guard)(void*)=nullptr;
 void*(*current_native_thread)()=nullptr;
 bool exact_original_prefixes=false;
};
struct Snapshot {
 uintptr_t ifm=0,filesystem=0,table=0,record_address=0,directory_address=0;
 uint32_t index=0,filesystem_id=0;
 unsigned char record[40]{};
 char directory[256]{},leaf[14]{};
 source_dependencies_01::Snapshot dependencies{};
};
/* Nonmoving caller-owned guard, never a guessed vendor object. A caught
 * construction/destruction exception retains this exact 8-byte guard forever. */
struct Guard {alignas(8) unsigned char native[8]{};uintptr_t mutex=0,thread=0;
 uint32_t old_depth=0;bool live=false,hold=false;};
Result snapshot(Memory,const NativeMutexApi&,Guard&,uintptr_t actual_ifm,int32_t actual_index,Snapshot&) noexcept;
Result recheck(Memory,const NativeMutexApi&,Guard&,const Snapshot&) noexcept;
bool same(const Snapshot&,const Snapshot&) noexcept;
bool relative_directory(const char*,char out[256]) noexcept;
bool native_factory(Memory,NativeMutexApi&) noexcept;
}
