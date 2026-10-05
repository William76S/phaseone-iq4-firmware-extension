#include "provider.hpp"
#include <cmath>
#include <cstring>
#include <limits>
namespace iq4::f1::normal09 {
namespace {
bool digest(const char*s)noexcept{if(!s||s[64])return false;bool any=false;for(unsigned i=0;i<64;i++){if(!((s[i]>='0'&&s[i]<='9')||(s[i]>='a'&&s[i]<='f')))return false;any|=s[i]!='0';}return any;}
bool jump(Address from,Address to,std::uint32_t&word)noexcept{
 if((from|to)&3||from>INT64_MAX||to>INT64_MAX)return false;const auto d=std::int64_t(to)-std::int64_t(from);if(d<-(1ll<<27)||d>=(1ll<<27))return false;word=0x14000000|(std::uint32_t(d/4)&0x3ffffff);return true;
}
bool rect(const Rectangle&r)noexcept{return r.address_point==0xb73b98&&r.width>0&&r.height>0&&r.width<=32768&&r.height<=32768;}
bool parent(Address fp,const Address(&pair)[2],Address return_pc)noexcept{return fp>=4096&&!(fp&15)&&pair[0]>fp&&!(pair[0]&15)&&pair[0]-fp<=65536&&pair[1]==return_pc;}
std::int32_t low(std::uint64_t n)noexcept{return std::int32_t(std::uint32_t(n));}
}
bool ProvenProviderAdapter::read(Address a,void*v,std::size_t n)const noexcept{return a>=4096&&n<=4096&&a<=UINTPTR_MAX-n&&memory_.read&&memory_.read(memory_.context,a,v,n);}
bool ProvenProviderAdapter::bind_observation_on_actual_ui(native_ui02::Memory memory,native_ui02::Native native,const native_ui02::Owner&o)noexcept{
 if(observing_||configured_||!memory.read||!native.current_thread||!o.queue||!o.lv||!o.manager||native.current_thread(native.context)!=o.queue)return false;
 memory_=memory;native_=native;contract_.owner=o;observing_=true;return true;
}
IngressResult ProvenProviderAdapter::sample_boundary_scalars_on_actual_ui()noexcept{
 status_.last={};
 if(!observing_||!ready_on_current_ui())return status_.result=IngressResult::WrongOwner;
 // Fresh current boundary candidates only; not a saved prior paint record.
 WriteFacts w{};w.queue=contract_.owner.queue;w.lv=contract_.owner.lv;status_.last=w;
 Address provider{},vt{},getter{},present{};
 if(!field(contract_.owner.manager+0x108,provider)||!field(provider,vt)||!field(vt+0x18,getter)||!field(vt+0x10,present))return status_.result=IngressResult::ReadFailed;
 w.provider=provider;w.provider_vtable=vt;w.getter_target=getter;w.present_target=present;
 if(read(getter,w.getter_words,24))w.getter_words_read=6;else if(read(getter,w.getter_words,8))w.getter_words_read=2;
 if(read(present,w.present_words,16))w.present_words_read=4;
 std::uint32_t add{};
 if(w.getter_words_read>=2&&w.getter_words[1]==0xd65f03c0)add=w.getter_words[0];
 else if(w.getter_words_read==6&&w.getter_words[0]==0xd10043ff&&w.getter_words[1]==0xf90007e0&&w.getter_words[2]==0xf94007e0&&w.getter_words[4]==0x910043ff&&w.getter_words[5]==0xd65f03c0)add=w.getter_words[3];
 status_.last=w;
 if((add&0xffc003ff)!=0x91000000)return status_.result=IngressResult::UnknownLease;
 const auto offset=(add>>10)&4095;if(offset&7||provider>UINTPTR_MAX-offset)return status_.result=IngressResult::UnknownLease;
 const Address surface=provider+offset;Address sv{},draw{},dv{};std::int32_t pitch{},height{};Rectangle bounds{};
 if(!field(surface,sv)||sv!=0xb7b780||!field(surface+8,draw)||!field(draw,dv)||dv!=0xb7b7d8||!field(surface+0x14,pitch)||!field(surface+0x18,height)||!read(surface+0x20,&bounds,24)||!rect(bounds)||bounds.x||bounds.y||bounds.width!=pitch||bounds.height!=height||pitch>4096||height>4096)return status_.result=IngressResult::ReadFailed;
 w.surface=surface;w.draw=draw;w.geometry.display_bounds={0,0,pitch,height};
 std::uint8_t animation{};
 if(!field(w.lv+0x190,w.geometry.scale)||!field(w.lv+0x194,w.geometry.normal_fit_scale)||!read(w.lv+0x118,&w.geometry.pan,sizeof w.geometry.pan)||!field(w.lv+0x1b0,w.geometry.rotation)||!field(w.lv+0x138,animation))return status_.result=IngressResult::ReadFailed;
 w.geometry.pan_animation=animation;
 status_.last=w;return status_.result=IngressResult::BoundaryObserved;
}
IngressResult ProvenProviderAdapter::observe_scaler_return_on_ui(const ScalerCapture&c)noexcept{
 status_.last={};
 if(!observing_||!ready_on_current_ui())return status_.result=IngressResult::Disabled;
 WriteFacts w{};const auto result=gather(c,w,false);++status_.normal_returns;status_.last=w;
 if(result==IngressResult::Emitted&&status_.serial!=UINT64_MAX){w.paint_serial=++status_.serial;w.geometry_epoch=status_.serial;status_.last=w;return status_.result=IngressResult::Observed;}
 return status_.result=result;
}
bool ProvenProviderAdapter::configure_on_actual_ui(native_ui02::Memory memory,native_ui02::Native native,const ActualProviderContract&c)noexcept{
 if(configured_||!memory.read||!native.current_thread||c.schema!=9||c.profile!=ProviderProfile::RootReviewedInlineUIRetainedUntilPresent||std::memcmp(c.actual_UserSHA,native_overlay::UserSHA,65)||!digest(c.owner_review_sha256)||!digest(c.hook_quiescence_receipt_sha256)||!c.owner.lv||!c.owner.manager||!c.owner.queue||native.current_thread(native.context)!=c.owner.queue||!c.provider||!c.provider_vtable||!c.getter||!c.present||!c.own_bridge||c.inline_surface_offset>4095||(c.inline_surface_offset&7))return false;
 std::uint32_t p{},b{};if(!jump(0x47f910,c.near_entry,p)||!jump(c.near_trampoline+4,0x47f914,b)||(c.near_entry<c.near_trampoline+8&&c.near_trampoline<c.near_entry+16))return false;
 ProvenProviderAdapter candidate;candidate.memory_=memory;candidate.native_=native;candidate.contract_=c;
 Address provider{},vt{},getter{},present{};
 if(!candidate.field(c.owner.manager+0x108,provider)||provider!=c.provider||!candidate.field(provider,vt)||vt!=c.provider_vtable||!candidate.field(vt+0x18,getter)||getter!=c.getter||!candidate.field(vt+0x10,present)||present!=c.present||!candidate.exact_inline_getter())return false;
 memory_=memory;native_=native;contract_=c;
 configured_=true;return true;
}
bool ProvenProviderAdapter::exact_inline_getter()const noexcept{
 const std::uint32_t add=0x91000000|(contract_.inline_surface_offset<<10);
 if(contract_.getter_shape==InlineGetterShape::LeafAddRet8){std::uint32_t body[2]{};return read(contract_.getter,body,8)&&body[0]==add&&body[1]==0xd65f03c0;}
 if(contract_.getter_shape==InlineGetterShape::OriginalO0StackAddRet24){const std::uint32_t wanted[6]={0xd10043ff,0xf90007e0,0xf94007e0,add,0x910043ff,0xd65f03c0};std::uint32_t body[6]{};return read(contract_.getter,body,24)&&!std::memcmp(body,wanted,24);}
 return false;
}
bool ProvenProviderAdapter::exact_patch_route()const noexcept{
 std::uint32_t expected{},back{},entry{},trampoline[2]{},veneer[2]{};Address own{};
 return jump(0x47f910,contract_.near_entry,expected)&&jump(contract_.near_trampoline+4,0x47f914,back)&&field(0x47f910,entry)&&entry==expected&&read(contract_.near_trampoline,trampoline,8)&&trampoline[0]==0xd10403ff&&trampoline[1]==back&&read(contract_.near_entry,veneer,8)&&veneer[0]==0x58000050&&veneer[1]==0xd61f0200&&field(contract_.near_entry+8,own)&&own==contract_.own_bridge;
}
bool ProvenProviderAdapter::provider_lease(Address surface)const noexcept{
 Address p{},vt{},get{},present{};
 return contract_.profile==ProviderProfile::RootReviewedInlineUIRetainedUntilPresent&&field(contract_.owner.manager+0x108,p)&&p==contract_.provider&&p<=UINTPTR_MAX-contract_.inline_surface_offset&&surface==p+contract_.inline_surface_offset&&field(p,vt)&&vt==contract_.provider_vtable&&field(vt+0x18,get)&&get==contract_.getter&&field(vt+0x10,present)&&present==contract_.present&&exact_inline_getter();
}
IngressResult ProvenProviderAdapter::gather(const ScalerCapture&c,WriteFacts&w,bool require_lease)const noexcept{
 // Only the fully saved RGB24/zero-rotation native row path is closed here.
 // Other call sites/rotation helpers cannot borrow this positive receipt.
 if(c.original_lr!=0x475908)return IngressResult::UnsupportedCall;
 if(low(c.arguments[1])||low(c.arguments[3])!=2||low(c.arguments[5])!=0)return IngressResult::UnsupportedFormat;
 const int sw=low(c.arguments[6]),sh=low(c.arguments[7]),dw=low(c.stack_arguments[1]),dh=low(c.stack_arguments[2]);
 if(sw<=0||sh<=0||dw<=0||dh<=0)return IngressResult::NoWrite;
 if(sw>32768||sh>32768||dw>4096||dh>4096)return IngressResult::InvalidGeometry;
 Address p[2]{},q[2]{},r[2]{},s[2]{};
 if(!read(c.original_fp,p,16)||!parent(c.original_fp,p,0x47718c)||!read(p[0],q,16)||!parent(p[0],q,0x51ddd0)||!read(q[0],r,16)||!parent(q[0],r,0x4abe94)||!read(r[0],s,16)||!parent(r[0],s,0x4e33bc))return IngressResult::ScopeMismatch;
 const Address helper=c.original_fp,lv_frame=q[0],control_frame=r[0],manager_frame=s[0];
 Address lv{},surface{},manager{},manager_surface{},manager_lv{},control_lv{},control_surface{},helper_surface{},bitmap{},source_rect{};
 if(!field(lv_frame+0x38,lv)||!field(lv_frame+0x30,surface)||!field(control_frame+0x48,control_lv)||!field(control_frame+0x40,control_surface)||!field(manager_frame+0x28,manager)||!field(manager_frame+0x148,manager_surface)||!field(manager_frame+0x150,manager_lv)||!field(helper+0x58,helper_surface)||!field(helper+0x30,bitmap)||!field(helper+0x40,source_rect))return IngressResult::ReadFailed;
 if(lv!=contract_.owner.lv||manager!=contract_.owner.manager||control_lv!=lv||manager_lv!=lv||!surface||surface!=control_surface||surface!=manager_surface||surface!=helper_surface)return IngressResult::ScopeMismatch;
 Address queue{},draw{},draw_vt{},row{};if(!field(c.thread_pointer+0x10,queue)||queue!=contract_.owner.queue||!field(surface+8,draw)||draw!=c.arguments[0]||!field(draw,draw_vt)||draw_vt!=0xb7b7d8||!field(draw_vt+0x18,row)||row!=0x47e9d0)return IngressResult::WrongOwner;
 Rectangle full{},clipped{},bounds{};std::int32_t bm[4]{},x{},y{},pitch{},height{},rotation{};float scale{},normal{};geometry03::Point8 pan{};std::uint8_t animation{},running{},visible{};std::uint32_t countdown{};
 if(!read(bitmap,bm,16)||!read(source_rect,&full,24)||!read(helper+0x68,&clipped,24)||!field(helper+0x54,x)||!field(helper+0x50,y)||!field(surface+0x14,pitch)||!field(surface+0x18,height)||!read(surface+0x20,&bounds,24)||!field(lv+0x190,scale)||!field(lv+0x194,normal)||!read(lv+0x118,&pan,sizeof pan)||!field(lv+0x138,animation)||!field(lv+0x1b0,rotation)||!field(lv+0x1b8,countdown)||!field(lv+0x104,running)||!field(lv+0x6f,visible))return IngressResult::ReadFailed;
 if(bm[0]!=0||bm[1]<=0||bm[2]<=0||bm[1]>32768||bm[2]>32768||bm[3]<=0||bm[3]<bm[1]*3||low(c.stack_arguments[0])!=bm[3]||low(c.stack_arguments[3])!=pitch*4)return IngressResult::UnsupportedFormat;
 if(!rect(full)||!rect(clipped)||full.x||full.y||full.width!=bm[1]||full.height!=bm[2]||clipped.x<0||clipped.y<0||clipped.width!=sw||clipped.height!=sh||std::int64_t(clipped.x)+sw>bm[1]||std::int64_t(clipped.y)+sh>bm[2])return IngressResult::PartialSource;
 Rectangle roi{};std::int32_t captured_size[2]{},cw{},ch{};Address access{},data_access{},access_vt{},engine{};
 if(!read(lv_frame+0xa0,&roi,24)||!read(lv_frame+0xb8,captured_size,8)||!field(lv+0x108,access)||!field(contract_.owner.data+0x118,data_access)||access!=data_access||!field(access,access_vt)||access_vt!=0xc07da8||!field(access+8,engine)||!field(engine+0x4764,cw)||!field(engine+0x4768,ch))return IngressResult::ReadFailed;
 if(!rect(roi)||roi.x||roi.y||roi.width!=bm[1]||roi.height!=bm[2]||captured_size[0]!=bm[1]||captured_size[1]!=bm[2]||cw!=bm[1]||ch!=bm[2])return IngressResult::PartialSource;
 if(!running||!visible||rotation||countdown||!std::isfinite(scale)||!std::isfinite(normal)||scale<=0||normal<=0||!rect(bounds)||bounds.x||bounds.y||bounds.width!=pitch||bounds.height!=height||pitch<=0||height<=0||pitch>4096||height>4096||x<0||y<0||std::int64_t(x)+dw>pitch||std::int64_t(y)+dh>height)return IngressResult::InvalidGeometry;
 // Original helper SP+7c = FP+4c holds the exact fit scale used to compute
 // destination rows. Compare actual conversion, not an LV return rectangle.
 float used{};if(!field(helper+0x4c,used)||!std::isfinite(used)||used<=0||float(sw)*used>4096||float(sh)*used>4096||int(float(sw)*used)!=dw||int(float(sh)*used)!=dh)return IngressResult::InvalidGeometry;
 Address clip_pointer{};Rectangle clip{};if(!field(helper+0x38,clip_pointer)||!read(clip_pointer,&clip,24)||!rect(clip))return IngressResult::ReadFailed;
 Address provider{},vt{},getter{},present{};if(!field(manager+0x108,provider)||!field(provider,vt)||!field(vt+0x18,getter)||!field(vt+0x10,present))return IngressResult::ReadFailed;
 if(require_lease&&!provider_lease(surface))return IngressResult::UnknownLease;
 w.queue=queue;w.lv=lv;w.surface=surface;w.draw=draw;w.provider=provider;w.provider_vtable=vt;w.getter_target=getter;w.manager_frame=manager_frame;
 auto&g=w.geometry;g.source_width=bm[1];g.source_height=bm[2];g.source_rectangle={full.x,full.y,full.width,full.height};g.clipped_source_rectangle={clipped.x,clipped.y,clipped.width,clipped.height};g.image_viewport={x,y,dw,dh};g.display_bounds={0,0,pitch,height};g.clip={clip.x,clip.y,clip.width,clip.height};g.scale=scale;g.normal_fit_scale=normal;g.pan=pan;g.pan_animation=animation;g.rotation=rotation;
 w.stock_clean_coverage=g.image_viewport;
 g.config_width=cw;g.config_height=ch;g.captured_slot_width=captured_size[0];g.captured_slot_height=captured_size[1];g.original_locked_roi={roi.x,roi.y,roi.width,roi.height};
 w.present_target=present;if(read(getter,w.getter_words,sizeof w.getter_words))w.getter_words_read=6;else if(read(getter,w.getter_words,8))w.getter_words_read=2;
 if(read(present,w.present_words,sizeof w.present_words))w.present_words_read=4;
 return IngressResult::Emitted;
}
IngressResult ProvenProviderAdapter::dispatch_scaler_return_on_ui(const ScalerCapture&c,Renderer&r)noexcept{
 status_.last={};
 auto finish=[this](IngressResult v){status_.result=v;return v;};
 if(!configured_)return finish(IngressResult::Disabled);
 if(native_.current_thread(native_.context)!=contract_.owner.queue)return finish(IngressResult::WrongOwner);
 if(!exact_patch_route())return finish(IngressResult::PatchMismatch);
 if(status_.serial==UINT64_MAX)return finish(IngressResult::RendererRejected);
 ++status_.normal_returns;WriteFacts w{};const auto result=gather(c,w,true);if(result!=IngressResult::Emitted)return finish(result);
 w.paint_serial=++status_.serial;w.geometry_epoch=status_.serial;status_.last=w;
 // Positive issuer is tied to an actual native return + complete call/row
 // branch and the separately Root-reviewed current inline provider lease.
 const PaintToken token(w);if(!r.after_native_write_on_ui(token))return finish(IngressResult::RendererRejected);++status_.emitted;return finish(IngressResult::Emitted);
}
}
