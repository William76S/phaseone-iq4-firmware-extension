#define IQ4_NEW_RAW_TEST
#include "receipt.cpp"
#include <cassert>
#include <cstdarg>
#include <cstdlib>
#include <vector>
#include <string>
#include <pthread.h>
extern "C" void iq4_new_raw_enqueue_thunk_55(){}
static std::vector<unsigned char> cm(0x8200),pool(0x400),node(0x200),meta(0x60),payload(0x2500),production(0x1500),raw(0x60),xqd(0x600),sd(0x600),fsx(0x220),fss(0x220);
static unsigned enqueues=0,events=0,removes=0,groups=0,backupEnqueues=0;static int backupBusy=0,policyThrows=0,lockAfterCatalog=0;static uint32_t nativeflags=6,failAfterClose=0,closeFailure=0,leaseBusy=0,identityMismatch=0,raceRename=0,denyRename=0;
static Iq4NewRawPolicy55 requested{1,1,4,0,0,1};static std::string rootDir,currentPath;static int nativeFd=-1;static void*currentFs=nullptr;static unsigned char fakeFile[24];static int catalog(void*,uintptr_t p,uint32_t i,const char*b,uint32_t flags,int after){if(after&&lockAfterCatalog){lockAfterCatalog=0;assert(enter());}return !identityMismatch&&p==uintptr_t(node.data())&&i==3&&!std::strcmp(b,"CAPTURE")&&(nativeflags&flags)==flags&&(!after||!leaseBusy);}
static int removed(void*,uintptr_t p,uint32_t i,uint32_t mask){assert(p==uintptr_t(node.data())&&i==3);nativeflags&=~mask;removes++;return 1;}
static int policy(void*,Iq4NewRawPolicy55*p){if(policyThrows)throw 1;*p=requested;return 1;}
static int backupQuiet(void*,uintptr_t ifm,uintptr_t p,uint32_t i){return ifm==0xabc000&&p==uintptr_t(node.data())&&i==3&&nativeflags==2&&!backupBusy;}
static int memory(void*,uintptr_t p,void*out,size_t n){for(const auto&q:NewRawPins55)if(p>=q.va&&p+n<=q.va+q.bytes){std::memcpy(out,q.data+(p-q.va),n);return 1;}for(auto*v:{&cm,&pool,&node,&meta,&payload,&production,&raw,&xqd,&sd,&fsx,&fss})if(p>=uintptr_t(v->data())&&p+n<=uintptr_t(v->data())+v->size()){std::memcpy(out,(void*)p,n);return 1;}if(p>=uintptr_t(fakeFile)&&p+n<=uintptr_t(fakeFile)+sizeof fakeFile){std::memcpy(out,(void*)p,n);return 1;}return 0;}
template<class T>static void put(std::vector<unsigned char>&v,size_t off,T n){std::memcpy(v.data()+off,&n,sizeof n);}
extern "C" long iq4_new_raw_syscall_55(long n,...){va_list ap;va_start(ap,n);long a[6]{};if(n==SYS_gettid){va_end(ap);return long(pthread_self());}for(auto&i:a)i=va_arg(ap,long);va_end(ap);
 switch(n){case SYS_close:return close(int(a[0]));case SYS_fcntl:return fcntl(int(a[0]),int(a[1]),a[2]);case SYS_fstat:return fstat(int(a[0]),(struct stat*)a[1]);case SYS_openat:return openat(int(a[0]),(const char*)a[1],int(a[2]),int(a[3]));case SYS_newfstatat:return fstatat(int(a[0]),(const char*)a[1],(struct stat*)a[2],int(a[3]));case SYS_unlinkat:return unlinkat(int(a[0]),(const char*)a[1],int(a[2]));case SYS_fsync:return fsync(int(a[0]));case SYS_renameat2:{if(denyRename){errno=ENOSYS;return -1;}if(raceRename){raceRename=0;unlinkat(int(a[0]),(const char*)a[1],0);int f=openat(int(a[0]),(const char*)a[1],O_WRONLY|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,"foreign",7)==7&&!close(f));}
#ifdef __APPLE__
 return renameatx_np(int(a[0]),(const char*)a[1],int(a[2]),(const char*)a[3],RENAME_EXCL);
#else
 return syscall(SYS_renameat2,a[0],a[1],a[2],a[3],a[4]);
#endif
 }default:assert(false);return -1;}}
extern "C" int*iq4_new_raw_errno_55(){return &errno;}
extern "C" int iq4_new_raw_original_open_55(const char*p,int flags,unsigned mode){return open(p,flags,mode);}
extern "C" void iq4_new_raw_original_enqueue_55(void*,void*){enqueues++;}
extern "C" void iq4_new_raw_original_node_event_55(void*){events++;}
extern "C" void iq4_new_raw_original_refs_55(void*,void*,uint8_t){}
extern "C" void iq4_new_raw_original_backup_enqueue_55(void*,uint32_t){backupEnqueues++;}
extern "C" bool iq4_new_raw_original_writer_close_55(void*){bool r=close(nativeFd)==0;nativeFd=-1;return r&&!closeFailure;}
extern "C" bool iq4_new_raw_original_file_close_55(void*f){int fd;std::memcpy(&fd,(unsigned char*)f+16,4);((unsigned char*)f)[20]=0;return close(fd)==0&&!closeFailure;}
extern "C" void iq4_new_raw_original_file_dtor_55(void*f){if(((unsigned char*)f)[20])iq4_new_raw_original_file_close_55(f);}
static bool create(const char*path,bool isXqd){nativeFd=iq4_new_raw_open_55(path,O_WRONLY|O_CREAT|O_TRUNC|O_CLOEXEC,0600);if(nativeFd<0)return false;char data[1024]{};data[0]='I';data[1]='I';data[2]='Q';assert(write(nativeFd,data,sizeof data)==sizeof data);
 if(isXqd){assert(!close(nativeFd));nativeFd=iq4_new_raw_open_55(path,O_RDWR|O_CLOEXEC,0);if(nativeFd<0)return false;assert(pwrite(nativeFd,"IIQfull",7,0)==7);std::memset(fakeFile,0,sizeof fakeFile);std::memcpy(fakeFile+8,&currentFs,8);std::memcpy(fakeFile+16,&nativeFd,4);fakeFile[20]=1;iq4_new_raw_xqd_dtor_55(fakeFile);nativeFd=-1;}else iq4_new_raw_sd_close_55(nullptr);return !failAfterClose;}
extern "C" bool iq4_new_raw_original_xqd_store_55(void*,void*,const char*p){currentFs=fsx.data();return create(p,true);}
extern "C" bool iq4_new_raw_original_sd_store_55(void*,void*,void*,void*,void*,void*,const char*p){currentFs=fss.data();return create(p,false);}
static void init(){assert(!iq4_new_raw_active_55());for(auto*v:{&cm,&pool,&node,&meta,&payload,&production,&raw,&xqd,&sd,&fsx,&fss})std::fill(v->begin(),v->end(),0);requested={1,1,4,0,0,1};nativeflags=6;failAfterClose=closeFailure=leaseBusy=identityMismatch=raceRename=denyRename=backupBusy=policyThrows=lockAfterCatalog=0;
 put(pool,0,uint64_t(0xdb4980));put(cm,0x2090,uintptr_t(pool.data()));put(cm,0x2098,uintptr_t(node.data()));put(cm,0x80f8,uintptr_t(production.data()));put(cm,0x2330,uint32_t(0));put(node,0x88,uintptr_t(raw.data()));put(node,0x90,uintptr_t(meta.data()));put(node,0xd8,uint32_t(3));put(meta,0x40,uintptr_t(payload.data()));put(payload,0xb8,uint32_t(0));put(xqd,0,uint64_t(0xdbc280));put(xqd,0x2c0,uintptr_t(fsx.data()));put(sd,0,uint64_t(0xdbc6b8));put(sd,0x2c0,uintptr_t(fss.data()));put(fsx,0,uint64_t(0xd91450));put(fss,0,uint64_t(0xd91450));Iq4NewRawOps55 a{nullptr,memory,policy,catalog,removed,uintptr_t(fsx.data()),uintptr_t(fss.data()),backupQuiet};assert(iq4_new_raw_bind_55(&a));char t[]="/tmp/IQ4-owned55-XXXXXX";assert(mkdtemp(t));rootDir=t;assert(!mkdir((rootDir+"/xqd").c_str(),0700)&&!mkdir((rootDir+"/sd").c_str(),0700));}
static void capture(uint32_t mask){nativeflags=mask;std::memcpy(node.data()+0x25,"CAPTURE",8);iq4_new_raw_enqueue_55(pool.data(),node.data(),cm.data());iq4_new_raw_refs_55(pool.data(),node.data(),uint8_t(mask));}
static bool store(uint32_t card){currentPath=rootDir+(card==2?"/xqd/":"/sd/")+"CAPTURE.IIQ";if(card==2)return iq4_new_raw_xqd_store_55(xqd.data(),node.data(),currentPath.c_str());return iq4_new_raw_sd_store_55(sd.data(),node.data(),fss.data(),nullptr,nullptr,nullptr,currentPath.c_str(),uintptr_t(iq4_new_raw_original_sd_store_55));}
static Iq4NewRawTicket55 acquire(uint32_t mask,uint32_t jpg=2){Iq4NewRawTicket55 t{};assert(iq4_new_raw_acquire_55(uintptr_t(node.data()),3,&requested,mask,jpg,&t)==1&&t.serial);return t;}
static void cleanup(){if(iq4_new_raw_active_55())iq4_new_raw_node_event_55(node.data());for(auto&e:entries)if(e.state)releaseEntry(e);for(auto c:{"xqd","sd"}){std::string p=rootDir+"/"+c;unlink((p+"/CAPTURE.IIQ").c_str());for(uint64_t n=1;n<=nextSerial;n++){char name[80];std::snprintf(name,sizeof name,".IQ4-JPEG-%016llx-%u.IIQ",(unsigned long long)n,c[0]=='x'?2:4);unlink((p+"/"+name).c_str());}assert(!rmdir(p.c_str()));}assert(!rmdir(rootDir.c_str()));groups++;}
int main(){
 init();capture(4);assert(store(4));auto t=acquire(4,4);assert(iq4_new_raw_publication_55(t,4)&&iq4_new_raw_end_55(t,1)==1&&access(currentPath.c_str(),F_OK));cleanup();
 init();capture(6);assert(store(2)&&store(4));t=acquire(6,6);assert(iq4_new_raw_publication_55(t,2)&&iq4_new_raw_end_55(t,1)==2&&!access(currentPath.c_str(),F_OK));cleanup();
 init();capture(6);assert(store(2)&&store(4));t=acquire(6,6);assert(iq4_new_raw_publication_55(t,6)&&iq4_new_raw_end_55(t,1)==1);cleanup();
 init();capture(2);assert(store(2));t=acquire(2);assert(!iq4_new_raw_publication_55(t,4));assert(iq4_new_raw_publication_55(t,2));leaseBusy=1;assert(iq4_new_raw_end_55(t,1)==2&&!access(currentPath.c_str(),F_OK));cleanup();
 init();capture(2);assert(store(2));t=acquire(2);assert(iq4_new_raw_publication_55(t,2));assert(iq4_new_raw_end_55(t,0)==2&&!access(currentPath.c_str(),F_OK));cleanup();
 init();capture(2);assert(store(2));t=acquire(2);assert(iq4_new_raw_publication_55(t,2));denyRename=1;assert(iq4_new_raw_end_55(t,1)==2&&!access(currentPath.c_str(),F_OK));cleanup();
 init();capture(2);assert(store(2));t=acquire(2);assert(iq4_new_raw_publication_55(t,2));raceRename=1;assert(iq4_new_raw_end_55(t,1)==-1);int f=open(currentPath.c_str(),O_RDONLY);char foreign[7];assert(f>=0&&read(f,foreign,7)==7&&!std::memcmp(foreign,"foreign",7)&&!close(f));cleanup();
 init();capture(2);assert(store(2));t=acquire(2);iq4_new_raw_node_event_55(node.data());assert(!iq4_new_raw_publication_55(t,2)&&iq4_new_raw_end_55(t,1)==2);cleanup();
 init();capture(2);assert(store(2));Iq4NewRawTicket55 no{};Iq4NewRawPolicy55 other=requested;other.generation++;assert(!iq4_new_raw_acquire_55(uintptr_t(node.data()),3,&other,2,2,&no)&&!no.serial);cleanup();
 init();capture(2);currentPath=rootDir+"/xqd/CAPTURE.IIQ";f=open(currentPath.c_str(),O_WRONLY|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,"oldraw",6)==6&&!close(f));assert(!store(2));f=open(currentPath.c_str(),O_RDONLY);assert(read(f,foreign,6)==6&&!std::memcmp(foreign,"oldraw",6)&&!close(f));assert(!iq4_new_raw_active_55());cleanup();
 init();capture(2);assert(store(2));t=acquire(2);assert(iq4_new_raw_publication_55(t,2));lockAfterCatalog=1;unsigned oldRemoves=removes;assert(iq4_new_raw_end_55(t,1)==-1&&iq4_new_raw_active_55()==1&&removes==oldRemoves+1);leave();assert(iq4_new_raw_end_55(t,1)==1&&!iq4_new_raw_active_55()&&removes==oldRemoves+1);cleanup();
 init();capture(2);closeFailure=1;assert(store(2));assert(!iq4_new_raw_active_55());cleanup();
 init();capture(2);failAfterClose=1;assert(!store(2)&&!iq4_new_raw_active_55());cleanup();
 for(unsigned flag=0;flag<5;++flag){init();if(flag==0)put(cm,0x2708,uint8_t(1));if(flag==1)put(production,0x1a0,uint8_t(1));if(flag==2)put(production,0x1488,uint32_t(1));if(flag==3)put(cm,0xc08,uint8_t(1));if(flag==4){put(cm,0x26fc,uint32_t(6));put(payload,0x484,uint32_t(6));}unsigned before=enqueues;capture(2);assert(enqueues==before+1&&!iq4_new_raw_active_55());cleanup();}
 init();requested.format=2;capture(2);assert(iq4_new_raw_active_55()==1);assert(store(2));Iq4NewRawPolicy55 captured{};assert(iq4_new_raw_policy_55(uintptr_t(node.data()),3,&captured)==1&&captured.format==2);t=acquire(2);assert(iq4_new_raw_publication_55(t,2)&&iq4_new_raw_end_55(t,1)==2&&!access(currentPath.c_str(),F_OK)&&!iq4_new_raw_active_55());cleanup();
 init();capture(2);assert(store(2));unsigned beforeBackup=backupEnqueues;iq4_new_raw_backup_enqueue_55((void*)0xabc000,3);assert(backupEnqueues==beforeBackup&&iq4_new_raw_backup_suppressed_55(uintptr_t(node.data()),3)==1);t=acquire(2,6);assert(iq4_new_raw_publication_55(t,6)&&iq4_new_raw_end_55(t,1)==1);cleanup();
 init();capture(2);assert(store(2));backupBusy=1;beforeBackup=backupEnqueues;iq4_new_raw_backup_enqueue_55((void*)0xabc000,3);assert(backupEnqueues==beforeBackup+1&&!iq4_new_raw_backup_suppressed_55(uintptr_t(node.data()),3));cleanup();
 init();capture(2);assert(store(2));beforeBackup=backupEnqueues;iq4_new_raw_backup_enqueue_55((void*)0xdef000,3);assert(backupEnqueues==beforeBackup+1);cleanup();
 init();capture(2);assert(store(2));nativeflags=6;beforeBackup=backupEnqueues;iq4_new_raw_backup_enqueue_55((void*)0xabc000,3);assert(backupEnqueues==beforeBackup+1&&!iq4_new_raw_acquire_55(uintptr_t(node.data()),3,&requested,6,6,&no));cleanup();
 init();requested.format=2;capture(2);beforeBackup=backupEnqueues;iq4_new_raw_backup_enqueue_55((void*)0xabc000,3);assert(backupEnqueues==beforeBackup+1);cleanup();
 init();policyThrows=1;unsigned beforeQueue=enqueues;capture(2);assert(enqueues==beforeQueue+1&&!iq4_new_raw_active_55());cleanup();
 init();assert(iq4_new_raw_settings_enter_55());assert(!iq4_new_raw_settings_enter_55());iq4_new_raw_settings_leave_55();capture(2);assert(iq4_new_raw_active_55()==1&&!iq4_new_raw_settings_enter_55());iq4_new_raw_node_event_55(node.data());assert(iq4_new_raw_settings_enter_55());iq4_new_raw_settings_leave_55();cleanup();
 std::printf("PASS %u focused groups; actual host inode/files, native objects/ABI/pixel/JPEG data are fixtures; camera not accessed\n",groups);
}
