#pragma once
#include "adapter.hpp"
#include "decode_receipt.h"
namespace iq4::native_render_02 {
// Prefix admission describes an exact static ABI candidate; it is not an
// on-camera acceptance result. The deployment owner verifies the whole User
// version/hash and supplies the actually checked native C++ unwind contract.
bool native_render_prefixes_02(Iq4DecodeRead02,void*) noexcept;
bool native_source_prefixes_02(Iq4DecodeRead02,void*) noexcept;
struct NativePoolApi {
 void (*construct)(void*,const char*,std::uint32_t,std::uint32_t,std::uint32_t)=nullptr;
 void (*start)(void*)=nullptr;
 void (*join)(void*)=nullptr;
 bool exact_static_abi_and_runtime_bytes=false,cpp_unwind_verified=false;
};
Result bind_native_render_02(Iq4DecodeRead02,void*,bool actual_cpp_unwind_verified,NativeApi&,NativePoolApi&) noexcept;
Result bind_native_source_02(Iq4DecodeRead02,void*,bool actual_cpp_unwind_verified,
 raw_file_source_01::NativeApi&,raw_file_source_01::ObjectApi&) noexcept;
// Actual same-held-native-fd stat/pread/tell, never the transaction's other fd.
// Linux/A64 implementation calls the verified original syscall PLT alias.
Result bind_native_file_ops_02(Iq4DecodeRead02,void*,raw_file_source_01::FileOps&) noexcept;
}
