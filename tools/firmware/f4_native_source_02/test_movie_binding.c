#include "movie_binding.h"
#include "native_calls.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
/* Synthetic factory boundary tests, never original functions or target code. */
static uint32_t on_ui=1,request_id,request_count,release_count,close_count,finish_count,abort_count;
static int request_result=F3_CARD_OK,begin_ok=1,fence=IQ4_F4_SRC_OK;
static enum F3IoState final_result=F3_IO_DONE;
static uint64_t tid=1;
int iq4_f4_source_is_ui_02(void*p){return p&&on_ui;}
uint64_t iq4_f4_native_tid_02(void){return tid;}
uint64_t iq4_f4_native_clock_02(void){return UINT64_C(90000123);}
int iq4_f4_source_fence_02(void*p){assert(p);return fence;}
static int read_own(void*c,uintptr_t a,void*b,size_t n){(void)c;(void)a;(void)b;(void)n;return 0;}
void f3_card_native_calls_05(struct F3LeaseCalls05*p){memset(p,0,sizeof*p);}
void f3_card_linux_io_05(struct F3CardIo05*p){memset(p,0,sizeof*p);}
void f3_card_native_try_calls_06(struct F3TryCalls06*p){memset(p,0,sizeof*p);}
void f4_movie_linux_api_01(struct F4MovieApi01*p){memset(p,0,sizeof*p);}
int f3_card_request_06(struct F3Card05*c,const struct F3CardRead05*r,const struct F3LeaseCalls05*l,const struct F3CardIo05*i,const struct F3TryCalls06*t,uint32_t rid,uint32_t jid){
 (void)r;(void)l;(void)i;(void)t;assert(rid==jid&&(rid==10||rid==11));request_id=rid;++request_count;
 c->raw_dir=c->jpeg_dir=-1;c->state=request_result==F3_CARD_PENDING_06?6:request_result==F3_CARD_FAIL?3:1;
 if(request_result==F3_CARD_OK){c->requested[rid-10]=1;c->raw_dir=40;c->jpeg_dir=41;}return request_result;
}
int f3_card_poll_06(struct F3Card05*c){assert(c->state==6);c->state=1;c->requested[request_id-10]=1;c->raw_dir=40;c->jpeg_dir=41;return F3_CARD_OK;}
enum F3CardOutcome05 f3_card_cancel_pending_06(struct F3Card05*c){assert(c->state==6);c->state=3;c->requested[0]=c->requested[1]=0;c->raw_dir=c->jpeg_dir=-1;return F3_CARD_FAIL;}
int f3_card_valid_05(struct F3Card05*c){return !c->hold&&c->state==1;}
void f3_card_hold_05(struct F3Card05*c){c->hold=1;}
enum F3CardOutcome05 f3_card_close_dirs_05(struct F3Card05*c){assert(!on_ui&&!c->hold);++close_count;c->raw_dir=c->jpeg_dir=-1;c->state=5;return F3_CARD_OK;}
enum F3CardOutcome05 f3_card_release_requests_05(struct F3Card05*c){assert(on_ui&&c->state==5);++release_count;c->requested[0]=c->requested[1]=0;c->state=3;return F3_CARD_OK;}
int f4_movie_begin_01(struct F4Movie01*m,struct F3Card05*c,const struct F4MovieApi01*a,uint64_t id,uint64_t nonce,uint32_t w,uint32_t h,uint64_t maxfile,uint32_t packet,uint32_t frames){
 assert(!on_ui&&id&&nonce&&c&&a&&maxfile&&packet&&frames);m->state=begin_ok?F4_MOVIE_WRITING:F4_MOVIE_FAILED;
 m->mux.state=IQ4_MKV_WRITING;m->mux.width=w;m->mux.height=h;m->mux.frames=1;return begin_ok;
}
enum F3IoState f4_movie_finish_01(struct F4Movie01*m,uint8_t*h,size_t hn,uint8_t*p,uint32_t pn){
 assert(!on_ui&&h&&hn>=65536&&p&&pn>=1024);++finish_count;
 if(final_result==F3_IO_UNKNOWN){m->state=F4_MOVIE_HOLD;return final_result;}
 if(final_result==F3_IO_DONE){m->state=F4_MOVIE_PUBLISHED;m->files_closed=m->published=1;}else m->state=F4_MOVIE_FAILED;return final_result;
}
enum F3IoState f4_movie_abort_01(struct F4Movie01*m){assert(!on_ui&&m->state!=F4_MOVIE_HOLD);++abort_count;m->state=F4_MOVIE_PARTIAL_CLOSED;m->files_closed=1;return F3_IO_DONE;}
static unsigned char hash[65536],packet[4096];
static Iq4F4MoviePorts02 init(Iq4F4MovieBinding02*b,uint32_t id){on_ui=1;tid=1;fence=IQ4_F4_SRC_OK;begin_ok=1;final_result=F3_IO_DONE;request_result=F3_CARD_OK;
 request_count=release_count=close_count=finish_count=abort_count=0;
 assert(iq4_f4_movie_binding_init_on_ui_02(b,(void*)1,read_own,0,id,hash,sizeof hash,packet,sizeof packet,65536,50));return iq4_f4_movie_binding_ports_02(b);}
int main(void){Iq4F4MovieBinding02 b;Iq4F4MoviePorts02 p;struct Iq4Mkv*m=0;uint32_t published;
 /* Each selected card is requested once, successful finalizer is called once;
  * card dirs close on worker and native release is postponed to actual UI. */
 for(uint32_t id=10;id<=11;++id){p=init(&b,id);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY&&request_id==id&&request_count==1);
  on_ui=0;tid=2;assert(p.prepare_on_worker(&b,640,480,&m)==IQ4_F4_MOVIE_READY&&m==&b.movie.mux);
  assert(p.finalize_on_worker(&b,m,1,&published)==IQ4_F4_MOVIE_READY&&published==1&&finish_count==1&&abort_count==0&&close_count==1&&release_count==0);
  on_ui=1;tid=1;assert(p.release_on_ui(&b)==IQ4_F4_MOVIE_READY&&release_count==1);
  assert(p.set_destination_on_ui(&b,id==10?11:10)==IQ4_F4_MOVIE_READY);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY&&request_count==2);
 }
 p=init(&b,10);request_result=F3_CARD_PENDING_06;assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_PENDING);assert(p.cancel_pending_on_ui(&b)==IQ4_F4_MOVIE_READY&&b.card.state==3);
 p=init(&b,10);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY);on_ui=0;tid=2;begin_ok=0;assert(p.prepare_on_worker(&b,640,480,&m)==IQ4_F4_MOVIE_FAIL);
 assert(p.finalize_on_worker(&b,0,0,&published)==IQ4_F4_MOVIE_READY&&!published&&abort_count==1&&close_count==1);
 p=init(&b,10);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY);on_ui=0;tid=2;assert(p.prepare_on_worker(&b,640,480,&m)==IQ4_F4_MOVIE_READY);final_result=F3_IO_FAIL;
 assert(p.finalize_on_worker(&b,m,1,&published)==IQ4_F4_MOVIE_FAIL&&abort_count==1&&close_count==1&&!published);
 p=init(&b,10);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY);on_ui=0;tid=2;assert(p.prepare_on_worker(&b,640,480,&m)==IQ4_F4_MOVIE_READY);final_result=F3_IO_UNKNOWN;
 assert(p.finalize_on_worker(&b,m,1,&published)==IQ4_F4_MOVIE_UNKNOWN&&b.hold&&finish_count==1&&!abort_count&&!close_count&&!release_count);
 p=init(&b,10);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY);on_ui=0;tid=2;assert(p.prepare_on_worker(&b,640,480,&m)==IQ4_F4_MOVIE_READY);fence=IQ4_F4_SRC_PENDING;
 assert(p.finalize_on_worker(&b,m,1,&published)==IQ4_F4_MOVIE_UNKNOWN&&b.hold&&!finish_count&&!close_count);
 p=init(&b,10);assert(p.acquire_on_ui(&b)==IQ4_F4_MOVIE_READY);assert(p.set_destination_on_ui(&b,11)==IQ4_F4_MOVIE_FAIL&&p.destination_on_ui(&b)==10);
 puts("movie binding synthetic 8 groups PASS");return 0;
}
