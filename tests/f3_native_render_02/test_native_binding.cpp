// Exact bytes and native-memory models only. No original addresses execute.
#include "native_binding.hpp"
#include "persistent_pool.hpp"
#include "api_pins.h"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/wait.h>
#include <unistd.h>
namespace nr=iq4::native_render_02;
struct Region{std::uintptr_t va;std::size_t bytes;const void* buffer;};
static Region regions[64];static unsigned count,fault,construct_calls,start_calls,join_calls;
static std::uint64_t tid=7;static unsigned char workers[3][0x360];
static std::uintptr_t worker_array[3];static unsigned char prefixes[33][32];
extern "C" std::uint64_t iq4_native_current_tid_01(){return tid;}
static void add(std::uintptr_t p,const void* b,std::size_t n){assert(count<64);regions[count++]={p,n,b};}
static int read_mock(void*,std::uintptr_t p,void* b,std::size_t n){
 for(unsigned i=0;i<count;++i)if(p>=regions[i].va&&p-regions[i].va<=regions[i].bytes&&n<=regions[i].bytes-(p-regions[i].va)){
  std::memcpy(b,static_cast<const unsigned char*>(regions[i].buffer)+p-regions[i].va,n);return 1;}return 0;
}
template<class T>static void put(void* b,unsigned at,T value){std::memcpy(static_cast<unsigned char*>(b)+at,&value,sizeof value);}
static void ctor(void* p,const char* name,std::uint32_t n,std::uint32_t priority,std::uint32_t stack){
 ++construct_calls;assert(!std::strcmp(name,"IQ4_F3_Own")&&n==3&&priority==1&&stack==4096);if(fault==1)throw 1;
 add((std::uintptr_t)p,p,0x18);put(p,0,(std::uintptr_t)worker_array);put(p,8,n);put(p,12,stack);put(p,16,priority);put(p,20,std::uint8_t(1));
 if(fault==2)put(p,8,std::uint32_t(2));
 for(unsigned i=0;i<3;++i){worker_array[i]=(std::uintptr_t)workers[i];put(workers[i],0,std::uintptr_t(0xc24fd0));put(workers[i],0x338,std::uint32_t(i));add((std::uintptr_t)workers[i],workers[i],sizeof workers[i]);}
 add((std::uintptr_t)worker_array,worker_array,sizeof worker_array);
}
static void start(void*){++start_calls;if(fault==3)throw 1;for(auto& worker:workers)worker[0x158]=1;if(fault==4)workers[1][0x158]=0;}
static void join(void*){++join_calls;if(fault==5)throw 1;}
static void one_pool(unsigned which){fault=which;nr::PersistentPool pool;
 const nr::NativePoolApi api{ctor,start,join,true,true};auto r=pool.initialize(api,read_mock,nullptr);
 if(which>=1&&which<=4){assert(r==nr::Result::Hold&&pool.quarantined());assert(pool.initialize(api,read_mock,nullptr)==nr::Result::Hold);assert(construct_calls==1);return;}
 assert(r==nr::Result::Ok);assert(pool.initialize(api,read_mock,nullptr)==nr::Result::Ok&&construct_calls==1&&start_calls==1);
 nr::PoolLease lease;std::uint64_t token;assert(pool.acquire(lease,token)==nr::Result::Ok&&token&&lease.held_started_exclusive(lease.context,lease.pool));
 nr::PoolLease duplicate;std::uint64_t duplicate_token;assert(pool.acquire(duplicate,duplicate_token)==nr::Result::Busy&&!duplicate.pool&&!duplicate_token);
 if(which==6){tid=8;assert(!lease.held_started_exclusive(lease.context,lease.pool));assert(pool.release_after_join(token)==nr::Result::Argument);tid=7;}
 if(which==7){workers[1][0x158]=0;assert(!lease.held_started_exclusive(lease.context,lease.pool));}
 assert(pool.release_after_join(token+1)==nr::Result::Argument);r=pool.release_after_join(token);
 if(which==5||which==7)assert(r==nr::Result::Hold&&pool.quarantined());
 else{assert(r==nr::Result::Ok&&join_calls==1&&!lease.held_started_exclusive(lease.context,lease.pool));assert(pool.acquire(lease,token)==nr::Result::Ok&&token==2);assert(pool.release_after_join(token)==nr::Result::Ok&&join_calls==2);}
}
static void setup_prefixes(){unsigned index=0;
 for(const auto& p:iq4_render_api_pins_02){std::memcpy(prefixes[index],p.bytes,32);add(p.va,prefixes[index++],32);}
 for(const auto& p:iq4_source_api_pins_02){std::memcpy(prefixes[index],p.bytes,32);add(p.va,prefixes[index++],32);}
 assert(index==33);add(0x40ae40,iq4_source_syscall_pin_02,32);
}
static void bindings(){setup_prefixes();assert(nr::native_render_prefixes_02(read_mock,nullptr)&&nr::native_source_prefixes_02(read_mock,nullptr));
 for(unsigned i=0;i<33;++i){prefixes[i][31]^=1;assert((i<17?!nr::native_render_prefixes_02(read_mock,nullptr):!nr::native_source_prefixes_02(read_mock,nullptr)));prefixes[i][31]^=1;}
 nr::NativeApi render;nr::NativePoolApi pool;iq4::raw_file_source_01::NativeApi file;iq4::raw_file_source_01::ObjectApi objects;iq4::raw_file_source_01::FileOps ops;
 assert(nr::bind_native_render_02(read_mock,nullptr,false,render,pool)==nr::Result::Unbound&&!render.process);
 assert(nr::bind_native_source_02(read_mock,nullptr,false,file,objects)==nr::Result::Unbound&&!file.construct);
#if !defined(__aarch64__) || !defined(__linux__)
 assert(nr::bind_native_render_02(read_mock,nullptr,true,render,pool)==nr::Result::Unbound&&!render.process&&!pool.start);
 assert(nr::bind_native_source_02(read_mock,nullptr,true,file,objects)==nr::Result::Unbound&&!file.construct&&!objects.input_construct);
 assert(nr::bind_native_file_ops_02(read_mock,nullptr,ops)==nr::Result::Unbound&&!ops.stat);
#endif
 assert(!nr::native_render_prefixes_02(nullptr,nullptr));assert(!nr::native_source_prefixes_02(nullptr,nullptr));
}
int main(){bindings();for(unsigned i=0;i<8;++i){pid_t p=fork();assert(p>=0);if(!p){one_pool(i);_exit(0);}int status;assert(waitpid(p,&status,0)==p);if(!WIFEXITED(status)||WEXITSTATUS(status)){std::fprintf(stderr,"binding/pool group %u failed\n",i);return 1;}}
 puts("{\"groups\":49,\"exact_function_prefix_mutations\":33,\"host_only\":true,\"native_vendor_code_executed\":false,\"camera_accessed\":false}");}
