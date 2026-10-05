#define _DARWIN_C_SOURCE
#include "../src/recording/native_mkv.h"
#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
struct Port {int fd,short_io,calls,fail_call,unknown_call,patch_unknown;};
static struct F3Io out(struct Port *p,ssize_t n){if(p->calls==p->unknown_call)return(struct F3Io){F3_IO_UNKNOWN,0};if(n<0)return(struct F3Io){F3_IO_FAIL,0};return(struct F3Io){F3_IO_DONE,(uint64_t)n};}
static struct F3Io append(void *v,const uint8_t *b,uint32_t n){struct Port *p=v;++p->calls;if(p->calls==p->fail_call)return(struct F3Io){F3_IO_FAIL,0};return out(p,write(p->fd,b,p->short_io&&n>3?n/3:n));}
static struct F3Io patch(void *v,uint64_t o,const uint8_t *b,uint32_t n){struct Port *p=v;++p->calls;if(p->patch_unknown)return(struct F3Io){F3_IO_UNKNOWN,0};return out(p,pwrite(p->fd,b,p->short_io&&n>1?n/2:n,(off_t)o));}
static struct F3Io read_at(void *v,uint64_t o,uint8_t *b,uint32_t n){struct Port *p=v;++p->calls;return out(p,pread(p->fd,b,p->short_io&&n>3?n/3:n,(off_t)o));}
static uint8_t *load(const char *p,uint32_t *n){FILE *f=fopen(p,"rb");assert(f);assert(!fseek(f,0,SEEK_END));long len=ftell(f);assert(len>=16&&len<65536);*n=(uint32_t)len;assert(!fseek(f,0,SEEK_SET));uint8_t *b=malloc(*n);assert(b&&fread(b,1,*n,f)==*n&&!fclose(f));return b;}
static int scratch(void){char p[]="/tmp/iq4-mkv-test-XXXXXX";int fd=mkstemp(p);assert(fd>=0&&!unlink(p));return fd;}
static struct Iq4MkvIo io(struct Port *p){return(struct Iq4MkvIo){p,append,patch};}
static enum Iq4MkvStatus begin(struct Iq4Mkv *m,struct Port *p){struct Iq4MkvIo i=io(p);return iq4_mkv_begin(m,&i,128,96,1024*1024,65536,100);}
int main(int argc,char **argv){assert(argc==5);uint8_t *jpeg[3];uint32_t lens[3];for(unsigned i=0;i<3;++i)jpeg[i]=load(argv[i+1],&lens[i]);
 const uint64_t times[3]={1000000000,1033333333,1078000000},local[3]={1,2,4};unsigned groups=0;
 struct Port p={0};p.fd=open(argv[4],O_RDWR|O_CREAT|O_EXCL,0600);assert(p.fd>=0);struct Iq4Mkv m={0};assert(begin(&m,&p)==IQ4_MKV_OK);for(unsigned i=0;i<3;++i)assert(iq4_mkv_packet(&m,jpeg[i],lens[i],times[i],local[i])==IQ4_MKV_OK);assert(m.frames==3&&iq4_mkv_seal(&m)==IQ4_MKV_OK&&m.state==IQ4_MKV_SEALED);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],2000000000,5)==IQ4_MKV_STATE);assert(!fsync(p.fd));++groups;
 struct Iq4MkvScan scan={0};struct Iq4MkvReader reader={&p,read_at};uint8_t recovered[65536];uint32_t n;uint64_t ns,id;p.short_io=1;assert(iq4_mkv_scan_begin(&scan,&reader,m.file_bytes,128,96,sizeof recovered)==IQ4_MKV_SCAN_PACKET);for(unsigned i=0;i<3;++i){assert(iq4_mkv_scan_next(&scan,recovered,sizeof recovered,&n,&ns,&id)==IQ4_MKV_SCAN_PACKET);assert(n==lens[i]&&ns==times[i]&&id==local[i]&&!memcmp(recovered,jpeg[i],n));}assert(iq4_mkv_scan_next(&scan,recovered,sizeof recovered,&n,&ns,&id)==IQ4_MKV_SCAN_END&&!n);++groups;
 uint64_t all=m.file_bytes;p.short_io=0;assert(!ftruncate(p.fd,(off_t)(all-1)));scan=(struct Iq4MkvScan){0};assert(iq4_mkv_scan_begin(&scan,&reader,all-1,128,96,sizeof recovered)==IQ4_MKV_SCAN_PACKET);for(unsigned i=0;i<2;++i)assert(iq4_mkv_scan_next(&scan,recovered,sizeof recovered,&n,&ns,&id)==IQ4_MKV_SCAN_PACKET);assert(iq4_mkv_scan_next(&scan,recovered,sizeof recovered,&n,&ns,&id)==IQ4_MKV_SCAN_END&&scan.frames==2);assert(!close(p.fd));++groups;
 /* Regenerate the public host-validation file, do not repair a partial in place. */
 assert(!unlink(argv[4]));p=(struct Port){.fd=open(argv[4],O_RDWR|O_CREAT|O_EXCL,0600),.short_io=1};assert(p.fd>=0);m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);for(unsigned i=0;i<3;++i)assert(iq4_mkv_packet(&m,jpeg[i],lens[i],times[i],local[i])==IQ4_MKV_OK);assert(iq4_mkv_seal(&m)==IQ4_MKV_OK&&!fsync(p.fd)&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_seal(&m)==IQ4_MKV_STATE);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[1],lens[1],times[0],2)==IQ4_MKV_ORDER&&m.state==IQ4_MKV_FAILED);assert(iq4_mkv_seal(&m)==IQ4_MKV_STATE&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[1],lens[1],times[1],1)==IQ4_MKV_ORDER&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch(),.fail_call=3};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_IO&&m.frames==0&&m.state==IQ4_MKV_FAILED&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch(),.unknown_call=3};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_HOLD&&m.frames==0);int calls=p.calls;assert(iq4_mkv_seal(&m)==IQ4_MKV_HOLD&&iq4_mkv_packet(&m,jpeg[0],lens[0],times[1],2)==IQ4_MKV_HOLD&&p.calls==calls);assert(!close(p.fd));++groups;
 p=(struct Port){.fd=scratch(),.patch_unknown=1};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_OK&&iq4_mkv_seal(&m)==IQ4_MKV_HOLD&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);uint8_t saved=jpeg[0][0];jpeg[0][0]=0;assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_PACKET&&!close(p.fd));jpeg[0][0]=saved;++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};struct Iq4MkvIo i=io(&p);assert(iq4_mkv_begin(&m,&i,129,96,1024*1024,65536,100)==IQ4_MKV_OK&&iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_PACKET&&!close(p.fd));++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};i=io(&p);assert(iq4_mkv_begin(&m,&i,128,96,4096,65536,1)==IQ4_MKV_OK);enum Iq4MkvStatus rc=iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1);if(rc==IQ4_MKV_OK)assert(iq4_mkv_packet(&m,jpeg[1],lens[1],times[1],2)==IQ4_MKV_LIMIT);else assert(rc==IQ4_MKV_LIMIT);assert(!close(p.fd));++groups;
 p=(struct Port){.fd=scratch()};m=(struct Iq4Mkv){0};assert(begin(&m,&p)==IQ4_MKV_OK);assert(iq4_mkv_packet(&m,jpeg[0],lens[0],times[0],1)==IQ4_MKV_OK);uint8_t corrupt=0x55;assert(pwrite(p.fd,&corrupt,1,(off_t)(m.file_bytes-1))==1);scan=(struct Iq4MkvScan){0};reader=(struct Iq4MkvReader){&p,read_at};assert(iq4_mkv_scan_begin(&scan,&reader,m.file_bytes,128,96,sizeof recovered)==IQ4_MKV_SCAN_PACKET&&iq4_mkv_scan_next(&scan,recovered,sizeof recovered,&n,&ns,&id)==IQ4_MKV_SCAN_END&&scan.frames==0&&!close(p.fd));++groups;
 for(unsigned k=0;k<3;++k)free(jpeg[k]);printf("{\"host_packet_file_groups\":%u,\"target_executed\":false}\n",groups);return 0;
}
