#include "receipt.h"
#include "pins.h"
#include <cstring>
#include <cstdio>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <errno.h>
#include <limits.h>
#if defined(IQ4_NEW_RAW_TEST) && defined(__APPLE__)
#undef SYS_gettid
#define SYS_gettid 1000001
#define SYS_newfstatat 1000002
#define SYS_renameat2 1000003
#define st_mtim st_mtimespec
#endif
extern "C" long iq4_new_raw_syscall_55(long,...);
extern "C" int *iq4_new_raw_errno_55();
extern "C" int iq4_new_raw_original_open_55(const char*,int,unsigned);
extern "C" void iq4_new_raw_original_enqueue_55(void*,void*);
extern "C" void iq4_new_raw_original_node_event_55(void*);
extern "C" void iq4_new_raw_original_backup_enqueue_55(void*,uint32_t);
extern "C" void iq4_new_raw_backup_enqueue_55(void*,uint32_t);
extern "C" bool iq4_new_raw_original_xqd_store_55(void*,void*,const char*);
extern "C" bool iq4_new_raw_original_sd_store_55(void*,void*,void*,void*,void*,void*,const char*);
extern "C" bool iq4_new_raw_original_writer_close_55(void*);
extern "C" bool iq4_new_raw_original_file_close_55(void*);
extern "C" void iq4_new_raw_original_file_dtor_55(void*);
extern "C" void iq4_new_raw_enqueue_thunk_55();
extern "C" void iq4_new_raw_node_event_55(void*);
extern "C" bool iq4_new_raw_xqd_store_55(void*,void*,const char*);
extern "C" bool iq4_new_raw_sd_store_55(void*,void*,void*,void*,void*,void*,const char*,uintptr_t);
extern "C" int iq4_new_raw_open_55(const char*,int,unsigned);
extern "C" bool iq4_new_raw_sd_close_55(void*);
extern "C" void iq4_new_raw_xqd_dtor_55(void*);
extern "C" void iq4_new_raw_refs_55(void*,void*,uint8_t);
namespace {
constexpr unsigned Count=32;constexpr uint32_t Xqd=2,Sd=4,Cards=6;
struct Identity {uintptr_t pool,node,raw,meta,payload;uint32_t number,black;};
struct File {int held=-1,dir=-1;uint32_t card=0,closed=0;uint64_t dev=0,ino=0,size=0;int64_t mtime=0,mtime_ns=0;char path[256]{},base[64]{};};
struct Entry {uint64_t serial=0,epoch=0;uint32_t state=0,index=UINT32_MAX,published=0,expected=0,sealed=0,backup_suppressed=0,retire_ready=0,retire_started=0;int32_t retire_result=0;Identity id{};Iq4NewRawPolicy55 policy{};File files[2]{};};
struct Scope {uint64_t owner=0,serial=0;uintptr_t storage=0,node=0,fs=0;uint32_t card=0,bad=0,close_count=0;File file{};};
static Iq4NewRawOps55 ops{};static Entry entries[Count]{};static Scope scopes[2]{};
static uint32_t bound=0,lock=0,active=0;static uint64_t nextSerial=0,epoch=1;
static void purge();
static bool enter(){uint32_t z=0;if(!__atomic_compare_exchange_n(&lock,&z,1,false,__ATOMIC_ACQUIRE,__ATOMIC_RELAXED))return false;purge();return true;}
static void leave(){__atomic_store_n(&lock,0,__ATOMIC_RELEASE);}
static bool read(uintptr_t p,void*b,size_t n){unsigned char other[256];return ops.read&&p&&n<=sizeof other&&p<=UINTPTR_MAX-n&&ops.read(ops.context,p,b,n)==1&&ops.read(ops.context,p,other,n)==1&&!std::memcmp(b,other,n);}
static uint64_t tid(){long n=iq4_new_raw_syscall_55(SYS_gettid);return n>0?uint64_t(n):0;}
static long call(long n,long a=0,long b=0,long c=0,long d=0,long e=0,long f=0){return iq4_new_raw_syscall_55(n,a,b,c,d,e,f);}
static bool same(const Identity&a,const Identity&b){return a.pool==b.pool&&a.node==b.node&&a.raw==b.raw&&a.meta==b.meta&&a.payload==b.payload&&a.number==b.number&&a.black==b.black;}
static bool inspect(uintptr_t pool,uintptr_t node,Identity&v){uint64_t vt;uint8_t black;
 v={pool,node,0,0,0,0,0};return !(pool&7)&&!(node&7)&&read(pool,&vt,8)&&vt==0xdb4980&&read(node+0x88,&v.raw,8)&&v.raw&&read(node+0x90,&v.meta,8)&&v.meta&&read(v.meta+0x40,&v.payload,8)&&v.payload&&read(v.payload+0xb8,&v.number,4)&&read(v.payload+0x484,&v.black,4)&&v.black<=4&&read(v.payload+0x490,&black,1)&&!black;}
static bool classify(uintptr_t cm,uintptr_t pool,uintptr_t node,Identity&v){uintptr_t a,p;uint8_t en,first,abort;uint32_t compare,black,number;Identity twice{};
 return read(cm+0x2090,&a,8)&&a==pool&&read(cm+0x2098,&a,8)&&a==node&&read(cm+0x80f8,&p,8)&&p&&read(p+0x1a0,&en,1)&&!en&&read(p+0x1488,&compare,4)&&!compare&&read(cm+0xc08,&abort,1)&&!abort&&read(cm+0x2708,&first,1)&&!first&&read(cm+0x26fc,&black,4)&&black<=4&&read(cm+0x2330,&number,4)&&inspect(pool,node,v)&&inspect(pool,node,twice)&&same(v,twice)&&v.number==number&&v.black==black&&read(cm+0x2090,&a,8)&&a==pool&&read(cm+0x2098,&a,8)&&a==node&&read(cm+0x80f8,&a,8)&&a==p&&read(p+0x1a0,&en,1)&&!en&&read(p+0x1488,&compare,4)&&!compare&&read(cm+0xc08,&abort,1)&&!abort&&read(cm+0x2708,&first,1)&&!first&&read(cm+0x26fc,&black,4)&&black==v.black&&read(cm+0x2330,&number,4)&&number==v.number;}
static bool policyValid(const Iq4NewRawPolicy55&p){return (p.format==1||p.format==2)&&p.size<=1&&p.sd_mode<=5&&p.generation&&!(p.raw_mask&~Cards)&&!(p.jpeg_mask&~Cards);}
static void releaseFile(File&f){if(f.held>=0)call(SYS_close,f.held);if(f.dir>=0)call(SYS_close,f.dir);f={};}
static void releaseEntry(Entry&e){for(auto&f:e.files)releaseFile(f);if(e.state)__atomic_sub_fetch(&active,1,__ATOMIC_RELEASE);e={};}
static void purge(){uint64_t current=__atomic_load_n(&epoch,__ATOMIC_ACQUIRE);for(auto&e:entries)if(e.state&&e.epoch!=current){if(e.state==1)releaseEntry(e);else e.state=5;}}
static Entry* bySerial(uint64_t n){for(auto&e:entries)if(e.state&&e.serial==n)return &e;return nullptr;}
static void invalidate(uintptr_t node){if(!enter()){__atomic_add_fetch(&epoch,1,__ATOMIC_RELEASE);return;}for(auto&e:entries)if(e.state&&e.id.node==node){if(e.state==1)releaseEntry(e);else e.state=5;}leave();}
static bool pins(){unsigned char b[512];for(const auto&p:NewRawPins55)if(p.bytes>sizeof b||!read(p.va,b,p.bytes)||std::memcmp(b,p.data,p.bytes))return false;
#ifndef IQ4_NEW_RAW_TEST
 const uintptr_t sites[]={0x79d300,0x8c5844,0x8c5c54,0x8df038,0x8e0618,0x825fcc,0x8dd440,0x8df8e8,0x8df8f0,0x8dc634,0x49686c};
 const uintptr_t targets[]={(uintptr_t)iq4_new_raw_enqueue_thunk_55,(uintptr_t)iq4_new_raw_node_event_55,(uintptr_t)iq4_new_raw_node_event_55,(uintptr_t)iq4_new_raw_xqd_store_55,(uintptr_t)iq4_new_raw_sd_store_55,(uintptr_t)iq4_new_raw_open_55,(uintptr_t)iq4_new_raw_sd_close_55,(uintptr_t)iq4_new_raw_xqd_dtor_55,(uintptr_t)iq4_new_raw_xqd_dtor_55,(uintptr_t)iq4_new_raw_refs_55,(uintptr_t)iq4_new_raw_backup_enqueue_55};
 for(unsigned i=0;i<11;++i){uint32_t word=0;int64_t delta=(int64_t)targets[i]-(int64_t)sites[i];if((delta&3)||delta<-(INT64_C(1)<<27)||delta>=(INT64_C(1)<<27)||!read(sites[i],&word,4)||word!=(0x94000000u|((uint32_t)(delta>>2)&0x3ffffff)))return false;}
#endif
 return true;}
static bool regular(int fd,struct stat&st){return call(SYS_fstat,fd,long(&st))==0&&S_ISREG(st.st_mode)&&st.st_nlink==1&&st.st_size>0;}
static Scope* scope(){uint64_t t=tid();if(!t)return nullptr;for(auto&s:scopes)if(__atomic_load_n(&s.owner,__ATOMIC_ACQUIRE)==t)return &s;return nullptr;}
static bool beginScope(Scope&s,uintptr_t storage,uintptr_t node,uint32_t card,uintptr_t fs){if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE)||scope()||!enter())return false;uint64_t serial=0;Identity id{};uint32_t index=UINT32_MAX;
 for(auto&e:entries)if(e.state==1&&e.policy.format==1&&e.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e.id.node==node&&inspect(e.id.pool,node,id)&&same(id,e.id)&&read(node+0xd8,&index,4)&&index!=UINT32_MAX){serial=e.serial;e.index=index;break;}
 leave();uintptr_t vt=0;if(!serial||!fs||!read(fs,&vt,8)||vt!=0xd91450)return false;
 uint64_t t=tid();if(!t||__atomic_load_n(&s.owner,__ATOMIC_ACQUIRE))return false;
 s.serial=serial;s.storage=storage;s.node=node;s.fs=fs;s.card=card;s.bad=0;s.close_count=0;s.file={};s.file.card=card;
 __atomic_store_n(&s.owner,t,__ATOMIC_RELEASE);return true;}
static void finishScope(Scope&s,bool ok){__atomic_store_n(&s.owner,0,__ATOMIC_RELEASE);
 struct stat st{};ok=ok&&!s.bad&&s.file.held>=0&&s.file.closed&&regular(s.file.held,st)&&uint64_t(st.st_dev)==s.file.dev&&uint64_t(st.st_ino)==s.file.ino;
 if(ok){s.file.size=uint64_t(st.st_size);s.file.mtime=st.st_mtim.tv_sec;s.file.mtime_ns=st.st_mtim.tv_nsec;}
 if(enter()){Entry*e=bySerial(s.serial);if(e&&e->state==1&&ok){unsigned i=s.card==Xqd?0:1;releaseFile(e->files[i]);e->files[i]=s.file;s.file={};}else if(e){if(e->state==1)releaseEntry(*e);else e->state=5;}leave();}
 releaseFile(s.file);s.serial=0;}
static bool ownedPath(Scope&s,const char*path){size_t n=0;for(;n<255&&path[n];++n){}if(n<5||n==255||path[0]!='/'||std::strcmp(path+n-4,".IIQ"))return false;
 const char*slash=std::strrchr(path,'/');if(!slash||slash==path||!slash[1]||std::strstr(path,"/../")||std::strstr(path,"/./"))return false;
 if(s.file.path[0])return !std::strcmp(s.file.path,path);
 if(std::strlen(slash+1)>=sizeof s.file.base)return false;
 std::memcpy(s.file.path,path,n+1);std::strcpy(s.file.base,slash+1);return true;}
static bool checkCaptured(int fd,Scope&s){struct stat st{};if(call(SYS_fstat,fd,long(&st))!=0||!S_ISREG(st.st_mode)||st.st_nlink!=1||st.st_size<0)return false;
 if(s.file.held>=0)return uint64_t(st.st_dev)==s.file.dev&&uint64_t(st.st_ino)==s.file.ino;
 long dup=call(SYS_fcntl,fd,F_DUPFD_CLOEXEC,3);if(dup<0||dup>INT_MAX)return false;
 s.file.held=int(dup);s.file.dev=uint64_t(st.st_dev);s.file.ino=uint64_t(st.st_ino);
 char parent[256];std::strcpy(parent,s.file.path);char*slash=std::strrchr(parent,'/');if(!slash)return false;*slash=0;
 long d=call(SYS_openat,AT_FDCWD,long(parent),O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC,0);if(d<0||d>INT_MAX)return false;s.file.dir=int(d);struct stat ds{},at{};
 return call(SYS_fstat,s.file.dir,long(&ds))==0&&uint64_t(ds.st_dev)==s.file.dev&&call(SYS_newfstatat,s.file.dir,long(s.file.base),long(&at),AT_SYMLINK_NOFOLLOW)==0&&uint64_t(at.st_dev)==s.file.dev&&uint64_t(at.st_ino)==s.file.ino&&S_ISREG(at.st_mode);}
static int cleanupFile(File&f,uint64_t serial){struct stat held{},at{},dir{};if(f.held<0||!regular(f.held,held)||uint64_t(held.st_dev)!=f.dev||uint64_t(held.st_ino)!=f.ino||uint64_t(held.st_size)!=f.size||held.st_mtim.tv_sec!=f.mtime||held.st_mtim.tv_nsec!=f.mtime_ns)return 2;
 if(f.dir<0)return 2;
 if(call(SYS_fstat,f.dir,long(&dir))||uint64_t(dir.st_dev)!=f.dev||call(SYS_newfstatat,f.dir,long(f.base),long(&at),AT_SYMLINK_NOFOLLOW)||!S_ISREG(at.st_mode)||uint64_t(at.st_dev)!=f.dev||uint64_t(at.st_ino)!=f.ino||uint64_t(at.st_size)!=f.size||at.st_mtim.tv_sec!=f.mtime||at.st_mtim.tv_nsec!=f.mtime_ns)return 2;
 char hidden[80];int n=std::snprintf(hidden,sizeof hidden,".IQ4-JPEG-%016llx-%u.IIQ",(unsigned long long)serial,f.card);if(n<0||size_t(n)>=sizeof hidden)return 2;
 // Atomic NOREPLACE isolates exactly the directory entry moved. Foreign
 // replacements are never deleted; restore without replacement or retain them.
 if(call(SYS_renameat2,f.dir,long(f.base),f.dir,long(hidden),1u))return 2;
 if(call(SYS_newfstatat,f.dir,long(hidden),long(&at),AT_SYMLINK_NOFOLLOW)||!S_ISREG(at.st_mode)||uint64_t(at.st_dev)!=f.dev||uint64_t(at.st_ino)!=f.ino||uint64_t(at.st_size)!=f.size||at.st_mtim.tv_sec!=f.mtime||at.st_mtim.tv_nsec!=f.mtime_ns){call(SYS_renameat2,f.dir,long(hidden),f.dir,long(f.base),1u);return -1;}
 if(call(SYS_unlinkat,f.dir,long(hidden),0))return -1;
 if(call(SYS_fsync,f.dir))return -1;return 1;}
}
extern "C" int iq4_new_raw_bind_55(const Iq4NewRawOps55*p){if(!p||!p->read||!p->policy||!p->catalog||!p->removed||!p->xqd_fs||!p->sd_fs||!p->backup_quiet||!enter())return 0;
 if(__atomic_load_n(&active,__ATOMIC_ACQUIRE)){leave();return 0;}ops=*p;bool good=pins();__atomic_store_n(&bound,good,__ATOMIC_RELEASE);leave();return good;}
extern "C" int iq4_new_raw_settings_enter_55(){if(!__atomic_load_n(&bound,__ATOMIC_ACQUIRE)||!enter())return 0;if(__atomic_load_n(&active,__ATOMIC_ACQUIRE)){leave();return 0;}return 1;}
extern "C" void iq4_new_raw_settings_leave_55(){leave();}
extern "C" uint32_t iq4_new_raw_active_55(){return __atomic_load_n(&active,__ATOMIC_ACQUIRE);}
extern "C" void iq4_new_raw_enqueue_55(void*pool,void*node,void*cm){uint64_t created=0;
 if(__atomic_load_n(&bound,__ATOMIC_ACQUIRE)&&enter()){
  try{for(auto&e:entries)if(e.state&&e.id.node==uintptr_t(node)){if(e.state==1)releaseEntry(e);else e.state=5;}
   Identity id{};Iq4NewRawPolicy55 p{};
   if(classify(uintptr_t(cm),uintptr_t(pool),uintptr_t(node),id)&&ops.policy(ops.context,&p)==1&&policyValid(p)&&nextSerial!=UINT64_MAX){for(auto&e:entries)if(!e.state){e.serial=++nextSerial;e.epoch=__atomic_load_n(&epoch,__ATOMIC_ACQUIRE);e.state=1;e.id=id;e.policy=p;created=e.serial;__atomic_add_fetch(&active,1,__ATOMIC_RELEASE);break;}}
  }catch(...){/* Extension admission failure must not suppress native capture. */}
  leave();
 }
 try{iq4_new_raw_original_enqueue_55(pool,node);}catch(...){if(created&&enter()){if(auto*e=bySerial(created))releaseEntry(*e);leave();}else if(created)__atomic_add_fetch(&epoch,1,__ATOMIC_RELEASE);throw;}
}
extern "C" void iq4_new_raw_node_event_55(void*node){invalidate(uintptr_t(node));iq4_new_raw_original_node_event_55(node);}
extern "C" void iq4_new_raw_original_refs_55(void*,void*,uint8_t);
extern "C" void iq4_new_raw_refs_55(void*pool,void*node,uint8_t flags){if(enter()){for(auto&e:entries)if(e.state==1&&e.id.pool==uintptr_t(pool)&&e.id.node==uintptr_t(node)){e.expected=flags&Cards;e.sealed=e.expected!=0;break;}leave();}iq4_new_raw_original_refs_55(pool,node,flags);}
extern "C" bool iq4_new_raw_xqd_store_55(void*storage,void*node,const char*path){Scope&s=scopes[0];uintptr_t fs=0,vt=0;bool selected=read(uintptr_t(storage),&vt,8)&&vt==0xdbc280&&read(uintptr_t(storage)+0x2c0,&fs,8)&&fs==ops.xqd_fs&&beginScope(s,uintptr_t(storage),uintptr_t(node),Xqd,fs);try{bool ok=iq4_new_raw_original_xqd_store_55(storage,node,path);if(selected)finishScope(s,ok);return ok;}catch(...){if(selected)finishScope(s,false);throw;}}
extern "C" bool iq4_new_raw_sd_store_55(void*storage,void*node,void*a,void*b,void*c,void*d,const char*path,uintptr_t original){Scope&s=scopes[1];uintptr_t fs=0,vt=0;bool selected=(original==0x8dcf98
#ifdef IQ4_NEW_RAW_TEST
 || original==uintptr_t(iq4_new_raw_original_sd_store_55)
#endif
 )&&read(uintptr_t(storage),&vt,8)&&vt==0xdbc6b8&&read(uintptr_t(storage)+0x2c0,&fs,8)&&fs==ops.sd_fs&&uintptr_t(a)==fs&&beginScope(s,uintptr_t(storage),uintptr_t(node),Sd,fs);
 using Store=bool(*)(void*,void*,void*,void*,void*,void*,const char*);try{bool ok=reinterpret_cast<Store>(original)(storage,node,a,b,c,d,path);if(selected)finishScope(s,ok);return ok;}catch(...){if(selected)finishScope(s,false);throw;}}
extern "C" int iq4_new_raw_open_55(const char*path,int flags,unsigned mode){Scope*s=scope();bool selected=s&&!(s->bad)&&ownedPath(*s,path);if(s&&!selected)s->bad=1;
 bool create=selected&&(flags&O_CREAT);if(create){if(s->file.held>=0){s->bad=1;*iq4_new_raw_errno_55()=EEXIST;return -1;}flags|=O_EXCL|O_NOFOLLOW;}
 int fd=iq4_new_raw_original_open_55(path,flags,mode);if(selected&&fd>=0&&!checkCaptured(fd,*s))s->bad=1;return fd;}
extern "C" bool iq4_new_raw_sd_close_55(void*writer){Scope*s=scope();bool ok=iq4_new_raw_original_writer_close_55(writer);if(s){s->close_count++;if(ok)s->file.closed=1;else s->bad=1;}return ok;}
extern "C" void iq4_new_raw_xqd_dtor_55(void*file){Scope*s=scope();uint8_t isOpen=0;uintptr_t fs=0;int fd=-1;
 bool selected=s&&s->card==Xqd&&read(uintptr_t(file)+8,&fs,8)&&fs==s->fs&&read(uintptr_t(file)+0x14,&isOpen,1)&&isOpen&&read(uintptr_t(file)+0x10,&fd,4)&&fd>=0;
 if(selected){struct stat st{};selected=regular(fd,st)&&uint64_t(st.st_dev)==s->file.dev&&uint64_t(st.st_ino)==s->file.ino;}
 if(selected){bool ok=iq4_new_raw_original_file_close_55(file);s->close_count++;if(ok)s->file.closed=1;else s->bad=1;}
 iq4_new_raw_original_file_dtor_55(file);}
extern "C" int iq4_new_raw_policy_55(uintptr_t node,uint32_t index,Iq4NewRawPolicy55*out){if(!out||!enter())return 0;int r=0;uint32_t actual=UINT32_MAX;
 for(auto&e:entries)if(e.state==1&&e.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e.id.node==node&&read(node+0xd8,&actual,4)&&actual==index){e.index=index;*out=e.policy;r=1;break;}leave();return r;}
extern "C" int iq4_new_raw_acquire_55(uintptr_t node,uint32_t index,const Iq4NewRawPolicy55*p,uint32_t raw,uint32_t jpeg,Iq4NewRawTicket55*out){if(!p||!out||!enter())return 0;out->serial=0;uint64_t n=0;char base[64]{};uint32_t actual=UINT32_MAX;
 for(auto&e:entries)if(e.state==1&&e.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e.id.node==node&&read(node+0xd8,&actual,4)&&actual==index&&e.sealed&&!std::memcmp(&e.policy,p,offsetof(Iq4NewRawPolicy55,jpeg_mask))&&e.policy.generation==p->generation&&(jpeg&Cards)&&!(jpeg&~Cards)&&(raw&Cards)==e.expected){bool complete=true;e.index=index;
  if(e.policy.format==1){for(unsigned k=0;k<2;++k)if(e.expected&(k?Sd:Xqd)){auto&f=e.files[k];complete=complete&&f.held>=0&&f.closed&&f.size;if(f.base[0]){if(base[0]&&std::strcmp(base,f.base))complete=false;else std::strcpy(base,f.base);}}}
  else{complete=read(node+0x25,base,17)&&std::memchr(base,0,17)&&base[0];}
  if(complete){e.policy.raw_mask=e.expected;e.policy.jpeg_mask=jpeg;e.state=2;n=e.serial;}break;
 }
 leave();if(!n)return 0;char*dot=std::strrchr(base,'.');if(dot)*dot=0;
 int matched=0;try{matched=ops.catalog(ops.context,node,index,base,raw,0);}catch(...){matched=0;}
 if(matched!=1){if(enter()){if(auto*e=bySerial(n))releaseEntry(*e);leave();}else __atomic_add_fetch(&epoch,1,__ATOMIC_RELEASE);return 0;}out->serial=n;return 1;}
extern "C" void iq4_new_raw_backup_enqueue_55(void*ifm,uint32_t index){uint64_t serial=0;uintptr_t node=0;
 if(__atomic_load_n(&bound,__ATOMIC_ACQUIRE)&&enter()){for(auto&e:entries)if(e.state==1&&e.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e.policy.format==1&&e.policy.sd_mode==4&&e.index==index&&e.sealed&&e.expected==Xqd&&e.files[0].held>=0&&e.files[0].closed&&e.files[0].size){serial=e.serial;node=e.id.node;break;}leave();}
 int quiet=0;if(serial)try{quiet=ops.backup_quiet(ops.context,uintptr_t(ifm),node,index);}catch(...){quiet=0;}
 if(quiet==1&&enter()){auto*e=bySerial(serial);bool sameEntry=e&&e->state==1&&e->epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e->id.node==node&&e->index==index;if(sameEntry)e->backup_suppressed=1;leave();if(sameEntry)return;}
 iq4_new_raw_original_backup_enqueue_55(ifm,index);
}
extern "C" int iq4_new_raw_backup_suppressed_55(uintptr_t node,uint32_t index){if(!enter())return 0;int ok=0;for(const auto&e:entries)if(e.state&&e.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&e.id.node==node&&e.index==index&&e.policy.format==1&&e.policy.sd_mode==4&&e.expected==Xqd&&e.backup_suppressed){ok=1;break;}leave();return ok;}
extern "C" int iq4_new_raw_publication_55(Iq4NewRawTicket55 t,uint32_t mask){if(!enter())return 0;int r=0;auto*e=bySerial(t.serial);if(e&&e->state==2&&!(mask&~e->policy.jpeg_mask)){e->published|=mask;r=1;}leave();return r;}
extern "C" int iq4_new_raw_end_55(Iq4NewRawTicket55 t,int jobOk){if(!enter())return 0;Entry copy{};auto*e=bySerial(t.serial);if(!e||(e->state!=2&&e->state!=3&&e->state!=5)){leave();return 0;}if(__atomic_load_n(&e->retire_ready,__ATOMIC_ACQUIRE)){int r=e->retire_result;releaseEntry(*e);leave();return r;}if(e->retire_started){leave();return 0;}copy=*e;e->state=3;e->retire_started=1;leave();int result=2;
 char base[64]{};for(const auto&f:copy.files)if(f.base[0]){std::strcpy(base,f.base);break;}char*dot=std::strrchr(base,'.');if(dot)*dot=0;
 try{if(copy.policy.format==1&&copy.state==2&&copy.epoch==__atomic_load_n(&epoch,__ATOMIC_ACQUIRE)&&jobOk==1&&copy.published==copy.policy.jpeg_mask&&ops.catalog(ops.context,copy.id.node,copy.index,base,copy.policy.raw_mask,1)==1){result=1;for(auto&f:copy.files)if(copy.policy.raw_mask&f.card){int r=cleanupFile(f,copy.serial);if(r!=1){result=r;break;}if(ops.removed(ops.context,copy.id.node,copy.index,f.card)!=1){result=-1;break;}}}}
 catch(...){result=-1;}
 // State3/5 retains this entry until this one synchronous I/O section ends.
 // A repeated end can only retire descriptors; it never repeats removal.
 e->retire_result=result;__atomic_store_n(&e->retire_ready,1,__ATOMIC_RELEASE);
 if(!enter())return -1; // No finite descriptor retirement: callers must HOLD.
 e=bySerial(t.serial);if(!e||(e->state!=3&&e->state!=5)){leave();return -1;}
 releaseEntry(*e);leave();return result;
}
