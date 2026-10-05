#define _GNU_SOURCE
#include "fs.h"
#include <assert.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void f3_fs_host_api_03(struct F3Posix*);
static uint8_t scratch[F3_STREAM_SCRATCH],raw_bytes[100001],jpeg[70001];
static const uint8_t header[]={255,216,255,192,0,17,8,0,48,0,64,3,1,17,0,2,17,0,3,17,0,255,218,0,12,3,1,0,2,0,3,0,0,63,0};
struct Lease{uint64_t epoch;int owner_valid;};
static uint64_t epoch(void*v){return((struct Lease*)v)->epoch;}
static int owner(void*v){return((struct Lease*)v)->owner_valid;}
static struct F3Posix base;static struct F3Fs*inject;
static struct F3SysResult fail_sync(int fd){if(inject->write_fd==fd)return(struct F3SysResult){-1,EIO};return base.sync(fd);}
static struct F3SysResult fail_after_remove(int fd){if(inject->raw_removed&&inject->raw_dir==fd)return(struct F3SysResult){-1,EIO};return base.sync(fd);}
static struct F3SysResult unsupported(int fd,const char*a,const char*b){(void)fd;(void)a;(void)b;return(struct F3SysResult){-1,ENOSYS};}
static void existing(int d,const char*p){int fd=openat(d,p,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);assert(fd>=0&&write(fd,"KEEP",4)==4&&!close(fd));}
static void unchanged(int d,const char*p){char b[5]={0};int fd=openat(d,p,O_RDONLY|O_NOFOLLOW);assert(fd>=0&&read(fd,b,5)==4&&!memcmp(b,"KEEP",4)&&!close(fd));}
static int absent(int d,const char*p){struct stat st;return fstatat(d,p,&st,AT_SYMLINK_NOFOLLOW)<0&&errno==ENOENT;}
static struct F3Job job(struct F3Fs*c,struct F3File f){struct F3Job j={0};j.boot_epoch=1;j.capture_id=c->capture_id;j.mode=F3_JPEG_ONLY;j.purpose=F3_NEW_CAPTURE;j.newly_created_raw_stage=1;j.source_raw_width=14204;j.source_raw_height=10652;j.render_width=j.output_width=64;j.render_height=j.output_height=48;j.render_source_kind=1;j.raw=j.render_source=f;return j;}
static struct F3File stage(struct F3Fs*c){assert(f3_fs_create_stage_03(c));assert(c->api.write(c->raw_fd,raw_bytes,sizeof(raw_bytes)).value==sizeof(raw_bytes));F4Sha h;char text[65];f4_sha_init(&h);f4_sha_update(&h,raw_bytes,sizeof(raw_bytes));f4_sha_end(&h,text);struct F3File f;assert(f3_fs_seal_stage_03(c,sizeof(raw_bytes),text,1,scratch,sizeof(scratch),&f));return f;}
static const struct F3StreamResult *save(struct F3Fs*c,struct F3File f,unsigned mode,int manual,struct F3Stream*s,struct F3Session*session){struct F3Job j=job(c,f);j.mode=mode;if(manual){j.purpose=F3_MANUAL_EXISTING_RAW;j.newly_created_raw_stage=0;}struct F3Ports p=f3_fs_ports_03(c);if(!f3_stream_begin_02(s,session,&j,&p,sizeof(jpeg),scratch,sizeof(scratch)))return &s->result;
 for(size_t off=0;off<sizeof(jpeg);){size_t n=sizeof(jpeg)-off;if(n>16384)n=16384;assert(f3_stream_sink_write_02(s,jpeg+off,n)==n);off+=n;}struct F3EncoderCompletion e={1,1,1,48,sizeof(jpeg)};return f3_stream_finish_02(s,&e);}
static int prepared(struct F3Fs*c,int d,struct Lease*l,uint64_t id){struct F3CardGuard g={l,epoch,owner};return f3_fs_prepare_03(c,&base,&g,d,d,7,id,9);}
static void test_cleanup(struct F3Fs*c){/* Host injector owns all real fds; not a production UNKNOWN recovery route. */if(c->write_fd>=0)assert(!close(c->write_fd));if(c->read_fd>=0)assert(!close(c->read_fd));if(c->raw_fd>=0)assert(!close(c->raw_fd));}
int main(int argc,char**argv){assert(argc==2);char root[4096];assert(snprintf(root,sizeof(root),"%s/fs-owned-XXXXXX",argv[1])>0&&mkdtemp(root));int d=open(root,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(d>=0);f3_fs_host_api_03(&base);struct Lease l={7,1};unsigned groups=0;struct F3Fs c={0};
 memset(raw_bytes,23,sizeof(raw_bytes));memset(jpeg,2,sizeof(jpeg));memcpy(jpeg,header,sizeof(header));jpeg[sizeof(jpeg)-2]=255;jpeg[sizeof(jpeg)-1]=217;
 assert(prepared(&c,d,&l,1));struct F3File f=stage(&c);struct F3Stream s={0};struct F3Session session={1,0,0};const struct F3StreamResult*r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);
 assert(r->saved.status==F3_JPEG_ONLY_DONE&&absent(d,c.raw_leaf)&&!absent(d,c.final_leaf));int fd=openat(d,c.final_leaf,O_RDONLY|O_NOFOLLOW);uint8_t part[4096];size_t off=0;while(off<sizeof(jpeg)){size_t n=sizeof(jpeg)-off;if(n>sizeof(part))n=sizeof(part);assert(read(fd,part,n)==(ssize_t)n&&!memcmp(part,jpeg+off,n));off+=n;}assert(read(fd,part,1)==0&&!close(fd)&&f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,2));f=stage(&c);s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_RAW_JPEG,0,&s,&session);assert(r->saved.status==F3_JPEG_WITH_RAW&&!absent(d,c.raw_leaf)&&f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,3));f=stage(&c);existing(d,c.temporary_leaf);s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!absent(d,c.raw_leaf)&&!c.raw_removed);unchanged(d,c.temporary_leaf);assert(f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,4));f=stage(&c);existing(d,c.final_leaf);s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!absent(d,c.raw_leaf)&&!c.raw_removed&&!absent(d,c.temporary_leaf));unchanged(d,c.final_leaf);assert(f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,5));existing(d,"OLD001.IIQ");fd=openat(d,"OLD001.IIQ",O_RDONLY|O_NOFOLLOW);assert(fd>=0&&f3_fs_manual_raw_03(&c,"OLD001.IIQ",fd,&f));s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,1,&s,&session);assert(r->saved.status==F3_JPEG_WITH_RAW&&!c.raw_removed);unchanged(d,"OLD001.IIQ");assert(f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,6));f=stage(&c);inject=&c;c.api.sync=fail_sync;s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&c.write_fd<0&&!c.raw_removed&&!c.published&&!absent(d,c.raw_leaf)&&f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,7));f=stage(&c);c.api.move_noreplace=unsupported;s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!c.published&&!absent(d,c.raw_leaf)&&f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,8));f=stage(&c);inject=&c;c.api.sync=fail_after_remove;s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_UNKNOWN_HOLD&&session.hold&&c.hold&&c.raw_removed&&absent(d,c.raw_leaf)&&!f3_fs_release_raw_03(&c));assert(pread(c.raw_fd,part,sizeof(part),0)==sizeof(part));test_cleanup(&c);++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,9));f=stage(&c);s=(struct F3Stream){0};session=(struct F3Session){1,0,0};struct F3Job j=job(&c,f);struct F3Ports p=f3_fs_ports_03(&c);assert(f3_stream_begin_02(&s,&session,&j,&p,sizeof(jpeg),scratch,sizeof(scratch)));assert(f3_stream_sink_write_02(&s,jpeg,16384)==16384);l.epoch=8;assert(!f3_stream_sink_write_02(&s,jpeg+16384,16384));r=f3_stream_abort_02(&s);assert(r->saved.status==F3_UNKNOWN_HOLD&&c.hold&&c.write_fd>=0&&!c.published&&!c.raw_removed&&!f3_fs_release_raw_03(&c));test_cleanup(&c);l.epoch=7;++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,10));assert(symlinkat("OLD001.IIQ",d,c.raw_leaf)==0&&!f3_fs_create_stage_03(&c)&&!c.owned_stage);unchanged(d,"OLD001.IIQ");++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,11));f=stage(&c);assert(pwrite(c.raw_fd,"x",1,0)==1);struct timespec old_times[2]={{c.raw_stat.mtime_sec,c.raw_stat.mtime_nsec},{c.raw_stat.mtime_sec,c.raw_stat.mtime_nsec}};assert(!futimens(c.raw_fd,old_times));s=(struct F3Stream){0};session=(struct F3Session){1,0,0};r=save(&c,f,F3_JPEG_ONLY,0,&s,&session);assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!c.raw_removed&&!c.published&&f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};assert(prepared(&c,d,&l,12));assert(f3_fs_create_stage_03(&c)&&c.api.write(c.raw_fd,raw_bytes,sizeof(raw_bytes)).value==sizeof(raw_bytes));char wrong[65];memset(wrong,'0',64);wrong[64]=0;assert(!f3_fs_seal_stage_03(&c,sizeof(raw_bytes),wrong,1,scratch,sizeof(scratch),&f)&&!c.stage_sealed&&!c.raw_removed);assert(f3_fs_release_raw_03(&c));++groups;
 c=(struct F3Fs){0};l.owner_valid=0;assert(!prepared(&c,d,&l,13)&&!c.bound);l.owner_valid=1;++groups;
 assert(!close(d));printf("{\"real_host_POSIX_groups\":%u,\"passed\":true,\"host_nonreplacement\":\"linkat_then_unlinkat\",\"camera_renameat2_tested\":false,\"RAW_bytes_synthetic\":true,\"target_executed\":false}\n",groups);return 0;
}
