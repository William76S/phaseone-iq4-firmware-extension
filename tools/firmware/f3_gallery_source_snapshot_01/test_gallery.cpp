#include "gallery.hpp"
#include "../f3_source_dependencies_02/pins.hpp"
#include <map>
#include <vector>
#include <cstring>
#include <cassert>
#include <cstdio>
using namespace iq4::gallery_source_01;
constexpr uintptr_t IFM=0x1000000,Reader=0x1100000,FS=0x1200000,Thread=0x1300000,Table=0x1400000,Records=0x1500000,Dir=0x1600000;
struct Fixture {
 std::map<uintptr_t,std::vector<unsigned char>>mem;unsigned ctor=0,dtor=0;int fault=0;
 void blob(uintptr_t p,const void*b,size_t n){mem[p]={static_cast<const unsigned char*>(b),static_cast<const unsigned char*>(b)+n};}
 template<class T>void put(uintptr_t p,T v){blob(p,&v,sizeof v);}
 Fixture(){for(const auto&p:iq4::source_dependencies_01::Pins)blob(p.va,p.data,p.bytes);
  put(0x8dc4c0,uint32_t(0x14000000u|((0x4240000-0x8dc4c0)/4)));
  put(IFM,uintptr_t(0xb7ece0));put(IFM+0x4d8,Reader);put(Reader,uintptr_t(0xd86708));
  size_t offs[]={0x10,8,0x62bf8,0x62c00,0x62c08};for(unsigned i=0;i<5;++i){put(Reader+offs[i],uintptr_t(0x1700000+i*0x1000));put(0x1700000+i*0x1000,uint64_t(17));}
  put(IFM+0x1a8,uint32_t(1));put(IFM+0x1b8,uint32_t(1));put(IFM+0x1b0,Table);put(Table,Records);put(Table+8,Records+40);
  unsigned char rec[40]{};std::memcpy(rec,"P0000001.IIQ",13);rec[0xe]=4;rec[0x10]=1;blob(Records,rec,40);
  put(IFM+0x7a0,FS);put(IFM+0x7b0,Dir);put(IFM+0x7d0,FS);put(IFM+0x7e0,Dir);
  put(FS,uintptr_t(0xd91450));const char dir[]="/DCIM/100PHASE";blob(Dir,dir,sizeof dir);
  put(IFM+0x5f8,uintptr_t(0x9f1df0));put(IFM+0x640,uintptr_t(0));put(IFM+0x648,uint32_t(0));put(IFM+0x64c,uint32_t(0));put(Thread,uintptr_t(0xb805c0));
 }
 static int read(void*ctx,uintptr_t p,void*out,size_t n){auto&f=*static_cast<Fixture*>(ctx);auto i=f.mem.upper_bound(p);if(i==f.mem.begin())return 0;--i;if(p-i->first>i->second.size()||n>i->second.size()-(p-i->first))return 0;std::memcpy(out,i->second.data()+p-i->first,n);return 1;}
};
static Fixture*active;
static void*thread(){return reinterpret_cast<void*>(Thread);}
static void construct(void*g,void*m){++active->ctor;std::memcpy(g,&m,8);if(active->fault==5)throw 1;active->put(IFM+0x640,Thread);active->put(IFM+0x648,uint32_t(active->fault==6?2:1));}
static void destroy(void*){++active->dtor;if(active->fault==7)throw 1;active->put(IFM+0x648,uint32_t(0));active->put(IFM+0x640,uintptr_t(0));}
int main(){unsigned passed=0;for(int id=0;id<13;++id){Fixture f;f.fault=id;active=&f;Memory m{&f,Fixture::read};NativeMutexApi a{construct,destroy,thread,true};Guard g;Snapshot s;
 if(id==1)f.mem[Records][12]='x';if(id==2)f.mem[Records][0xe]=0;if(id==3)f.mem[Records][0x10]=0;
 if(id==4)f.put(IFM+0x1b8,uint32_t(2));if(id==8)f.put(IFM+0x640,Thread+8),f.put(IFM+0x648,uint32_t(1));
 if(id==9)f.mem[iq4::source_dependencies_01::Pins[0].va][0]^=1;
 auto r=snapshot(m,a,g,IFM,id==10?-1:0,s);
 if(id==0||id==11||id==12){assert(r==Result::Ok&&f.ctor==1&&f.dtor==1&&!g.live&&!g.hold&&s.filesystem_id==10);
  if(id==11){f.mem[Records][0]='Q';assert(recheck(m,a,g,s)==Result::Changing);}
  if(id==12){f.mem[Records][0xe]=6;Snapshot q;assert(snapshot(m,a,g,IFM,0,q)==Result::Ok&&q.filesystem_id==11);}
 }else if(id>=5&&id<=7){assert(r==Result::Hold&&g.hold);auto calls=f.ctor+f.dtor;assert(snapshot(m,a,g,IFM,0,s)==Result::Hold&&calls==f.ctor+f.dtor);}
 else{assert(r!=Result::Ok&&!s.ifm&&!g.hold);assert(id==8?f.ctor==0:f.ctor==1&&f.dtor==1);}
 ++passed;}
 char path[256];assert(relative_directory("/",path)&&!path[0]);assert(!relative_directory("DCIM/../x",path));assert(!relative_directory("//DCIM",path));
 std::printf("{\"cases\":%u,\"passed\":true,\"native_mutexes_are_fixtures\":true,\"target_executed\":false}\n",passed);
}
