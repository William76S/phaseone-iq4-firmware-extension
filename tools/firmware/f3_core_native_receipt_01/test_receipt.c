#include "receipt.h"
#include "pins.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static unsigned char settings[0x2c8],frame[0x3f0],arena[65536],allocator[48],output[88],pool[32],cancel;
static uint64_t thread=73;static int code_bad,read_bad,original_hooks,decoder_hook_bad,preview_bad;
uint64_t iq4_native_current_tid_01(void){return thread;}
static void put64(void*p,size_t n,uintptr_t v){memcpy((char*)p+n,&v,8);}
static void put32(void*p,size_t n,uint32_t v){memcpy((char*)p+n,&v,4);}
static int read_memory(void*unused,uintptr_t a,void*out,size_t n){(void)unused;
 if(read_bad&&a==(uintptr_t)frame+0x130)return 0;
 for(size_t i=0;i<sizeof iq4_core_pins_01/sizeof*iq4_core_pins_01;++i){const struct Iq4CorePin01*p=&iq4_core_pins_01[i];
  if(a>=p->va&&a-p->va<=p->n&&n<=p->n-(a-p->va)){memcpy(out,p->bytes+a-p->va,n);
   if(n==4&&!original_hooks&&(a==0x964860||a==0x91a78c||a==0x91a964||a==0x963d28)){
    uintptr_t target=a==0x963d28?(decoder_hook_bad?0xa20004:0xa20000):(a==0x964860?0xa10000:(a==0x91a78c?0xa10100:0xa10200));
    uint32_t w=0x94000000|((uint32_t)(((int64_t)target-(int64_t)a)>>2)&0x3ffffff);memcpy(out,&w,4);}
   if((code_bad&&a==0x919d58)||(preview_bad&&a==0x963d2c))((unsigned char*)out)[0]^=1;return 1;}}
 struct {const void*p;size_t n;} ranges[]={{settings,sizeof settings},{frame,sizeof frame},{allocator,sizeof allocator},{&cancel,1},{arena,sizeof arena},{output,sizeof output},{pool,sizeof pool}};
 for(size_t i=0;i<sizeof ranges/sizeof*ranges;++i){uintptr_t b=(uintptr_t)ranges[i].p;if(a>=b&&a-b<=ranges[i].n&&n<=ranges[i].n-(a-b)){memcpy(out,(void*)a,n);return 1;}}
 return 0;
}
int main(int argc,char**argv){int which=argc>1?atoi(argv[1]):0;
 put32(settings,0,0x3f800000);settings[0x291]=1;put32(settings,0x2c0,8);put32(settings,0x2c4,6);
 put64(allocator,8,(uintptr_t)arena+1024);put64(allocator,16,sizeof arena-1024);
 put64(frame,0xe8,(uintptr_t)allocator);put64(frame,0x118,(uintptr_t)output);put64(frame,0x88,(uintptr_t)settings);put64(frame,0xb8,(uintptr_t)&cancel);put32(frame,0xb4,2);
 Iq4CoreOwner01 owner={(uintptr_t)settings,(uintptr_t)&cancel,(uintptr_t)pool,(uintptr_t)output,(uintptr_t)arena,sizeof arena};uint64_t gen=0;
 if(which==1)code_bad=1;if(which==2)original_hooks=1;if(which==3)put32(settings,0,0x3f400000);if(which==15)decoder_hook_bad=1;if(which==16)preview_bad=1;
 int begin=iq4_f3_core_begin_01(read_memory,0,&owner,&gen);
 if(which==1||which==2||which==15||which==16){assert(begin==IQ4_CORE_UNBOUND);goto done;}
 if(which==3){assert(begin==IQ4_CORE_ARGUMENT);goto done;}
 assert(begin==IQ4_CORE_OK&&gen);assert(iq4_f3_core_begin_01(read_memory,0,&owner,&gen)==IQ4_CORE_BUSY);
 uintptr_t a[8]={(uintptr_t)allocator,1,(uintptr_t)output,0,0,(uintptr_t)settings,(uintptr_t)pool,(uintptr_t)&cancel};
 iq4_f3_core_before_01(a,0,which==4?0x963f48:0x964864);
 if(which==5){thread=74;iq4_f3_core_join_returned_01(0,0,0);thread=73;}
 if(which==6)put32(frame,0xb4,0);
 if(which!=7)iq4_f3_core_join_returned_01((uintptr_t)frame,(uintptr_t)pool,0x91a790);
 if(which==8)iq4_f3_core_join_returned_01((uintptr_t)frame,(uintptr_t)pool,0x91a790);
 put32(frame,0xf0,1);
 if(which!=7&&which!=9)iq4_f3_core_join_returned_01((uintptr_t)frame,(uintptr_t)pool,0x91a790);
 put32(frame,0xf0,2);put32(frame,0x130,2);
 if(which==10)cancel=1;if(which==11)read_bad=1;if(which==12)put64(frame,0x118,(uintptr_t)pool);
 if(which!=13)iq4_f3_core_terminal_01((uintptr_t)frame,0x91a968);
 if(which!=14)iq4_f3_core_after_01();
 Iq4CoreView01 view;int end=iq4_f3_core_end_01(gen,&view);
 if(which==0||which==5){assert(end==IQ4_CORE_OK&&view.complete&&view.joins==2&&view.stages==2&&view.core_returned&&!view.held);}
 else if(which==4||which==11||which==12||which==14){assert(end==IQ4_CORE_HOLD&&view.held&&!view.complete);assert(iq4_f3_core_begin_01(read_memory,0,&owner,&gen)==IQ4_CORE_HOLD);}
 else {assert(end==IQ4_CORE_FAILED&&!view.held&&!view.complete);}
done:printf("PASS: exact core receipt own-memory case %d; no native function execution\n",which);return 0;
}
