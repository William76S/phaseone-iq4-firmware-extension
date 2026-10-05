#include "card.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static unsigned char*stock;static size_t stock_bytes;
static unsigned char power[2][0x3a0],filesystems[2][0x218];
static uintptr_t head,tail;static uint8_t rows[2][32];
static unsigned reg_calls,wait_calls,release_calls;static int fault;
static uint64_t current_mount[3]={101,102,17};
struct Descriptor{int active,index;uint64_t mount;};static struct Descriptor fds[64];
static void u32(void*p,uint32_t v){memcpy(p,&v,4);}static void up(void*p,uintptr_t v){memcpy(p,&v,8);}
static int readmem(void*ctx,uintptr_t p,void*out,size_t n){(void)ctx;
 if(p==0x41fc5e8&&n==8){memcpy(out,&head,8);return 1;}if(p==0x41fc5f0&&n==8){memcpy(out,&tail,8);return 1;}
 for(unsigned i=0;i<2;++i){if(p==0xf55e18+i*32&&n==32){memcpy(out,rows[i],n);return 1;}uintptr_t a=(uintptr_t)power[i],b=(uintptr_t)filesystems[i];
  if(p>=a&&p+n<=a+sizeof(power[i])){memcpy(out,(void*)p,n);return 1;}if(p>=b&&p+n<=b+sizeof(filesystems[i])){memcpy(out,(void*)p,n);return 1;}}
 uint64_t ph;uint16_t count;memcpy(&ph,stock+32,8);memcpy(&count,stock+56,2);for(unsigned i=0;i<count;++i){uint32_t type;uint64_t off,va,size;memcpy(&type,stock+ph+i*56,4);memcpy(&off,stock+ph+i*56+8,8);memcpy(&va,stock+ph+i*56+16,8);memcpy(&size,stock+ph+i*56+32,8);if(type==1&&p>=va&&n<=size&&p-va<=size-n&&off+p-va+n<=stock_bytes){memcpy(out,stock+off+p-va,n);if(fault==1&&p==0x8ca3ec)((uint8_t*)out)[0]^=1;return 1;}}
 return 0;
}
static enum F3CardOutcome05 reg(void*ctx,uintptr_t p,const char*n,uint32_t*out){(void)ctx;++reg_calls;if(fault==2){*out=0;return F3_CARD_OK;}uintptr_t value;for(unsigned i=2;i<32;++i){memcpy(&value,(void*)(p+0x70+i*8),8);if(!value){up((void*)(p+0x70+i*8),(uintptr_t)n);*out=i;return F3_CARD_OK;}}return F3_CARD_UNKNOWN;}
static enum F3CardOutcome05 waitreq(void*ctx,uintptr_t p,uint32_t id,uint32_t ms,uint32_t*out){(void)ctx;assert(ms==6000);++wait_calls;uint32_t mask;memcpy(&mask,(void*)(p+0x17c),4);u32((void*)(p+0x17c),mask|(1u<<id));if(fault==3)return F3_CARD_UNKNOWN;*out=fault==4?1:0;u32((void*)(p+0x320),1);return F3_CARD_OK;}
static enum F3CardOutcome05 release(void*ctx,uintptr_t p,uint32_t id,uint32_t*out){(void)ctx;++release_calls;if(fault==10)return F3_CARD_UNKNOWN;uint32_t mask;memcpy(&mask,(void*)(p+0x17c),4);u32((void*)(p+0x17c),mask&~(1u<<id));*out=0;return F3_CARD_OK;}
static struct F3SysResult opened(int index){for(int i=4;i<64;++i)if(!fds[i].active){fds[i]=(struct Descriptor){1,index,current_mount[index]};return(struct F3SysResult){i,0};}return(struct F3SysResult){-1,24};}
static struct F3SysResult openroot(const char*p){assert(!strcmp(p,"/run/media/sdcard/")||!strcmp(p,"/run/media/xqdcard/"));return opened(!strcmp(p,"/run/media/xqdcard/"));}
static struct F3SysResult parent(void){return opened(2);}
static struct F3SysResult mounted(int fd,uint64_t*out,int*aux){assert(fd>=4&&fd<64&&fds[fd].active);if(fault==6)return(struct F3SysResult){-1,22};if(fault==7){*aux=61;fds[61]=(struct Descriptor){1,2,17};return(struct F3SysResult){-1,5};}*out=fds[fd].mount;return(struct F3SysResult){0,0};}
static struct F3SysResult statfd(int fd,struct F3FdStat*out){assert(fd>=4&&fd<64&&fds[fd].active);*out=(struct F3FdStat){fds[fd].index+100u,fds[fd].index+7u,0,2,0040700,0,0};return(struct F3SysResult){0,0};}
static struct F3SysResult closefd(int fd){assert(fd>=4&&fd<64&&fds[fd].active);if(fault==8)return(struct F3SysResult){-1,5};fds[fd].active=0;return(struct F3SysResult){0,0};}
int main(int argc,char**argv){assert(argc==3);fault=atoi(argv[2]);FILE*f=fopen(argv[1],"rb");assert(f&&!fseek(f,0,SEEK_END));stock_bytes=(size_t)ftell(f);assert(!fseek(f,0,SEEK_SET));stock=malloc(stock_bytes);assert(stock&&fread(stock,1,stock_bytes,f)==stock_bytes&&!fclose(f));
 for(unsigned i=0;i<2;++i){up(power[i],0xdb6628);up(power[i]+0x68,i?0x9f3fe8:0x9f4000);up(power[i]+0x70,1);up(power[i]+0x78,2);up(filesystems[i],0xd91450);strcpy((char*)filesystems[i]+0x15,i?"/run/media/xqdcard/":"/run/media/sdcard/");u32(rows[i],10+i);up(rows[i]+16,(uintptr_t)filesystems[i]);u32(rows[i]+24,2);}
 head=(uintptr_t)power[0];tail=(uintptr_t)power[1];up(power[0]+0x170,tail);if(fault==5)up(power[1]+0x170,head);if(fault==11)current_mount[0]=17;
 struct F3CardRead05 m={0,readmem};struct F3LeaseCalls05 a={0,reg,waitreq,release};struct F3CardIo05 io={openroot,parent,mounted,statfd,closefd};struct F3Card05 c={0};enum F3CardOutcome05 r=f3_card_begin_05(&c,&m,&a,&io,11,10);
 if(fault==1||fault==5){assert(r==F3_CARD_FAIL&&!reg_calls&&!wait_calls);}else if(fault==2){assert(r==F3_CARD_FAIL&&reg_calls==1&&!wait_calls);}else if(fault==4){assert(r==F3_CARD_FAIL&&wait_calls==1&&release_calls==1);}else if(fault==6||fault==11){assert(r==F3_CARD_FAIL&&release_calls==2);}else if(fault==3||fault==7||fault==8){assert(r==F3_CARD_UNKNOWN&&c.hold);}
 else {assert(r==F3_CARD_OK&&c.raw_mount==102&&c.jpeg_mount==101&&f3_card_guard_05(&c).actual_epoch(&c)==101);
  if(fault==9){current_mount[0]=103;assert(!f3_card_valid_05(&c)&&c.hold&&!release_calls&&fds[c.raw_dir].active&&fds[c.jpeg_dir].active);}
  else if(fault==10){assert(f3_card_close_dirs_05(&c)==F3_CARD_OK&&f3_card_release_requests_05(&c)==F3_CARD_UNKNOWN&&c.hold);}
  else if(fault==12){power[0][0x178]=1;assert(!f3_card_valid_05(&c)&&c.hold&&!release_calls);}
  else {struct F3Card05 other={0};assert(f3_card_begin_05(&other,&m,&a,&io,10,10)==F3_CARD_FAIL&&reg_calls==2);assert(f3_card_finish_05(&c)==F3_CARD_OK&&release_calls==2);assert(f3_card_begin_05(&other,&m,&a,&io,11,10)==F3_CARD_OK&&reg_calls==2);assert(f3_card_finish_05(&other)==F3_CARD_OK&&release_calls==4);}
 }
 if(c.hold){unsigned w=wait_calls;struct F3Card05 blocked={0};assert(f3_card_begin_05(&blocked,&m,&a,&io,10,10)==F3_CARD_FAIL&&wait_calls==w&&!f3_card_valid_05(&c)&&f3_card_finish_05(&c)==F3_CARD_UNKNOWN);}
 free(stock);printf("{\"card_fault_case\":%d,\"passed\":true,\"own_memory_and_kernel_mount_fixture\":true,\"target_executed\":false}\n",fault);return 0;
}
