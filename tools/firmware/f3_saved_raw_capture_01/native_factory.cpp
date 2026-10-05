#include "native_factory.h"
#include "capture_pins.inc"
#include <cstring>
static F3Card05 card;
static F3CardRead05 memory;
static F3LeaseCalls05 calls;
static F3CardIo05 io;
static bool attempted;
static F3Card05* acquire(void*){
 // Reuse only a fully normal-ended prior owner. Permanent native client name
 // registration remains in frozen card.c; its lookup avoids re-registration.
 if(card.state==3&&!card.hold)card={};
 if(card.state||card.hold)return &card;
 auto r=f3_card_begin_05(&card,&memory,&calls,&io,10,10);
 return r==F3_CARD_OK||r==F3_CARD_UNKNOWN?&card:nullptr;
}
static bool prefixes(const F3CardRead05*m){
 if(!m||!m->read)return false;
 unsigned char a[64],b[64];for(const auto&p:CapturePins01){
  if(p.bytes>sizeof(a)||m->read(m->context,p.va,a,p.bytes)!=1||
   m->read(m->context,p.va,b,p.bytes)!=1||std::memcmp(a,b,p.bytes)||std::memcmp(a,p.data,p.bytes))return false;
 }return true;
}
extern "C" int f3_capture_install_native_01(const F3CardRead05*m,int(*saved)(void*,F3CapturedRaw01*),void*ctx){
 if(attempted||!saved||!prefixes(m))return 0;attempted=true;
 memory=*m;f3_card_native_calls_05(&calls);f3_card_linux_io_05(&io);
 F3CaptureOps01 ops{};f3_fs_linux_api_03(&ops.files);f3_capture_linux_directories_01(&ops.dirs);
 ops.memory=memory;ops.acquire_sd=acquire;ops.saved=saved;ops.context=ctx;
 return f3_capture_configure_01(&ops);
}
