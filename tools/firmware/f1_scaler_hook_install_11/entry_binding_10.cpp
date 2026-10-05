#include "entry_binding_10.hpp"
#include "../f1_display_observe_06/native_layout.hpp"
#include <cstring>
#include <limits>
namespace iq4::f1::entry10 {
namespace {
constexpr unsigned OwnTag=0x463110;
constexpr const char* Names[6]={"IQ4 F1 10 Off","IQ4 F1 10 XPan","IQ4 F1 10 16:9","IQ4 F1 10 3:2","IQ4 F1 10 1:1","IQ4 F1 10 private Open"};
constexpr const char* Labels[5]={"Off / native","XPan 65:24","16:9","3:2","1:1"};
constexpr MaskMode Modes[5]={MaskMode::Off,MaskMode::XPan65_24,MaskMode::Ratio16_9,MaskMode::Ratio3_2,MaskMode::Ratio1_1};
constexpr char ButtonLabel[]="F1 mask",ObserverName[]="IQ4 F1 10 private UI";
bool overlaps(const Rectangle24&a,std::int32_t x,std::int32_t y)noexcept{return a.width>0&&a.height>0&&std::int64_t(a.x)<std::int64_t(x)+128&&std::int64_t(a.y)<std::int64_t(y)+128&&std::int64_t(a.x)+a.width>x&&std::int64_t(a.y)+a.height>y;}
bool contains(native_overlay::PixelRect a,native_overlay::PixelRect b)noexcept{return a.width>0&&a.height>0&&b.width>0&&b.height>0&&a.x<=b.x&&a.y<=b.y&&std::int64_t(a.x)+a.width>=std::int64_t(b.x)+b.width&&std::int64_t(a.y)+a.height>=std::int64_t(b.y)+b.height;}
}
Binding::Binding()noexcept:control_table_{0,nullptr,control_destroy,control_destroy,control_notify},queue_table_{0,nullptr,queue_destroy,queue_destroy,queue_notify}{for(unsigned i=0;i<5;i++)std::strncpy(labels_[i].data(),Labels[i],32);}
bool Binding::on_ui()const noexcept{return configured_&&native_.current_thread&&native_.current_thread(native_.context)==owner_.queue;}
bool Binding::resource()const noexcept{
 Inspector p(memory_,0);Address a{},b{},v{};return p.word(owner_.manager+0x788,a)&&a>=4096&&p.word(owner_.lv+0xf0,b)&&a==b&&p.word(a+0x10,v)&&v==resource_&&p.word(v,b)&&b>=0x400000&&b<0xf31752;
}
bool Binding::current(bool popup)const noexcept{
 if(!on_ui()||!actual_owner())return false;Inspector p(memory_,0);
 Address v{},first{},last{};std::uint8_t aux{};if(!p.word(owner_.manager+0xc8,v)||v||!p.word(owner_.manager+0xd8,v)||v||!p.read(owner_.manager+0xe0,&aux,1)||aux)return false;
 for(Address list:{owner_.manager+0x40,owner_.manager+0x68})if(!p.word(list,v)||v!=0xb8f4e8||!p.word(list+8,v)||v!=0xc22908||!p.word(list+16,v)||v!=0xc22960)return false;
 Address normal=owner_.manager+0x78,priority=owner_.manager+0x50;if(!p.word(priority+8,v)||v!=priority||!p.word(priority+16,v)||v!=priority||!p.word(normal+8,first)||!p.word(normal+16,last))return false;
 Address dialogs[3]={home_,owner_.lv,own_popup()},previous=normal;unsigned begin=home_?0:1,end=popup?3:2;
 for(unsigned i=begin;i<end;i++){
  Address next{},prev{},dialog{},manager{};const Address node=dialogs[i]+0x88;const Address vt=i==0?0xb951f0:i==1?0xb9abf8:0xb933e0;
  if(first!=node||!p.word(node,v)||v!=vt||!p.word(node+8,next)||!p.word(node+16,prev)||prev!=previous||!p.word(node+24,dialog)||dialog!=dialogs[i]||!p.word(dialog+0xb0,manager)||manager!=owner_.manager)return false;
  previous=node;first=next;
 }
 return first==normal&&previous==last&&stock_popup_unchanged();
}
bool Binding::actual_owner()const noexcept{
 Inspector p(memory_,0);Address v{};
 for(auto check:std::array<std::array<Address,2>,10>{{{owner_.queue,0xb91f48},{owner_.queue+0x1c8,owner_.manager},{owner_.manager,0xb8f358},{owner_.manager+8,owner_.queue},{owner_.queue+0x9b8,owner_.data},{owner_.manager+0x790,owner_.data},{owner_.queue+0x8c0,owner_.lv},{owner_.lv+0xb0,owner_.manager},{owner_.popup,0xb931b0},{owner_.popup+0xb0,owner_.manager}}})if(!p.word(check[0],v)||v!=check[1])return false;
 if(!p.word(owner_.popup+0x128,v)||v!=0xb90020||!p.word(owner_.lv,v))return false;
 if(v==0xb9a9d8)return true;
 if(!display_||v!=display_->shadow_address_point())return false;
 const auto meta=display_->snapshot();if(meta.owner_before.owner.lv!=owner_.lv||meta.own_shadow_address_point!=v||!meta.own_paint_callback)return false;
 for(unsigned i=0;i<display06::OriginalLVTable.size();i++){
  const Address expected=i==display06::PaintWord?meta.own_paint_callback:display06::OriginalLVTable[i];Address actual{};if(!p.word(v-16+8*i,actual)||actual!=expected)return false;
 }
 return true;
}
bool Binding::boundary_matches(const BoundaryInput&in,Address&popped)const noexcept{
 Inspector p(memory_,0);Address q{};if(in.original_result||in.caller_pc!=0x6be8ac||!p.word(in.thread_pointer+0x10,q)||q!=owner_.queue||in.mutex!=q+0xf8||!actual_owner())return false;
 Address fp=in.frame_pointer,start=fp;
 for(unsigned n=0;n<24;n++){
  Address pair[2]{};if(!p.read(fp,pair,16)||pair[0]<=fp||(pair[0]&7)||pair[0]-fp>65536||pair[0]-start>1048576)return false;
  if(pair[1]==0x71396c){
   Address pop=pair[0],a[2]{},b[2]{},v{},listener{};if(!p.read(pop,a,16)||a[1]!=0x70ff9c||a[0]<=pop||(a[0]&7)||a[0]-pop>65536||a[0]-start>1048576||!p.read(a[0],b,16)||b[1]!=0x4ef984||!p.word(pop+0x28,v)||v!=q||!p.word(a[0]+0x18,v)||v!=q||!p.word(pop+0x68,listener)||listener<4096||!p.word(listener+0x40,popped)||popped<4096)return false;return true;
  }fp=pair[0];
 }return false;
}
bool Binding::stock_popup_unchanged()const noexcept{
 Inspector p(memory_,0);std::array<unsigned char,0x18>a{};std::array<unsigned char,0x58>b{};const Address n=owner_.popup+0x128;
 return p.read(n,a.data(),a.size())&&p.read(n+0x300,b.data(),b.size())&&a==stock_menu_head_&&b==stock_menu_stack_;
}
bool Binding::free_placement()const noexcept{
 Inspector p(memory_,0);Rectangle24 bounds{};if(!p.read(owner_.lv+0x28,&bounds,sizeof bounds)||bounds.address_point!=0xb73b98||placement_.x<0||placement_.y<0||std::int64_t(placement_.x)+128>bounds.width||std::int64_t(placement_.y)+128>bounds.height)return false;
 Address first{},node{},previous{};if(!p.word(owner_.lv+0x10,first))return false;node=first;std::array<Address,512>seen{};unsigned count=0;
 while(node){
  if(count==seen.size()||node==own_button()||node<4096||(node&7))return false;for(unsigned i=0;i<count;i++)if(seen[i]==node)return false;seen[count++]=node;
  Address parent{},prev{},next{};Rectangle24 r{};std::uint8_t visible{};
  if(!p.word(node+8,parent)||parent!=owner_.lv||!p.word(node+0x18,prev)||prev!=previous||!p.word(node+0x20,next)||!p.read(node+0x28,&r,sizeof r)||r.address_point!=0xb73b98||r.width<0||r.height<0||!p.read(node+0x6f,&visible,1)||visible>1)return false;
  if(visible&&overlaps(r,placement_.x,placement_.y))return false;previous=node;node=next;
 }
 Address again{};return p.word(owner_.lv+0x10,again)&&again==first;
}
bool Binding::bind_on_actual_boundary(Memory memory,entry01::Module&m,const BoundaryInput&in,Admission permit,Placement placement,Selection selection,const display06::Collector*display,Synchronization sync)noexcept{
 if(configured_||!permit.native_object_construction_reviewed||!permit.registry_quiescence_held||!permit.retain_until_User_exit||!permit.RAM_restore_route_held||!sync.try_lock||!sync.original_unlock)return false;
 entry01::Observation observed{};Boundary b{};Inspector p(memory,0);
 if(!m.snapshot(observed)||!observed.qualified_boundaries||observed.caller_pc!=in.caller_pc||observed.frame_pointer!=in.frame_pointer||observed.thread_pointer!=in.thread_pointer||observed.mutex!=in.mutex||!p.boundary(in,b)||b.owner.queue!=observed.queue||b.owner.lv!=observed.lv||in.original_result)return false;
 auto n=m.selector_ports();auto ports=m.button_ports();if(!n.current_thread||!n.inspect_triple||!n.invalidate||n.current_thread(n.context)!=b.owner.queue||!ports.text_button_ctor||!ports.own_popup_ctor||!ports.control_observer_ctor||!ports.queue_observer_ctor||!ports.event_ctor||!ports.subscribe||!ports.unsubscribe||!ports.notify||!ports.control_bind||!ports.control_attach||!ports.control_detach||!ports.set_menu||!ports.show||!ports.close||!ports.submenu_ctor||!ports.item_ctor||!ports.append_item)return false;
 memory_=memory;module_=&m;display_=display;native_=n;ports_=ports;owner_=b.owner;placement_=placement;selection_=selection;
 entry01::StackFacts stack{};if(!entry01::observe_stack(memory_,0,owner_,stack)||!stack.priority_empty||!stack.lv_at_tail||!(stack.normal_count==1||stack.normal_count==2))return false;
 if(stack.normal_count==2){Address vt{};if(stack.node_vtables[0]!=0xb951f0||!p.word(stack.dialogs[0],vt)||vt!=0xb94fd8)return false;home_=stack.dialogs[0];}
 Address wrapper{},lvwrapper{},provider{},controlrtti{},queuertti{};
 if(!p.word(owner_.manager+0x788,wrapper)||!p.word(owner_.lv+0xf0,lvwrapper)||wrapper!=lvwrapper||!p.word(wrapper+0x10,provider)||provider<4096||!p.word(entry_ports01::ControlObserverVT-8,controlrtti)||!p.word(entry_ports01::QueueObserverVT-8,queuertti)||!p.popup_title(owner_,title_)||!p.read(owner_.popup+0x128,stock_menu_head_.data(),stock_menu_head_.size())||!p.read(owner_.popup+0x128+0x300,stock_menu_stack_.data(),stock_menu_stack_.size()))return false;
 resource_=provider;control_table_.rtti=reinterpret_cast<void*>(controlrtti);queue_table_.rtti=reinterpret_cast<void*>(queuertti);configured_=true;
 iq4::f4::bootstrap::Native listener_native{};listener_native.try_lock=sync.try_lock;listener_native.unlock=sync.original_unlock;
 if(!listener_inspector_.configure({memory_.context,memory_.read},listener_native,{false,true,true,true,0})){configured_=false;return false;}
 // Persistent UI ports have their own validated TLS/listener inspector.
 // Frozen Module's 64-observation cap cannot disable or strand this UI.
 native_.context=this;native_.current_thread=native_current;native_.inspect_triple=native_triple;
 if(!current(false)||!resource()||!free_placement()){configured_=false;return false;}status_.phase=static_cast<unsigned>(Phase::Bound);return true;
}
Address Binding::native_current(void*c)noexcept{
 auto&b=*static_cast<Binding*>(c);if(!b.configured_||!b.ports_.current_thread||b.status_.phase==static_cast<unsigned>(Phase::Hold)||b.status_.phase==static_cast<unsigned>(Phase::DetachedRetained))return 0;try{return reinterpret_cast<Address>(b.ports_.current_thread());}catch(...){return 0;}
}
Triple Binding::native_triple(void*c,Address q,Address e,const Observer*o)noexcept{
 auto&b=*static_cast<Binding*>(c);if(q!=b.owner_.queue||native_current(c)!=q)return Triple::Unknown;
 const auto r=b.listener_inspector_.inspect(q,e,reinterpret_cast<const iq4::f4::ui_counter::Observer*>(o));
 return r==iq4::f4::ui_counter::Triple::Present?Triple::Present:r==iq4::f4::ui_counter::Triple::Absent?Triple::Absent:Triple::Unknown;
}
bool Binding::triples(Triple expected)const noexcept{for(unsigned i=0;i<registered_;i++)if(native_.inspect_triple(native_.context,owner_.queue,own_event(i),&queue_)!=expected)return false;return true;}
bool Binding::own_menu(Address root)const noexcept{
 Inspector p(memory_,0);Address n=own_popup()+0x128,v{};std::uint32_t depth{};
 if(!p.word(own_popup(),v)||v!=entry_ports01::PopupVT||!p.word(own_popup()+0xb0,v)||v!=owner_.manager||!p.word(n,v)||v!=0xb90020||!p.word(n+0x18,v)||v!=root||!p.word(n+0x300,v)||v||!p.read(n+0x348,&depth,4)||depth||!p.word(n+0x308,v)||v!=root)return false;
 for(unsigned i=1;i<8;i++)if(!p.word(n+0x308+8*i,v)||v)return false;return true;
}
bool Binding::button_bound(bool bound)const noexcept{
 Inspector p(memory_,0);Address v{};std::uint32_t tag{};return p.word(own_button(),v)&&v==entry_ports01::TextButtonVT&&p.word(own_button()+0x60,v)&&v==(bound?reinterpret_cast<Address>(&control_):0)&&p.read(own_button()+0x68,&tag,4)&&tag==(bound?OwnTag:0);
}
bool Binding::check_items()const noexcept{
 Inspector p(memory_,0);Address v{},first{},last{},prior=own_root()+0x28;std::uint32_t title{};
 if(!p.word(own_root(),v)||v!=0xb8f9b8||!p.read(own_root()+0x14,&title,4)||title!=title_||!p.word(own_root()+0x18,v)||v!=0xb8faa0||!p.word(own_root()+0x20,v)||v!=0xc22908||!p.word(prior,v)||v!=0xc22960||!p.word(prior+8,first)||!p.word(prior+16,last))return false;
 for(unsigned i=0;i<5;i++){
  const Address item=reinterpret_cast<Address>(items_[i].data());std::uint32_t id{};
  if(!p.word(item,v)||v!=0xb90748||!p.read(item+0x14,&id,4)||id!=UINT32_MAX||!p.word(item+0x18,v)||v!=own_event(i)||!p.word(item+0x20,v)||v||!p.word(item+0x30,v)||v!=reinterpret_cast<Address>(labels_[i].data()))return false;
  Address next{},prev{},actual{};if(!p.word(first,v)||v!=0xb8f958||!p.word(first+8,next)||!p.word(first+16,prev)||prev!=prior||!p.word(first+24,actual)||actual!=item)return false;prior=first;first=next;
 }return first==own_root()+0x28&&prior==last;
}
bool Binding::build_on_ui()noexcept{
 if(!configured_||status_.phase!=static_cast<unsigned>(Phase::Bound)||!current(false)||!resource()||!free_placement())return false;status_.phase=static_cast<unsigned>(Phase::Building);status_.ui_mutation_attempted=1;Inspector p(memory_,0);Address v{};
 try{
  ports_.control_observer_ctor(&control_.native);if(control_.native.address_point!=reinterpret_cast<void*>(entry_ports01::ControlObserverVT)){hold();return false;}control_.extension=this;control_.native.address_point=&control_table_.destroy;
  ports_.queue_observer_ctor(reinterpret_cast<entry_ports01::QueueObserverNative*>(&queue_),ObserverName,reinterpret_cast<void*>(owner_.queue));if(queue_.queue!=reinterpret_cast<void*>(owner_.queue)||queue_.name!=ObserverName){hold();return false;}queue_.extension=this;queue_.address_point=&queue_table_.destroy;
  ports_.submenu_ctor(root_.data(),title_,nullptr,nullptr);
  for(unsigned i=0;i<6;i++){
   ports_.event_ctor(events_[i].data(),Names[i]);if(!p.word(own_event(i),v)||v!=0xc237a0||native_.inspect_triple(native_.context,owner_.queue,own_event(i),&queue_)!=Triple::Absent){hold();return false;}
   ++registered_;ports_.subscribe(reinterpret_cast<entry_ports01::QueueObserverNative*>(&queue_),events_[i].data());if(!triples(Triple::Present)){hold();return false;}
   if(i<5){ports_.item_ctor(items_[i].data(),UINT32_MAX,events_[i].data(),nullptr);const char*label=labels_[i].data();std::memcpy(items_[i].data()+0x30,&label,8);ports_.append_item(root_.data(),items_[i].data());}
  }
  // Separate native selector has a null constructor root, with its own
  // navigator and subscriptions. The embedded stock selector is untouched.
  ports_.own_popup_ctor(popup_.data(),reinterpret_cast<void*>(owner_.manager),nullptr,750,1);
  if(!own_menu(0)||!check_items()){hold();return false;}
  // Original Play caller's retained 128x128/font5/0/1/stack1 numeric ABI.
  ports_.text_button_ctor(button_.data(),128,128,reinterpret_cast<void*>(resource_),5,ButtonLabel,0,1,1);
  if(!p.word(own_button(),v)||v!=entry_ports01::TextButtonVT){hold();return false;}
  ports_.control_bind(button_.data(),&control_.native,OwnTag);if(!button_bound(true)){hold();return false;}
  ports_.control_attach(reinterpret_cast<void*>(owner_.lv),button_.data(),placement_.x,placement_.y,1,1);
 }catch(...){hold();return false;}
 Address parent{};if(!p.word(own_button()+8,parent)||parent!=owner_.lv||!current(false)||!resource()||!triples(Triple::Present)||!stock_popup_unchanged()){hold();return false;}
 status_.phase=static_cast<unsigned>(Phase::Ready);return true;
}
bool Binding::install_selection_once_on_ui(Selection selection)noexcept{
 if(!selection.apply_on_ui||selection_.apply_on_ui||!current(false)||status_.phase!=static_cast<unsigned>(Phase::Ready)||callback_depth_||open_pending_||status_.selected!=MaskMode::Off||!status_.stock_paint_restored)return false;
 selection_=selection;return true;
}
void Binding::control_notification(void*sender,const void*event,std::uint32_t tag)noexcept{
 ++callback_depth_;++status_.callbacks;std::uint32_t kind{};
 if(status_.phase!=static_cast<unsigned>(Phase::Ready)||reinterpret_cast<Address>(sender)!=own_button()||tag!=OwnTag||!event||!current(false)||!button_bound(true)||!triples(Triple::Present)||!Inspector(memory_,0).read(reinterpret_cast<Address>(event),&kind,4)||kind!=1||open_pending_){++status_.rejected;--callback_depth_;return;}
 // Only kind1 scalar is copied. Borrowed input pointer is never queued.
 open_pending_=true;++status_.open_requests;try{ports_.notify(events_[5].data());}catch(...){hold();}--callback_depth_;
}
bool Binding::close_private()noexcept{
 try{if(current(true))ports_.close(popup_.data());if(!current(false)){hold();return false;}ports_.set_menu(popup_.data(),nullptr);}catch(...){hold();return false;}
 if(!own_menu(0)||native_.inspect_triple(native_.context,owner_.queue,own_root()+0x60,reinterpret_cast<const Observer*>(own_popup()+0x128))!=Triple::Absent||!stock_popup_unchanged()){hold();return false;}return true;
}
void Binding::queue_notification(void*event)noexcept{
 ++callback_depth_;++status_.callbacks;unsigned i=0;for(;i<6;i++)if(reinterpret_cast<Address>(event)==own_event(i))break;
 if(i==6||!on_ui()||!triples(Triple::Present)){++status_.rejected;--callback_depth_;return;}
 if(i==5){
  if(!open_pending_||status_.phase!=static_cast<unsigned>(Phase::Ready)||!current(false)||!own_menu(0)||!check_items()){++status_.rejected;--callback_depth_;return;}
  open_pending_=false;status_.phase=static_cast<unsigned>(Phase::Open);
  try{ports_.set_menu(popup_.data(),root_.data());if(!own_menu(own_root())||native_.inspect_triple(native_.context,owner_.queue,own_root()+0x60,reinterpret_cast<const Observer*>(own_popup()+0x128))!=Triple::Present){hold();--callback_depth_;return;}ports_.show(popup_.data());}catch(...){hold();--callback_depth_;return;}
  if(!current(true))hold();--callback_depth_;return;
 }
 if(status_.phase!=static_cast<unsigned>(Phase::Open)||!current(true)||status_.generation==UINT64_MAX){++status_.rejected;--callback_depth_;return;}
 if(!selection_.apply_on_ui&&i!=0){++status_.rejected;--callback_depth_;return;}
 if(!close_private()){--callback_depth_;return;}++status_.generation;
 const auto applied=selection_.apply_on_ui?selection_.apply_on_ui(selection_.context,Modes[i],status_.generation):SelectResult::AlreadyOff;
 if(applied==SelectResult::Rejected){++status_.rejected;status_.phase=static_cast<unsigned>(Phase::Ready);--callback_depth_;return;}
 if(applied==SelectResult::AlreadyOff&&i!=0){hold();--callback_depth_;return;}
 status_.selected=Modes[i];++status_.selections;
 // No success value certifies new sensor frames or a completed image write.
 status_.stock_paint_restored=applied==SelectResult::AlreadyOff;
 status_.phase=static_cast<unsigned>(applied==SelectResult::AlreadyOff?Phase::Ready:Phase::AwaitingStockPaint);--callback_depth_;
}
void Binding::control_notify(ControlObserver*o,void*s,const void*e,std::uint32_t t)noexcept{if(o&&o->extension)static_cast<Binding*>(o->extension)->control_notification(s,e,t);}
void Binding::control_destroy(ControlObserver*o)noexcept{if(o&&o->extension)static_cast<Binding*>(o->extension)->hold();}
void Binding::queue_notify(Observer*o,void*e)noexcept{if(o&&o->extension)static_cast<Binding*>(o->extension)->queue_notification(e);}
void Binding::queue_destroy(Observer*o)noexcept{if(o&&o->extension)static_cast<Binding*>(o->extension)->hold();}
bool Binding::cancel_on_ui()noexcept{if(status_.phase!=static_cast<unsigned>(Phase::Open)||!on_ui()||!close_private())return false;status_.phase=static_cast<unsigned>(Phase::Ready);return true;}
bool Binding::observe_stock_paint_on_ui(const PaintReceipt&r)noexcept{
 if(status_.phase!=static_cast<unsigned>(Phase::AwaitingStockPaint)||!current(false)||r.lv!=owner_.lv||!r.surface||r.request_generation!=status_.generation||!r.ui_paint_serial||r.ui_paint_serial<=last_paint_)return false;
 if(!r.original_returned_normally||!r.display_lease_live){hold();return false;}if(!r.native_image_blit_completed||!contains(r.actual_stock_coverage,r.image_viewport))return false;
 last_paint_=r.ui_paint_serial;status_.stock_paint_restored=status_.selected==MaskMode::Off;status_.phase=static_cast<unsigned>(Phase::Ready);return true;
}
bool Binding::detach_on_ui(std::uint64_t epoch)noexcept{
 if(status_.phase!=static_cast<unsigned>(Phase::Ready)||!current(false)||callback_depth_||open_pending_||!epoch||status_.selected!=MaskMode::Off||!status_.stock_paint_restored||!triples(Triple::Present))return false;
 status_.phase=static_cast<unsigned>(Phase::Detaching);status_.detach_epoch=epoch;
 try{ports_.control_bind(button_.data(),nullptr,0);if(!button_bound(false)){hold();return false;}ports_.control_detach(button_.data());for(unsigned i=0;i<registered_;i++)ports_.unsubscribe(reinterpret_cast<entry_ports01::QueueObserverNative*>(&queue_),events_[i].data());}catch(...){hold();return false;}
 if(!triples(Triple::Absent)){hold();return false;}return true;
}
bool Binding::after_actual_boundary(const BoundaryInput&in,std::uint64_t epoch)noexcept{
 if(!configured_||!on_ui())return false;Address popped{};if(!boundary_matches(in,popped))return false;
 if(status_.phase==static_cast<unsigned>(Phase::Bound))return build_on_ui();
 if(status_.phase==static_cast<unsigned>(Phase::Open)&&current(false))return cancel_on_ui();
 if(status_.phase!=static_cast<unsigned>(Phase::Detaching)||epoch<=status_.detach_epoch||callback_depth_||popped==reinterpret_cast<Address>(&queue_)||!current(false)||!triples(Triple::Absent)||!own_menu(0))return false;
 // Native Detach retains +8 Parent. Require unreachable from real sibling
 // traversal instead of inventing parent-null or permission to delete.
 Inspector p(memory_,0);Address node{};if(!p.word(owner_.lv+0x10,node))return false;unsigned n=0;while(node){if(node==own_button()||++n>512||!p.word(node+0x20,node))return false;}
 status_.phase=static_cast<unsigned>(Phase::DetachedRetained);return true;
}
}
