#define _GNU_SOURCE
#define main unused_card_fixture_main_movie01
#include "../f3_native_card_bridge_05/test_card.c"
#undef main
#include "movie.h"
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
extern void f3_fs_host_api_03(struct F3Posix*);
static struct F3Posix real;static char media[4096],sd[4096],xqd[4096];static int fd_mount[1024],scenario;
static unsigned writes,patches,closes,moves,syncs;static struct F4Movie01*active;
static struct F3SysResult root_open(const char*p){int index=!strcmp(p,"/run/media/xqdcard/");assert(index||!strcmp(p,"/run/media/sdcard/"));int fd=open(index?xqd:sd,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(fd>=0&&fd<1024);fd_mount[fd]=index?102:101;return(struct F3SysResult){fd,0};}
static struct F3SysResult media_open(void){int fd=open(media,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(fd>=0&&fd<1024);fd_mount[fd]=17;return(struct F3SysResult){fd,0};}
static struct F3SysResult mnt(int fd,uint64_t*out,int*aux){(void)aux;assert(fd>=0&&fd<1024&&fd_mount[fd]);*out=fd_mount[fd];if(scenario==3&&writes>1&&fd_mount[fd]==101)*out+=1;return(struct F3SysResult){0,0};}
static struct F3SysResult cardclose(int fd){fd_mount[fd]=0;return real.close(fd);}
static struct F3SysResult checked_write(int fd,const void*p,uint32_t n){++writes;if(scenario==11&&writes==2)return(struct F3SysResult){-1,5};return real.write(fd,p,scenario==2&&writes==2?1:n);}
static struct F3SysResult write_at(int fd,const void*p,uint32_t n,uint64_t off){++patches;if(scenario==4)return(struct F3SysResult){-1,28};if(scenario==8){uint8_t broken[8]={1};assert(n==8);return(struct F3SysResult){pwrite(fd,broken,8,(off_t)off),0};}return(struct F3SysResult){pwrite(fd,p,n,(off_t)off),0};}
static struct F3SysResult checked_close(int fd){++closes;if(scenario==5||(scenario==10&&closes==2))return(struct F3SysResult){-1,5};return real.close(fd);}
static struct F3SysResult checked_move(int d,const char*a,const char*b){++moves;if(scenario==6)return(struct F3SysResult){-1,17};return real.move_noreplace(d,a,b);}
static struct F3SysResult checked_read_at(int fd,void*p,uint32_t n,uint64_t off){if(scenario==12)return(struct F3SysResult){-1,5};return real.read_at(fd,p,n,off);}
static struct F3SysResult checked_sync(int fd){++syncs;if(scenario==7&&moves)return(struct F3SysResult){-1,5};return real.sync(fd);}
static uint8_t*load(const char*p,size_t*n){FILE*f=fopen(p,"rb");assert(f&&!fseek(f,0,SEEK_END));*n=(size_t)ftell(f);assert(*n&&!fseek(f,0,SEEK_SET));uint8_t*b=malloc(*n);assert(b&&fread(b,1,*n,f)==*n&&!fclose(f));return b;}
int main(int argc,char**argv){assert(argc==5);scenario=atoi(argv[4]);stock=load(argv[1],&stock_bytes);size_t jpeg_bytes;uint8_t*jpeg=load(argv[2],&jpeg_bytes);uint32_t width=0,height=0;assert(f3_jpeg_shape_01(jpeg,jpeg_bytes,&width,&height));
 for(unsigned i=0;i<2;++i){up(power[i],0xdb6628);up(power[i]+0x68,i?0x9f3fe8:0x9f4000);up(filesystems[i],0xd91450);strcpy((char*)filesystems[i]+0x15,i?"/run/media/xqdcard/":"/run/media/sdcard/");u32(rows[i],10+i);up(rows[i]+16,(uintptr_t)filesystems[i]);u32(rows[i]+24,2);}head=(uintptr_t)power[0];tail=(uintptr_t)power[1];up(power[0]+0x170,tail);
 snprintf(media,sizeof(media),"%s/movie-%d-XXXXXX",argv[3],scenario);assert(mkdtemp(media));assert(snprintf(sd,sizeof(sd),"%s/sd",media)>0&&snprintf(xqd,sizeof(xqd),"%s/xqd",media)>0&&!mkdir(sd,0700)&&!mkdir(xqd,0700));f3_fs_host_api_03(&real);
 struct F3CardRead05 memory={0,readmem};struct F3LeaseCalls05 calls={0,reg,waitreq,release};struct F3CardIo05 cio={root_open,media_open,mnt,real.stat_fd,cardclose};struct F3Card05 card={0};assert(f3_card_begin_05(&card,&memory,&calls,&cio,10,10)==F3_CARD_OK);
 struct F4MovieApi01 api={real,write_at};api.fs.write=checked_write;api.fs.read_at=checked_read_at;api.fs.close=checked_close;api.fs.move_noreplace=checked_move;api.fs.sync=checked_sync;struct F4Movie01 movie={0};active=&movie;assert(f4_movie_begin_01(&movie,&card,&api,9,11,width,height,1024*1024,65536,10));
 if(scenario==1){struct F4Movie01 collision={0};assert(!f4_movie_begin_01(&collision,&card,&api,9,11,width,height,1024*1024,65536,10)&&collision.write_fd<0&&!card.hold);}
 enum Iq4MkvStatus rc=f4_movie_packet_01(&movie,jpeg,(uint32_t)jpeg_bytes,UINT64_C(1000000000),1);
 if(scenario==2)assert(rc==IQ4_MKV_IO);else if(scenario==3||scenario==11)assert(rc==IQ4_MKV_HOLD&&movie.state==F4_MOVIE_HOLD);else assert(rc==IQ4_MKV_OK);
 uint8_t scratch[65536],packet[65536];enum F3IoState finished;
 if(scenario==9){uint8_t bad=0;assert(pwrite(movie.write_fd,&bad,1,(off_t)(movie.accepted_bytes-1))==1);}
 if(scenario==2)finished=f4_movie_abort_01(&movie);else finished=f4_movie_finish_01(&movie,scratch,sizeof(scratch),packet,sizeof(packet));
 if(scenario==3||scenario==5||scenario==7||scenario==10||scenario==11||scenario==12){assert(finished==F3_IO_UNKNOWN&&card.hold&&movie.state==F4_MOVIE_HOLD);unsigned w=writes,c=closes,m=moves;assert(f4_movie_abort_01(&movie)==F3_IO_UNKNOWN&&f4_movie_finish_01(&movie,scratch,sizeof(scratch),packet,sizeof(packet))==F3_IO_UNKNOWN&&writes==w&&closes==c&&moves==m&&!release_calls);}
 else if(scenario==4||scenario==6||scenario==8||scenario==9){assert(finished==F3_IO_FAIL&&!movie.published&&!release_calls&&f4_movie_abort_01(&movie)==F3_IO_DONE&&movie.files_closed);assert(f3_card_finish_05(&card)==F3_CARD_OK);}
 else if(scenario==2){assert(finished==F3_IO_DONE&&!movie.published&&movie.files_closed&&movie.state==F4_MOVIE_PARTIAL_CLOSED&&f3_card_finish_05(&card)==F3_CARD_OK);}
 else{assert(finished==F3_IO_DONE&&movie.published&&movie.structure_checked&&movie.files_closed&&movie.sha256[64]==0&&movie.state==F4_MOVIE_PUBLISHED);int d=open(sd,O_RDONLY|O_DIRECTORY);assert(d>=0);struct F3FdStat st;assert(!real.stat_leaf(d,movie.final_leaf,&st).value&&st.size==movie.reviewed_bytes&&!close(d));assert(f3_card_finish_05(&card)==F3_CARD_OK);}
 free(stock);free(jpeg);printf("{\"movie_case\":%d,\"passed\":true,\"real_host_files\":true,\"card_mounts_fixture\":true,\"target_executed\":false}\n",scenario);return 0;
}
