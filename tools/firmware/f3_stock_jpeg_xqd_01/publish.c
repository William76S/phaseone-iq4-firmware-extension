#define _GNU_SOURCE
#include "stock.h"
#include <stdint.h>
#include <stddef.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
extern int iq4_stock_publish_host_fault(unsigned);
extern int iq4_stock_publish_host_mount(int,uint64_t*);
#else
#include <sys/syscall.h>
_Static_assert(sizeof(struct stat)==128 && offsetof(struct stat,st_ino)==8 && offsetof(struct stat,st_size)==48,"A64 Linux stat");
_Static_assert(SYS_openat==56 && SYS_newfstatat==79 && SYS_fstat==80 && SYS_write==64 && SYS_read==63 && SYS_fsync==82 && SYS_close==57 && SYS_renameat2==276 && SYS_unlinkat==35,"A64 Linux IO");
extern long iq4_f3_original_syscall_03(long,...);
extern int *iq4_f3_original_errno_location_03(void);
#endif
/* Native LinuxFilesystem root and relative name are obtained by runtime.cpp.
 * Exclusive staging never truncates a RAW, JPEG, or unknown prior temp file. */
enum {P_OPEN=1,P_STAT,P_WRITE,P_SYNC,P_CLOSE,P_RENAME,P_UNLINK,P_READ};
static uint32_t serial;
static int err(void){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 return errno;
#else
 return *iq4_f3_original_errno_location_03();
#endif
}
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
static int fault(unsigned op){int e=iq4_stock_publish_host_fault(op);if(e)errno=e;return e;}
#endif
static int op(int fd,const char*p,int flags){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_OPEN))return -1;return openat(fd,p,flags,0600);
#else
 return (int)iq4_f3_original_syscall_03(SYS_openat,fd,p,flags,0600);
#endif
}
static int st(int fd,struct stat*s){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_STAT))return -1;return fstat(fd,s);
#else
 return (int)iq4_f3_original_syscall_03(SYS_fstat,fd,s);
#endif
}
static int lst(int fd,const char*p,struct stat*s){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_STAT))return -1;return fstatat(fd,p,s,AT_SYMLINK_NOFOLLOW);
#else
 return (int)iq4_f3_original_syscall_03(SYS_newfstatat,fd,p,s,AT_SYMLINK_NOFOLLOW);
#endif
}
static long wr(int fd,const void*p,size_t n){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_WRITE))return -1;return write(fd,p,n);
#else
 return iq4_f3_original_syscall_03(SYS_write,fd,p,n);
#endif
}
static int sync_(int fd){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_SYNC))return -1;return fsync(fd);
#else
 return (int)iq4_f3_original_syscall_03(SYS_fsync,fd);
#endif
}
static int close_(int*fd){if(*fd<0)return 1;int d=*fd;*fd=-1;
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 int e=fault(P_CLOSE),r=close(d);return !e&&!r;
#else
 return !iq4_f3_original_syscall_03(SYS_close,d);
#endif
}
static int unlink_(int d,const char*p){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_UNLINK))return -1;return unlinkat(d,p,0);
#else
 return (int)iq4_f3_original_syscall_03(SYS_unlinkat,d,p,0);
#endif
}
static int publish_(int d,const char*from,const char*to){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 if(fault(P_RENAME))return -1;
 /* macOS host equivalent has the same no-overwrite link commit. A failure
  * after link must be unknown (2), not a native worker success. */
 if(linkat(d,from,d,to,0))return -1;
 return unlinkat(d,from,0)?2:0;
#else
 return (int)iq4_f3_original_syscall_03(SYS_renameat2,d,from,d,to,1u);
#endif
}
static size_t decimal(char*b,uint64_t n){char tmp[24];size_t z=0,k=0;do{tmp[z++]=(char)('0'+n%10);n/=10;}while(n);while(z)b[k++]=tmp[--z];b[k]=0;return k;}
static int mount_(int fd,uint64_t*out){
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 return iq4_stock_publish_host_mount(fd,out);
#else
 char path[64]="/proc/self/fdinfo/",data[2048];decimal(path+18,(unsigned)fd);int d=op(AT_FDCWD,path,O_RDONLY|O_NOFOLLOW|O_CLOEXEC);if(d<0)return 0;
 long n=iq4_f3_original_syscall_03(SYS_read,d,data,sizeof(data)-1);if(!close_(&d))return -1;if(n<=0||n>=(long)sizeof(data)-1)return 0;data[n]=0;
 for(long i=0;i<n;++i)if((!i||data[i-1]=='\n')&&i+7<n&&!memcmp(data+i,"mnt_id:",7)){long j=i+7;while(j<n&&(data[j]==' '||data[j]=='\t'))++j;uint64_t v=0;unsigned digits=0;while(j<n&&data[j]>='0'&&data[j]<='9'){if(v>(UINT64_MAX-9)/10)return 0;v=v*10+(unsigned)(data[j++]-'0');++digits;}if(!digits||!v||j>=n||data[j]!='\n')return 0;*out=v;return 1;}
 return 0;
#endif
}
static int same(const struct stat*a,const struct stat*b){return a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_mode==b->st_mode;}
static int valid_leaf(const char*p,size_t n){if(!n||n>128||p[0]=='.')return 0;for(size_t i=0;i<n;++i){unsigned char c=(unsigned char)p[i];if(!((c>='a'&&c<='z')||(c>='A'&&c<='Z')||(c>='0'&&c<='9')||c=='_'||c=='-'||c=='.'))return 0;}return n>=5&&!memcmp(p+n-4,".JPG",4);}
static int guard_(int(*g)(void)){return g&&g()==1;}
int iq4_stock_jpeg_publish_01(const char*root,const char*relative,const void*jpeg,uint32_t bytes,int(*guard)(void)){
 int r=-1,parent=-1,dcim=-1,dir=-1,file=-1,probe=-1;int outcome=0,created=0,committed=0;uint64_t mount=0,pmount=0;struct stat rs,ds,fs,current;
 char folder[16],leaf[129],temp[80],root_path[256];
 if(!root||!relative||!jpeg||bytes<4||bytes>104857600u||!guard_(guard))return 0;
 size_t root_n=strnlen(root,256);if(!root_n||root_n>=256)return 0;memcpy(root_path,root,root_n+1);if(root_n>1&&root_path[root_n-1]=='/')root_path[root_n-1]=0;
 size_t n=strnlen(relative,256);if(n>=256||n<18||memcmp(relative,"DCIM/",5)||relative[13]!='/')return 0;
 memcpy(folder,relative+5,8);folder[8]=0;
 if(folder[0]<'1'||folder[0]>'9'||folder[1]<'0'||folder[1]>'9'||folder[2]<'0'||folder[2]>'9'||memcmp(folder+3,"PHASE",5)||!valid_leaf(relative+14,n-14))return 0;
 memcpy(leaf,relative+14,n-14+1);
 const int flags=O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC;
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 r=op(AT_FDCWD,root,flags);parent=op(AT_FDCWD,"/",flags);
#else
 if(strcmp(root,"/run/media/sdcard/")&&strcmp(root,"/run/media/xqdcard/"))return 0;
 probe=op(AT_FDCWD,"/",flags);if(probe<0)goto done;parent=op(probe,"run",flags);if(!close_(&probe)){outcome=-1;goto done;}if(parent<0)goto done;
 probe=op(parent,"media",flags);if(!close_(&parent)){outcome=-1;goto done;}parent=probe;probe=-1;if(parent<0)goto done;
 r=op(parent,root[11]=='s'?"sdcard":"xqdcard",flags);
#endif
 if(r<0||parent<0||st(r,&rs)||!S_ISDIR(rs.st_mode))goto done;
 {int a=mount_(r,&mount),b=mount_(parent,&pmount);if(a<0||b<0){outcome=-1;goto done;}if(a!=1||b!=1||mount==pmount)goto done;}
 if(!close_(&parent)){outcome=-1;goto done;}
 dcim=op(r,"DCIM",flags);if(dcim<0)goto done;dir=op(dcim,folder,flags);if(dir<0||st(dir,&ds)||!S_ISDIR(ds.st_mode)||ds.st_dev!=rs.st_dev)goto done;
 if(!close_(&dcim)){outcome=-1;goto done;}if(!guard_(guard)){outcome=-1;goto done;}
 memcpy(temp,".iq4-stock-jpeg-",16);size_t k=16;
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 k+=decimal(temp+k,(unsigned)getpid());
#else
 {long pid=iq4_f3_original_syscall_03(SYS_getpid);if(pid<=0)goto done;k+=decimal(temp+k,(uint64_t)pid);}
#endif
 temp[k++]='-';k+=decimal(temp+k,__atomic_add_fetch(&serial,1,__ATOMIC_RELAXED));memcpy(temp+k,".tmp",5);
 file=op(dir,temp,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC);if(file<0)goto done;created=1;
 if(st(file,&fs)||!S_ISREG(fs.st_mode)||fs.st_nlink!=1||fs.st_size!=0||fs.st_dev!=rs.st_dev){outcome=-1;goto done;}
 {size_t off=0;unsigned interrupted=0;while(off<bytes){if(!guard_(guard)){outcome=-1;goto done;}size_t amount=bytes-off;if(amount>1048576)amount=1048576;long q=wr(file,(const char*)jpeg+off,amount);if(q<0&&err()==EINTR&&++interrupted<=8)continue;if(q<=0||(size_t)q>amount)goto done;interrupted=0;off+=(size_t)q;}}
 if(sync_(file)||st(file,&current)||!same(&fs,&current)||current.st_nlink!=1||current.st_size!=bytes)goto done;
 if(!close_(&file)){outcome=-1;goto done;}
 if(!guard_(guard)||st(r,&current)||!same(&rs,&current)){outcome=-1;goto done;}
 {uint64_t now=0;int a=mount_(r,&now);if(a!=1||now!=mount){outcome=-1;goto done;}}
 /* Re-open the currently mounted root before committing to the held directory. */
 probe=op(AT_FDCWD,root_path,flags);if(probe<0||st(probe,&current)||!same(&rs,&current)){outcome=-1;goto done;}
 {uint64_t now=0;if(mount_(probe,&now)!=1||now!=mount){outcome=-1;goto done;}}if(!close_(&probe)){outcome=-1;goto done;}
 if(!guard_(guard)||lst(dir,temp,&current)||!same(&fs,&current)||current.st_size!=bytes||current.st_nlink!=1){outcome=-1;goto done;}
 {int q=publish_(dir,temp,leaf);if(q==2){committed=1;outcome=-1;goto done;}if(q)goto done;committed=1;created=0;}
 if(sync_(dir)||lst(dir,leaf,&current)||!same(&fs,&current)||current.st_size!=bytes||current.st_nlink!=1||!guard_(guard)){outcome=-1;goto done;}
 outcome=1;
 done:
 if(!close_(&file))outcome=-1;
 if(created&&!committed){/* Only remove our own exact inode on the same still-valid card. */
  if(outcome<0||!guard_(guard)||lst(dir,temp,&current)||!same(&fs,&current)||current.st_nlink!=1)outcome=-1;
  else if(unlink_(dir,temp)||sync_(dir))outcome=-1;
 }
 if(!close_(&probe))outcome=-1;if(!close_(&dir))outcome=-1;if(!close_(&dcim))outcome=-1;if(!close_(&parent))outcome=-1;if(!close_(&r))outcome=-1;
 return outcome;
}
/* Read-only mounted-card check used before native catalog clear/rescan.
 * This is private to the core; no product/debug menu surface is added. */
int iq4_stock_jpeg_probe_mount_01(const char*root,int(*guard)(void)){
 int r=-1,parent=-1;uint64_t m=0,p=0;int result=0;struct stat a;char path[256];size_t n;
 if(!root||!guard_(guard)||(n=strnlen(root,sizeof path))==sizeof path||!n)return 0;memcpy(path,root,n+1);if(n>1&&path[n-1]=='/')path[n-1]=0;
 const int flags=O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC;
#ifdef IQ4_STOCK_JPEG_PUBLISH_HOST
 r=op(AT_FDCWD,path,flags);parent=op(AT_FDCWD,"/",flags);
#else
 if(strcmp(root,"/run/media/sdcard/")&&strcmp(root,"/run/media/xqdcard/"))return 0;r=op(AT_FDCWD,path,flags);parent=op(AT_FDCWD,"/run/media",flags);
#endif
 if(r>=0&&parent>=0&&!st(r,&a)&&S_ISDIR(a.st_mode)){int x=mount_(r,&m),y=mount_(parent,&p);if(x<0||y<0)result=-1;else if(x==1&&y==1&&m!=p&&guard_(guard))result=1;}
 if(!close_(&parent))result=-1;if(!close_(&r))result=-1;return result;
}
