#ifndef IQ4_F4_STATUS_WIRE_03_H
#define IQ4_F4_STATUS_WIRE_03_H
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#define F4_STATUS_BYTES 64U
#define F4_STATUS_MAX_MESSAGES 8U
enum { F4_KIND_LOADED=1, F4_KIND_PHASE=2, F4_KIND_REJECTED=3 };
enum { F4_PHASE_DISABLED=0,F4_PHASE_WAITING=1,F4_PHASE_QUEUED=3,
       F4_PHASE_ATTACHED=4,F4_PHASE_DETACHING=5,F4_PHASE_DETACHED_RETAINED=6,F4_PHASE_HOLD=7 };
enum { F4_REASON_NONE=0,F4_REASON_DISABLED=1,F4_REASON_ORIGINAL_PTHREAD=2,
       F4_REASON_USER_IMAGE=3,F4_REASON_CONFIGURE=4 };
typedef struct {
 uint8_t kind,phase,flags;uint32_t sequence,reason;
 uint64_t epoch,qualified,callbacks,notifications;uint32_t dropped;
} F4Status03;
typedef struct {F4Status03 last;uint32_t accepted;uint8_t failed,detached;} F4StatusReceiver03;
static inline uint32_t f4_u32(const unsigned char *b){return (uint32_t)b[0]|((uint32_t)b[1]<<8)|((uint32_t)b[2]<<16)|((uint32_t)b[3]<<24);}
static inline uint64_t f4_u64(const unsigned char *b){return f4_u32(b)|((uint64_t)f4_u32(b+4)<<32);}
static inline void f4_p32(unsigned char *b,uint32_t x){for(unsigned i=0;i<4;i++)b[i]=(unsigned char)(x>>(8*i));}
static inline void f4_p64(unsigned char *b,uint64_t x){for(unsigned i=0;i<8;i++)b[i]=(unsigned char)(x>>(8*i));}
static inline void f4_status_encode(unsigned char b[F4_STATUS_BYTES],const F4Status03 *s){
 memset(b,0,F4_STATUS_BYTES);memcpy(b,"F4S3",4);b[4]=1;b[5]=s->kind;b[6]=s->phase;b[7]=s->flags;
 f4_p32(b+8,s->sequence);f4_p32(b+12,s->reason);f4_p64(b+16,s->epoch);
 f4_p64(b+24,s->qualified);f4_p64(b+32,s->callbacks);f4_p64(b+40,s->notifications);f4_p32(b+48,s->dropped);
}
static inline int f4_status_decode(const unsigned char *b,size_t n,F4Status03 *s){
 if(n!=F4_STATUS_BYTES||memcmp(b,"F4S3",4)||b[4]!=1||b[7]>3)return 0;
 for(unsigned i=52;i<F4_STATUS_BYTES;i++)if(b[i])return 0;
 s->kind=b[5];s->phase=b[6];s->flags=b[7];s->sequence=f4_u32(b+8);s->reason=f4_u32(b+12);
 s->epoch=f4_u64(b+16);s->qualified=f4_u64(b+24);s->callbacks=f4_u64(b+32);s->notifications=f4_u64(b+40);s->dropped=f4_u32(b+48);
 return s->sequence>0&&s->sequence<=F4_STATUS_MAX_MESSAGES&&s->epoch<=4096&&s->qualified==s->epoch&&s->callbacks<=4096;
}
static inline int f4_status_accept(F4StatusReceiver03 *r,const unsigned char *b,size_t n){
 F4Status03 s;if(r->failed||r->detached||!f4_status_decode(b,n,&s)||s.dropped||s.sequence!=r->accepted+1){r->failed=1;return 0;}
 if(!r->accepted){
  if(s.kind!=F4_KIND_LOADED||s.phase!=F4_PHASE_DISABLED||s.flags||s.reason||s.epoch||s.callbacks||s.notifications){r->failed=1;return 0;}
 }else if(s.kind==F4_KIND_REJECTED){
  if(r->last.phase!=F4_PHASE_DISABLED||s.phase!=F4_PHASE_HOLD||s.flags||s.reason<1||s.reason>4||s.epoch||s.callbacks||s.notifications){r->failed=1;return 0;}
  r->failed=1;r->last=s;r->accepted++;return 1;
 }else{
  const uint8_t prior=r->last.phase;
  int okay=s.kind==F4_KIND_PHASE&&!s.reason&&s.epoch>=r->last.epoch&&s.callbacks>=r->last.callbacks&&s.notifications>=r->last.notifications;
  if(s.phase==F4_PHASE_WAITING)okay=okay&&prior==F4_PHASE_DISABLED&&!s.flags&&!s.epoch&&!s.callbacks&&!s.notifications;
  else if(s.phase==F4_PHASE_QUEUED)okay=okay&&prior==F4_PHASE_WAITING&&s.flags==3&&s.epoch>0&&!s.callbacks;
  else if(s.phase==F4_PHASE_ATTACHED)okay=okay&&prior==F4_PHASE_QUEUED&&s.flags==3&&s.callbacks==1;
  else if(s.phase==F4_PHASE_DETACHING)okay=okay&&prior==F4_PHASE_ATTACHED&&s.flags==3&&s.callbacks==2;
  else if(s.phase==F4_PHASE_DETACHED_RETAINED)okay=okay&&prior==F4_PHASE_DETACHING&&s.flags==3&&s.callbacks==2&&s.epoch>r->last.epoch;
  else if(s.phase==F4_PHASE_HOLD)okay=okay&&(prior==F4_PHASE_WAITING||prior==F4_PHASE_QUEUED||prior==F4_PHASE_ATTACHED||prior==F4_PHASE_DETACHING);
  else okay=0;
  if(!okay){r->failed=1;return 0;}
 }
 r->last=s;r->accepted++;
 if(s.phase==F4_PHASE_HOLD)r->failed=1;
 if(s.phase==F4_PHASE_DETACHED_RETAINED)r->detached=1;
 return 1;
}
#endif
