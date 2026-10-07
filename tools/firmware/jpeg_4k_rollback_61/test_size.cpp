/* Focused actual production accessors with declared in-memory backend fixture.
 * No JPEG native job return, pixel render, card I/O or pending cleanup mocked. */
#include <cassert>
#include <cstdlib>
#include <cstdio>
#include <vector>
#define IQ4_STOCK_JPEG_TEST
#include "runtime.cpp"
struct Range61 {uintptr_t p;size_t n;};
static std::vector<Range61> ranges61;
static uint32_t native_size61=1, pending61, capture61, receipts61, setter61;
static uint32_t settings_enter61,settings_leave61;
static uintptr_t allocate61(size_t n){void*p=calloc(1,n);assert(p);ranges61.push_back({uintptr_t(p),n});return uintptr_t(p);}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){
 if(p>=0xf55e18&&p+n<=0xf55e18+64){unsigned char rows[64]={};
  for(unsigned i=0;i<2;++i){uint32_t id=10+i,flag=2;memcpy(rows+32*i,&id,4);memcpy(rows+32*i+16,&binding.fs[i],8);memcpy(rows+32*i+24,&flag,4);}
  memcpy(out,rows+p-0xf55e18,n);return 1;
 }
 if(p==0xdce120&&n==8){uintptr_t fn=0x98d8a8;memcpy(out,&fn,8);return 1;}
 if(p==0x9f1920&&n==8){uintptr_t fn=0x41497c;memcpy(out,&fn,8);return 1;}
 for(const auto&r:ranges61)if(p>=r.p&&p+n>=p&&p+n<=r.p+r.n){memcpy(out,(void*)p,n);return 1;}
 return 0;
}
extern "C" uint64_t iq4_native_current_tid_01(){return 77;}
extern "C" int iq4_new_raw_settings_enter_55(){++settings_enter61;return 1;}
extern "C" void iq4_new_raw_settings_leave_55(){++settings_leave61;}
extern "C" uint32_t iq4_new_raw_active_55(){return receipts61;}
extern "C" uintptr_t iq4_stock_jpeg_test_call(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t){
 if(pc==0x5e7350){assert(a==binding.group[0]+0x2a8);return native_size61;}
 if(pc==0x5e7384){assert(a==binding.group[0]+0x2a8&&b==1);++setter61;native_size61=(uint32_t)b;return 0;}
 if(pc==0x41497c){assert(a==native_sequence+0x298);return capture61;}
 if(pc==0x8e2590){assert(a==binding.ifm);return pending61;}
 assert(!"unexpected boundary call");return 0;
}
int main(){
 binding.task=allocate61(0x220);binding.ifm=allocate61(8);
 for(unsigned i=0;i<2;++i){binding.group[i]=allocate61(0x1400);binding.fs[i]=allocate61(0x220);binding.power[i]=allocate61(0x330);
  put(binding.group[i],0xbca228);*((unsigned char*)(binding.group[i]+0x13f3))=i?2:4;
  put(binding.fs[i],0xd91450);strcpy((char*)(binding.fs[i]+0x15),i?"/run/media/xqdcard/":"/run/media/sdcard/");
  put(binding.power[i],0xdb6628);put(binding.power[i]+0x68,i?0x9f3fe8:0x9f4000);
  put(binding.power[i]+0x70,0xdbc878);put(binding.power[i]+0x78,i?(uintptr_t)client_name:(uintptr_t)sd_source_name);
 }
 binding.native_out=0;binding.source=0;binding.extra_out=1;binding.sd_source=1;
 put(binding.task,0xdbce40);put(binding.task+0x1c8,binding.group[0]);put(binding.task+0x1d0,binding.ifm);
 put(binding.task+0x1e0,binding.power[1]);put32(binding.task+0x1ec,0);put32(binding.task+0x1b8,16);
 uintptr_t enc=allocate61(8);put(enc,0xdce100);put(binding.task+0x1f0,enc);
 native_sequence=allocate61(0x400);put(native_sequence,0xbd0a38);put(native_sequence+0x298,0x9f18e0);
 bound=receipt_bound=1;uint32_t v=99;
 assert(iq4_stock_jpeg_bound_01());
 assert(iq4_stock_jpeg_extended_size_get_02(&v)==1&&v==0);
 assert(iq4_stock_jpeg_size_get_01(&v)==1&&v==1);
 assert(iq4_stock_jpeg_quality_get_02(&v)==1&&v==100);
 assert(!iq4_stock_jpeg_extended_size_get_02(nullptr)&&!iq4_stock_jpeg_quality_get_02(nullptr));
 unsigned before=setter61;assert(!iq4_stock_jpeg_extended_size_set_02(1)&&!iq4_stock_jpeg_extended_size_set_02(UINT32_MAX));
 assert(setter61==before&&settings_enter61==0);
 assert(!iq4_stock_jpeg_size_set_01(0)&&!iq4_stock_jpeg_size_set_01(2)&&setter61==before);
 assert(iq4_stock_jpeg_extended_size_set_02(0)==1&&native_size61==1&&setter61==before+1&&settings_enter61==settings_leave61);
 native_size61=0;v=99;assert(!iq4_stock_jpeg_extended_size_get_02(&v)&&v==99);
 assert(iq4_stock_jpeg_extended_size_set_02(0)==1&&native_size61==1);
 before=setter61;pending61=1;assert(!iq4_stock_jpeg_extended_size_set_02(0)&&setter61==before);pending61=0;
 capture61=1;assert(!iq4_stock_jpeg_extended_size_set_02(0)&&setter61==before);capture61=0;
 receipts61=1;assert(!iq4_stock_jpeg_extended_size_set_02(0)&&setter61==before);receipts61=0;
 active=1;assert(!iq4_stock_jpeg_extended_size_set_02(0)&&setter61==before);active=0;
 put32(binding.power[1]+0x17c,1);assert(!iq4_stock_jpeg_extended_size_set_02(0)&&setter61==before);put32(binding.power[1]+0x17c,0);
 held=1;v=99;assert(!iq4_stock_jpeg_extended_size_get_02(&v)&&v==99);assert(!iq4_stock_jpeg_quality_get_02(&v)&&v==99);held=0;
 assert(settings_enter61==settings_leave61);
 for(auto&r:ranges61)free((void*)r.p);
 puts("PASS 61 production 4K-only get/set, obsolete choices rejected, Quality100, busy/pending/owner refusal");
}
