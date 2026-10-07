#define _GNU_SOURCE
#include "stock.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
static const char *scenario;static unsigned ops[9];static int guard_calls;
int iq4_stock_publish_host_fault(unsigned op){++ops[op];if(!strcmp(scenario,"space")&&op==3)return ENOSPC;if(!strcmp(scenario,"sync")&&op==4&&ops[op]==1)return EIO;if(!strcmp(scenario,"close")&&op==5&&ops[op]==2)return EIO;return 0;}
int iq4_stock_publish_host_mount(int fd,uint64_t*out){struct stat s,base;if(fstat(fd,&s)||stat("/",&base))return 0;*out=(s.st_dev==base.st_dev&&s.st_ino==base.st_ino)?1:2;return 1;}
static int guard(void){return strcmp(scenario,"guard")||++guard_calls<3;}
int main(int argc,char**argv){scenario=argc>1?argv[1]:"ok";char root[]="/tmp/iq4-stock-jpeg.XXXXXX";assert(mkdtemp(root));char dcim[256],dir[256],leaf[256];snprintf(dcim,sizeof dcim,"%s/DCIM",root);snprintf(dir,sizeof dir,"%s/DCIM/100PHASE",root);snprintf(leaf,sizeof leaf,"%s/DCIM/100PHASE/IMG0001.JPG",root);assert(!mkdir(dcim,0700)&&!mkdir(dir,0700));
 const unsigned char jpeg[]={255,216,1,2,3,4,5,6,255,217};const char prior[]="original-file";int old=-1;
 if(!strcmp(scenario,"collision")){old=open(leaf,O_CREAT|O_EXCL|O_WRONLY,0600);assert(old>=0&&write(old,prior,sizeof prior)==sizeof prior&&!close(old));}
 int got=iq4_stock_jpeg_publish_01(root,"DCIM/100PHASE/IMG0001.JPG",jpeg,sizeof jpeg,guard);int expected=(!strcmp(scenario,"ok"))?1:(!strcmp(scenario,"close")||!strcmp(scenario,"guard"))?-1:0;assert(got==expected);
 unsigned char b[32]={0};old=open(leaf,O_RDONLY);if(!strcmp(scenario,"ok")){assert(old>=0&&read(old,b,sizeof b)==sizeof jpeg&&!memcmp(b,jpeg,sizeof jpeg));}else if(!strcmp(scenario,"collision")){assert(old>=0&&read(old,b,sizeof b)==sizeof prior&&!memcmp(b,prior,sizeof prior));}else assert(old<0);if(old>=0)close(old);
 /* Cleanup is host-fixture-only; no device files or paths are used. */
 char cleanup[320];snprintf(cleanup,sizeof cleanup,"rm -rf -- '%s'",root);assert(!system(cleanup));printf("PASS publish %s result=%d existing file preserved\n",scenario,got);return 0;
}
