#define IQ4_DUAL_HOST 1
#include "runtime.cpp"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
static unsigned char memory[0x30000];
static constexpr uintptr_t BASE=0x10000000,D=BASE,L=BASE+0x1000,M=BASE+0x2000,Q=BASE+0x4000,C=BASE+0x5000,S=BASE+0x6000,CFG=BASE+0xa000;
static unsigned fail_pin,throw_get,throw_set,throw_listener,wrong_set,listener_count,set_count,update_count,other_actor,quantize_count;
static void put(uintptr_t a,uintptr_t v){assert(a>=BASE&&a+8<=BASE+sizeof memory);memcpy(memory+(a-BASE),&v,8);}
static void put32(uintptr_t a,uint32_t v){assert(a>=BASE&&a+4<=BASE+sizeof memory);memcpy(memory+(a-BASE),&v,4);}
extern "C" int iq4_native_self_read_01(void*,uintptr_t a,void*b,size_t n){
 if(a>=BASE&&a+n<=BASE+sizeof memory){memcpy(b,memory+(a-BASE),n);return 1;}
 for(auto&p:dual_pins_01)if(a>=p.va&&a+n<=p.va+p.bytes){memcpy(b,p.data+a-p.va,n);if(fail_pin)((unsigned char*)b)[0]^=1;return 1;}
 return 0;
}
extern "C" int iq4_f4_native_current_02(uintptr_t*q){*q=Q;return 1;}
extern "C" int iq4_activity_snapshot_01(Iq4ActivitySnapshot01*a){*a={1,other_actor,0};return IQ4_ACTIVITY_OK01;}
extern "C" void dual_test_listener(uintptr_t w,uintptr_t l,uint64_t mask,uint32_t tag){assert(w==L&&l==D+0x108&&mask==0x100&&tag==4);++listener_count;if(throw_listener)throw 1;put(w+0x60,l);put32(w+0x68,tag);}
extern "C" float dual_test_get(uintptr_t p){assert(p==S+0x1080);if(throw_get)throw 1;float f;memcpy(&f,memory+(p+0xc0-BASE),4);return f;}
extern "C" void dual_test_set(uintptr_t p,float f){assert(p==S+0x1080&&step(f));++set_count;if(throw_set)throw 1;if(!wrong_set)memcpy(memory+(p+0xc0-BASE),&f,4);}
extern "C" int32_t dual_test_quantize(float){++quantize_count;return 123;}
extern "C" void dual_test_update(uintptr_t d){assert(d==D);++update_count;}
static void setup(){memset(memory,0,sizeof memory);active_dialog=active_label=active_queue=held=busy=0;fail_pin=throw_get=throw_set=throw_listener=wrong_set=listener_count=set_count=update_count=other_actor=quantize_count=0;
 put(D,0xba2608);put(D+0x108,0xba2898);memory[D+0x128-BASE]=1;put(D+0xb0,M);put(M,0xb8f358);put(M+8,Q);put(M+0x790,C);put(Q,0xb91f48);put(Q+0x1c8,M);put(C+0x30,S);put(C+0x38,CFG);put(D+0x3e8,CFG+0x1370);put(CFG+0x1370,0xbc1088);put(CFG+0x1378,S+0x1080);put(S+0x1080,0x9f8508);put(D+0x3c8,L);put(L,0xb846f0);put32(S+0x1a8,138);float f=8;memcpy(memory+(S+0x1080+0xc0-BASE),&f,4);
}
static void bind(){iq4_dual_after_open_01(D);assert(listener_count==1&&active_dialog==D&&!held);}
int main(){unsigned cases=0;setup();bind();
 for(unsigned i=0;i<18;++i){iq4_dual_cycle_01(D,L,0,4);assert(step(dual_test_get(S+0x1080))==i%9+1);assert(set_count==i+1&&update_count==i+1&&!held);}++cases;
 for(unsigned tag=0;tag<8;++tag)if(tag!=4){setup();bind();iq4_dual_cycle_01(D,L,0,tag);assert(!set_count);++cases;}
 for(unsigned kind=0;kind<10;++kind){setup();if(kind==0)fail_pin=1;if(kind==1)put(D,0);if(kind==2)memory[0x128]=0;if(kind==3)put(D+0xb0,M+8);if(kind==4)put(Q+0x1c8,M+8);if(kind==5)put(CFG+0x1378,0);if(kind==6)put(L+0x60,1234);if(kind==7)put(L,0);if(kind==8)throw_get=1;if(kind==9)throw_listener=1;
 iq4_dual_after_open_01(D);assert(!active_dialog&&!set_count);++cases;}
 for(unsigned kind=0;kind<8;++kind){setup();bind();if(kind==0)other_actor=1;if(kind==1)put(D,0);if(kind==2)memory[0x128]=0;if(kind==3)put(L+0x60,0);if(kind==4)throw_get=1;if(kind==5)throw_set=1;if(kind==6)wrong_set=1;if(kind==7)busy=1;
 iq4_dual_cycle_01(D,L,0,4);assert(update_count==0);unsigned old=set_count;iq4_dual_cycle_01(D,L,0,4);assert(set_count==old);++cases;}
 setup();bind();iq4_dual_cycle_01(D+8,L,0,4);iq4_dual_cycle_01(D,L+8,0,4);assert(!set_count);++cases;
 setup();bind();float nan;uint32_t bits=0x7fc00000;memcpy(&nan,&bits,4);assert(step(nan)==0&&step(0)==0&&step(16)==0);++cases;
 for(unsigned n=1;n<=9;++n){setup();float f=ratios[n-1];memcpy(memory+(S+0x1140-BASE),&f,4);busy=1;
  assert(iq4_dual_long_tick_02(D,138,1.0f,f)==138-(int32_t)(4*n));assert(!quantize_count);++cases;}
 for(unsigned k=0;k<8;++k){setup();float f=ratios[0];memcpy(memory+(S+0x1140-BASE),&f,4);int base=138;
  if(k==0)f=16;if(k==1)f=nan;if(k==2)put(D,0);if(k==3)put32(S+0x1a8,140);if(k==4)throw_get=1;if(k==5)base=3;if(k==6)base=145;if(k==7)memory[0x128]=0;
  assert(iq4_dual_long_tick_02(D,base,1.0f,f)==123&&quantize_count==1);++cases;}
 printf("{\"cases\":%u,\"host_native_fixtures\":true,\"hardware_executed\":false}\n",cases);
}
