#pragma once
#include "observe.hpp"
#include "home_tables.hpp"
#include "../f1_observe_geometry_04/fixture.hpp"
#include <array>
#include <cassert>
#include <cstring>
namespace iq4::f1::stack05::test {
struct Fixture:observe04::test::Fixture {
    alignas(16)std::array<unsigned char,0xe8>home{};
    alignas(16)std::array<unsigned char,0xe8>extra[7]{};
    unsigned primary_reads{};bool move_primary{},deny_primary{},deny_home_table{};
    Fixture(){add(home);for(auto&e:extra)add(e);dialog(a(home),0xb94fe8,0xb95200);}
    void dialog(Address d,Address vt,Address node_vt){put(d,vt);put(d+0xb0,manager);put(d+0x88,node_vt);put(d+0xa0,d);}
    void chain(std::initializer_list<Address>ds){
      const Address head=manager+0x78;Address prev=head;
      for(Address d:ds){const Address node=d+0x88;put(prev+8,node);put(node+16,prev);put(node+24,d);put(d+0xb0,manager);prev=node;}
      put(prev+8,head);put(head+16,prev);
    }
    static bool read_stack(void*p,Address at,void*out,std::size_t n)noexcept{
      auto&f=*static_cast<Fixture*>(p);
      if(at==0xb94fd8&&n==sizeof(HomePrimary)){if(f.deny_home_table)return false;std::memcpy(out,HomePrimary,n);return true;}
      if(at==0xb951f0&&n==sizeof(HomeNode)){if(f.deny_home_table)return false;std::memcpy(out,HomeNode,n);return true;}
      if(at==a(f.home)&&n==8){if(f.deny_primary)return false;if(f.move_primary&&++f.primary_reads==2){Address moved=0x222220;std::memcpy(out,&moved,8);return true;}}
      return observe04::test::Fixture::read(&f,at,out,n);
    }
    Memory memory(){return {this,read_stack};}
    entry01::Observation source(unsigned epoch=1){
      Boundary b{};assert(native_ui02::Inspector(memory(),0).boundary(input,b));
      entry01::Observation s{};s.sequence=2*epoch;s.phase=native_ui02::Inspector(memory(),0).current(b.owner,false)?2:3;
      s.dispatch_epoch=s.qualified_boundaries=epoch;s.native_original_calls=epoch;s.queue=queue;s.manager=manager;s.data=a(data);s.lv=live;s.popup=popup;
      s.popped_observer=b.popped_observer;s.caller_pc=input.caller_pc;s.frame_pointer=input.frame_pointer;s.thread_pointer=input.thread_pointer;s.mutex=input.mutex;
      s.local_bounds={0xb73b98,10,20,800,480};s.pan_x=-4;s.pan_y=7;s.scale=4;s.visible=s.running=1;
      assert(entry01::observe_stack(memory(),0,b.owner,s.original_stack));return s;
    }
    static entry01::Observation waiting(){entry01::Observation s;s.phase=1;return s;}
};
}
