#define _GNU_SOURCE 1
#include "decode.h"
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include "../native_runtime_01/self_read.h"
extern long iq4_gallery_syscall_55(long,...);
static uint32_t quarantine;
static int quarantined_fd=-1;
int iq4_stock_jpeg_decoder_bound_55(void){
#ifdef IQ4_DECODER_HOST_TEST55
 return !__atomic_load_n(&quarantine,__ATOMIC_ACQUIRE);
#else
 static const unsigned char pin[16]={0xd0,0x59,0x00,0xb0,0x11,0x9e,0x44,0xf9,0x10,0xe2,0x24,0x91,0x20,0x02,0x1f,0xd6};unsigned char a[16],b[16];
 return !__atomic_load_n(&quarantine,__ATOMIC_ACQUIRE)&&iq4_native_self_read_01(NULL,0x40ae40,a,16)==1&&iq4_native_self_read_01(NULL,0x40ae40,b,16)==1&&!memcmp(a,b,16)&&!memcmp(a,pin,16);
#endif
}
static long call55(long n,long a,long b,long c,long d){return iq4_gallery_syscall_55(n,a,b,c,d,0L,0L);}
static int path55(const char*p){
 if(!p)return 0;size_t n=strnlen(p,260);if(n<35||n==260)return 0;
 const char*tail=NULL;if(!strncmp(p,"/run/media/xqdcard/DCIM/",24))tail=p+24;else if(!strncmp(p,"/run/media/sdcard/DCIM/",23))tail=p+23;else return 0;
 for(const char*q=tail;*q;++q)if((unsigned char)*q<32||*q=='\\')return 0;
 if(strstr(tail,"..")||strstr(tail,"//"))return 0;const char*slash=strchr(tail,'/');if(!slash||slash==tail||strchr(slash+1,'/'))return 0;
 return slash[1]&&n>=4&&!strcmp(p+n-4,".JPG");
}
#ifdef __APPLE__
#define st_mtim st_mtimespec
#define st_ctim st_ctimespec
#endif
static int same55(const struct stat*a,const struct stat*b){return S_ISREG(b->st_mode)&&a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_size==b->st_size&&a->st_mtim.tv_sec==b->st_mtim.tv_sec&&a->st_mtim.tv_nsec==b->st_mtim.tv_nsec&&a->st_ctim.tv_sec==b->st_ctim.tv_sec&&a->st_ctim.tv_nsec==b->st_ctim.tv_nsec;}
/* Compressed input only, bounded by the actual capture JPEG sink. The decoder
 * itself needs one reduced RGB scanline and no additional RGB image arena. */
static int load55(const char*path,int(*guard)(void*),void*ctx,uint8_t**bytes,size_t*n){
 *bytes=NULL;*n=0;if(!iq4_stock_jpeg_decoder_bound_55()||!path55(path)||!guard||guard(ctx)!=1)return 0;
 long fd=call55(SYS_openat,AT_FDCWD,(long)path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW,0);if(fd<0||fd>INT_MAX)return 0;
 struct stat before={0},after={0};int result=0;uint8_t*buffer=NULL;
 if(call55(SYS_fstat,fd,(long)&before,0,0)||!S_ISREG(before.st_mode)||before.st_size<4||before.st_size>100*1024*1024)goto done;
 buffer=malloc((size_t)before.st_size);if(!buffer)goto done;
 size_t pos=0;while(pos<(size_t)before.st_size){if(guard(ctx)!=1){result=-1;goto done;}size_t chunk=(size_t)before.st_size-pos;if(chunk>65536)chunk=65536;long got=call55(SYS_read,fd,(long)(buffer+pos),(long)chunk,0);if(got<=0||(size_t)got>chunk)goto done;pos+=(size_t)got;}
 if(guard(ctx)!=1||call55(SYS_fstat,fd,(long)&after,0,0)||!same55(&before,&after))goto done;result=1;
done:
 if(call55(SYS_close,fd,0,0,0)){quarantined_fd=(int)fd;__atomic_store_n(&quarantine,1,__ATOMIC_RELEASE);result=-2;}
 if(result==1){*bytes=buffer;*n=(size_t)before.st_size;}else free(buffer);return result;
}
int iq4_stock_jpeg_decode_file_55(const char*path,uint8_t*rgb,size_t cap,uint32_t stride,uint32_t mw,uint32_t mh,int(*guard)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){
 if(!r)return 0;memset(r,0,sizeof *r);uint8_t*bytes=NULL;size_t n=0;int rc=load55(path,guard,ctx,&bytes,&n);if(rc!=1)return rc;rc=iq4_stock_jpeg_decode_rgb_55(bytes,n,rgb,cap,stride,mw,mh,guard,ctx,r);free(bytes);return rc;
}
int iq4_stock_jpeg_probe_file_55(const char*path,int(*guard)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){
 if(!r)return 0;memset(r,0,sizeof *r);uint8_t*bytes=NULL;size_t n=0;int rc=load55(path,guard,ctx,&bytes,&n);if(rc!=1)return rc;rc=iq4_stock_jpeg_probe_bytes_55(bytes,n,r);if(guard(ctx)!=1){memset(r,0,sizeof *r);rc=-1;}free(bytes);return rc;
}
int iq4_stock_jpeg_decode_crop_file_55(const char*path,uint32_t x,uint32_t y,uint32_t w,uint32_t h,uint8_t*rgb,size_t cap,uint32_t stride,uint32_t mw,uint32_t mh,int(*guard)(void*),void*ctx,struct Iq4JpegDecodeResult55*r){
 if(!r||!w||!h)return 0;memset(r,0,sizeof *r);uint8_t*bytes=NULL;size_t n=0;int rc=load55(path,guard,ctx,&bytes,&n);if(rc!=1)return rc;rc=iq4_stock_jpeg_decode_crop_rgb_55(bytes,n,x,y,w,h,rgb,cap,stride,mw,mh,guard,ctx,r);free(bytes);return rc;
}
