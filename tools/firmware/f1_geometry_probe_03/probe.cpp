#include "probe.hpp"
#include <cmath>
#include <cstring>
#include <limits>

namespace iq4::f1::geometry03 {
namespace {
bool addr(Address base,std::size_t off,Address&out)noexcept {if(!base||base>std::numeric_limits<Address>::max()-off)return false;out=base+off;return true;}
bool read(Memory m,Address a,void*p,std::size_t n)noexcept {return m.read&&a&&p&&n&&n<=4096&&a<=std::numeric_limits<Address>::max()-n&&m.read(m.context,a,p,n);}
template<class T>bool get(Memory m,Address base,std::size_t off,T&v)noexcept {Address a;return addr(base,off,a)&&read(m,a,&v,sizeof(v));}
bool i32(std::int64_t v,std::int32_t&out)noexcept {if(v<INT32_MIN||v>INT32_MAX)return false;out=static_cast<std::int32_t>(v);return true;}
bool positive(const Rectangle24&r)noexcept {return r.width>0&&r.height>0&&static_cast<std::int64_t>(r.x)+r.width<=INT32_MAX&&static_cast<std::int64_t>(r.y)+r.height<=INT32_MAX;}
bool bounded_size(std::int32_t w,std::int32_t h)noexcept {return w>0&&h>0&&w<=1048576&&h<=1048576;}
bool same_owner(const Owner&a,const Owner&b)noexcept {return a.queue==b.queue&&a.manager==b.manager&&a.data==b.data&&a.lv==b.lv&&a.popup==b.popup;}
bool same_rect(const Rectangle24&a,const Rectangle24&b)noexcept {return a.address_point==b.address_point&&a.x==b.x&&a.y==b.y&&a.width==b.width&&a.height==b.height;}
bool same_facts(const Facts&a,const Facts&b)noexcept {
    return same_rect(a.local_control,b.local_control)&&same_rect(a.recursive_bounds_candidate,b.recursive_bounds_candidate)&&same_rect(a.locked_roi,b.locked_roi)&&
      a.pan_cached.x==b.pan_cached.x&&a.pan_cached.y==b.pan_cached.y&&std::memcmp(&a.scale,&b.scale,4)==0&&std::memcmp(&a.normal_fit_scale,&b.normal_fit_scale,4)==0&&
      a.rotation==b.rotation&&a.client_id==b.client_id&&a.access_owner==b.access_owner&&a.config_width==b.config_width&&a.config_height==b.config_height&&
      a.slot_width==b.slot_width&&a.slot_height==b.slot_height&&a.countdown==b.countdown&&a.software_completion_id==b.software_completion_id&&a.locked_slot==b.locked_slot&&
      a.parent_depth==b.parent_depth&&a.alignment_flags==b.alignment_flags&&a.running==b.running&&a.visible==b.visible&&a.pan_animation==b.pan_animation&&
      a.borrowed_pointer_present==b.borrowed_pointer_present&&a.retain_borrowed==b.retain_borrowed&&a.locked_metadata_present==b.locked_metadata_present&&
      a.recursive_bounds_candidate_present==b.recursive_bounds_candidate_present&&a.parent_transform_would_update_local_size==b.parent_transform_would_update_local_size;
}
bool unavailable(void*,Address,display::ViewMapping&out,std::uint64_t&epoch)noexcept {out={};epoch=0;return false;}
bool trunc_float(float f,std::int32_t&out)noexcept {if(!std::isfinite(f)||static_cast<double>(f)<INT32_MIN||static_cast<double>(f)>=2147483648.0)return false;out=static_cast<std::int32_t>(f);return true;}
}
bool Probe::read(Address a,void*p,std::size_t n)const noexcept{return geometry03::read(memory_,a,p,n);}
bool parent_transform(const Rectangle24&local,std::uint32_t flags,std::int32_t pad,const Rectangle24&parent,Rectangle24&out,bool&writes_size)noexcept {
    out=local;writes_size=false;if(flags&~15U)return false;
    if(!i32(static_cast<std::int64_t>(local.x)+parent.x,out.x)||!i32(static_cast<std::int64_t>(local.y)+parent.y,out.y))return false;
    if(flags&1U){if(!i32(static_cast<std::int64_t>(parent.x)+pad,out.x))return false;
      if(flags&2U){if(!i32(static_cast<std::int64_t>(parent.width)-2LL*pad,out.width))return false;writes_size=true;}}
    else if(flags&2U){if(!i32(static_cast<std::int64_t>(parent.x)+parent.width-out.width-pad,out.x))return false;}
    if(flags&4U){if(!i32(static_cast<std::int64_t>(parent.y)+pad,out.y))return false;
      if(flags&8U){if(!i32(static_cast<std::int64_t>(parent.height)-2LL*pad,out.height))return false;writes_size=true;}}
    else if(flags&8U){if(!i32(static_cast<std::int64_t>(parent.y)+parent.height-out.height-pad,out.y))return false;}
    return positive(out);
}
bool Probe::recursive_bounds(Address control,Rectangle24&out,std::uint32_t&depth,bool&writes)const noexcept {
    struct Node {Rectangle24 rect{};std::uint32_t flags{};std::int32_t pad{};Address address{};};
    std::array<Node,16>nodes{};depth=0;writes=false;
    while(control){if(depth==nodes.size())return false;for(std::uint32_t i=0;i<depth;++i)if(nodes[i].address==control)return false;
      Address vt{},parent{},getter{},bounds{},transform{};auto&n=nodes[depth];n.address=control;
      if(!get(memory_,control,0,vt)||!get(memory_,vt,0x18,getter)||getter!=bias_+0x70c4c0||
         !get(memory_,vt,0xb8,bounds)||bounds!=bias_+0x4ab9d8||!get(memory_,vt,0x130,transform)||transform!=bias_+0x4abac8||
         !get(memory_,control,8,parent)||!get(memory_,control,0x28,n.rect)||n.rect.address_point!=bias_+0xb73b98||
         !get(memory_,control,0x44,n.flags)||!get(memory_,control,0x48,n.pad)||!positive(n.rect))return false;
      ++depth;control=parent;
    }
    if(!depth)return false;out=nodes[depth-1].rect;
    for(std::uint32_t i=depth-1;i>0;--i){Rectangle24 next{};bool w{};if(!parent_transform(nodes[i-1].rect,nodes[i-1].flags,nodes[i-1].pad,out,next,w))return false;out=next;writes|=w;}
    return true;
}
Result Probe::once(const Owner&o,Facts&f)const noexcept {
    f={};Address access{},access_data{},vt{},engine{},borrowed{};std::uint8_t running{},visible{},anim{},retain{};
    if(!get(memory_,o.lv,0x108,access)||!get(memory_,o.data,0x118,access_data)||access!=access_data||!get(memory_,access,0,vt)||vt!=bias_+0xc07da8||
       !get(memory_,access,8,engine)||!engine)return Result::ReadFailed;
    if(!get(memory_,o.lv,0x28,f.local_control)||!get(memory_,o.lv,0x44,f.alignment_flags)||!get(memory_,o.lv,0x118,f.pan_cached)||
       !get(memory_,o.lv,0x138,anim)||!get(memory_,o.lv,0x190,f.scale)||!get(memory_,o.lv,0x194,f.normal_fit_scale)||
       !get(memory_,o.lv,0x1b0,f.rotation)||!get(memory_,o.lv,0x1b8,f.countdown)||!get(memory_,o.lv,0x104,running)||
       !get(memory_,o.lv,0x6f,visible)||!get(memory_,o.lv,0x188,borrowed)||!get(memory_,o.lv,0x1c0,retain)||
       !get(memory_,o.lv,0x100,f.client_id)||!get(memory_,access,0xb0,f.access_owner)||!get(memory_,engine,0x4764,f.config_width)||!get(memory_,engine,0x4768,f.config_height))return Result::ReadFailed;
    if(running>1||visible>1||anim>1||retain>1||f.local_control.address_point!=bias_+0xb73b98||!positive(f.local_control)||
       !std::isfinite(f.scale)||f.scale<=0||!std::isfinite(f.normal_fit_scale)||f.normal_fit_scale<=0||
       !bounded_size(f.config_width,f.config_height)||f.client_id<0||f.client_id>4||f.access_owner< -1||f.access_owner>4||
       (f.rotation!=0&&f.rotation!=90&&f.rotation!=180&&f.rotation!=270))return Result::Invalid;
    f.running=running;f.visible=visible;f.pan_animation=anim;f.borrowed_pointer_present=borrowed!=0;f.retain_borrowed=retain;
    f.recursive_bounds_candidate_present=recursive_bounds(o.lv,f.recursive_bounds_candidate,f.parent_depth,f.parent_transform_would_update_local_size);
    Address buffer{};if(!addr(engine,0x2170,buffer)||!get(memory_,buffer,0xe8,f.locked_slot))return Result::ReadFailed;
    if(f.locked_slot>4)return Result::Invalid;
    // No slot pixel pointer is read. Source ownership remains a separate fact;
    // e8 and LV+188 agreement alone is not a source lease proof.
    if(f.locked_slot<4){std::array<std::int32_t,2>size{};
      if(!get(memory_,buffer,0x50+8*f.locked_slot,size)||!get(memory_,buffer,0x70+24*f.locked_slot,f.locked_roi)||!get(memory_,buffer,0xf4,f.software_completion_id))return Result::ReadFailed;
      if(!bounded_size(size[0],size[1])||f.locked_roi.address_point!=bias_+0xb73b98||!positive(f.locked_roi))return Result::Invalid;
      f.slot_width=size[0];f.slot_height=size[1];f.locked_metadata_present=true;
    }
    return Result::Ok;
}
Result Probe::collect_owner(Address tp,Address lv,Observation&out)const noexcept {
    out={};Address q{};native_ui02::Inspector in(memory_,bias_);Owner a{},b{};Facts fa{},fb{};
    if(!get(memory_,tp,0x10,q)||!in.owner_chain(q,a)||a.lv!=lv||!in.current(a,false))return Result::OwnerRejected;
    auto r=once(a,fa);if(r!=Result::Ok)return r;
    if(!in.owner_chain(q,b)||!same_owner(a,b)||!in.current(b,false))return Result::Changing;
    r=once(b,fb);if(r!=Result::Ok)return r;if(!same_facts(fa,fb))return Result::Changing;
    fa.consistent_double_read=true;out={a,fa};return Result::Ok;
}
Result Probe::collect_boundary(const BoundaryInput&input,Observation&out)const noexcept {
    out={};native_ui02::Boundary b{};native_ui02::Inspector in(memory_,bias_);
    if(!in.boundary(input,b)||!in.current(b.owner,false))return Result::OwnerRejected;
    return collect_owner(input.thread_pointer,b.owner.lv,out);
}
bool point_candidate(const Facts&f,Point8 source,Point8&out)noexcept {
    out={};if(!f.recursive_bounds_candidate_present||!bounded_size(f.config_width,f.config_height)||!std::isfinite(f.scale)||f.scale<=0)return false;
    std::int32_t px{},py{},fw{},fh{};
    if(!trunc_float(static_cast<float>(source.x)/f.scale,px)||!trunc_float(static_cast<float>(source.y)/f.scale,py)||
       !trunc_float(static_cast<float>(f.config_width)/f.scale,fw)||!trunc_float(static_cast<float>(f.config_height)/f.scale,fh))return false;
    const auto&r=f.recursive_bounds_candidate;
    std::int64_t x=static_cast<std::int64_t>(px)+f.pan_cached.x+r.x,y=static_cast<std::int64_t>(py)+f.pan_cached.y+r.y;
    if(fw<r.width)x+=(static_cast<std::int64_t>(r.width)-fw)/2;
    if(fh<r.height)y+=(static_cast<std::int64_t>(r.height)-fh)/2;
    return i32(x,out.x)&&i32(y,out.y);
}
bool fit_candidate(Rect dst,std::int32_t sw,std::int32_t sh,std::int32_t rotation,Rect&out,float&scale)noexcept {
    out={};scale=0;if(dst.w<=0||dst.h<=0||!bounded_size(sw,sh))return false;
    if(rotation==90||rotation==270){const auto t=sw;sw=sh;sh=t;}else if(rotation!=0&&rotation!=180)return false;
    scale=std::fmin(static_cast<float>(dst.w)/static_cast<float>(sw),static_cast<float>(dst.h)/static_cast<float>(sh));
    std::int32_t w{},h{};if(!trunc_float(scale*static_cast<float>(sw),w)||!trunc_float(scale*static_cast<float>(sh),h)||w<=0||h<=0)return false;
    out.w=w;out.h=h;return i32(static_cast<std::int64_t>(dst.x)+(static_cast<std::int64_t>(dst.w)-w)/2,out.x)&&
      i32(static_cast<std::int64_t>(dst.y)+(static_cast<std::int64_t>(dst.h)-h)/2,out.y);
}
bool read_surface_metadata(Memory m,Address bias,Address surface,Rectangle24&r,std::uint32_t&pitch,std::uint32_t&height)noexcept {
    r={};pitch=height=0;Address vt{},draw{},drawvt{};
    if(bias>UINTPTR_MAX-0xc22960)return false;
    if(!get(m,surface,0,vt)||vt!=bias+0xb7b780||!get(m,surface,8,draw)||!get(m,draw,0,drawvt)||drawvt!=bias+0xb7b7d8||
       !get(m,surface,0x14,pitch)||!get(m,surface,0x18,height)||!get(m,surface,0x20,r)||r.address_point!=bias+0xb73b98||!positive(r))return false;
    return pitch>0&&pitch<=1048576&&height>0&&height<=1048576&&r.x>=0&&r.y>=0&&
      static_cast<std::uint64_t>(r.x)+static_cast<std::uint32_t>(r.width)<=pitch&&static_cast<std::uint64_t>(r.y)+static_cast<std::uint32_t>(r.height)<=height;
}
Result collect_paint_scope(Memory m,Address bias,const PaintInput&i,PaintScope&out)noexcept {
    out={};if(bias>UINTPTR_MAX-0xc22960||i.caller_pc!=bias+0x4abe94||!i.frame_pointer||(i.frame_pointer&15U))return Result::NoPaintScope;
    Address own_parent{},own_lr{},control_parent{},control_lr{},q{};Owner owner{};native_ui02::Inspector in(m,bias);
    if(!get(m,i.thread_pointer,0x10,q)||!in.owner_chain(q,owner)||owner.lv!=i.lv||!in.current(owner,false)||
       !get(m,i.frame_pointer,0,own_parent)||!get(m,i.frame_pointer,8,own_lr)||own_lr!=i.caller_pc||
       own_parent<=i.frame_pointer||own_parent-i.frame_pointer>65536||(own_parent&15U)||
       !get(m,own_parent,0,control_parent)||!get(m,own_parent,8,control_lr)||control_lr!=bias+0x4e33bc||
       control_parent<=own_parent||control_parent-own_parent>65536||(control_parent&15U))return Result::NoPaintScope;
    Address clv{},csurface{},manager{},msurface{},mlv{},provider{};
    if(!get(m,own_parent,0x48,clv)||clv!=i.lv||!get(m,own_parent,0x40,csurface)||csurface!=i.surface||
       i.draw_rectangle!=own_parent+0xb8||i.clip_rectangle!=own_parent+0xd0||
       !get(m,control_parent,0x28,manager)||manager!=owner.manager||!get(m,control_parent,0x148,msurface)||msurface!=i.surface||
       !get(m,control_parent,0x150,mlv)||mlv!=i.lv||!get(m,manager,0x108,provider)||!provider||
       !read(m,i.draw_rectangle,&out.original_draw,sizeof(Rectangle24))||!read(m,i.clip_rectangle,&out.original_clip,sizeof(Rectangle24))||
       out.original_draw.address_point!=bias+0xb73b98||out.original_clip.address_point!=bias+0xb73b98||!positive(out.original_draw)||!positive(out.original_clip))return Result::NoPaintScope;
    if(!read_surface_metadata(m,bias,i.surface,out.display_bounds,out.pitch_pixels,out.height))return Result::Invalid;
    out.owner=owner;out.control_frame=own_parent;out.manager_frame=control_parent;out.surface_provider=provider;
    out.context_chain_consistent=true;out.display_extent_valid=true;return Result::Ok;
}
native_ui02::GeometryPort unavailable_geometry_port()noexcept{return {nullptr,unavailable};}
bool fresh_receipt_unavailable(const PaintScope&,native_overlay::Receipt&out)noexcept{out={};return false;}
}
