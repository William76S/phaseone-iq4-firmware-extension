#include "fs.h"
#define DIRMODE 0040000u
#define REGMODE 0100000u
#define TYPEMASK 0170000u
static struct F3Io done(uint64_t v){return(struct F3Io){F3_IO_DONE,v};}
static struct F3Io failed(void){return(struct F3Io){F3_IO_FAIL,0};}
static struct F3Io unknown(struct F3Fs*c){c->hold=1;return(struct F3Io){F3_IO_UNKNOWN,0};}
static int same(const struct F3FdStat*a,const struct F3FdStat*b,int content){return a->device==b->device&&a->inode==b->inode&&(a->mode&TYPEMASK)==(b->mode&TYPEMASK)&&(!content||(a->nlink==b->nlink&&a->size==b->size&&a->mtime_sec==b->mtime_sec&&a->mtime_nsec==b->mtime_nsec));}
static int copy_leaf(char*out,const char*p){unsigned n=0;while(p&&p[n]){unsigned ch=(unsigned char)p[n];if(n>=63||ch=='/'||ch=='\\'||ch=='.'||!((ch>='A'&&ch<='Z')||(ch>='0'&&ch<='9')||ch=='_'))return 0;out[n]=p[n];++n;}if(!n)return 0;out[n]=0;return 1;}
static void name(char*out,const char*prefix,uint64_t id,uint64_t nonce,const char*suffix){unsigned n=0;while(*prefix)out[n++]=*prefix++;static const char hex[]="0123456789abcdef";for(int i=15;i>=0;--i)out[n++]=hex[(id>>(i*4))&15];out[n++]='-';for(int i=15;i>=0;--i)out[n++]=hex[(nonce>>(i*4))&15];while(*suffix)out[n++]=*suffix++;out[n]=0;}
static int guard(struct F3Fs*c){struct F3FdStat a,b;if(!c||!c->bound||c->hold||!c->guard.actual_epoch||!c->guard.native_owner_valid||c->guard.actual_epoch(c->guard.context)!=c->epoch||!c->guard.native_owner_valid(c->guard.context))return 0;
 if(c->api.stat_fd(c->jpeg_dir,&a).value||c->api.stat_fd(c->raw_dir,&b).value)return 0;return same(&a,&c->jpeg_directory,0)&&same(&b,&c->raw_directory,0);}
static int stat_pair(struct F3Fs*c,int fd,int dir,const char*leaf,struct F3FdStat*out){struct F3FdStat a,b;if(c->api.stat_fd(fd,&a).value||c->api.stat_leaf(dir,leaf,&b).value||!same(&a,&b,1)||(a.mode&TYPEMASK)!=REGMODE||a.nlink!=1)return 0;*out=a;return 1;}
int f3_fs_prepare_03(struct F3Fs*c,const struct F3Posix*p,const struct F3CardGuard*g,int jd,int rd,uint64_t epoch,uint64_t id,uint64_t nonce){
 if(!c||c->bound||!p||!g||!epoch||!id||!nonce||jd<0||rd<0||!p->open_leaf||!p->stat_fd||!p->stat_leaf||!p->read||!p->read_at||!p->write||!p->sync||!p->close||!p->move_noreplace||!p->unlink_leaf||!g->actual_epoch||!g->native_owner_valid)return 0;
 c->api=*p;c->guard=*g;c->jpeg_dir=jd;c->raw_dir=rd;c->raw_fd=c->write_fd=c->read_fd=-1;c->epoch=epoch;c->capture_id=id;c->task_nonce=nonce;
 if(p->stat_fd(jd,&c->jpeg_directory).value||p->stat_fd(rd,&c->raw_directory).value||(c->jpeg_directory.mode&TYPEMASK)!=DIRMODE||(c->raw_directory.mode&TYPEMASK)!=DIRMODE)return 0;
 name(c->raw_leaf,".iq4-f3-",id,nonce,".iiq.tmp");name(c->temporary_leaf,".iq4-f3-",id,nonce,".jpg.tmp");name(c->final_leaf,"F3-",id,nonce,".JPG");c->bound=1;if(!guard(c)){c->bound=0;return 0;}return 1;
}
int f3_fs_create_stage_03(struct F3Fs*c){if(!guard(c)){if(c&&(c->raw_fd>=0||c->owned_stage))c->hold=1;return 0;}if(c->raw_fd>=0||c->owned_stage)return 0;struct F3SysResult r=c->api.open_leaf(c->raw_dir,c->raw_leaf,1);if(r.value<0)return 0;c->raw_fd=(int)r.value;c->owned_stage=1;if(!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&c->raw_stat)||c->raw_stat.size||!guard(c)){c->hold=1;return 0;}return 1;}
int f3_fs_seal_stage_03(struct F3Fs*c,uint64_t bytes,const char*h,uint32_t completed,uint8_t*scratch,size_t cap,struct F3File*out){
 if(!guard(c)){if(c&&(c->raw_fd>=0||c->owned_stage))c->hold=1;return 0;}if(!c->owned_stage||c->stage_sealed||c->raw_fd<0||!bytes||bytes>1024ull*1024*1024||!h||h[64]||completed!=1||!scratch||cap<F3_STREAM_SCRATCH||!out)return 0;
 for(unsigned i=0;i<64;++i)if(!((h[i]>='0'&&h[i]<='9')||(h[i]>='a'&&h[i]<='f')))return 0;
 struct F3FdStat a,b;if(!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&a)||a.size!=bytes||c->api.sync(c->raw_fd).value){if(!guard(c))c->hold=1;return 0;}if(!guard(c)){c->hold=1;return 0;}
 F4Sha sha;char actual[65];f4_sha_init(&sha);for(uint64_t off=0;off<bytes;){uint32_t n=(uint32_t)(bytes-off);if(n>F3_STREAM_SCRATCH)n=F3_STREAM_SCRATCH;if(!guard(c)){c->hold=1;return 0;}struct F3SysResult r=c->api.read_at(c->raw_fd,scratch,n,off);if(!guard(c)){c->hold=1;return 0;}if(r.value!=(int64_t)n)return 0;f4_sha_update(&sha,scratch,n);off+=n;}
 f4_sha_end(&sha,actual);for(unsigned i=0;i<65;++i)if(actual[i]!=h[i])return 0;
 if(!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&b)||!same(&a,&b,1)||c->api.sync(c->raw_dir).value){if(!guard(c))c->hold=1;return 0;}if(!guard(c)){c->hold=1;return 0;}
 c->raw_stat=b;c->raw_producer_bytes=bytes;c->stage_sealed=1;for(unsigned i=0;i<65;++i)c->raw_sha256[i]=actual[i];*out=(struct F3File){b.device,b.inode,c->epoch,c->task_nonce,bytes};return 1;
}
int f3_fs_manual_raw_03(struct F3Fs*c,const char*leaf,int fd,struct F3File*out){
 if(!guard(c)||c->raw_fd>=0||c->owned_stage||fd<0||!out||!leaf)return 0;
 /* Actual 8.IIQ-style extension is accepted only after normalising exact base separately. */
 unsigned n=0;while(leaf[n]&&n<64)++n;if(n<5||n>=64||leaf[n-4]!='.'||leaf[n-3]!='I'||leaf[n-2]!='I'||leaf[n-1]!='Q')return 0;
 char base[64];for(unsigned i=0;i<n-4;++i)base[i]=leaf[i];base[n-4]=0;if(!copy_leaf(c->raw_leaf,base))return 0;for(unsigned i=n-4;i<=n;++i)c->raw_leaf[i]=leaf[i];
 struct F3FdStat st;if(!stat_pair(c,fd,c->raw_dir,c->raw_leaf,&st)||!st.size)return 0;
 c->raw_fd=fd;c->raw_stat=st;c->stage_sealed=1;if(!guard(c)){c->hold=1;return 0;}*out=(struct F3File){st.device,st.inode,c->epoch,c->task_nonce,st.size};return 1;
}
static struct F3Io raw_check(void*v,const struct F3Job*j){struct F3Fs*c=v;struct F3FdStat st;
 if(!guard(c)){if(c&&(c->raw_fd>=0||c->owned_stage||c->stage_sealed||c->write_fd>=0||c->read_fd>=0))return unknown(c);return failed();}
 if(!c->stage_sealed||c->raw_fd<0||!j||j->capture_id!=c->capture_id||j->raw.task_nonce!=c->task_nonce||j->raw.card_epoch!=c->epoch||j->raw.device!=c->raw_stat.device||j->raw.inode!=c->raw_stat.inode||j->raw.bytes!=c->raw_stat.size)return failed();
 if(!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&st)||!guard(c))return unknown(c);if(!same(&st,&c->raw_stat,1))return failed();
 if(c->owned_stage){uint8_t block[4096];F4Sha sha;char actual[65];f4_sha_init(&sha);for(uint64_t off=0;off<c->raw_stat.size;){uint32_t n=(uint32_t)(c->raw_stat.size-off);if(n>sizeof(block))n=sizeof(block);if(!guard(c))return unknown(c);struct F3SysResult r=c->api.read_at(c->raw_fd,block,n,off);if(!guard(c))return unknown(c);if(r.value!=(int64_t)n)return failed();f4_sha_update(&sha,block,n);off+=n;}f4_sha_end(&sha,actual);if(!guard(c))return unknown(c);for(unsigned i=0;i<65;++i)if(actual[i]!=c->raw_sha256[i])return failed();if(!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&st)||!guard(c))return unknown(c);if(!same(&st,&c->raw_stat,1))return failed();}
 return done(1);}
static struct F3Io openw(void*v,const struct F3Job*j,struct F3File*out){struct F3Fs*c=v;if(!guard(c))return unknown(c);if(c->write_fd>=0||c->read_fd>=0||j->capture_id!=c->capture_id)return failed();struct F3SysResult r=c->api.open_leaf(c->jpeg_dir,c->temporary_leaf,1);if(r.value<0){if(!guard(c))return unknown(c);return failed();}c->write_fd=(int)r.value;
 if(!stat_pair(c,c->write_fd,c->jpeg_dir,c->temporary_leaf,&c->jpeg_stat)||c->jpeg_stat.size||!guard(c))return unknown(c);*out=(struct F3File){c->jpeg_stat.device,c->jpeg_stat.inode,c->epoch,c->task_nonce,0};return done(1);}
static struct F3Io write_jpeg(void*v,const uint8_t*p,uint32_t n){struct F3Fs*c=v;if(!guard(c)||c->write_fd<0)return unknown(c);struct F3SysResult r=c->api.write(c->write_fd,p,n);if(!guard(c))return unknown(c);return r.value<0?failed():done((uint64_t)r.value);}
static struct F3Io closew(void*v){struct F3Fs*c=v;if(!guard(c)||c->write_fd<0)return unknown(c);int fd=c->write_fd;struct F3SysResult s=c->api.sync(fd);if(!guard(c))return unknown(c);struct F3SysResult r=c->api.close(fd);if(r.value)return unknown(c);c->write_fd=-1;if(!guard(c))return unknown(c);return s.value?failed():done(1);}
static struct F3Io openr(void*v,const struct F3File*f,struct F3File*out){struct F3Fs*c=v;if(!guard(c))return unknown(c);if(c->write_fd>=0||c->read_fd>=0)return failed();struct F3SysResult r=c->api.open_leaf(c->jpeg_dir,c->temporary_leaf,0);if(r.value<0){if(!guard(c))return unknown(c);return failed();}c->read_fd=(int)r.value;
 if(!stat_pair(c,c->read_fd,c->jpeg_dir,c->temporary_leaf,&c->jpeg_stat)||!guard(c))return unknown(c);*out=(struct F3File){c->jpeg_stat.device,c->jpeg_stat.inode,c->epoch,c->task_nonce,c->jpeg_stat.size};(void)f;return done(1);}
static struct F3Io read_jpeg(void*v,uint8_t*p,uint32_t n){struct F3Fs*c=v;if(!guard(c)||c->read_fd<0)return unknown(c);struct F3SysResult r=c->api.read(c->read_fd,p,n);if(!guard(c))return unknown(c);return r.value<0?failed():done((uint64_t)r.value);}
static struct F3Io statr(void*v,struct F3File*out){struct F3Fs*c=v;struct F3FdStat st;if(!guard(c)||c->read_fd<0||!stat_pair(c,c->read_fd,c->jpeg_dir,c->temporary_leaf,&st)||!guard(c))return unknown(c);*out=(struct F3File){st.device,st.inode,c->epoch,c->task_nonce,st.size};return done(1);}
static struct F3Io closer(void*v){struct F3Fs*c=v;if(!guard(c)||c->read_fd<0)return unknown(c);struct F3SysResult r=c->api.close(c->read_fd);if(r.value)return unknown(c);c->read_fd=-1;if(!guard(c))return unknown(c);return done(1);}
static struct F3Io publish(void*v,const struct F3File*f){struct F3Fs*c=v;struct F3FdStat st;if(!guard(c))return unknown(c);if(c->write_fd>=0||c->read_fd>=0||c->published||c->api.stat_leaf(c->jpeg_dir,c->temporary_leaf,&st).value||st.inode!=f->inode||st.device!=f->device||st.size!=f->bytes)return failed();
 if(!guard(c))return unknown(c);struct F3SysResult r=c->api.move_noreplace(c->jpeg_dir,c->temporary_leaf,c->final_leaf);if(r.value==-2)return unknown(c);if(r.value){if(!guard(c))return unknown(c);return failed();}c->published=1;
 if(!guard(c)||c->api.sync(c->jpeg_dir).value||!guard(c)||c->api.stat_leaf(c->jpeg_dir,c->final_leaf,&st).value||st.inode!=f->inode||st.device!=f->device||st.size!=f->bytes||!guard(c))return unknown(c);return done(1);}
static struct F3Io remove_raw(void*v,const struct F3Job*j){struct F3Fs*c=v;if(!c->owned_stage||!c->stage_sealed||!c->published||j->purpose!=F3_NEW_CAPTURE||!j->newly_created_raw_stage||c->raw_removed)return failed();struct F3Io check=raw_check(v,j);if(check.state!=F3_IO_DONE)return check;
 /* Requires native serialized sole owner of this private namespace. stat+unlink
  * is NOT an inode-conditional unlink and cannot defeat concurrent name replacement. */
 struct F3SysResult r=c->api.unlink_leaf(c->raw_dir,c->raw_leaf);if(r.value){struct F3FdStat current;if(!guard(c)||!stat_pair(c,c->raw_fd,c->raw_dir,c->raw_leaf,&current)||!same(&current,&c->raw_stat,1))return unknown(c);return failed();}c->raw_removed=1;if(!guard(c)||c->api.sync(c->raw_dir).value||!guard(c))return unknown(c);return done(1);}
struct F3Ports f3_fs_ports_03(struct F3Fs*c){return(struct F3Ports){c,raw_check,openw,write_jpeg,closew,openr,read_jpeg,statr,closer,publish,remove_raw};}
int f3_fs_release_raw_03(struct F3Fs*c){if(!c||!c->bound||c->hold||c->write_fd>=0||c->read_fd>=0||c->raw_fd<0)return 0;if(!guard(c)){c->hold=1;return 0;}struct F3SysResult r=c->api.close(c->raw_fd);if(r.value){c->hold=1;return 0;}c->raw_fd=-1;return 1;}
