#include "gallery.hpp"
#include <cstring>
namespace iq4::gallery_source_01 {
namespace {
bool rd(Memory m,uintptr_t p,void*out,size_t n){return m.read&&p&&n&&p<=UINTPTR_MAX-n&&m.read(m.context,p,out,n)==1;}
bool twice(Memory m,uintptr_t p,void*out,size_t n){unsigned char b[256];return n<=sizeof(b)&&rd(m,p,out,n)&&rd(m,p,b,n)&&!std::memcmp(out,b,n);}
template<class T>bool get(Memory m,uintptr_t p,T&v){return twice(m,p,&v,sizeof(v));}
bool ptr(uintptr_t p){return p&&!(p&7);}
bool name(const char*p){size_t n=0;while(n<14&&p[n]){unsigned c=(unsigned char)p[n];if(c=='/'||c=='\\'||!((c>='a'&&c<='z')||(c>='A'&&c<='Z')||(c>='0'&&c<='9')||c=='_'||c=='.'))return false;++n;}
 if(n<5||n>=14)return false;for(size_t i=0;i<n-4;++i)if(p[i]=='.')return false;
 return p[n-4]=='.'&&(!std::memcmp(p+n-3,"IIQ",3)||!std::memcmp(p+n-3,"iiq",3));}
Result copy(Memory m,uintptr_t ifm,int32_t index,Snapshot&out){
 Snapshot s{};uintptr_t vt=0,table=0,begin=0,end=0,fs=0,dir=0;
 uint32_t count=0,declared=0;
 if(!ptr(ifm)||ifm>UINTPTR_MAX-0x7e8||!get(m,ifm,vt)||vt!=0xb7ece0||
  !get(m,ifm+0x1a8,declared)||!get(m,ifm+0x1b8,count)||!get(m,ifm+0x1b0,table)||!ptr(table)||
  !get(m,table,begin)||!get(m,table+8,end)||end<begin||(end-begin)%40)return Result::Owner;
 // IFM+1a8 is U32 capacity, not a pointer. Read only those four bytes.
 if(index<0||!count||count>declared||declared>1000000u||(uint64_t)index>=count||
  (uint64_t)index>=(end-begin)/40||begin>UINTPTR_MAX-(uint64_t(index)+1)*40)return Result::Index;
 s.ifm=ifm;s.index=(uint32_t)index;s.table=table;s.record_address=begin+uint64_t(index)*40;
 if(!twice(m,s.record_address,s.record,40))return Result::Changing;
 uint16_t work=0;std::memcpy(&work,s.record+0x10,2);
 if(!(work&1))return Result::NotFile;
 const unsigned flags=s.record[0x0e];
 // Match original XQD-first branch, not guessed record+0x10 storage bits.
 const uintptr_t off=(flags&2)?0x7d0:(flags&4)?0x7a0:0;
 if(!off||!get(m,ifm+off,fs)||!ptr(fs)||!get(m,fs,vt)||vt!=0xd91450||
  !get(m,ifm+off+0x10,dir)||!dir)return Result::Owner;
 s.filesystem=fs;s.filesystem_id=off==0x7d0?11:10;s.directory_address=dir;
 // Copy char-by-char so a short string need not own 256 readable bytes.
 bool nul=false;for(size_t i=0;i<sizeof(s.directory);++i){if(!twice(m,dir+i,s.directory+i,1))return Result::Changing;if(!s.directory[i]){nul=true;break;}}
 if(!nul)return Result::Path;
 std::memcpy(s.leaf,s.record,sizeof s.leaf);
 char relative[256];if(!name(s.leaf)||!relative_directory(s.directory,relative))return Result::Path;
 if(source_dependencies_01::snapshot_from_ifm(m,ifm,s.dependencies)!=source_dependencies_01::Result::Ok)return Result::Owner;
 out=s;return Result::Ok;
}
Result close(Memory m,const NativeMutexApi&a,Guard&g,Result result){
 uintptr_t current=0,owner=0;uint32_t depth=0;
 try{current=reinterpret_cast<uintptr_t>(a.current_native_thread());}catch(...){g.hold=true;return Result::Hold;}
 if(current!=g.thread||!get(m,g.mutex+0x48,owner)||owner!=g.thread||
  !get(m,g.mutex+0x50,depth)||depth!=g.old_depth+1){g.hold=true;return Result::Hold;}
 try{a.destroy_guard(g.native);}catch(...){g.hold=true;return Result::Hold;}
 g.live=false;
 if(!get(m,g.mutex+0x50,depth)||depth!=g.old_depth||!get(m,g.mutex+0x48,owner)||
  owner!=(g.old_depth?g.thread:0)){g.hold=true;return Result::Hold;}
 return result;
}
}
bool relative_directory(const char*p,char out[256]) noexcept {
 if(!p||!out)return false;size_t n=0,j=0;if(p[0]=='/')n=1;
 if(!p[n]){out[0]=0;return true;}
 size_t component=0;for(;n<256&&p[n];++n){unsigned c=(unsigned char)p[n];
  if(c=='/'){if(!component||j>=255)return false;component=0;out[j++]='/';continue;}
  if(!((c>='a'&&c<='z')||(c>='A'&&c<='Z')||(c>='0'&&c<='9')||c=='_'||c=='-')||j>=255)return false;
  out[j++]=(char)c;++component;}
 if(n>=256||!component)return false;out[j]=0;return true;
}
bool same(const Snapshot&a,const Snapshot&b) noexcept {
 return a.ifm==b.ifm&&a.filesystem==b.filesystem&&a.table==b.table&&a.record_address==b.record_address&&
  a.directory_address==b.directory_address&&a.index==b.index&&a.filesystem_id==b.filesystem_id&&
  !std::memcmp(a.record,b.record,40)&&!std::strcmp(a.directory,b.directory)&&!std::strcmp(a.leaf,b.leaf)&&
  a.dependencies.original_reader==b.dependencies.original_reader&&a.dependencies.module_a==b.dependencies.module_a&&
  a.dependencies.module_b==b.dependencies.module_b&&a.dependencies.metadata_a==b.dependencies.metadata_a&&
  a.dependencies.metadata_b==b.dependencies.metadata_b&&a.dependencies.metadata_c==b.dependencies.metadata_c;
}
Result snapshot(Memory m,const NativeMutexApi&a,Guard&g,uintptr_t ifm,int32_t index,Snapshot&out) noexcept {
 out={};if(g.hold)return Result::Hold;if(g.live||!m.read||!ptr(ifm)||ifm>UINTPTR_MAX-0x650)return Result::Argument;
 if(!a.exact_original_prefixes||!a.construct_guard||!a.destroy_guard||!a.current_native_thread)return Result::Unbound;
 uintptr_t vt=0,owner=0,thread=0;uint32_t depth=0,mode=0;
 if(!get(m,ifm,vt)||vt!=0xb7ece0||!get(m,ifm+0x5f8,vt)||vt!=0x9f1df0)return Result::Owner;
 try{thread=reinterpret_cast<uintptr_t>(a.current_native_thread());}catch(...){g.hold=true;return Result::Hold;}
 if(!ptr(thread)||!get(m,thread,vt)||!get(m,ifm+0x640,owner)||!get(m,ifm+0x648,depth)||
  !get(m,ifm+0x64c,mode)||mode>1||depth==UINT32_MAX||(depth&&owner!=thread))return Result::Owner;
 g.mutex=ifm+0x5f8;g.thread=thread;g.old_depth=depth;g.live=true;
 try{a.construct_guard(g.native,reinterpret_cast<void*>(g.mutex));}catch(...){g.hold=true;return Result::Hold;}
 uintptr_t guarded=0;std::memcpy(&guarded,g.native,8);
 if(guarded!=g.mutex||!get(m,g.mutex+0x48,owner)||owner!=thread||!get(m,g.mutex+0x50,depth)||depth!=g.old_depth+1){g.hold=true;return Result::Hold;}
 Snapshot first{},second{};auto r=copy(m,ifm,index,first);if(r==Result::Ok){r=copy(m,ifm,index,second);if(r==Result::Ok&&!same(first,second))r=Result::Changing;}
 r=close(m,a,g,r);if(r==Result::Ok)out=first;return r;
}
Result recheck(Memory m,const NativeMutexApi&a,Guard&g,const Snapshot&s) noexcept {Snapshot f{};auto r=snapshot(m,a,g,s.ifm,(int32_t)s.index,f);return r==Result::Ok&&!same(s,f)?Result::Changing:r;}
}
