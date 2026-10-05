// Host event models exercise both actual receipt implementations. No vendor
// decoder, renderer, target hooks, device or synthetic rendered output runs.
#include "completion.hpp"
#include "decode_pins.h"
#include "../../tools/firmware/f3_core_native_receipt_01/pins.h"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <initializer_list>
#include <sys/wait.h>
#include <unistd.h>
namespace nr=iq4::native_render_02;
struct Region{std::uintptr_t va;std::size_t n;const unsigned char* bytes;};
static Region regions[64];static unsigned count;
static unsigned char code[24][8192];
extern "C" std::uint64_t iq4_native_current_tid_01(){return 7;}
static void add(std::uintptr_t p,const void* b,std::size_t n){assert(count<64);regions[count++]={p,n,static_cast<const unsigned char*>(b)};}
static int read_mock(void*,std::uintptr_t p,void* b,std::size_t n){
 for(unsigned i=0;i<count;++i)if(p>=regions[i].va&&p-regions[i].va<=regions[i].n&&n<=regions[i].n-(p-regions[i].va)){
  std::memcpy(b,regions[i].bytes+p-regions[i].va,n);return 1;}return 0;
}
template<class T>static void put(void* b,unsigned at,T v){std::memcpy(static_cast<unsigned char*>(b)+at,&v,sizeof v);}
static void patch(std::uintptr_t pc,std::uintptr_t to){const auto word=0x94000000u|(std::uint32_t((to-pc)>>2)&0x3ffffffu);bool found=false;
 for(unsigned i=0;i<count;++i)if(pc>=regions[i].va&&pc+4<=regions[i].va+regions[i].n){put(const_cast<unsigned char*>(regions[i].bytes),unsigned(pc-regions[i].va),word);found=true;}assert(found);}
static void setup(){unsigned at=0;
 for(const auto& p:iq4_decode_pins_02){assert(p.n<=sizeof code[0]);std::memcpy(code[at],p.bytes,p.n);add(p.va,code[at++],p.n);}
 for(const auto& p:iq4_core_pins_01){assert(p.n<=sizeof code[0]);std::memcpy(code[at],p.bytes,p.n);add(p.va,code[at++],p.n);}
 assert(at<=24);patch(0x963d28,0xa20000);patch(0x9226c0,0xa20100);patch(0x9226d8,0xa20100);patch(0x922a1c,0xa20200);
 patch(0x964860,0xa10000);patch(0x91a78c,0xa10100);patch(0x91a964,0xa10200);
}
static void one(unsigned fault){setup();
 void* mapping=nullptr;const std::uint64_t bytes=nr::PrefixBytes+4096;assert(posix_memalign(&mapping,32,bytes)==0);
 auto* arena=static_cast<unsigned char*>(mapping);unsigned char settings[0x2c8]={},rgb32[0x58]={},planar[0x58]={},cancel=0;
 unsigned char payload[400]={},states[8]={},decoder[0x58]={},job[0x58]={},allocator[0x18]={},frame[0x138]={};
 std::uint32_t rows[8],copied[8],pairs[2]={0,2};for(unsigned i=0;i<8;++i)rows[i]=copied[i]=i*16;
 std::uintptr_t rowvector[3]={(std::uintptr_t)copied,(std::uintptr_t)(copied+8),(std::uintptr_t)(copied+8)};
 std::uintptr_t pairvector[3]={(std::uintptr_t)pairs,(std::uintptr_t)(pairs+2),(std::uintptr_t)(pairs+2)};
 iq4::raw_file_source_01::NativeRawInputLayout input{};input.format=8;input.rows_begin=rows;input.rows_end=rows+8;input.rows_capacity=rows+8;input.payload=payload;input.payload_bytes=128;
 nr::Owner owner{(void*)0x500100,&input,rgb32,planar,settings,(void*)0x500000,&cancel,arena,bytes,77,{8,8,0,2,8,4,8,128,rows,payload}};
 put(settings,0,std::uint32_t(0x3f800000));settings[0x291]=1;put(settings,0x2c0,std::uint32_t(8));put(settings,0x2c4,std::uint32_t(4));
 for(const auto& r:{Region{(std::uintptr_t)settings,sizeof settings,settings},Region{(std::uintptr_t)&cancel,1,&cancel},
  Region{(std::uintptr_t)payload,sizeof payload,payload},Region{(std::uintptr_t)rows,sizeof rows,(const unsigned char*)rows},
  Region{(std::uintptr_t)copied,sizeof copied,(const unsigned char*)copied},Region{(std::uintptr_t)pairs,sizeof pairs,(const unsigned char*)pairs},
  Region{(std::uintptr_t)rowvector,sizeof rowvector,(const unsigned char*)rowvector},Region{(std::uintptr_t)pairvector,sizeof pairvector,(const unsigned char*)pairvector},
  Region{(std::uintptr_t)decoder,sizeof decoder,decoder},Region{(std::uintptr_t)job,sizeof job,job},Region{(std::uintptr_t)allocator,sizeof allocator,allocator},Region{(std::uintptr_t)frame,sizeof frame,frame}})add(r.va,r.bytes,r.n);
 nr::CombinedCompletion combined;combined.read=read_mock;combined.payload_allocation_bytes=sizeof payload;combined.row_states=states;combined.row_states_bytes=sizeof states;
 const auto callbacks=combined.callbacks();
 if(fault==1)patch(0x963d28,0xa20004);
 if(fault==2)patch(0x964860,0xa10004);
 auto result=callbacks.begin(callbacks.context,owner);
 if(fault==1||fault==2){assert(result==nr::Result::Unbound&&!combined.active);free(mapping);return;}
 assert(result==nr::Result::Ok);assert(callbacks.begin(callbacks.context,owner)==nr::Result::Busy);
 std::uintptr_t readerargs[9]={(std::uintptr_t)owner.pool,0x500200,(std::uintptr_t)arena+nr::PrefixBytes,(std::uintptr_t)rowvector,(std::uintptr_t)payload,128,8,8,0x500300};
 std::uintptr_t stack[10]={8,4,2,0,0,0,8,4,8,(std::uintptr_t)pairvector};
 iq4_f3_decode_reader_before_02(readerargs,stack,0x600000,0x963d2c);
 put(job,0,(std::uintptr_t)pairs);put(job,8,(std::uintptr_t)(pairs+2));put(job,0x10,(std::uintptr_t)rowvector);put(job,0x18,(std::uintptr_t)payload);put(job,0x20,(std::uintptr_t)arena+nr::PrefixBytes);put(job,0x34,std::uint32_t(32));put(job,0x38,std::uint32_t(8));put(decoder,0,std::uint32_t(8));
 for(unsigned pair=0;pair<2;++pair)for(unsigned second=0;second<2;++second){unsigned row=2+pair*2+second;
  if(fault==3&&row==3)continue;std::uintptr_t args[4]={(std::uintptr_t)decoder,(std::uintptr_t)payload+rows[row],(std::uintptr_t)arena+nr::PrefixBytes+row*32,8};
  const auto pc=second?0x9226dcu:0x9226c4u;const auto index=(std::uintptr_t)(pairs+pair);
  iq4_f3_decode_row_before_02(args,(std::uintptr_t)job,index,pc);put(decoder,0x50,args[1]+4);iq4_f3_decode_row_after_02(args,(std::uintptr_t)job,index,pc);
 }
 iq4_f3_decode_join_after_02(0x600000-0x140,(std::uintptr_t)owner.pool,0x922a20);iq4_f3_decode_reader_after_02(0x963d2c);
 put(allocator,8,(std::uintptr_t)arena+nr::PrefixBytes+256);put(allocator,16,std::uintptr_t(1024));
 std::uintptr_t coreargs[8]={(std::uintptr_t)allocator,0,(std::uintptr_t)rgb32,(std::uintptr_t)planar,0,(std::uintptr_t)settings,(std::uintptr_t)owner.pool,(std::uintptr_t)&cancel};
 iq4_f3_core_before_01(coreargs,0,0x964864);
 put(frame,0xe8,(std::uintptr_t)allocator);put(frame,0x118,(std::uintptr_t)rgb32);put(frame,0x88,(std::uintptr_t)settings);put(frame,0xb8,(std::uintptr_t)&cancel);put(frame,0xb4,std::uint32_t(2));
 for(unsigned stage=0;stage<3;++stage){put(frame,0xf0,std::uint32_t(stage));iq4_f3_core_join_returned_01((std::uintptr_t)frame,(std::uintptr_t)owner.pool,0x91a790);}
 put(frame,0xf0,std::uint32_t(3));put(frame,0x130,std::uint32_t(3));
 if(fault!=4)iq4_f3_core_terminal_01((std::uintptr_t)frame,0x91a968);
 if(fault==5)cancel=1;
 iq4_f3_core_after_01();nr::Receipt receipt{};
 if(fault==6)owner.identity++;
 result=callbacks.end(callbacks.context,owner,fault==7?0:1,receipt);
 if(fault==6){assert(result==nr::Result::Hold&&combined.active);_exit(0);}
 if(fault==3||fault==4||fault==5||fault==7){assert(result==nr::Result::Incomplete);assert(callbacks.abort_after_join(callbacks.context,owner)==nr::Result::Ok);}
 else assert(result==nr::Result::Ok&&receipt.reader_returned&&receipt.decoded_rows_complete&&receipt.decode_workers_joined&&receipt.full_r0_core_complete&&receipt.core_workers_joined);
 assert(!combined.active);free(mapping);
}
int main(){for(unsigned i=0;i<8;++i){pid_t p=fork();assert(p>=0);if(!p){one(i);_exit(0);}int status;assert(waitpid(p,&status,0)==p);if(!WIFEXITED(status)||WEXITSTATUS(status)){std::fprintf(stderr,"combined group %u failed\n",i);return 1;}}
 puts("{\"groups\":8,\"host_only\":true,\"actual_receipt_implementations\":2,\"native_vendor_code_executed\":false,\"camera_accessed\":false}");}
