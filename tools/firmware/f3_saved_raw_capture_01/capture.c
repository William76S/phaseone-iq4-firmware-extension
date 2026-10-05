#include "capture.h"
#include <string.h>
static int same(const struct F3FdStat*a,const struct F3FdStat*b,int content){
 return a->device==b->device&&a->inode==b->inode&&a->mode==b->mode&&
 (!content||(a->nlink==b->nlink&&a->size==b->size&&a->mtime_sec==b->mtime_sec&&a->mtime_nsec==b->mtime_nsec));
}
void f3_capture_hold_01(struct F3CapturedRaw01*c){if(c){c->hold=1;c->state=F3_CAPTURE_HOLD01;if(c->card)f3_card_hold_05(c->card);if(c->activity.word)iq4_activity_hold_01(&c->activity);}}
static int guard(struct F3CapturedRaw01*c){return c&&!c->hold&&c->card&&f3_card_valid_05(c->card)&&c->card->raw_id==10&&c->card->jpeg_id==10&&c->card->fs[0]==c->native_fs;}
static int pair(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o,struct F3FdStat*out){struct F3FdStat a,b;
 if(c->raw_fd<0||c->parent_dir<0||o->files.stat_fd(c->raw_fd,&a).value||o->files.stat_leaf(c->parent_dir,c->leaf,&b).value||!same(&a,&b,1)||(a.mode&0170000u)!=0100000u||a.nlink!=1)return 0;*out=a;return 1;
}
int f3_capture_path_01(const char*p,char directory[9],char leaf[32]){
 if(!p)return 0;size_t n=0;while(n<64&&p[n])++n;if(n>=64||n<26||memcmp(p,"DCIM/",5)||p[5]<'1'||p[5]>'9'||p[6]<'0'||p[6]>'9'||p[7]<'0'||p[7]>'9'||memcmp(p+8,"PHASE/",6))return 0;
 size_t len=n-14;if(len>=32||len<12||p[14]!='P'||memcmp(p+n-4,".IIQ",4))return 0;
 unsigned digits=0,suffix=0;for(size_t i=15;i<n-4;++i){if(p[i]>='0'&&p[i]<='9'){if(suffix)++suffix;else ++digits;}else if(p[i]=='_'&&!suffix&&digits>=7&&digits<=10)suffix=1;else return 0;}
 if(digits<7||digits>10||suffix==1||suffix>5)return 0;
 memcpy(directory,p+5,8);directory[8]=0;memcpy(leaf,p+14,len+1);return 1;
}
int f3_capture_open_01(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o,uintptr_t fs,uintptr_t file,const char*path,uint64_t thread){
 if(!c||!o||c->state!=F3_CAPTURE_WRITING01||c->writer_bound||c->exclusive_created||!file||!thread||!o->dirs.open_child||!o->files.open_leaf||!o->files.stat_fd||!o->files.stat_leaf||!o->files.read_at||!o->files.sync||!o->files.close)return 0;
 c->native_fs=fs;c->native_file=file;c->writer_thread=thread;
 if(!guard(c)||!f3_capture_path_01(path,c->directory,c->leaf))return 0;
 struct F3SysResult r=o->dirs.open_child(c->card->raw_dir,"DCIM");if(r.value<0)return 0;c->dcim_dir=(int)r.value;
 r=o->dirs.open_child(c->dcim_dir,c->directory);if(r.value<0)return 0;c->parent_dir=(int)r.value;
 if(o->files.stat_fd(c->parent_dir,&c->parent_stat).value||(c->parent_stat.mode&0170000u)!=0040000u||c->parent_stat.device!=c->card->raw_stat.device||!guard(c)){f3_capture_hold_01(c);return 0;}
 r=o->files.open_leaf(c->parent_dir,c->leaf,1);if(r.value<0)return 0;c->writer_fd=(int)r.value;c->exclusive_created=1;
 if(o->files.stat_fd(c->writer_fd,&c->created).value||(c->created.mode&0170000u)!=0100000u||c->created.size||c->created.nlink!=1||c->created.device!=c->parent_stat.device||!guard(c)){f3_capture_hold_01(c);return 0;}
 r=o->files.open_leaf(c->parent_dir,c->leaf,0);if(r.value<0){f3_capture_hold_01(c);return 0;}c->raw_fd=(int)r.value;struct F3FdStat a;
 if(!pair(c,o,&a)||!same(&a,&c->created,1)||!guard(c)){f3_capture_hold_01(c);return 0;}return 1;
}
int f3_capture_close_result_01(struct F3CapturedRaw01*c,uintptr_t file,int returned,int success){
 if(!c||c->hold||c->state!=F3_CAPTURE_WRITING01||!c->writer_bound||file!=c->native_file||c->close_returned)return 0;
 if(returned!=1||success!=1){f3_capture_hold_01(c);return 0;}c->close_returned=c->close_success=1;c->writer_fd=-1;return 1;
}
static int hash(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o,char out[65],const struct F3FdStat*a){
 uint8_t buffer[65536];F4Sha s;f4_sha_init(&s);
 for(uint64_t off=0;off<a->size;){uint32_t n=(uint32_t)(a->size-off);if(n>sizeof(buffer))n=sizeof(buffer);if(!guard(c)){f3_capture_hold_01(c);return 0;}struct F3SysResult r=o->files.read_at(c->raw_fd,buffer,n,off);if(!guard(c)){f3_capture_hold_01(c);return 0;}if(r.value!=(int64_t)n)return 0;f4_sha_update(&s,buffer,n);off+=n;}
 uint8_t tail;struct F3SysResult eof=o->files.read_at(c->raw_fd,&tail,1,a->size);if(!guard(c)){f3_capture_hold_01(c);return 0;}if(eof.value)return 0;f4_sha_end(&s,out);return 1;
}
int f3_capture_saved_01(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o,int success){
 if(!c||!o||c->state!=F3_CAPTURE_WRITING01||c->store_returned||c->hold)return 0;c->store_returned=1;c->store_success=success==1;
 if(!guard(c)){f3_capture_hold_01(c);return 0;}if(!success)return 0;
 if(!c->exclusive_created||!c->writer_bound||!c->close_returned||!c->close_success||c->writer_fd>=0){f3_capture_hold_01(c);return 0;}
 struct F3FdStat a,b;if(!pair(c,o,&a)||!same(&a,&c->created,0)||!a.size||a.size>1024ull*1024*1024){f3_capture_hold_01(c);return 0;}
 if(!hash(c,o,c->sha256,&a)||!pair(c,o,&b)||!same(&a,&b,1)||o->files.sync(c->parent_dir).value||!guard(c)){f3_capture_hold_01(c);return 0;}
 c->final_stat=b;c->state=F3_CAPTURE_SAVED01;return 1;
}
int f3_capture_fresh_01(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o){
 if(!c||!o||c->state!=F3_CAPTURE_SAVED01||!c->exclusive_created||!c->writer_bound||!c->store_success||!c->close_success)return 0;
 if(!guard(c)){f3_capture_hold_01(c);return 0;}struct F3FdStat a,b;char h[65];
 if(!pair(c,o,&a)||!same(&a,&c->final_stat,1)||!hash(c,o,h,&a)||memcmp(h,c->sha256,65)||!pair(c,o,&b)||!same(&a,&b,1)){if(!guard(c))f3_capture_hold_01(c);return 0;}return 1;
}
int f3_capture_release_files_01(struct F3CapturedRaw01*c,const struct F3CaptureOps01*o){
 if(!c||!o||c->hold||(c->writer_bound&&!c->close_success))return 0;if(!guard(c)){f3_capture_hold_01(c);return 0;}
 int*fds[]={&c->raw_fd,&c->parent_dir,&c->dcim_dir};for(unsigned i=0;i<3;++i){if(*fds[i]<0)continue;int fd=*fds[i];if(o->files.close(fd).value){f3_capture_hold_01(c);return 0;}*fds[i]=-1;}
 if(!guard(c)){f3_capture_hold_01(c);return 0;}c->state=F3_CAPTURE_DONE01;return 1;
}
