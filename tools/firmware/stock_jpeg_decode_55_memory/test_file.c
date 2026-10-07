#include "decode.h"
#include <assert.h>
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
static const char*fixture;static int stop,reads,stat_calls,change,fail_close,opens;
static int guard(void*p){return p==(void*)0x1234&&!stop;}
/* Only the source camera-path mapping is a fixture. Reads, descriptor lifetime,
 * fstat, regular-file classification and JPEG contents use actual local files. */
long iq4_gallery_syscall_55(long n,...){va_list ap;va_start(ap,n);long a=va_arg(ap,long),b=va_arg(ap,long),c=va_arg(ap,long);va_end(ap);if(n==SYS_openat){++opens;return open(fixture,(int)c);}
 if(n==SYS_fstat){int rc=fstat((int)a,(struct stat*)b);if(++stat_calls==2&&change)((struct stat*)b)->st_ino++;return rc;}
 if(n==SYS_read){++reads;return read((int)a,(void*)b,(size_t)c);}
 if(n==SYS_close){int rc=close((int)a);return fail_close?-1:rc;}abort();}
int main(int argc,char**argv){assert(argc==2);fixture=argv[1];unsigned char*out=malloc(800*480*3);assert(out);struct Iq4JpegDecodeResult55 r;const char*x="/run/media/xqdcard/DCIM/100PHASE/CF123456.JPG",*sd="/run/media/sdcard/DCIM/100PHASE/CF123456.JPG";
 assert(iq4_stock_jpeg_probe_file_55(x,guard,(void*)0x1234,&r)==1&&r.source_width==7102&&r.source_height==5326&&r.rows==0);
 stat_calls=0;assert(iq4_stock_jpeg_decode_file_55(sd,out,800*480*3,800*3,800,480,guard,(void*)0x1234,&r)==1&&r.rows==480);
 stat_calls=0;change=1;assert(iq4_stock_jpeg_probe_file_55(x,guard,(void*)0x1234,&r)==0&&r.source_width==0);change=0;
 int count=opens;assert(iq4_stock_jpeg_probe_file_55("/tmp/test.JPG",guard,(void*)0x1234,&r)==0&&opens==count);assert(iq4_stock_jpeg_probe_file_55("/run/media/xqdcard/DCIM/../private.JPG",guard,(void*)0x1234,&r)==0&&opens==count);
 stop=1;assert(iq4_stock_jpeg_probe_file_55(x,guard,(void*)0x1234,&r)==0&&opens==count);stop=0;
 fail_close=1;stat_calls=0;assert(iq4_stock_jpeg_probe_file_55(x,guard,(void*)0x1234,&r)==-2&&r.source_width==0);count=opens;assert(iq4_stock_jpeg_probe_file_55(x,guard,(void*)0x1234,&r)==0&&opens==count);
 free(out);printf("{\"groups\":8,\"actual_file_reads\":%d,\"path_mapping\":\"explicit fixture\",\"camera_accessed\":false}\n",reads);return 0;}
