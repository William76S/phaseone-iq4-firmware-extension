#include "movie.h"
#include <string.h>
static enum F3IoState unknown(struct F4Movie01*m){m->state=F4_MOVIE_HOLD;f3_card_hold_05(m->card);return F3_IO_UNKNOWN;}
static struct F3Io io(uint32_t state,uint64_t value){return(struct F3Io){state,value};}
/* Linux errno values. Device/descriptor identity failures cannot be treated
 * as an ordinary full-card failure even if the old mount remains visible. */
static int lost(struct F3SysResult r){return r.value<0&&(r.error==5||r.error==6||r.error==9||r.error==19||r.error==116);}
static int same(const struct F3FdStat*a,const struct F3FdStat*b,int contents){return a->device==b->device&&a->inode==b->inode&&a->mode==b->mode&&a->nlink==1&&b->nlink==1&&((a->mode&0170000u)==0100000u)&&(!contents||(a->size==b->size&&a->mtime_sec==b->mtime_sec&&a->mtime_nsec==b->mtime_nsec));}
static int pair(struct F4Movie01*m,int fd,const char*leaf,struct F3FdStat*out){struct F3FdStat a,b;return !m->api.fs.stat_fd(fd,&a).value&&!m->api.fs.stat_leaf(m->card->jpeg_dir,leaf,&b).value&&same(&a,&b,1)&&(*out=a,1);}
static int valid(struct F4Movie01*m){if(!m||m->state==F4_MOVIE_HOLD||!f3_card_valid_05(m->card))return 0;
 if(m->write_fd>=0){struct F3FdStat st;if(!pair(m,m->write_fd,m->part_leaf,&st)||!same(&m->original,&st,0)||st.size!=m->accepted_bytes)return 0;}return 1;}
static struct F3Io append(void*v,const uint8_t*p,uint32_t n){struct F4Movie01*m=v;if(m->state!=F4_MOVIE_WRITING||m->write_fd<0||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}
 if(!p||!n||n>m->mux.max_file_bytes||m->accepted_bytes>m->mux.max_file_bytes-n){m->state=F4_MOVIE_FAILED;return io(F3_IO_FAIL,0);}
 struct F3SysResult r=m->api.fs.write(m->write_fd,p,n);if(r.value>0&&(uint64_t)r.value<=n)m->accepted_bytes+=(uint64_t)r.value;
 if(lost(r)||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}if(r.value!=(int64_t)n){m->state=F4_MOVIE_FAILED;return io(F3_IO_FAIL,0);}return io(F3_IO_DONE,n);}
static struct F3Io patch(void*v,uint64_t off,const uint8_t*p,uint32_t n){struct F4Movie01*m=v;if(m->state!=F4_MOVIE_WRITING||m->write_fd<0||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}
 if(!p||!n||off>m->accepted_bytes||n>m->accepted_bytes-off){m->state=F4_MOVIE_FAILED;return io(F3_IO_FAIL,0);}struct F3SysResult r=m->api.write_at(m->write_fd,p,n,off);
 if(lost(r)||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}if(r.value!=(int64_t)n){m->state=F4_MOVIE_FAILED;return io(F3_IO_FAIL,0);}return io(F3_IO_DONE,n);}
static void name(char*out,const char*prefix,uint64_t id,uint64_t nonce,const char*suffix){static const char hex[]="0123456789abcdef";unsigned n=0;while(*prefix)out[n++]=*prefix++;for(int i=15;i>=0;--i)out[n++]=hex[(id>>(4*i))&15];out[n++]='-';for(int i=15;i>=0;--i)out[n++]=hex[(nonce>>(4*i))&15];while(*suffix)out[n++]=*suffix++;out[n]=0;}
int f4_movie_begin_01(struct F4Movie01*m,struct F3Card05*c,const struct F4MovieApi01*a,uint64_t id,uint64_t nonce,uint32_t w,uint32_t h,uint64_t max_file,uint32_t max_packet,uint32_t max_frames){
 if(!m||m->state||!c||!a||!id||!nonce||!a->fs.open_leaf||!a->fs.stat_fd||!a->fs.stat_leaf||!a->fs.write||!a->fs.read_at||!a->fs.sync||!a->fs.close||!a->fs.move_noreplace||!a->write_at||!f3_card_valid_05(c))return 0;
 /* Validate the same finite native-mux limits before creating a file. */
 if(!w||!h||w>65500||h>65500||!max_frames||max_frames>1000000||max_packet<16||max_packet>32u*1024u*1024u||max_file<4096||max_file>UINT64_C(4294967295))return 0;
 m->card=c;m->api=*a;m->write_fd=m->read_fd=-1;name(m->part_leaf,".iq4-video-",id,nonce,".part");name(m->final_leaf,"LV-",id,nonce,".MKV");
 struct F3SysResult r=a->fs.open_leaf(c->jpeg_dir,m->part_leaf,1);if(r.value<0){if(lost(r)||!f3_card_valid_05(c))unknown(m);else m->state=F4_MOVIE_FAILED;return 0;}m->write_fd=(int)r.value;m->state=F4_MOVIE_WRITING;
 if(!pair(m,m->write_fd,m->part_leaf,&m->original)||m->original.size||!valid(m)){unknown(m);return 0;}
 struct Iq4MkvIo ports={m,append,patch};enum Iq4MkvStatus rc=iq4_mkv_begin(&m->mux,&ports,w,h,max_file,max_packet,max_frames);return rc==IQ4_MKV_OK;
}
enum Iq4MkvStatus f4_movie_packet_01(struct F4Movie01*m,const uint8_t*p,uint32_t n,uint64_t ns,uint64_t seq){if(!m)return IQ4_MKV_ARGUMENT;if(m->state==F4_MOVIE_HOLD)return IQ4_MKV_HOLD;if(m->state!=F4_MOVIE_WRITING)return IQ4_MKV_STATE;enum Iq4MkvStatus r=iq4_mkv_packet(&m->mux,p,n,ns,seq);if(r!=IQ4_MKV_OK&&m->state!=F4_MOVIE_HOLD)m->state=F4_MOVIE_FAILED;return r;}
static enum F3IoState close_one(struct F4Movie01*m,int*fd){if(*fd<0)return F3_IO_DONE;struct F3SysResult r=m->api.fs.close(*fd);if(r.value)return unknown(m);*fd=-1;return F3_IO_DONE;}
enum F3IoState f4_movie_abort_01(struct F4Movie01*m){if(!m)return F3_IO_FAIL;if(m->state==F4_MOVIE_UNUSED||m->state==F4_MOVIE_PUBLISHED)return F3_IO_FAIL;if(m->state==F4_MOVIE_PARTIAL_CLOSED)return F3_IO_DONE;if(m->state==F4_MOVIE_HOLD||!valid(m))return unknown(m);
 int failure=0;if(m->write_fd>=0){struct F3SysResult synced=m->api.fs.sync(m->write_fd);failure=synced.value!=0;if(lost(synced)||!valid(m))return unknown(m);if(close_one(m,&m->write_fd)!=F3_IO_DONE)return F3_IO_UNKNOWN;}if(close_one(m,&m->read_fd)!=F3_IO_DONE)return F3_IO_UNKNOWN;
 m->files_closed=1;m->state=F4_MOVIE_PARTIAL_CLOSED;return failure?F3_IO_FAIL:F3_IO_DONE;}
static struct F3Io read_at(void*v,uint64_t off,uint8_t*p,uint32_t n){struct F4Movie01*m=v;if(m->read_fd<0||off>m->reviewed_bytes||n>m->reviewed_bytes-off||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}struct F3SysResult r=m->api.fs.read_at(m->read_fd,p,n,off);if(lost(r)||!valid(m)){unknown(m);return io(F3_IO_UNKNOWN,0);}return r.value==(int64_t)n?io(F3_IO_DONE,n):io(F3_IO_FAIL,0);}
enum F3IoState f4_movie_finish_01(struct F4Movie01*m,uint8_t*scratch,size_t cap,uint8_t*packet,uint32_t packet_cap){
 if(!m||!scratch||cap<65536||!packet)return F3_IO_FAIL;if(m->state==F4_MOVIE_HOLD)return F3_IO_UNKNOWN;
 if(m->state!=F4_MOVIE_WRITING||packet_cap<m->mux.max_packet_bytes)return F3_IO_FAIL;
 if(iq4_mkv_seal(&m->mux)!=IQ4_MKV_OK)return m->state==F4_MOVIE_HOLD?F3_IO_UNKNOWN:F3_IO_FAIL;
 if(!valid(m))return unknown(m);if(m->mux.file_bytes!=m->accepted_bytes){m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}
 struct F3SysResult synced=m->api.fs.sync(m->write_fd);if(lost(synced)||!valid(m))return unknown(m);if(synced.value){m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}
 if(close_one(m,&m->write_fd)!=F3_IO_DONE)return F3_IO_UNKNOWN;if(!valid(m))return unknown(m);
 struct F3SysResult r=m->api.fs.open_leaf(m->card->jpeg_dir,m->part_leaf,0);if(r.value<0)return unknown(m);m->read_fd=(int)r.value;
 if(!pair(m,m->read_fd,m->part_leaf,&m->final)||!same(&m->original,&m->final,0)||m->final.size!=m->accepted_bytes||!valid(m))return unknown(m);m->reviewed_bytes=m->final.size;
 uint8_t segment[8];struct F3Io declared=read_at(m,m->mux.segment_size_offset,segment,8);if(declared.state!=F3_IO_DONE){if(declared.state==F3_IO_UNKNOWN)return F3_IO_UNKNOWN;m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}uint64_t segment_bytes=0;for(unsigned i=1;i<8;++i)segment_bytes=(segment_bytes<<8)|segment[i];if(segment[0]!=1||segment_bytes!=m->reviewed_bytes-m->mux.segment_start){m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}
 F4Sha sh;f4_sha_init(&sh);for(uint64_t off=0;off<m->reviewed_bytes;){uint32_t n=(uint32_t)(m->reviewed_bytes-off);if(n>65536)n=65536;struct F3Io rr=read_at(m,off,scratch,n);if(rr.state!=F3_IO_DONE){if(rr.state==F3_IO_UNKNOWN)return F3_IO_UNKNOWN;m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}f4_sha_update(&sh,scratch,n);off+=n;}f4_sha_end(&sh,m->sha256);
 struct Iq4MkvReader reader={m,read_at};struct Iq4MkvScan scan={0};enum Iq4MkvScanStatus rc=iq4_mkv_scan_begin(&scan,&reader,m->reviewed_bytes,m->mux.width,m->mux.height,m->mux.max_packet_bytes);if(rc!=IQ4_MKV_SCAN_PACKET){if(rc==IQ4_MKV_SCAN_HOLD)return unknown(m);m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}
 for(uint32_t i=0;i<=m->mux.frames;++i){uint32_t n=0;uint64_t ns=0,seq=0;rc=iq4_mkv_scan_next(&scan,packet,packet_cap,&n,&ns,&seq);if(rc==IQ4_MKV_SCAN_END)break;if(rc!=IQ4_MKV_SCAN_PACKET){if(rc==IQ4_MKV_SCAN_HOLD)return unknown(m);m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}}
 struct F3FdStat after;if(!scan.ended||scan.offset!=m->reviewed_bytes||scan.frames!=m->mux.frames||scan.first_ns!=m->mux.first_observed_ns||scan.last_ns!=m->mux.last_observed_ns||scan.last_local_sequence!=m->mux.last_local_sequence){m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}
 if(!pair(m,m->read_fd,m->part_leaf,&after)||!same(&m->final,&after,1)||!valid(m))return unknown(m);m->structure_checked=1;
 if(close_one(m,&m->read_fd)!=F3_IO_DONE)return F3_IO_UNKNOWN;if(!valid(m))return unknown(m);m->files_closed=1;
 r=m->api.fs.move_noreplace(m->card->jpeg_dir,m->part_leaf,m->final_leaf);if(r.value==-2||lost(r))return unknown(m);if(r.value){if(!valid(m))return unknown(m);m->state=F4_MOVIE_FAILED;return F3_IO_FAIL;}m->published=1;
 if(!valid(m)||m->api.fs.sync(m->card->jpeg_dir).value||!valid(m)||m->api.fs.stat_leaf(m->card->jpeg_dir,m->final_leaf,&after).value||!same(&m->final,&after,1))return unknown(m);
 m->state=F4_MOVIE_PUBLISHED;return F3_IO_DONE;
}
