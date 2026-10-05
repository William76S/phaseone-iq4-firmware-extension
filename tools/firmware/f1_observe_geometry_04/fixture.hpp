#pragma once
#include "observe.hpp"
#include <array>
#include <cstring>
#include <vector>
namespace iq4::f1::observe04::test {
using namespace geometry03;
struct Span {Address at{};std::size_t size{};};
struct Fixture {
    alignas(16)std::array<unsigned char,0xd50>q{};
    alignas(16)std::array<unsigned char,0x800>m{};
    alignas(16)std::array<unsigned char,0x2000>lv{};
    alignas(16)std::array<unsigned char,0x180>data{};
    alignas(16)std::array<unsigned char,0xf8>access{};
    alignas(16)std::array<unsigned char,0x5000>engine{};
    alignas(16)std::array<unsigned char,0x40>tp{};
    alignas(16)std::array<unsigned char,0x900>frames{};
    alignas(16)std::array<unsigned char,0x80>listener{};
    alignas(16)std::array<unsigned char,0x80>surface{};
    alignas(16)std::array<unsigned char,0x20>draw{};
    alignas(16)std::array<unsigned char,0x80>parent{};
    std::vector<Span>spans;unsigned reads{},forbidden{},pan_reads{};bool changing{};
    Address queue{},manager{},live{},popup{},thread{},buffer{},own_frame{},control_frame{},manager_frame{};
    BoundaryInput input{};PaintInput paint{};
    template<class T>static Address a(T&t){return reinterpret_cast<Address>(t.data());}
    template<class T>static void value(Address p,T v){std::memcpy(reinterpret_cast<void*>(p),&v,sizeof(v));}
    static void put(Address p,Address v){value(p,v);}
    template<class T>void add(T&t){spans.push_back({a(t),t.size()});}
    static bool read(void*c,Address p,void*out,std::size_t n)noexcept {
      auto&f=*static_cast<Fixture*>(c);++f.reads;
      if((p>=f.buffer+0x10&&p<f.buffer+0x50)||(p>=a(f.surface)+0x38&&p<a(f.surface)+0x40)){++f.forbidden;return false;}
      if(p==0xb9a9d8+0x18&&n==8){const Address x=0x70c4c0;std::memcpy(out,&x,8);return true;}
      if(p==0xb9a9d8+0xb8&&n==8){const Address x=0x4ab9d8;std::memcpy(out,&x,8);return true;}
      if(p==0xb9a9d8+0x130&&n==8){const Address x=0x4abac8;std::memcpy(out,&x,8);return true;}
      for(auto&s:f.spans)if(p>=s.at&&n<=s.size&&p-s.at<=s.size-n){std::memcpy(out,reinterpret_cast<void*>(p),n);
        if(p==f.live+0x118&&n==8&&f.changing&&++f.pan_reads==2)static_cast<Point8*>(out)->x+=1;
        return true;}
      return false;
    }
    Fixture(){
      queue=a(q);manager=a(m);live=a(lv);popup=live+0x588;thread=a(tp);buffer=a(engine)+0x2170;
      add(q);add(m);add(lv);add(data);add(access);add(engine);add(tp);add(frames);add(listener);add(surface);add(draw);add(parent);
      put(queue,0xb91f48);put(queue+0x1c8,manager);put(queue+0x9b8,a(data));put(queue+0x8c0,live);
      put(manager,0xb8f358);put(manager+8,queue);put(manager+0x790,a(data));
      put(manager+0x40,0xb8f4e8);put(manager+0x48,0xc22908);put(manager+0x50,0xc22960);
      put(manager+0x58,manager+0x50);put(manager+0x60,manager+0x50);
      put(manager+0x68,0xb8f4e8);put(manager+0x70,0xc22908);put(manager+0x78,0xc22960);
      put(manager+0x80,live+0x88);put(manager+0x88,live+0x88);
      put(live,0xb9a9d8);put(live+0x88,0xb9abf8);put(live+0x90,manager+0x78);put(live+0x98,manager+0x78);put(live+0xa0,live);put(live+0xb0,manager);
      put(popup,0xb931b0);put(popup+0x88,0xb933e0);put(popup+0xb0,manager);put(popup+0x128,0xb90020);
      put(thread+0x10,queue);put(live+0x108,a(access));put(a(data)+0x118,a(access));put(a(access),0xc07da8);put(a(access)+8,a(engine));
      value(live+0x28,Rectangle24{0xb73b98,10,20,800,480});value(live+0x118,Point8{-4,7});value(live+0x190,4.0F);value(live+0x194,4.0F);
      value(live+0x100,std::int32_t(2));value(a(access)+0xb0,std::int32_t(2));value(live+0x104,std::uint8_t(1));value(live+0x6f,std::uint8_t(1));
      value(a(engine)+0x4764,std::int32_t(3200));value(a(engine)+0x4768,std::int32_t(2400));value(buffer+0xe8,std::uint32_t(4));
      const Address fp=a(frames),pop=fp+0x100,dispatch=fp+0x200;put(fp,pop);put(fp+8,0x71396c);put(pop,dispatch);put(pop+8,0x70ff9c);
      put(dispatch,dispatch+0x100);put(dispatch+8,0x4ef984);put(pop+0x28,queue);put(dispatch+0x18,queue);put(pop+0x68,a(listener));put(a(listener)+0x40,0x777770);
      input={0x6be8ac,fp,thread,queue+0xf8,0};
      put(a(surface),0xb7b780);put(a(surface)+8,a(draw));put(a(draw),0xb7b7d8);
      value(a(surface)+0x14,std::uint32_t(832));value(a(surface)+0x18,std::uint32_t(480));value(a(surface)+0x20,Rectangle24{0xb73b98,0,0,800,480});
      own_frame=fp+0x400;control_frame=fp+0x500;manager_frame=fp+0x700;
      put(own_frame,control_frame);put(own_frame+8,0x4abe94);put(control_frame,manager_frame);put(control_frame+8,0x4e33bc);
      put(control_frame+0x48,live);put(control_frame+0x40,a(surface));value(control_frame+0xb8,Rectangle24{0xb73b98,10,20,800,460});value(control_frame+0xd0,Rectangle24{0xb73b98,0,0,800,480});
      put(manager_frame+0x28,manager);put(manager_frame+0x148,a(surface));put(manager_frame+0x150,live);put(manager+0x108,0x889900);
      paint={thread,own_frame,0x4abe94,live,a(surface),control_frame+0xb8,control_frame+0xd0};
    }
    Memory memory(){return {this,read};}
    geometry03::Result owner(Observation&out){return Probe(memory(),0).collect_owner(thread,live,out);}
    void slot(unsigned s=1){value(buffer+0xe8,std::uint32_t(s));value(buffer+0x50+8*s,std::array<std::int32_t,2>{1024,764});value(buffer+0x70+24*s,Rectangle24{0xb73b98,0,0,3200,2400});value(buffer+0xf4,std::uint32_t(17));}
};
}
