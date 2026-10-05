/* Host-only actual Card06 -> MovieBinding -> Movie01 -> MKVzero chain.
 * Native memory/owner, kernel mount ids and source fence are explicit fixtures.
 * File I/O, pthread execution, JPEG syntax, SHA/scanner/publication are real. */
#define _GNU_SOURCE
#define main unused_card_fixture_main_start05
#include "../../tools/firmware/f3_native_card_bridge_05/test_card.c"
#undef main
#include "../../tools/firmware/f4_native_source_02/movie_binding.h"
#include "../../tools/firmware/f4_native_source_02/native_calls.h"
#include <fcntl.h>
#include <pthread.h>
#include <sys/stat.h>
#include <time.h>
#include <unistd.h>
extern void f3_fs_host_api_03(struct F3Posix*);
static struct F3Posix real;
static char media[4096],sd[4096],xqd[4096];
static int fd_mount[1024],scenario,pending,unknown_request;
static unsigned request_calls,current_calls,writes,movie_closes;
static uintptr_t ui_vt=0xb91f48;
static pthread_t ui;
static int fence=IQ4_F4_SRC_OK;
static unsigned char hash[65536],packet[65536];
static Iq4F4MovieBinding02 binding;
static Iq4F4MoviePorts02 ports;
static unsigned char *jpeg;
static size_t jpeg_bytes;
static uint32_t width,height;
static int mem(void*p,uintptr_t a,void*out,size_t n){
 if(a==(uintptr_t)&ui_vt&&n==8){memcpy(out,&ui_vt,8);return 1;}
 return readmem(p,a,out,n);
}
static uintptr_t native_current(void*p){(void)p;++current_calls;return pthread_equal(pthread_self(),ui)?(uintptr_t)&ui_vt:0;}
static enum F3CardOutcome05 req(void*p,uintptr_t a,uint32_t id,uint32_t*out){
 (void)p;++request_calls;assert(native_current(0));uint32_t mask;
 memcpy(&mask,(void*)(a+0x17c),4);u32((void*)(a+0x17c),mask|(1u<<id));
 if(unknown_request)return F3_CARD_UNKNOWN;
 *out=pending?0:1;u32((void*)(a+0x320),*out);return F3_CARD_OK;
}
static struct F3SysResult root_open(const char*p){
 int i=!strcmp(p,"/run/media/xqdcard/");assert(i||!strcmp(p,"/run/media/sdcard/"));
 int fd=open(i?xqd:sd,O_RDONLY|O_DIRECTORY|O_CLOEXEC);
 if(fd<0)return(struct F3SysResult){-1,2};assert(fd<1024);fd_mount[fd]=i?102:101;
 return(struct F3SysResult){fd,0};
}
static struct F3SysResult media_open(void){int fd=open(media,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(fd>=0&&fd<1024);fd_mount[fd]=17;return(struct F3SysResult){fd,0};}
static struct F3SysResult mount_of(int fd,uint64_t*out,int*aux){(void)aux;assert(fd>=0&&fd<1024&&fd_mount[fd]);*out=fd_mount[fd];return(struct F3SysResult){0,0};}
static struct F3SysResult card_close(int fd){fd_mount[fd]=0;return real.close(fd);}
static struct F3SysResult movie_write(int fd,const void*p,uint32_t n){
 ++writes;if(scenario==7&&writes==2)return(struct F3SysResult){-1,5};
 return real.write(fd,p,scenario==6&&writes==2?1:n);
}
static struct F3SysResult movie_close(int fd){++movie_closes;return real.close(fd);}
static struct F3SysResult patch(int fd,const void*p,uint32_t n,uint64_t off){return(struct F3SysResult){pwrite(fd,p,n,(off_t)off),0};}
/* Only factories/native source identity are host substitutions. Neither card,
 * binding, movie, mux, scanner nor file lifecycle is mocked. */
void f3_card_native_calls_05(struct F3LeaseCalls05*p){*p=(struct F3LeaseCalls05){0,reg,waitreq,release};}
void f3_card_native_try_calls_06(struct F3TryCalls06*p){*p=(struct F3TryCalls06){0,native_current,req};}
void f3_card_linux_io_05(struct F3CardIo05*p){*p=(struct F3CardIo05){root_open,media_open,mount_of,real.stat_fd,card_close};}
void f4_movie_linux_api_01(struct F4MovieApi01*p){*p=(struct F4MovieApi01){real,patch};p->fs.write=movie_write;p->fs.close=movie_close;}
int iq4_f4_source_is_ui_02(void*p){return p&&pthread_equal(pthread_self(),ui);}
int iq4_f4_source_fence_02(void*p){assert(p);return fence;}
uint64_t iq4_f4_native_tid_02(void){return(uint64_t)(uintptr_t)pthread_self();}
uint64_t iq4_f4_native_clock_02(void){struct timespec t;assert(!clock_gettime(CLOCK_MONOTONIC,&t));return(uint64_t)t.tv_sec*1000000000u+(uint64_t)t.tv_nsec;}
static unsigned char *load(const char*p,size_t*n){FILE*f=fopen(p,"rb");assert(f&&!fseek(f,0,SEEK_END));*n=(size_t)ftell(f);assert(*n&&!fseek(f,0,SEEK_SET));unsigned char*b=malloc(*n);assert(b&&fread(b,1,*n,f)==*n&&!fclose(f));return b;}
static void start_fixture(void){
 for(unsigned i=0;i<2;++i){up(power[i],0xdb6628);up(power[i]+0x68,i?0x9f3fe8:0x9f4000);up(filesystems[i],0xd91450);strcpy((char*)filesystems[i]+0x15,i?"/run/media/xqdcard/":"/run/media/sdcard/");u32(rows[i],10+i);up(rows[i]+16,(uintptr_t)filesystems[i]);u32(rows[i]+24,2);}
 head=(uintptr_t)power[0];tail=(uintptr_t)power[1];up(power[0]+0x170,tail);
 ui=pthread_self();f3_fs_host_api_03(&real);
 assert(iq4_f4_movie_binding_init_on_ui_02(&binding,(void*)1,mem,0,10,hash,sizeof hash,packet,sizeof packet,1024*1024,10));
 ports=iq4_f4_movie_binding_ports_02(&binding);
}
static void *worker(void*unused){
 (void)unused;assert(!native_current(0));unsigned before=current_calls;
 struct Iq4Mkv*m=0;uint32_t published=99;
 assert(ports.prepare_on_worker(&binding,width,height,&m)==IQ4_F4_MOVIE_READY&&m==&binding.movie.mux);
 assert(current_calls==before); /* No original UI TLS on worker/card-valid. */
 enum Iq4MkvStatus p=f4_movie_packet_01(&binding.movie,jpeg,(uint32_t)jpeg_bytes,1000000000,0);
 if(scenario==6){assert(p==IQ4_MKV_IO);assert(ports.finalize_on_worker(&binding,m,0,&published)==IQ4_F4_MOVIE_READY&&!published);}
 else if(scenario==7){assert(p==IQ4_MKV_HOLD);unsigned cl=movie_closes;assert(ports.finalize_on_worker(&binding,m,0,&published)==IQ4_F4_MOVIE_UNKNOWN&&binding.hold&&movie_closes==cl);}
 else{
  assert(p==IQ4_MKV_OK);assert(f4_movie_packet_01(&binding.movie,jpeg,(uint32_t)jpeg_bytes,1037000000,1)==IQ4_MKV_OK);
  if(scenario==8){fence=IQ4_F4_SRC_PENDING;unsigned cl=movie_closes;assert(ports.finalize_on_worker(&binding,m,1,&published)==IQ4_F4_MOVIE_UNKNOWN&&binding.hold&&movie_closes==cl);}
  else{assert(ports.finalize_on_worker(&binding,m,1,&published)==IQ4_F4_MOVIE_READY&&published==1&&binding.movie.structure_checked&&binding.movie.mux.frames==2&&binding.movie.mux.last_local_sequence==1&&binding.movie.files_closed&&binding.card.state==5);}
 }
 assert(current_calls==before);return 0;
}
static void run_worker(void){pthread_t t;assert(!pthread_create(&t,0,worker,0)&&!pthread_join(t,0));}
int main(int argc,char**argv){
 assert(argc==5);scenario=atoi(argv[4]);stock=load(argv[1],&stock_bytes);jpeg=load(argv[2],&jpeg_bytes);assert(jpeg_bytes<=sizeof packet&&f3_jpeg_shape_01(jpeg,jpeg_bytes,&width,&height));
 snprintf(media,sizeof media,"%s/chain-%d-XXXXXX",argv[3],scenario);assert(mkdtemp(media));assert(snprintf(sd,sizeof sd,"%s/sd",media)>0&&snprintf(xqd,sizeof xqd,"%s/xqd",media)>0&&!mkdir(sd,0700)&&!mkdir(xqd,0700));start_fixture();
 if(scenario==0){
  struct F3Card05 other={0};struct F3CardRead05 mr={0,mem};struct F3LeaseCalls05 lc;struct F3CardIo05 io;struct F3TryCalls06 tr;
  f3_card_native_calls_05(&lc);f3_card_linux_io_05(&io);f3_card_native_try_calls_06(&tr);
  assert(f3_card_request_06(&other,&mr,&lc,&io,&tr,11,11)==F3_CARD_OK&&f3_card_valid_05(&other));
  struct F3Card05 before=other;unsigned rq=request_calls,rl=release_calls;
  int busy=ports.acquire_on_ui(&binding);
#ifdef ORIGINAL_BUSY_REPRO
  assert(busy==IQ4_F4_MOVIE_UNKNOWN&&binding.hold&&binding.card.hold);
#else
  static const unsigned char zero[sizeof(struct F3Card05)]={0};
  assert(busy==IQ4_F4_MOVIE_FAIL&&!binding.hold&&!memcmp(&binding.card,zero,sizeof zero));
#endif
  assert(request_calls==rq&&release_calls==rl&&!memcmp(&other,&before,sizeof other)&&f3_card_valid_05(&other));
  assert(f3_card_close_dirs_05(&other)==F3_CARD_OK&&f3_card_release_requests_05(&other)==F3_CARD_OK);
#ifdef ORIGINAL_BUSY_REPRO
  assert(ports.acquire_on_ui(&binding)==IQ4_F4_MOVIE_UNKNOWN&&request_calls==rq);
  printf("{\"case\":0,\"original_busy_permanent_hold_reproduced\":true,\"target_executed\":false}\n");return 0;
#endif
 }
 if(scenario==1||scenario==2)pending=1;
 if(scenario==3)assert(!rmdir(sd));
 if(scenario==4)unknown_request=1;
 int ac=ports.acquire_on_ui(&binding);
 if(scenario==1||scenario==2){assert(ac==IQ4_F4_MOVIE_PENDING&&binding.card.state==6);unsigned rq=request_calls;assert(ports.poll_on_ui(&binding)==IQ4_F4_MOVIE_PENDING&&request_calls==rq);
  if(scenario==2){assert(ports.cancel_pending_on_ui(&binding)==IQ4_F4_MOVIE_READY&&binding.card.state==3);pending=0;assert(ports.acquire_on_ui(&binding)==IQ4_F4_MOVIE_READY);}
  else{pending=0;u32(power[0]+0x320,1);assert(ports.poll_on_ui(&binding)==IQ4_F4_MOVIE_READY);}}
 else if(scenario==3){assert(ac==IQ4_F4_MOVIE_FAIL&&!binding.hold&&binding.card.state==3);assert(!mkdir(sd,0700));assert(ports.acquire_on_ui(&binding)==IQ4_F4_MOVIE_READY);}
 else if(scenario==4){assert(ac==IQ4_F4_MOVIE_UNKNOWN&&binding.hold&&binding.card.requested[0]&&!release_calls);unsigned rq=request_calls;assert(ports.acquire_on_ui(&binding)==IQ4_F4_MOVIE_UNKNOWN&&request_calls==rq);}
 else assert(ac==IQ4_F4_MOVIE_READY&&binding.card.state==2);
 if(scenario==5){struct Iq4Mkv*m=0;assert(ports.prepare_on_worker(&binding,width,height,&m)==IQ4_F4_MOVIE_UNKNOWN&&binding.hold&&!writes&&!release_calls);}
 else if(scenario!=4){run_worker();if(scenario!=7&&scenario!=8){assert(!binding.hold&&ports.release_on_ui(&binding)==IQ4_F4_MOVIE_READY&&binding.card.state==3);if(scenario==6){scenario=9;assert(ports.acquire_on_ui(&binding)==IQ4_F4_MOVIE_READY);run_worker();assert(ports.release_on_ui(&binding)==IQ4_F4_MOVIE_READY);}}else{unsigned rl=release_calls;assert(binding.hold&&ports.release_on_ui(&binding)==IQ4_F4_MOVIE_UNKNOWN&&release_calls==rl);}}
 printf("{\"case\":%d,\"passed\":true,\"actual_card_binding_movie_mux\":true,\"real_host_file_io\":true,\"native_mount_source_fixtures\":true,\"native_wait_calls\":%u,\"target_executed\":false}",atoi(argv[4]),wait_calls);
 if(binding.movie.published)printf("\n{\"published_path\":\"%s/%s\",\"frames\":2,\"explicit_fixture_pts_ns\":[1000000000,1037000000],\"fixture_sequence\":[0,1],\"hardware_fps_proof\":false}\n",sd,binding.movie.final_leaf);else puts("");
 free(stock);free(jpeg);return 0;
}
