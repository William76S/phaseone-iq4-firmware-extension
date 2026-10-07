#include "../f3_native_card_bridge_06/card.h"
#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <sys/syscall.h>
#include <errno.h>
static char expected[64];static int err,read_done,opens,closes;
int*iq4_f3_original_errno_location_03(void){return &err;}
void f3_fs_linux_api_03(struct F3Posix*out){memset(out,0,sizeof *out);}
long iq4_f3_original_syscall_03(long op,...){
 va_list a;va_start(a,op);long result=-1;
 if(op==SYS_openat){(void)va_arg(a,int);const char*p=va_arg(a,const char*);++opens;if(strcmp(p,expected)){err=ENOENT;}else{read_done=0;result=100;}}
 else if(op==SYS_read){assert(va_arg(a,int)==100);char*b=va_arg(a,char*);size_t n=va_arg(a,size_t);const char*s="pos:\t0\nflags:\t0100000\nmnt_id:\t42\n";assert(n>=strlen(s));if(read_done++)result=0;else{memcpy(b,s,strlen(s));result=strlen(s);}}
 else if(op==SYS_close){assert(va_arg(a,int)==100);++closes;result=0;}
 va_end(a);return result;
}
int main(void){struct F3CardIo05 io;f3_card_linux_io_05(&io);int values[]={0,9,10,123,2147483647};
 for(unsigned i=0;i<sizeof values/sizeof *values;++i){snprintf(expected,sizeof expected,"/proc/self/fdinfo/%d",values[i]);uint64_t id=0;int retained=-1;struct F3SysResult r=io.mount_id(values[i],&id,&retained);if(r.value){fprintf(stderr,"fd=%d path rejected errno=%d\n",values[i],r.error);return 1;}assert(id==42&&retained==-1);}
 assert(opens==5&&closes==5);puts("PASS: 5 actual mount_id path/read/close cases");return 0;}
