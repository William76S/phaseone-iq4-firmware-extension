#pragma once
#include "../f1_native_ui_02/ui.hpp"

namespace iq4::f1::firmware_ui02 {
// Exact stock Grid subtree only. The inherited hit selector returns self in
// mode 0/1 only for flags +41/+42. Mode 2 remains a native target; no claim is
// made about all pointer modes. This classifier never changes Grid/ShowGrid.
inline bool display_grid_without_click_target(const native_ui02::Inspector&p,
 native_ui02::Address lv,native_ui02::Address node)noexcept{
 using native_ui02::Address;
 if(lv<4096||(lv&7)||node<4096||(node&7))return false;
 Address actual{},parent{},vt{},handler{},observer{};
 unsigned char click{},longpress{};
 if(!p.word(lv+0xd48,actual)||actual!=node||!p.word(node,vt)||vt!=0xba6540||
    !p.word(node+8,parent)||parent!=lv||!p.word(vt+0x140,handler)||handler!=0x4ac32c||
    !p.read(node+0x41,&click,1)||click||!p.read(node+0x42,&longpress,1)||longpress||
    !p.word(node+0x60,observer)||observer)return false;
 Address lines[5]{};
 for(unsigned i=0;i<5;++i){
  if(!p.word(node+0xa0+8*i,lines[i])||lines[i]<4096||(lines[i]&7)||lines[i]==node)return false;
  for(unsigned j=0;j<i;++j)if(lines[j]==lines[i])return false;
 }
 Address first{},child{},previous{};bool seen[5]{};
 if(!p.word(node+0x10,first))return false;child=first;
 for(unsigned n=0;n<5;++n){
  unsigned i=0;for(;i<5;++i)if(lines[i]==child)break;
  if(i==5||seen[i])return false;seen[i]=true;
  Address prev{},next{},descendant{};
  if(!p.word(child,vt)||vt!=0xba6880||!p.word(vt+0x140,handler)||handler!=0x4ac32c||
     !p.word(child+8,parent)||parent!=node||!p.word(child+0x18,prev)||prev!=previous||
     !p.word(child+0x20,next)||!p.word(child+0x10,descendant)||descendant||
     !p.read(child+0x41,&click,1)||click||!p.read(child+0x42,&longpress,1)||longpress||
     !p.word(child+0x60,observer)||observer)return false;
  previous=child;child=next;
 }
 Address again{};
 return child==0&&p.word(node+0x10,again)&&again==first&&p.word(lv+0xd48,actual)&&actual==node;
}
}
