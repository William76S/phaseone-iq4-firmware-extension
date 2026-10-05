#define _GNU_SOURCE
#include "../f3_saved_raw_capture_01/capture.h"
#include <assert.h>
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
extern void f3_fs_host_api_03(struct F3Posix*);
static unsigned calls,reads,closes;static int epoch_ok=1,short_read,close_fail;
static struct F3Posix original;
void f3_capture_group_hold_03(const struct F3CapturedRaw01*c){(void)c;}
int f3_card_valid_05(struct F3Card05*c){return c&&c->state==2&&!c->hold&&epoch_ok;}
void f3_card_hold_05(struct F3Card05*c){if(c){c->state=4;c->hold=1;}}
static struct F3SysResult child(int d,const char*p){++calls;int fd=openat(d,p,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);return(struct F3SysResult){fd,fd<0?errno:0};}
static struct F3SysResult ra(int fd,void*p,uint32_t n,uint64_t off){++calls;++reads;if(short_read)return(struct F3SysResult){n?(int64_t)n-1:0,0};return original.read_at(fd,p,n,off);}
static struct F3SysResult cl(int fd){++calls;++closes;if(close_fail)return(struct F3SysResult){-1,EIO};return original.close(fd);}
static void begin(struct F3CapturedRaw01*c,struct F3Card05*card){*c=(struct F3CapturedRaw01){0};c->state=F3_CAPTURE_WRITING01;c->ticket=(struct F3CaptureTicket01){101,202,303,{F3_JPEG_ONLY,0,92}};c->card=card;c->native_fs=1234;c->dcim_dir=c->parent_dir=c->raw_fd=c->writer_fd=-1;}
static int writer(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o){assert(f3_capture_open_01(c,o,1234,5678,"DCIM/100PHASE/P0000001.IIQ",999));c->writer_bound=1;assert(write(c->writer_fd,"opaque complete IIQ fixture",27)==27);assert(!fsync(c->writer_fd));assert(!close(c->writer_fd));return f3_capture_close_result_01(c,5678,1,1);}
int main(int argc,char**argv){assert(argc==4);int scenario=atoi(argv[2]),card_id=atoi(argv[3]);assert(scenario>=0&&scenario<13&&(card_id==10||card_id==11));char root[4096];assert(snprintf(root,sizeof(root),"%s/savedraw-%d-XXXXXX",argv[1],scenario)>0);assert(mkdtemp(root));int d=open(root,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(d>=0);assert(!mkdirat(d,"DCIM",0700));int dc=openat(d,"DCIM",O_RDONLY|O_DIRECTORY);assert(dc>=0);assert(!mkdirat(dc,"100PHASE",0700));int pd=openat(dc,"100PHASE",O_RDONLY|O_DIRECTORY);assert(pd>=0);
 f3_fs_host_api_03(&original);struct F3CaptureOps01 o={0};o.files=original;o.files.read_at=ra;o.files.close=cl;o.dirs.open_child=child;
 struct F3Card05 card={0};card.state=2;card.raw_id=card.jpeg_id=(uint32_t)card_id;card.fs[0]=1234;card.raw_dir=card.jpeg_dir=d;assert(!original.stat_fd(d,&card.raw_stat).value);
 struct F3CapturedRaw01 c;begin(&c,&card);
 if(scenario==1){int f=openat(pd,"P0000001.IIQ",O_RDWR|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,"user existing",13)==13&&!close(f));assert(!f3_capture_open_01(&c,&o,1234,5678,"DCIM/100PHASE/P0000001.IIQ",999));char b[14]={0};f=openat(pd,"P0000001.IIQ",O_RDONLY);assert(f>=0&&read(f,b,13)==13&&!memcmp(b,"user existing",13)&&!close(f));assert(!c.exclusive_created&&!c.writer_bound&&f3_capture_release_files_01(&c,&o));}
 else if(scenario==2){assert(!unlinkat(dc,"100PHASE",AT_REMOVEDIR));assert(!symlinkat("100PHASE-REAL",dc,"100PHASE"));assert(!mkdirat(dc,"100PHASE-REAL",0700));assert(!f3_capture_open_01(&c,&o,1234,5678,"DCIM/100PHASE/P0000001.IIQ",999));assert(!c.exclusive_created&&f3_capture_release_files_01(&c,&o));}
 else if(scenario==3){assert(!symlinkat("user.IIQ",pd,"P0000001.IIQ"));assert(!f3_capture_open_01(&c,&o,1234,5678,"DCIM/100PHASE/P0000001.IIQ",999));struct stat st;assert(!fstatat(pd,"P0000001.IIQ",&st,AT_SYMLINK_NOFOLLOW)&&S_ISLNK(st.st_mode));assert(!c.exclusive_created&&f3_capture_release_files_01(&c,&o));}
 else if(scenario==4){assert(f3_capture_open_01(&c,&o,1234,5678,"DCIM/100PHASE/P0000001.IIQ",999));c.writer_bound=1;assert(!f3_capture_close_result_01(&c,5678,1,0));unsigned before=calls;assert(c.hold&&!f3_capture_saved_01(&c,&o,1)&&!f3_capture_release_files_01(&c,&o)&&calls==before);assert(c.writer_fd>=0&&c.raw_fd>=0);}
 else{
  assert(writer(&c,&o));
  if(scenario==5)epoch_ok=0;
  if(scenario==6)short_read=1;
  int saved=f3_capture_saved_01(&c,&o,scenario!=9);
  if(scenario==5||scenario==6){assert(!saved&&c.hold&&c.raw_fd>=0);unsigned before=calls;assert(!f3_capture_fresh_01(&c,&o)&&!f3_capture_release_files_01(&c,&o)&&calls==before);}
  else if(scenario==9){assert(!saved&&!c.hold&&c.store_returned&&!c.store_success&&f3_capture_release_files_01(&c,&o));}
  else{
   assert(saved&&c.state==F3_CAPTURE_SAVED01&&c.final_stat.size==27&&strlen(c.sha256)==64);
   if(scenario==7){int f=openat(pd,"P0000001.IIQ",O_WRONLY);assert(f>=0&&pwrite(f,"X",1,0)==1&&!close(f));assert(!f3_capture_fresh_01(&c,&o)&&!c.hold);}
   else if(scenario==8){assert(!renameat(pd,"P0000001.IIQ",pd,"held-original.IIQ"));int f=openat(pd,"P0000001.IIQ",O_WRONLY|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,"other user IIQ",14)==14&&!close(f));assert(!f3_capture_fresh_01(&c,&o)&&!c.hold);}
   else if(scenario==10){close_fail=1;assert(!f3_capture_release_files_01(&c,&o)&&c.hold&&closes==1);unsigned before=calls;assert(!f3_capture_release_files_01(&c,&o)&&calls==before);}
   else if(scenario==11){assert(!f3_capture_close_result_01(&c,5678,1,1)&&!c.hold&&f3_capture_fresh_01(&c,&o));}
   else if(scenario==12){epoch_ok=0;unsigned before=reads;assert(!f3_capture_fresh_01(&c,&o)&&c.hold&&reads==before);}
   else assert(f3_capture_fresh_01(&c,&o));
   if(!c.hold)assert(f3_capture_release_files_01(&c,&o));
  }
 }
 /* Test harness dismantles retained host fixture fds only after assertions. This
  * is not production recovery, and no target code or vendor destructor runs. */
 if(c.writer_fd>=0)close(c.writer_fd);if(c.raw_fd>=0)close(c.raw_fd);if(c.parent_dir>=0)close(c.parent_dir);if(c.dcim_dir>=0)close(c.dcim_dir);assert(!close(pd)&&!close(dc)&&!close(d));
 char dir[9],leaf[32];const char*bad[]={"","DCIM/099PHASE/P0000001.IIQ","DCIM/100PHASE/../OLD.IIQ","DCIM/100PHASE/P000001.IIQ","DCIM/100PHASE/P0000001.iiq","DCIM/100PHASE/P0000001_.IIQ"};
 for(unsigned i=0;i<sizeof(bad)/sizeof(bad[0]);++i)assert(!f3_capture_path_01(bad[i],dir,leaf));assert(f3_capture_path_01("DCIM/999PHASE/P4294967295_9999.IIQ",dir,leaf));
 printf("{\"scenario\":%d,\"passed\":true,\"actual_host_files\":true,\"native_file_calls_are_fixtures\":true,\"public_raw_unlinks\":0}\n",scenario);return 0;
}
