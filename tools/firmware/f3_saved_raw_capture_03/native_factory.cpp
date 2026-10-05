#include "capture03.h"
#include "capture_pins.inc"
#include <cstring>
#include <fcntl.h>
#include <sys/syscall.h>
#include <errno.h>
extern "C" long iq4_f3_original_syscall_03(long,...);
extern "C" int*iq4_f3_original_errno_location_03();
static F3Card05 cards[2];static F3CardRead05 memory;
static F3LeaseCalls05 calls;static F3CardIo05 io;static bool attempted;
static F3SysResult(*regular_open)(int,const char*,int);
static F3SysResult capture_open(int d,const char*p,int wr){
 if(wr&&f3_capture_active_card_03()==11){
  // Preserve the original final XQD O_DIRECT writer and initial position zero.
  // Exclusive creation adds EXCL/NOFOLLOW, deliberately removes TRUNC/adoption.
  long r=iq4_f3_original_syscall_03(SYS_openat,d,p,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC|O_DIRECT,0600);
  return {r,r<0?*iq4_f3_original_errno_location_03():0};
 }
 return regular_open(d,p,wr);
}
static F3Card05*acquire(void*,uint32_t id){
 if(id<10||id>11)return nullptr;F3Card05&card=cards[id-10];
 if(card.state==3&&!card.hold)card={};if(card.state||card.hold)return &card;
 auto r=f3_card_begin_05(&card,&memory,&calls,&io,id,id);
 return r==F3_CARD_OK||r==F3_CARD_UNKNOWN?&card:nullptr;
}
static bool prefixes(const F3CardRead05*m){
 if(!m||!m->read)return false;unsigned char a[64],b[64];for(const auto&p:CapturePins03){
  if(p.bytes>sizeof(a)||m->read(m->context,p.va,a,p.bytes)!=1||m->read(m->context,p.va,b,p.bytes)!=1||std::memcmp(a,b,p.bytes)||std::memcmp(a,p.data,p.bytes))return false;
 }return true;
}
extern "C" int f3_capture_install_native_01(const F3CardRead05*m,int(*saved)(void*,F3CapturedRaw01*),void*ctx){
 if(attempted||!saved||!prefixes(m))return 0;attempted=true;memory=*m;
 f3_card_native_calls_05(&calls);f3_card_linux_io_05(&io);
 F3CaptureOps03 o{};f3_fs_linux_api_03(&o.common.files);regular_open=o.common.files.open_leaf;o.common.files.open_leaf=capture_open;
 f3_capture_linux_directories_01(&o.common.dirs);o.common.memory=memory;o.common.saved=saved;o.common.context=ctx;o.acquire_card=acquire;
 return f3_capture_configure_03(&o);
}
#if defined(__aarch64__)&&defined(__linux__)
static_assert(O_DIRECT==0x10000&&SYS_clock_gettime==113&&SYS_nanosleep==101&&SYS_openat==56,"original target Linux ABI");
#endif
