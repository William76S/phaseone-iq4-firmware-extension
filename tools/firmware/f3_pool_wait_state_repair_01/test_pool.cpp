#include "../f3_native_render_02/persistent_pool.hpp"
#include <cassert>
#include <cstring>
#include <cstdlib>
using namespace iq4::native_render_02;
extern "C" unsigned iq4_f3_pool_detail_01();
extern "C" uint64_t iq4_native_current_tid_01(){return 1;}
alignas(16) static unsigned char workers[3][0x360];
static uintptr_t array[3];static unsigned fault;
static int readmem(void*,uintptr_t p,void*b,size_t n){std::memcpy(b,(void*)p,n);return 1;}
static void ctor(void*p,const char*,uint32_t n,uint32_t pri,uint32_t stack){if(fault==1)throw 1;auto*b=(unsigned char*)p;uintptr_t a=(uintptr_t)array;std::memcpy(b,&a,8);if(fault==12)n=4;std::memcpy(b+8,&n,4);std::memcpy(b+12,&stack,4);std::memcpy(b+16,&pri,4);b[20]=1;for(unsigned i=0;i<3;++i){array[i]=(uintptr_t)workers[i];uintptr_t vt=0xc24fd0;if(fault==21&&i==0)vt=0;std::memcpy(workers[i],&vt,8);std::memcpy(workers[i]+0x338,&i,4);}}
static void start(void*){if(fault==3)throw 1;for(auto&w:workers){w[0x158]=(fault==23||fault==24||fault==25||fault==26||fault==27)?0:1;if(fault==24||fault==25||fault==26||fault==27){uint64_t tid=123;uint32_t state=fault==24?1:fault==25?0:fault==27?3:2;std::memcpy(w+0xb8,&tid,8);std::memcpy(w+0xb4,&state,4);}}}
static void join(void*){}
int main(int argc,char**argv){assert(argc==2);fault=std::atoi(argv[1]);PersistentPool p;NativePoolApi a{ctor,start,join,true,true};auto r=p.initialize(a,readmem,nullptr);bool ok=!fault||fault==24||fault==25||fault==27;assert(r==(ok?Result::Ok:Result::Hold));assert(iq4_f3_pool_detail_01()==(ok?5:fault==26?23:fault));if(!ok)assert(p.initialize(a,readmem,nullptr)==Result::Hold);}
