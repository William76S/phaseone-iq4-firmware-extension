bool free_placement(const Owner&o,iq4::f1::entry10::Placement&out)noexcept{
 Inspector p({nullptr,read_self},0);Rectangle24 bounds{};
 if(!p.read(o.lv+0x28,&bounds,sizeof bounds)||bounds.address_point!=0xb73b98||bounds.width<128||bounds.height<128||bounds.width>8192||bounds.height>8192)return false;
 struct Occupied {Rectangle24 r;};Occupied boxes[512]{};unsigned count=0;Address first{},node{},previous{};
 if(!p.word(o.lv+0x10,first))return false;node=first;Address seen[512]{};
 while(node){
  if(count==512||node<4096||(node&7))return false;for(unsigned i=0;i<count;++i)if(seen[i]==node)return false;seen[count]=node;
  Address parent{},prev{},next{};Rectangle24 r{};unsigned char visible{};
  if(!p.word(node+8,parent)||parent!=o.lv||!p.word(node+0x18,prev)||prev!=previous||!p.word(node+0x20,next)||!p.read(node+0x28,&r,sizeof r)||r.address_point!=0xb73b98||r.width<0||r.height<0||!p.read(node+0x6f,&visible,1)||visible>1)return false;
  boxes[count++].r=visible&&!iq4::f1::firmware_ui02::display_grid_without_click_target(p,o.lv,node)?r:Rectangle24{};previous=node;node=next;
 }
 Address again{};if(!p.word(o.lv+0x10,again)||again!=first)return false;
 for(int y=0;y<=bounds.height-128;y+=128)for(int x=0;x<=bounds.width-128;x+=128){
  bool vacant=true;for(unsigned i=0;i<count;++i){const auto&r=boxes[i].r;if(r.width>0&&r.height>0&&std::int64_t(r.x)<x+128&&std::int64_t(r.y)<y+128&&std::int64_t(r.x)+r.width>x&&std::int64_t(r.y)+r.height>y){vacant=false;break;}}
  if(vacant){out={x,y};return true;}
 }
 return false;
}
