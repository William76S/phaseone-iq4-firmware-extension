#define _GNU_SOURCE
#include "../f3_native_fs_adapter_04/fs.h"
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
void f3_fs_host_api_03(struct F3Posix*);
static struct F3Posix original;
static uint64_t lease_epoch=7;
static uint8_t scratch[F3_STREAM_SCRATCH],jpeg[81];
static unsigned stat_calls,open_calls,move_calls;
static int fault,rawdir,jpegdir;
static uint64_t epoch(void*v){(void)v;return lease_epoch;}
static int valid(void*v){(void)v;return 1;}
static void existing(int d,const char*n){int f=openat(d,n,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW,0600);assert(f>=0&&write(f,"KEEP",4)==4&&!close(f));}
static void kept(int d,const char*n){char b[8]={0};int f=openat(d,n,O_RDONLY|O_NOFOLLOW);assert(f>=0&&read(f,b,8)==4&&!memcmp(b,"KEEP",4)&&!close(f));}
static void actual_jpeg(int d,const char*n){uint8_t b[82];int f=openat(d,n,O_RDONLY|O_NOFOLLOW);assert(f>=0&&read(f,b,sizeof b)==sizeof jpeg&&!memcmp(b,jpeg,sizeof jpeg)&&!close(f));}
static struct F3SysResult stat_fault(int d,const char*n,struct F3FdStat*s){
 ++stat_calls;
 if(!strncmp(n,"F3-",3)&&fault==6){*s=(struct F3FdStat){0};return(struct F3SysResult){0,0};}
 if(!strncmp(n,"F3-",3)&&fault==7)return(struct F3SysResult){-1,EACCES};
 return original.stat_leaf(d,n,s);
}
static struct F3SysResult open_fault(int d,const char*n,int wr){
 ++open_calls;
 if(wr&&fault==5&&open_calls==1){existing(d,n);return(struct F3SysResult){-1,EEXIST};}
 if(wr&&fault==8)return(struct F3SysResult){-1,EIO};
 if(wr&&fault==10){lease_epoch=8;return(struct F3SysResult){-1,EEXIST};}
 return original.open_leaf(d,n,wr);
}
static struct F3SysResult move_fault(int d,const char*a,const char*b){
 ++move_calls;
 if(fault==4&&move_calls==1)existing(d,b);
 if(fault==9)return(struct F3SysResult){-1,ENOSYS};
 if(fault==12)return(struct F3SysResult){-2,EIO};
 struct F3SysResult r=original.move_noreplace(d,a,b);
 if(fault==11&&r.value==0)lease_epoch=8;
 return r;
}
static struct F3File bind(struct F3Fs*c,uint64_t id){
 struct F3Posix io=original;io.stat_leaf=stat_fault;io.open_leaf=open_fault;io.move_noreplace=move_fault;
 struct F3CardGuard g={0,epoch,valid};assert(f3_fs_prepare_03(c,&io,&g,jpegdir,rawdir,7,id,id));
 int f=openat(rawdir,"SOURCE.IIQ",O_RDONLY|O_NOFOLLOW);struct F3File raw;
 assert(f>=0&&f3_fs_manual_raw_03(c,"SOURCE.IIQ",f,&raw));return raw;
}
static const struct F3StreamResult* save(struct F3Fs*c,struct F3File raw,struct F3Stream*s,struct F3Session*ss){
 struct F3Job j={0};j.boot_epoch=1;j.capture_id=c->capture_id;j.mode=F3_RAW_JPEG;j.purpose=F3_MANUAL_EXISTING_RAW;
 j.source_raw_width=14204;j.source_raw_height=10652;j.render_width=j.output_width=64;j.render_height=j.output_height=48;
 j.render_source_kind=1;j.raw=j.render_source=raw;struct F3Ports ports=f3_fs_ports_03(c);
 if(!f3_stream_begin_02(s,ss,&j,&ports,1024,scratch,sizeof scratch))return &s->result;
 assert(f3_stream_sink_write_02(s,jpeg,sizeof jpeg)==sizeof jpeg);
 struct F3EncoderCompletion e={1,1,1,48,sizeof jpeg};return f3_stream_finish_02(s,&e);
}
static void fixture_cleanup(struct F3Fs*c){/* Synthetic host fixture owns these fds; never a device HOLD recovery. */
 if(c->write_fd>=0)assert(!close(c->write_fd));if(c->read_fd>=0)assert(!close(c->read_fd));if(c->raw_fd>=0)assert(!close(c->raw_fd));
}
static void reset(int f){fault=f;lease_epoch=7;stat_calls=open_calls=move_calls=0;}
int main(int argc,char**argv){
 assert(argc==2);char root[4096];assert(snprintf(root,sizeof root,"%s/jpeg-unique-XXXXXX",argv[1])>0&&mkdtemp(root));
 int d=open(root,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(d>=0&&!mkdirat(d,"raw",0700)&&!mkdirat(d,"jpeg",0700));
 rawdir=openat(d,"raw",O_RDONLY|O_DIRECTORY|O_CLOEXEC);jpegdir=openat(d,"jpeg",O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(rawdir>=0&&jpegdir>=0);existing(rawdir,"SOURCE.IIQ");
 f3_fs_host_api_03(&original);const uint8_t h[]={255,216,255,192,0,17,8,0,48,0,64,3,1,17,0,2,17,0,3,17,0,255,218,0,12,3,1,0,2,0,3,0,0,63,0};
 memset(jpeg,2,sizeof jpeg);memcpy(jpeg,h,sizeof h);jpeg[79]=255;jpeg[80]=217;unsigned groups=0;
 for(unsigned round=0;round<2;++round){reset(0);struct F3Fs c={0};struct F3File f=bind(&c,1);struct F3Stream s={0};struct F3Session ss={1,0,0};const struct F3StreamResult*r=save(&c,f,&s,&ss);
  assert(r->saved.status==F3_JPEG_WITH_RAW&&!c.raw_removed);actual_jpeg(jpegdir,c.final_leaf);assert(f3_fs_release_raw_03(&c));if(round)assert(strstr(c.final_leaf,"-0001.JPG"));++groups;
 }
 kept(rawdir,"SOURCE.IIQ");
 for(int scenario=2;scenario<=12;++scenario){reset(scenario);struct F3Fs c={0};struct F3File f=bind(&c,(uint64_t)scenario);char oldtmp[64],oldfinal[64];strcpy(oldtmp,c.temporary_leaf);strcpy(oldfinal,c.final_leaf);
  if(scenario==2)existing(jpegdir,oldtmp);
  if(scenario==3){assert(!symlinkat("SOURCE.IIQ",jpegdir,oldfinal));}
  struct F3Stream s={0};struct F3Session ss={1,0,0};const struct F3StreamResult*r=save(&c,f,&s,&ss);
  if(scenario<=5){assert(r->saved.status==F3_JPEG_WITH_RAW&&!c.hold);actual_jpeg(jpegdir,c.final_leaf);assert(strstr(c.final_leaf,"-0001.JPG"));assert(f3_fs_release_raw_03(&c));
   if(scenario==2||scenario==5)kept(jpegdir,oldtmp);if(scenario==4)kept(jpegdir,oldfinal);
   if(scenario==3){char b[32]={0};assert(readlinkat(jpegdir,oldfinal,b,sizeof b)==10&&!strcmp(b,"SOURCE.IIQ"));}
  }else if(scenario<=9){assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!c.hold&&!c.raw_removed&&!c.published);assert(f3_fs_release_raw_03(&c));
   if(scenario==6)assert(open_calls==0&&stat_calls>=4096);if(scenario==7)assert(open_calls==0);if(scenario==8)assert(open_calls==1);if(scenario==9)assert(move_calls==1);
  }else{assert(r->saved.status==F3_UNKNOWN_HOLD&&c.hold&&ss.hold&&!f3_fs_release_raw_03(&c));assert(!c.raw_removed);
   if(scenario==10)assert(open_calls==1&&move_calls==0);if(scenario==11)assert(c.published&&move_calls==1);if(scenario==12)assert(!c.published&&move_calls==1);fixture_cleanup(&c);
  }
  kept(rawdir,"SOURCE.IIQ");++groups;
 }
 /* Held JPEG dir differs from RAW dir; no guessing/normalizing either path. */
 struct stat st;assert(fstatat(rawdir,"F3-0000000000000001-0000000000000001.JPG",&st,AT_SYMLINK_NOFOLLOW)<0&&errno==ENOENT);++groups;
 assert(!close(jpegdir)&&!close(rawdir)&&!close(d));
 printf("{\"groups\":%u,\"real_host_files\":true,\"RAW_source_unchanged\":true,\"target_executed\":false,\"camera_accessed\":false}\n",groups);
 return 0;
}
