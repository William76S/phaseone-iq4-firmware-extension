#define _GNU_SOURCE
#define main unused_card_fixture_main_05
#include "../f3_native_card_bridge_05/test_card.c"
#undef main
#include "coordinator.h"
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
extern void f3_fs_host_api_03(struct F3Posix*);
static struct F3Posix host;static char sd[4096],xqd[4096],parent_path[4096];static int mounts[1024],case_id;
static unsigned image_count,generator_count,reader_calls,arena_calls,source_release_calls,raw_unlinks,codec_writes;
static uint8_t*arena;static struct F3Fs*active_fs;
static struct F3SysResult real_open(const char*p){int index=!strcmp(p,"/run/media/xqdcard/");assert(index||!strcmp(p,"/run/media/sdcard/"));int fd=open(index?xqd:sd,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);assert(fd>=0&&fd<1024);mounts[fd]=index?102:101;return(struct F3SysResult){fd,0};}
static struct F3SysResult real_parent(void){int fd=open(parent_path,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(fd>=0&&fd<1024);mounts[fd]=17;return(struct F3SysResult){fd,0};}
static struct F3SysResult real_mount(int fd,uint64_t*m,int*aux){(void)aux;assert(fd>=0&&fd<1024&&mounts[fd]);*m=mounts[fd];if(case_id==5&&!generator_count&&raw_unlinks==0&&image_count==0&&codec_writes)*m+=1;return(struct F3SysResult){0,0};}
static struct F3SysResult real_close(int fd){mounts[fd]=0;return host.close(fd);}
static struct F3SysResult checked_write(int fd,const void*p,uint32_t n){++codec_writes;if(case_id==4)return host.write(fd,p,n?1:0);return host.write(fd,p,n);}
static struct F3SysResult checked_unlink(int d,const char*p){if(!strcmp(p,active_fs->raw_leaf)){assert(!image_count&&!generator_count&&!reader_calls&&!arena_calls&&!source_release_calls);++raw_unlinks;}return host.unlink_leaf(d,p);}
static struct F3Io okay(void){return(struct F3Io){F3_IO_DONE,1};}
static struct F3Io sourcevalid(void*p){(void)p;assert(!source_release_calls);return okay();}
static struct F3Io readerclose(void*p){(void)p;assert(!image_count&&!generator_count);++reader_calls;return case_id==6?(struct F3Io){F3_IO_UNKNOWN,0}:okay();}
static struct F3Io arenaclose(void*p){(void)p;assert(reader_calls==1);++arena_calls;return case_id==7?(struct F3Io){F3_IO_FAIL,0}:okay();}
static struct F3Io release_source(void*p){(void)p;assert(reader_calls==1&&arena_calls==1&&active_fs->raw_fd<0);++source_release_calls;return case_id==8?(struct F3Io){F3_IO_UNKNOWN,0}:okay();}
static enum f3_result genctor(void*p,void*g,void*b,uint64_t n){(void)p;(void)g;assert(b==arena&&n>=F3_NATIVE_GENERATOR_PREFIX_BYTES+64*48*4);++generator_count;return F3_OK;}
static enum f3_result gendtor(void*p,void*g){(void)p;(void)g;assert(!image_count);--generator_count;return F3_OK;}
static enum f3_result imagector(void*p,void*i){(void)p;(void)i;++image_count;return F3_OK;}
static enum f3_result imagedtor(void*p,void*i){(void)p;(void)i;if(case_id==3)return F3_CLEANUP_FAILURE;--image_count;return F3_OK;}
static enum f3_result configure_source(void*p,void*g,uint32_t s,void*t){(void)p;(void)g;(void)s;(void)t;return F3_OK;}
static enum f3_result configure_profile(void*p,void*g,void*s,uint32_t id){(void)p;(void)g;(void)s;(void)id;return F3_OK;}
static enum f3_result process(void*p,void*g,const void*r,void*i,void*b,void*s,void*t,const uint8_t*c,struct f3_native_process_outcome*out){(void)p;(void)g;(void)r;(void)i;(void)b;(void)s;(void)t;assert(!*c);*out=(struct f3_native_process_outcome){1,1,1};return F3_OK;}
static enum f3_result join(void*p,void*t){(void)p;(void)t;return F3_OK;}
static enum f3_result plane(void*p,const void*i,const uint8_t**out,uint32_t*w,uint32_t*h,uint32_t*stride,uint32_t*format){(void)p;(void)i;*out=arena+F3_NATIVE_GENERATOR_PREFIX_BYTES;*w=64;*h=48;*stride=256;*format=5;return F3_OK;}
static Iq4JpegApi codec(void){return(Iq4JpegApi){jpeg_std_error,jpeg_CreateCompress,jpeg_set_defaults,jpeg_set_quality,jpeg_start_compress,jpeg_write_scanlines,jpeg_finish_compress,jpeg_destroy_compress,JPEG_LIB_VERSION,sizeof(struct jpeg_compress_struct),1};}
int main(int argc,char**argv){assert(argc==4);case_id=atoi(argv[3]);FILE*f=fopen(argv[1],"rb");assert(f&&!fseek(f,0,SEEK_END));stock_bytes=(size_t)ftell(f);assert(!fseek(f,0,SEEK_SET));stock=malloc(stock_bytes);assert(stock&&fread(stock,1,stock_bytes,f)==stock_bytes&&!fclose(f));
 for(unsigned i=0;i<2;++i){up(power[i],0xdb6628);up(power[i]+0x68,i?0x9f3fe8:0x9f4000);up(filesystems[i],0xd91450);strcpy((char*)filesystems[i]+0x15,i?"/run/media/xqdcard/":"/run/media/sdcard/");u32(rows[i],10+i);up(rows[i]+16,(uintptr_t)filesystems[i]);u32(rows[i]+24,2);}head=(uintptr_t)power[0];tail=(uintptr_t)power[1];up(power[0]+0x170,tail);
 snprintf(parent_path,sizeof(parent_path),"%s/coordinator-%d-XXXXXX",argv[2],case_id);assert(mkdtemp(parent_path));assert(snprintf(sd,sizeof(sd),"%s/sd",parent_path)>0&&snprintf(xqd,sizeof(xqd),"%s/xqd",parent_path)>0);assert(!mkdir(sd,0700)&&!mkdir(xqd,0700));f3_fs_host_api_03(&host);
 struct F3CardRead05 m={0,readmem};struct F3LeaseCalls05 a={0,reg,waitreq,release};struct F3CardIo05 io={real_open,real_parent,real_mount,host.stat_fd,real_close};struct F3Card05 card={0};assert(f3_card_begin_05(&card,&m,&a,&io,11,10)==F3_CARD_OK);
 struct F3Fs fs={0};active_fs=&fs;struct F3Posix api=host;api.write=checked_write;api.unlink_leaf=checked_unlink;struct F3CardGuard guard=f3_card_guard_05(&card);assert(f3_fs_prepare_03(&fs,&api,&guard,card.jpeg_dir,card.raw_dir,card.jpeg_mount,77,222));
 uint8_t rawbytes[2048],scratch[F3_STREAM_SCRATCH];memset(rawbytes,0x5a,sizeof(rawbytes));struct F3File identity;int manual=case_id==1;
 if(manual){int fd=openat(card.raw_dir,"ActualLowercase.iiq",O_RDWR|O_CREAT|O_EXCL,0600);assert(fd>=0&&write(fd,rawbytes,sizeof(rawbytes))==(ssize_t)sizeof(rawbytes)&&!close(fd));fd=openat(card.raw_dir,"ActualLowercase.iiq",O_RDONLY|O_NOFOLLOW);assert(fd>=0&&f3_fs_manual_raw_03(&fs,"ActualLowercase.iiq",fd,&identity));}
 else{assert(f3_fs_create_stage_03(&fs));assert(write(fs.raw_fd,rawbytes,sizeof(rawbytes))==(ssize_t)sizeof(rawbytes));F4Sha sh;char digest[65];f4_sha_init(&sh);f4_sha_update(&sh,rawbytes,sizeof(rawbytes));f4_sha_end(&sh,digest);assert(f3_fs_seal_stage_03(&fs,sizeof(rawbytes),digest,1,scratch,sizeof(scratch),&identity));}
 struct f3_source source={F3_RAW_FILE_PAYLOAD,64,48,0,0,64,48,0,77,1,1};struct f3_plan plan={0};plan.identity=77;plan.output_width=plan.render_width=64;plan.output_height=plan.render_height=48;plan.ratio=100;plan.admitted=1;plan.required_upper_bytes=F3_NATIVE_GENERATOR_PREFIX_BYTES+16384;plan.generator_backing_upper_bytes=F3_NATIVE_GENERATOR_PREFIX_BYTES+16384;
 assert(!posix_memalign((void**)&arena,32,(size_t)plan.generator_backing_upper_bytes));for(unsigned i=0;i<64*48*4;++i)arena[F3_NATIVE_GENERATOR_PREFIX_BYTES+i]=(uint8_t)i;
 uint8_t settings[F3_NATIVE_SETTINGS_MIN_BYTES]={0},cancel=0;float fv=1;memcpy(settings,&fv,4);fv=64;memcpy(settings+4,&fv,4);fv=48;memcpy(settings+8,&fv,4);u32(settings+0x20,5);u32(settings+0x2c0,64);u32(settings+0x2c4,48);
 struct f3_native_input input={rawbytes,rawbytes,settings,sizeof(settings),rawbytes,&cancel,1,0,1,1,1};struct f3_native_ops ops={0,1,genctor,gendtor,imagector,imagedtor,configure_source,configure_profile,process,join,plane};Iq4JpegApi jpeg=codec();struct F3Job job={0};job.boot_epoch=444;job.capture_id=77;job.mode=case_id==2?F3_RAW_JPEG:case_id==9?F3_RAW:F3_JPEG_ONLY;job.purpose=manual?F3_MANUAL_EXISTING_RAW:F3_NEW_CAPTURE;job.newly_created_raw_stage=!manual;job.source_raw_width=job.render_width=job.output_width=64;job.source_raw_height=job.render_height=job.output_height=48;job.render_source_kind=1;job.raw=job.render_source=identity;
 struct F3SaveRequest05 request={job,&source,&plan,&input,&ops,&jpeg,arena,plan.generator_backing_upper_bytes,1024*1024,scratch,sizeof(scratch),90};struct F3SaveOwners05 owners={0,sourcevalid,readerclose,arenaclose,release_source};struct F3Save05 c={0};const struct F3SaveResult05*r=f3_save_run_05(&c,&fs,&card,&owners,&request);assert(r);
 if(case_id==3||case_id==5||case_id==6||case_id==7||case_id==8){assert(c.state==3&&r->saved.status==F3_UNKNOWN_HOLD&&card.hold);unsigned reads=reader_calls,rels=release_calls,writes=codec_writes;assert(f3_save_run_05(&c,&fs,&card,&owners,&request)==r&&reader_calls==reads&&release_calls==rels&&codec_writes==writes);if(case_id==3||case_id==5)assert(!raw_unlinks&&!reader_calls);if(case_id==8)assert(!release_calls&&r->directories_closed);}
 else {assert(c.state==2&&r->card_requests_released&&r->source_lease_released&&release_calls==2);if(case_id==4)assert(r->saved.status==F3_FAILED_RAW_RETAINED&&!raw_unlinks);else if(case_id==0)assert(r->saved.status==F3_JPEG_ONLY_DONE&&raw_unlinks==1);else if(case_id==9)assert(r->saved.status==F3_RAW_RETAINED&&!codec_writes&&!raw_unlinks);else assert(r->saved.status==F3_JPEG_WITH_RAW&&!raw_unlinks);}
 if(!raw_unlinks){struct stat st;int audit=open(xqd,O_RDONLY|O_DIRECTORY);assert(audit>=0&&!fstatat(audit,fs.raw_leaf,&st,AT_SYMLINK_NOFOLLOW)&&st.st_size==2048&&!close(audit));}
 free(arena);free(stock);printf("{\"coordinator_case\":%d,\"passed\":true,\"real_host_codec_and_files\":true,\"vendor_ops_are_fixture\":true,\"target_executed\":false}\n",case_id);return 0;
}
