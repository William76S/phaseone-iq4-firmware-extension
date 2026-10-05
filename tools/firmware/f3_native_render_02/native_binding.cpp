#include "native_binding.hpp"
#include "api_pins.h"
#include <cstring>
namespace iq4::native_render_02 {
static bool prefixes(Iq4DecodeRead02 read,void* ctx,const Iq4ApiPin02* pins,std::size_t count) noexcept {
 if(!read)return false;unsigned char bytes[32];
 for(std::size_t i=0;i<count;++i)if(read(ctx,pins[i].va,bytes,sizeof bytes)!=1||std::memcmp(bytes,pins[i].bytes,sizeof bytes))return false;
 return true;
}
bool native_render_prefixes_02(Iq4DecodeRead02 read,void* ctx) noexcept {return prefixes(read,ctx,iq4_render_api_pins_02,sizeof iq4_render_api_pins_02/sizeof*iq4_render_api_pins_02);}
bool native_source_prefixes_02(Iq4DecodeRead02 read,void* ctx) noexcept {return prefixes(read,ctx,iq4_source_api_pins_02,sizeof iq4_source_api_pins_02/sizeof*iq4_source_api_pins_02);}
Result bind_native_render_02(Iq4DecodeRead02 read,void* ctx,bool unwind,NativeApi& api,NativePoolApi& pool) noexcept {
 api={};pool={};if(!unwind||!native_render_prefixes_02(read,ctx))return Result::Unbound;
#if defined(__aarch64__) && defined(__linux__)
 api={true,true,
  reinterpret_cast<decltype(api.settings_construct)>(0x7bbc54),reinterpret_cast<decltype(api.settings_destroy)>(0x7bbf44),
  reinterpret_cast<decltype(api.generator_construct)>(0x962058),reinterpret_cast<decltype(api.generator_destroy)>(0x9622a8),
  reinterpret_cast<decltype(api.image_construct)>(0x904550),reinterpret_cast<decltype(api.image_destroy)>(0x903ca8),
  reinterpret_cast<decltype(api.configure_source)>(0x960478),reinterpret_cast<decltype(api.configure_profile)>(0x961208),
  reinterpret_cast<decltype(api.process)>(0x963a28),reinterpret_cast<decltype(api.pool_join)>(0x716e60),
  reinterpret_cast<decltype(api.image_plane)>(0x9043c8),reinterpret_cast<decltype(api.image_width)>(0x904448),
  reinterpret_cast<decltype(api.image_height)>(0x904450),reinterpret_cast<decltype(api.image_stride)>(0x904468),
  reinterpret_cast<decltype(api.image_format)>(0x9043a0)};
 pool={reinterpret_cast<decltype(pool.construct)>(0x716a84),reinterpret_cast<decltype(pool.start)>(0x716c58),
  reinterpret_cast<decltype(pool.join)>(0x716e60),true,true};return Result::Ok;
#else
 return Result::Unbound; // Never expose camera addresses as host callable APIs.
#endif
}
Result bind_native_source_02(Iq4DecodeRead02 read,void* ctx,bool unwind,
 raw_file_source_01::NativeApi& reader,raw_file_source_01::ObjectApi& objects) noexcept {
 reader={};objects={};if(!unwind||!native_source_prefixes_02(read,ctx))return Result::Unbound;
#if defined(__aarch64__) && defined(__linux__)
 reader={reinterpret_cast<decltype(reader.construct)>(0x7d92b8),reinterpret_cast<decltype(reader.destroy)>(0x7d9390),
  reinterpret_cast<decltype(reader.open)>(0x7d9988),reinterpret_cast<decltype(reader.close)>(0x7d9ae0),
  reinterpret_cast<decltype(reader.is_open)>(0x7d95c0),reinterpret_cast<decltype(reader.read_payload)>(0x7d9630),
  reinterpret_cast<decltype(reader.capture_codec)>(0x7d9710),true,true,0xd90410,0xd91450};
 objects={reinterpret_cast<decltype(objects.map_construct)>(0x7bba0c),reinterpret_cast<decltype(objects.map_destroy)>(0x7bba2c),
  reinterpret_cast<decltype(objects.map_index)>(0x7bcc64),reinterpret_cast<decltype(objects.tag_u32)>(0x7bb8e0),
  reinterpret_cast<decltype(objects.tag_float)>(0x7bb910),reinterpret_cast<decltype(objects.tag_blob)>(0x7bb940),
  reinterpret_cast<decltype(objects.input_construct)>(0x7bbac0),reinterpret_cast<decltype(objects.input_destroy)>(0x7bbafc),
  reinterpret_cast<decltype(objects.vector_push)>(0x7bc7e4),true,true};return Result::Ok;
#else
 return Result::Unbound;
#endif
}
}
