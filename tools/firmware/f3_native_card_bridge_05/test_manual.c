#define _GNU_SOURCE
#include "card.h"
#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
extern void f3_fs_host_api_03(struct F3Posix*);
static uint64_t epoch(void*p){(void)p;return 19;}static int valid(void*p){(void)p;return 1;}
int main(int argc,char**argv){assert(argc==2);char root[4096];snprintf(root,sizeof(root),"%s/manual05-XXXXXX",argv[1]);assert(mkdtemp(root));int d=open(root,O_RDONLY|O_DIRECTORY|O_CLOEXEC);assert(d>=0);struct F3Posix api;f3_fs_host_api_03(&api);struct F3CardGuard g={0,epoch,valid};
 const char*names[]={"IQ4_P0_2026100415266.iiq","mixedCaseA1.IIQ","../OLD.iiq","a/b.iiq","a.b.iiq","a.IiQ","a.iiq/",".iiq"};unsigned count=0;
 for(unsigned i=0;i<8;++i){struct F3Fs c={0};assert(f3_fs_prepare_03(&c,&api,&g,d,d,19,i+1,22));const char*created=i<2?names[i]:"SAFE.IIQ";int fd=openat(d,created,O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW,0600);if(i>=3){fd=openat(d,"SAFE.IIQ",O_RDONLY|O_NOFOLLOW);}assert(fd>=0);if(i<3)assert(write(fd,"OPAQUE",6)==6);struct F3File f;int ok=f3_fs_manual_raw_03(&c,names[i],fd,&f);assert(ok==(i<2));if(ok){assert(!strcmp(c.raw_leaf,names[i])&&f.bytes==6&&!c.owned_stage&&f3_fs_release_raw_03(&c));}else assert(!close(fd));++count;}
 assert(!symlinkat(names[0],d,"linked.iiq"));struct F3Fs c={0};assert(f3_fs_prepare_03(&c,&api,&g,d,d,19,99,22));int fd=openat(d,"linked.iiq",O_RDONLY);assert(fd>=0);struct F3File f;assert(!f3_fs_manual_raw_03(&c,"linked.iiq",fd,&f)&&!close(fd));
 assert(!close(d));printf("{\"real_host_manual_groups\":%u,\"passed\":true,\"manual_original_never_deleted\":true}\n",count+1);}
