#include "status_wire.h"
#include <assert.h>
#include <stdio.h>
static F4Status03 message(unsigned seq,unsigned phase){
 F4Status03 s={0};s.sequence=seq;s.kind=seq==1?F4_KIND_LOADED:F4_KIND_PHASE;s.phase=(uint8_t)phase;
 if(phase>=3){s.flags=3;s.epoch=1;s.qualified=1;}
 if(phase==4)s.callbacks=1;
 if(phase==5||phase==6)s.callbacks=2;
 if(phase==6){s.epoch=2;s.qualified=2;}
 return s;
}
static int accept(F4StatusReceiver03 *r,F4Status03 s){unsigned char b[64];f4_status_encode(b,&s);return f4_status_accept(r,b,sizeof(b));}
static F4StatusReceiver03 ready(void){F4StatusReceiver03 r={0};assert(accept(&r,message(1,0)));assert(accept(&r,message(2,1)));return r;}
int main(void){unsigned groups=0;
 {F4StatusReceiver03 r=ready();assert(accept(&r,message(3,3)));assert(accept(&r,message(4,4)));assert(accept(&r,message(5,5)));assert(accept(&r,message(6,6)));assert(r.detached&&!r.failed);++groups;}
 {F4StatusReceiver03 r={0};F4Status03 s=message(1,0);unsigned char b[64];f4_status_encode(b,&s);F4Status03 t;assert(f4_status_decode(b,64,&t)&&t.sequence==1);for(size_t n=0;n<64;n++)assert(!f4_status_decode(b,n,&t));assert(!f4_status_decode(b,65,&t));assert(!r.detached);++groups;}
 {for(unsigned i=52;i<64;i++){F4StatusReceiver03 r={0};unsigned char b[64];F4Status03 s=message(1,0);f4_status_encode(b,&s);b[i]=1;assert(!f4_status_accept(&r,b,64)&&r.failed);}++groups;}
 {for(unsigned i=0;i<5;i++){F4StatusReceiver03 r={0};unsigned char b[64];F4Status03 s=message(1,0);f4_status_encode(b,&s);b[i]^=1;assert(!f4_status_accept(&r,b,64));}++groups;}
 {F4StatusReceiver03 r=ready();F4Status03 s=message(3,3);s.dropped=1;assert(!accept(&r,s)&&r.failed);++groups;}
 {F4StatusReceiver03 r=ready();assert(!accept(&r,message(4,3)));r=ready();assert(!accept(&r,message(2,1)));++groups;}
 {F4StatusReceiver03 r=ready();assert(!accept(&r,message(3,6)));r=ready();assert(!accept(&r,message(3,4)));++groups;}
 {F4StatusReceiver03 r=ready();F4Status03 s=message(3,3);s.flags=0;assert(!accept(&r,s));r=ready();s=message(3,3);s.qualified=2;assert(!accept(&r,s));++groups;}
 {F4StatusReceiver03 r={0};assert(accept(&r,message(1,0)));F4Status03 s=message(2,7);s.kind=F4_KIND_REJECTED;s.reason=F4_REASON_DISABLED;s.flags=0;s.epoch=s.qualified=0;assert(accept(&r,s)&&r.failed&&!r.detached);++groups;}
 {F4StatusReceiver03 r=ready();F4Status03 s=message(3,7);assert(accept(&r,s)&&r.failed&&!r.detached);++groups;}
 {F4StatusReceiver03 r=ready();assert(accept(&r,message(3,3)));assert(accept(&r,message(4,4)));assert(accept(&r,message(5,5)));F4Status03 s=message(6,6);s.epoch=s.qualified=1;assert(!accept(&r,s));++groups;}
 {F4StatusReceiver03 r=ready();F4Status03 s=message(3,3);s.notifications=3;assert(accept(&r,s));s=message(4,4);s.notifications=2;assert(!accept(&r,s));++groups;}
 {F4StatusReceiver03 r=ready();assert(accept(&r,message(3,3)));assert(accept(&r,message(4,4)));assert(accept(&r,message(5,5)));assert(accept(&r,message(6,6)));assert(!accept(&r,message(7,6)));++groups;}
 {F4StatusReceiver03 r={0};F4Status03 s=message(9,0);assert(!accept(&r,s));s=message(1,0);s.kind=9;r=(F4StatusReceiver03){0};assert(!accept(&r,s));++groups;}
 printf("%u SDK-free supervision wire groups passed; no native or device code executed\n",groups);return 0;
}
