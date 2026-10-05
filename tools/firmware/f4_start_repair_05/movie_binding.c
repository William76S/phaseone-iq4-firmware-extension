#include "../f4_native_source_02/movie_binding.h"
#include "../f4_native_source_02/native_calls.h"
#include <string.h>
static int unknown(Iq4F4MovieBinding02*b){b->hold=1;f3_card_hold_05(&b->card);return IQ4_F4_MOVIE_UNKNOWN;}
static int result(Iq4F4MovieBinding02*b,int r){if(r==F3_CARD_OK)return IQ4_F4_MOVIE_READY;if(r==F3_CARD_PENDING_06)return IQ4_F4_MOVIE_PENDING;if(r==F3_CARD_FAIL&&!b->card.hold&&b->card.state==3)return IQ4_F4_MOVIE_FAIL;return unknown(b);}
static int acquire(void*p){Iq4F4MovieBinding02*b=p;if(b->hold||!iq4_f4_source_is_ui_02(b->source))return unknown(b);
 if(b->card.state==3){if(b->card.hold||b->card.requested[0]||b->card.requested[1]||b->card.raw_dir>=0||b->card.jpeg_dir>=0)return unknown(b);memset(&b->card,0,sizeof b->card);}
 if(b->card.state)return unknown(b);
 struct F3CardRead05 r={b->read_context,b->read};
 int rc=f3_card_request_06(&b->card,&r,&b->lease,&b->card_io,&b->request,b->destination_fs_id,b->destination_fs_id);
 /* Card06 early argument/CAS rejection leaves the canonical initial card
  * entirely untouched. No request, fd, lease or global task is ours to clean.
  * Distinguish only that exact byte state from unknown partial acquisition;
  * never clear another card's sole_task or release its native requests. */
 static const unsigned char initial[sizeof(struct F3Card05)]={0};
 if(rc==F3_CARD_FAIL&&!memcmp(&b->card,initial,sizeof initial))return IQ4_F4_MOVIE_FAIL;
 return result(b,rc);
}
static int poll(void*p){Iq4F4MovieBinding02*b=p;if(b->hold||!iq4_f4_source_is_ui_02(b->source))return unknown(b);return result(b,f3_card_poll_06(&b->card));}
static int worker(Iq4F4MovieBinding02*b){uint64_t tid=iq4_f4_native_tid_02();if(!tid||iq4_f4_source_is_ui_02(b->source))return 0;
 if(!b->worker_tid)b->worker_tid=tid;return b->worker_tid==tid;}
static int prepare(void*p,uint32_t w,uint32_t h,struct Iq4Mkv**out){Iq4F4MovieBinding02*b=p;if(!out||b->hold||!worker(b)||!f3_card_valid_05(&b->card))return unknown(b);*out=0;
 if(b->movie.state){if(!b->movie.files_closed||b->movie.state==F4_MOVIE_HOLD)return unknown(b);memset(&b->movie,0,sizeof b->movie);}
 uint64_t nonce=iq4_f4_native_clock_02();if(!nonce||b->serial==UINT64_MAX)return unknown(b);++b->serial;
 if(!f4_movie_begin_01(&b->movie,&b->card,&b->api,b->serial,nonce,w,h,b->max_file,b->packet_capacity,b->max_frames))return b->movie.state==F4_MOVIE_HOLD?unknown(b):IQ4_F4_MOVIE_FAIL;
 *out=&b->movie.mux;return IQ4_F4_MOVIE_READY;
}
static int finalize(void*p,struct Iq4Mkv*m,int complete,uint32_t*published){Iq4F4MovieBinding02*b=p;
 if(!published||b->hold||!worker(b)||iq4_f4_source_fence_02(b->source)!=IQ4_F4_SRC_OK||(m&&m!=&b->movie.mux))return unknown(b);*published=0;
 enum F3IoState r=F3_IO_DONE;
 if(complete){if(!m||!m->frames||b->movie.state!=F4_MOVIE_WRITING)return unknown(b);
  r=f4_movie_finish_01(&b->movie,b->hash_scratch,b->hash_capacity,b->packet_scratch,b->packet_capacity);
 }else if(b->movie.state!=F4_MOVIE_UNUSED)r=f4_movie_abort_01(&b->movie);
 if(r==F3_IO_UNKNOWN||b->movie.state==F4_MOVIE_HOLD)return unknown(b);
 if(r==F3_IO_FAIL&&b->movie.state!=F4_MOVIE_UNUSED&&!b->movie.files_closed){
  /* Normal finite file failure may close checked once and preserve its part.
   * No repair/delete/publish retry. Unknown abort remains fully held. */
  enum F3IoState abort=f4_movie_abort_01(&b->movie);if(abort==F3_IO_UNKNOWN)return unknown(b);
 }
 if(b->movie.state!=F4_MOVIE_UNUSED&&!b->movie.files_closed)return unknown(b);
 *published=b->movie.published;
 if(f3_card_close_dirs_05(&b->card)!=F3_CARD_OK)return unknown(b);
 return r==F3_IO_DONE?IQ4_F4_MOVIE_READY:IQ4_F4_MOVIE_FAIL;
}
static int release(void*p){Iq4F4MovieBinding02*b=p;if(b->hold||!iq4_f4_source_is_ui_02(b->source)||b->card.state!=5)return unknown(b);return f3_card_release_requests_05(&b->card)==F3_CARD_OK?IQ4_F4_MOVIE_READY:unknown(b);}
static int cancel(void*p){Iq4F4MovieBinding02*b=p;if(b->hold||!iq4_f4_source_is_ui_02(b->source)||b->card.state!=6)return unknown(b);
 int r=f3_card_cancel_pending_06(&b->card);return r==F3_CARD_FAIL&&!b->card.hold&&b->card.state==3?IQ4_F4_MOVIE_READY:unknown(b);}
static uint32_t destination(void*p){Iq4F4MovieBinding02*b=p;return b&&!b->hold&&iq4_f4_source_is_ui_02(b->source)?b->destination_fs_id:0;}
static int set_destination(void*p,uint32_t id){Iq4F4MovieBinding02*b=p;if(b->hold||!iq4_f4_source_is_ui_02(b->source)||(id!=10&&id!=11))return unknown(b);
 if(b->card.state!=0&&b->card.state!=3)return IQ4_F4_MOVIE_FAIL;b->destination_fs_id=id;return IQ4_F4_MOVIE_READY;}
int iq4_f4_movie_binding_init_on_ui_02(Iq4F4MovieBinding02*b,void*source,Iq4F4SelfRead02 read,void*ctx,uint32_t id,unsigned char*hash,size_t hashcap,unsigned char*packet,uint32_t cap,uint64_t maxfile,uint32_t frames){
 if(!b||!source||!read||(id!=10&&id!=11)||!hash||hashcap<65536||!packet||cap<1024||cap>32u*1024u*1024u||maxfile<4096||maxfile>UINT64_C(4294967295)||!frames||frames>1000000||!iq4_f4_source_is_ui_02(source))return 0;
 memset(b,0,sizeof*b);b->source=source;b->read=read;b->read_context=ctx;b->destination_fs_id=id;b->hash_scratch=hash;b->hash_capacity=hashcap;b->packet_scratch=packet;b->packet_capacity=cap;b->max_file=maxfile;b->max_frames=frames;
 f3_card_native_calls_05(&b->lease);f3_card_linux_io_05(&b->card_io);f3_card_native_try_calls_06(&b->request);f4_movie_linux_api_01(&b->api);return 1;
}
Iq4F4MoviePorts02 iq4_f4_movie_binding_ports_02(Iq4F4MovieBinding02*b){return(Iq4F4MoviePorts02){b,acquire,poll,prepare,finalize,release,cancel,set_destination,destination};}
