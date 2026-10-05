#define _DARWIN_C_SOURCE 1
#include "public_raw.h"
#include "../f3_stream_transaction_02/sha256.h"
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
struct Fixture {int dir,fault,live,calls,renames,unlinks,closes,syncs;char path[256];};
static struct Fixture*f;
static struct F3SysResult result(int64_t v){return (struct F3SysResult){v,v<0?errno:0};}
static void fillstat(struct F3FdStat*out,const struct stat*s){*out=(struct F3FdStat){(uint64_t)s->st_dev,s->st_ino,(uint64_t)s->st_size,(uint64_t)s->st_nlink,(uint32_t)s->st_mode,s->st_mtimespec.tv_sec,s->st_mtimespec.tv_nsec};}
static struct F3SysResult op_open(int d,const char*p,int w){++f->calls;return result(openat(d,p,w?(O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW):(O_RDONLY|O_NOFOLLOW),0600));}
static struct F3SysResult op_stat(int d,struct F3FdStat*out){++f->calls;struct stat s;int r=fstat(d,&s);if(!r)fillstat(out,&s);return result(r);}
static struct F3SysResult op_leaf(int d,const char*p,struct F3FdStat*out){++f->calls;struct stat s;int r=fstatat(d,p,&s,AT_SYMLINK_NOFOLLOW);if(!r)fillstat(out,&s);return result(r);}
static struct F3SysResult op_read(int d,void*p,uint32_t n,uint64_t o){++f->calls;
 if(f->fault==7){errno=EIO;return result(-1);}if(f->fault==13&&n==1){((char*)p)[0]=7;return result(1);}return result(pread(d,p,n,(off_t)o));}
static struct F3SysResult op_sync(int d){++f->calls;++f->syncs;if(f->fault==10&&f->syncs==2){errno=EIO;return result(-1);}return result(fsync(d));}
static struct F3SysResult op_close(int d){++f->calls;++f->closes;if(f->fault==11){errno=EIO;return result(-1);}int r=close(d);if(f->fault==12)f->live=0;return result(r);}
static void put(int d,const char*p,unsigned char c){int fd=openat(d,p,O_WRONLY|O_CREAT|O_EXCL,0600);assert(fd>=0);assert(write(fd,&c,1)==1);assert(close(fd)==0);}
static struct F3SysResult op_move(int d,const char*a,const char*b){++f->calls;++f->renames;
 if((f->fault==4||f->fault==5)&&f->renames==1){assert(renameat(d,a,d,"retained_original.IIQ")==0);put(d,a,99);}
 int r=renameatx_np(d,a,d,b,RENAME_EXCL);
 if(f->fault==8&&f->renames==1)f->live=0;
 if(f->fault==5&&f->renames==1&&r==0)put(d,a,100);
 return result(r);}
static struct F3SysResult op_unlink(int d,const char*p){++f->calls;++f->unlinks;return result(unlinkat(d,p,0));}
static uint64_t epoch(void*ctx){struct Fixture*x=ctx;return x->live?55:56;}
static int valid(void*ctx){return ((struct Fixture*)ctx)->live;}
static int exists(const char*p){struct stat s;return fstatat(f->dir,p,&s,AT_SYMLINK_NOFOLLOW)==0;}
static void initialize(struct Fixture*x,struct F3CapturedRaw01*c){memset(x,0,sizeof *x);x->live=1;strcpy(x->path,"/tmp/iq4-f3-public06-XXXXXX");assert(mkdtemp(x->path));x->dir=open(x->path,O_RDONLY|O_DIRECTORY);assert(x->dir>=0);f=x;
 unsigned char raw[251];for(unsigned i=0;i<sizeof raw;++i)raw[i]=(unsigned char)(i*7);int fd=openat(x->dir,"P0000001.IIQ",O_WRONLY|O_CREAT|O_EXCL,0600);assert(fd>=0);assert(write(fd,raw,sizeof raw)==sizeof raw);assert(close(fd)==0);
 memset(c,0,sizeof *c);c->exclusive_created=c->writer_bound=c->store_success=c->close_success=1;c->writer_fd=-1;c->parent_dir=x->dir;c->raw_fd=openat(x->dir,"P0000001.IIQ",O_RDONLY|O_NOFOLLOW);assert(c->raw_fd>=0);strcpy(c->leaf,"P0000001.IIQ");assert(op_stat(c->raw_fd,&c->final_stat).value==0);F4Sha h;f4_sha_init(&h);f4_sha_update(&h,raw,sizeof raw);f4_sha_end(&h,c->sha256);x->calls=0;
}
static void shutdown_fixture(struct Fixture*x,const struct F3CapturedRaw01*c,struct F3PublicRaw06*s){
 /* Host fixture teardown only: target UNKNOWN never performs these calls. */
 if(s->quarantine_fd>=0)assert(close(s->quarantine_fd)==0);assert(close(c->raw_fd)==0);
 const char*leaves[]={"P0000001.IIQ","retained_original.IIQ",s->quarantine_leaf};for(unsigned i=0;i<3;++i)if(leaves[i][0])unlinkat(x->dir,leaves[i],0);assert(close(x->dir)==0);assert(rmdir(x->path)==0);
}
int main(void){unsigned tested=0;for(int id=0;id<16;++id){struct Fixture x;struct F3CapturedRaw01 c;initialize(&x,&c);x.fault=id;struct F3PublicRaw06 s={.quarantine_fd=-1};uint8_t scratch[31];
 struct F3Posix api={.open_leaf=op_open,.stat_fd=op_stat,.stat_leaf=op_leaf,.read_at=op_read,.sync=op_sync,.close=op_close,.move_noreplace=op_move,.unlink_leaf=op_unlink};struct F3CardGuard g={&x,epoch,valid};
 unsigned published=1;if(id==1)published=0;if(id==2)c.exclusive_created=0;if(id==3)c.sha256[0]=c.sha256[0]=='a'?'b':'a';
 if(id==6)put(x.dir,".iq4-f3-discard-0000000000000009.tmp",33);if(id==9)x.live=0;if(id==14)c.final_stat.inode+=1;
 int r=f3_public_discard_06(&s,&api,&g,55,x.dir,9,&c,published,scratch,sizeof scratch);
 if(id==0||id==15){assert(r==F3_PUBLIC_REMOVED06&&!s.hold&&s.state==2&&s.quarantine_fd==-1&&x.unlinks==1&&!exists(c.leaf));}
 else if(id==1||id==2||id==3||id==6||id==14){assert(r==F3_PUBLIC_PRESERVED06&&!s.hold&&!x.unlinks&&exists(c.leaf));if(id==1||id==2)assert(x.calls==0);}
 else{assert(r==F3_PUBLIC_HOLD06&&s.hold);int calls=x.calls;assert(f3_public_discard_06(&s,&api,&g,55,x.dir,9,&c,1,scratch,sizeof scratch)==F3_PUBLIC_HOLD06&&x.calls==calls);
  if(id==4)assert(s.restore_attempted&&s.restore_succeeded&&exists(c.leaf)&&exists("retained_original.IIQ")&&!exists(s.quarantine_leaf)&&!x.unlinks);
  if(id==5)assert(s.restore_attempted&&!s.restore_succeeded&&exists(c.leaf)&&exists(s.quarantine_leaf)&&!x.unlinks);
  if(id==8)assert(s.quarantine_fd==-1&&exists(s.quarantine_leaf)&&!x.unlinks);
  if(id==10||id==11)assert(s.quarantine_fd>=0&&x.unlinks==1);
  if(id==12)assert(s.quarantine_fd==-1&&x.unlinks==1);
 }
 if(id==15){int calls=x.calls;assert(f3_public_discard_06(&s,&api,&g,55,x.dir,9,&c,1,scratch,sizeof scratch)==0&&calls==x.calls);}
 shutdown_fixture(&x,&c,&s);++tested;
 }
 printf("{\"cases\":%u,\"passed\":true,\"host_real_mac_posix_files\":true,\"target_syscalls_executed\":false,\"unknown_fixture_teardown_is_host_only\":true}\n",tested);return 0;
}
