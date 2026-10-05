#define _DARWIN_C_SOURCE
#include "../f3_file_arena_01/arena.h"
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>
static uint64_t current_epoch=7;
static int current_owner=1,drop_at_map,partial_write,fail_write,fail_flush,drop_after_unmap;
static int allocate_ok,write_calls,closed_calls,map_calls;
static struct F3SysResult res(int64_t n){return(struct F3SysResult){n,n<0?errno:0};}
static uint64_t epoch(void *p){(void)p;return current_epoch;}
static int owner(void *p){(void)p;return current_owner;}
static unsigned unique_fault,unique_opens;
static struct F3SysResult open_leaf(int d,const char *s,int wrflag) {
 ++unique_opens;
 if(wrflag&&unique_fault==1&&unique_opens==1){int fd=openat(d,s,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);assert(fd>=0&&write(fd,"KEEP",4)==4&&!close(fd));return(struct F3SysResult){-1,EEXIST};}
 if(wrflag&&unique_fault==2)return(struct F3SysResult){-1,EEXIST};
 if(wrflag&&unique_fault==3)return(struct F3SysResult){-1,EACCES};
 if(wrflag&&unique_fault==4){current_epoch=8;return(struct F3SysResult){-1,EEXIST};}
 return res(openat(d,s,wrflag?(O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW):(O_RDONLY|O_NOFOLLOW),0600));
}
static void statcopy(struct F3FdStat *out,const struct stat *s) {
 *out=(struct F3FdStat){s->st_dev,s->st_ino,(uint64_t)s->st_size,s->st_nlink,s->st_mode,s->st_mtimespec.tv_sec,s->st_mtimespec.tv_nsec};
}
static struct F3SysResult stfd(int fd,struct F3FdStat *out){struct stat s;int n=fstat(fd,&s);if(!n)statcopy(out,&s);return res(n);}
static struct F3SysResult stleaf(int d,const char *s,struct F3FdStat *out){struct stat st;int n=fstatat(d,s,&st,AT_SYMLINK_NOFOLLOW);if(!n)statcopy(out,&st);return res(n);}
static struct F3SysResult wr(int fd,const void *p,uint32_t n){++write_calls;if(fail_write){errno=ENOSPC;return res(-1);}return res(write(fd,p,partial_write&&n>1?n/2:n));}
static struct F3SysResult sy(int fd){return res(fsync(fd));}
static struct F3SysResult cl(int fd){++closed_calls;return res(close(fd));}
static struct F3SysResult ul(int d,const char *s){return res(unlinkat(d,s,0));}
static struct F3SysResult tr(int fd,uint64_t n){return res(ftruncate(fd,(off_t)n));}
static struct F3SysResult alloc(int fd,uint64_t n){/* Host success branch is a fixture,
  * never a disk reservation claim. Actual host reservation test uses zero writes. */
 if(allocate_ok)return tr(fd,n);return(struct F3SysResult){-2,0};}
static struct F3SysResult mp(int fd,uint64_t n){++map_calls;void *p=mmap(0,(size_t)n,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);if(drop_at_map)current_epoch=8;return res((intptr_t)p);}
static struct F3SysResult flush(void *p,uint64_t n){if(fail_flush){errno=EIO;return res(-1);}return res(msync(p,(size_t)n,MS_SYNC));}
static struct F3SysResult unmap(void *p,uint64_t n){int r=munmap(p,(size_t)n);if(drop_after_unmap)current_epoch=8;return res(r);}
static struct F3ArenaApi api(void){struct F3ArenaApi a={0};a.io.open_leaf=open_leaf;a.io.stat_fd=stfd;a.io.stat_leaf=stleaf;a.io.write=wr;a.io.sync=sy;a.io.close=cl;a.io.unlink_leaf=ul;a.truncate=tr;a.allocate=alloc;a.map_shared=mp;a.flush_map=flush;a.unmap=unmap;return a;}
static struct F3CardGuard card(void){return(struct F3CardGuard){0,epoch,owner};}
static uint8_t zeros[F3_ARENA_ZERO_BYTES];
static struct F3ArenaApi aapi;
static struct F3CardGuard guard;
static enum F3ArenaStatus create(struct F3Arena *a,int d,uint64_t id){return f3_arena_create_01(a,&aapi,&guard,d,7,id,9,131072,zeros,sizeof zeros);}
static int exists(int d,const char *s){struct stat st;return !fstatat(d,s,&st,AT_SYMLINK_NOFOLLOW);}
static void fixture_clean(struct F3Arena *a){/* Host fault injector owns its fds;
  * this is not a production recovery method for UNKNOWN state. */
 if(a->base)assert(!munmap(a->base,(size_t)a->bytes));
 if(a->fd>=0)assert(!close(a->fd));
 if(a->leaf[0])assert(!unlinkat(a->dirfd,a->leaf,0));
}
int main(void){
 char path[]="/tmp/iq4-arena-XXXXXX";assert(mkdtemp(path));int d=open(path,O_RDONLY|O_DIRECTORY);assert(d>=0);aapi=api();guard=card();unsigned groups=0;
 struct F3Arena a={0};assert(create(&a,d,1)==F3_ARENA_OK&&a.reservation_method==2&&write_calls==2);void *p=0;uint64_t n=0;assert(f3_arena_loan_01(&a,&p,&n)==F3_ARENA_OK&&n==131072);assert(f3_arena_release_01(&a)==F3_ARENA_BUSY);memset(p,0x51,(size_t)n);assert(!msync(p,(size_t)n,MS_SYNC));int readfd=openat(d,a.leaf,O_RDONLY|O_NOFOLLOW);assert(readfd>=0);uint8_t block[4096];assert(pread(readfd,block,sizeof block,65536)==sizeof block);for(size_t i=0;i<sizeof block;++i)assert(block[i]==0x51);assert(!close(readfd));assert(f3_arena_end_loan_01(&a)==F3_ARENA_OK&&f3_arena_release_01(&a)==F3_ARENA_OK&&!exists(d,a.leaf));++groups;
 a=(struct F3Arena){0};partial_write=1;assert(create(&a,d,2)==F3_ARENA_OK);assert(f3_arena_release_01(&a)==F3_ARENA_OK);partial_write=0;++groups;
 a=(struct F3Arena){0};fail_write=1;int maps=map_calls;assert(create(&a,d,3)==F3_ARENA_IO&&!a.base&&map_calls==maps&&exists(d,a.leaf));fail_write=0;assert(f3_arena_release_01(&a)==F3_ARENA_OK);++groups;
 a=(struct F3Arena){0};drop_at_map=1;assert(create(&a,d,4)==F3_ARENA_HOLD&&a.base&&a.hold);int closes=closed_calls;assert(f3_arena_release_01(&a)==F3_ARENA_HOLD&&closed_calls==closes&&exists(d,a.leaf));fixture_clean(&a);drop_at_map=0;current_epoch=7;++groups;
 a=(struct F3Arena){0};assert(create(&a,d,5)==F3_ARENA_OK);current_owner=0;assert(f3_arena_loan_01(&a,&p,&n)==F3_ARENA_HOLD&&!p&&!n);assert(f3_arena_release_01(&a)==F3_ARENA_HOLD);fixture_clean(&a);current_owner=1;++groups;
 a=(struct F3Arena){0};assert(create(&a,d,6)==F3_ARENA_OK);int foreign=openat(d,"FOREIGN",O_RDWR|O_CREAT|O_EXCL,0600);assert(foreign>=0&&!write(foreign,"",0));assert(!close(foreign));assert(!unlinkat(d,a.leaf,0)&&!renameat(d,"FOREIGN",d,a.leaf));assert(f3_arena_release_01(&a)==F3_ARENA_HOLD&&exists(d,a.leaf));fixture_clean(&a);++groups;
 a=(struct F3Arena){0};assert(create(&a,d,7)==F3_ARENA_OK);fail_flush=1;assert(f3_arena_release_01(&a)==F3_ARENA_IO&&a.base&&exists(d,a.leaf));fail_flush=0;assert(f3_arena_release_01(&a)==F3_ARENA_OK);++groups;
 a=(struct F3Arena){0};assert(create(&a,d,8)==F3_ARENA_OK);drop_after_unmap=1;assert(f3_arena_release_01(&a)==F3_ARENA_HOLD&&!a.base&&a.fd>=0&&exists(d,a.leaf));fixture_clean(&a);drop_after_unmap=0;current_epoch=7;++groups;
 a=(struct F3Arena){0};allocate_ok=1;int writes=write_calls;assert(create(&a,d,9)==F3_ARENA_OK&&a.reservation_method==1&&write_calls==writes);assert(f3_arena_release_01(&a)==F3_ARENA_OK);allocate_ok=0;++groups;
 a=(struct F3Arena){0};assert(f3_arena_create_01(&a,&aapi,&guard,d,7,10,9,0,zeros,sizeof zeros)==F3_ARENA_ARGUMENT);assert(f3_arena_create_01(&a,&aapi,&guard,d,7,10,9,F3_ARENA_MAX_BYTES+4096,zeros,sizeof zeros)==F3_ARENA_ARGUMENT);assert(f3_arena_create_01(&a,&aapi,&guard,d,7,10,9,1,zeros,sizeof zeros)==F3_ARENA_ARGUMENT);++groups;
 /* A synthetic process restart abandons a real host file. New contexts use
  * fresh suffixes, and their normal cleanup cannot remove the prior inode. */
 a=(struct F3Arena){0};assert(create(&a,d,11)==F3_ARENA_OK);
 char old[64];strcpy(old,a.leaf);memset(a.base,0x51,(size_t)a.bytes);assert(!msync(a.base,(size_t)a.bytes,MS_SYNC));
 assert(!munmap(a.base,(size_t)a.bytes)&&!close(a.fd));a.base=0;a.fd=-1;
 struct F3Arena b={0};assert(create(&b,d,11)==F3_ARENA_OK&&strstr(b.leaf,"-0001.tmp"));assert(f3_arena_release_01(&b)==F3_ARENA_OK);
 readfd=openat(d,old,O_RDONLY|O_NOFOLLOW);assert(readfd>=0&&pread(readfd,block,sizeof block,0)==sizeof block);for(size_t i=0;i<sizeof block;++i)assert(block[i]==0x51);assert(!close(readfd)&&exists(d,old));assert(!unlinkat(d,old,0));++groups;
 for(unsigned scenario=1;scenario<=4;++scenario){
  a=(struct F3Arena){0};unique_fault=scenario;unique_opens=0;unsigned before_maps=(unsigned)map_calls;
  enum F3ArenaStatus result=create(&a,d,11+scenario);
  if(scenario==1){assert(result==F3_ARENA_OK&&unique_opens==2&&strstr(a.leaf,"-0001.tmp"));assert(f3_arena_release_01(&a)==F3_ARENA_OK);char original[64];assert(snprintf(original,sizeof original,".iq4-arena-%016llx-%016x.tmp",(unsigned long long)(11+scenario),9)>0);readfd=openat(d,original,O_RDONLY|O_NOFOLLOW);assert(readfd>=0&&read(readfd,block,8)==4&&!memcmp(block,"KEEP",4)&&!close(readfd)&&!unlinkat(d,original,0));}
  else{assert(a.fd==-1&&a.state==F3_ARENA_EMPTY&&(unsigned)map_calls==before_maps);
   if(scenario==2)assert(result==F3_ARENA_IO&&unique_opens==4096&&!a.hold);
   if(scenario==3)assert(result==F3_ARENA_IO&&unique_opens==1&&!a.hold);
   if(scenario==4)assert(result==F3_ARENA_HOLD&&unique_opens==1&&a.hold);
  }
  unique_fault=0;current_epoch=7;++groups;
 }
 for(unsigned nonregular=0;nonregular<2;++nonregular){char original[64];assert(snprintf(original,sizeof original,".iq4-arena-%016llx-%016x.tmp",(unsigned long long)(20+nonregular),9)>0);
  if(nonregular)assert(!mkdirat(d,original,0700));else assert(!symlinkat("NOT-A-SOURCE",d,original));
  a=(struct F3Arena){0};assert(create(&a,d,20+nonregular)==F3_ARENA_OK&&strstr(a.leaf,"-0001.tmp"));assert(f3_arena_release_01(&a)==F3_ARENA_OK&&exists(d,original));assert(!unlinkat(d,original,nonregular?AT_REMOVEDIR:0));++groups;
 }
 assert(!close(d)&&!rmdir(path));printf("{\"actual_host_file_groups\":%u,\"target_executed\":false}\n",groups);return 0;
}
