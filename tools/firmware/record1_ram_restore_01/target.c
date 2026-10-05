/* Fixed private binding. Default config returns before EEPROM open. No SDK,
 * private ABI, PIN text, signal, whole-EEP writer, recordCreate or format.
 */
#define _GNU_SOURCE
#include "config.h"
#include "engine.h"
#include "../f4_ram_entry_02/sha256.h"
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <sys/utsname.h>
#include <unistd.h>
int f4_parse_stat(const char *,size_t,uint64_t,uint64_t *);
typedef struct {int fd;enum R1Action action;unsigned writes;} R1Target;
static int r1_attempt(enum R1Action a){
 const char *path=a==R1_SAME_ORIGINAL?R1_STATE "/same-original.once":a==R1_CLEAR?R1_STATE "/clear.once":a==R1_RESTORE?R1_STATE "/restore.once":NULL;
 if(!path)return 0;int fd=open(path,O_WRONLY|O_CREAT|O_EXCL|O_CLOEXEC|O_NOFOLLOW,0600);if(fd<0)return 0;int okay=write(fd,"attempt\n",8)==8;if(close(fd))okay=0;return okay;
}
static int r1_meta(int fd){struct stat s;return !fstat(fd,&s)&&S_ISREG(s.st_mode)&&s.st_uid==0&&s.st_gid==0&&(s.st_mode&07777)==R1_EEP_MODE&&s.st_size==R1_EEP_STAT_SIZE&&(uint64_t)s.st_ino==R1_EEP_INODE&&major(s.st_dev)==R1_EEP_DEV_MAJOR&&minor(s.st_dev)==R1_EEP_DEV_MINOR;}
static int r1_owner(void){
 if(R1_USER_PID<=1||!R1_USER_START_TICKS)return 0;char p[64],s[4096],exe[4096];uint64_t tick;ssize_t n;
 snprintf(p,sizeof(p),"/proc/%llu/stat",(unsigned long long)R1_USER_PID);int fd=open(p,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;n=read(fd,s,sizeof(s));close(fd);if(n<=0||!f4_parse_stat(s,(size_t)n,R1_USER_PID,&tick)||tick!=R1_USER_START_TICKS)return 0;
 snprintf(p,sizeof(p),"/proc/%llu/exe",(unsigned long long)R1_USER_PID);n=readlink(p,exe,sizeof(exe)-1);if(n<=0||(size_t)n>=sizeof(exe)-1)return 0;exe[n]=0;if(strcmp(exe,R1_USER_PATH))return 0;
 snprintf(p,sizeof(p),"/proc/%llu/stat",(unsigned long long)R1_USER_PID);fd=open(p,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;n=read(fd,s,sizeof(s));close(fd);return n>0&&f4_parse_stat(s,(size_t)n,R1_USER_PID,&tick)&&tick==R1_USER_START_TICKS;
}
static int r1_user(void){
 if(!r1_owner())return 0;int fd=open(R1_USER_PATH,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;struct stat st;ssize_t n;int okay=!fstat(fd,&st)&&S_ISREG(st.st_mode)&&st.st_size==11874544&&st.st_uid==0&&st.st_gid==0&&(st.st_mode&07777)==0755;
 F4Sha sha;f4_sha_init(&sha);uint64_t count=0;unsigned interruptions=0;char b[4096],h[65];
 while(okay){n=read(fd,b,sizeof(b));if(n<0&&errno==EINTR&&++interruptions<4)continue;if(n<0){okay=0;break;}if(!n)break;if((uint64_t)n>11874544-count){okay=0;break;}count+=(uint64_t)n;f4_sha_update(&sha,b,(size_t)n);}
 f4_sha_end(&sha,h);if(close(fd))okay=0;return okay&&count==11874544&&!strcmp(h,R1_USER_SHA)&&r1_owner();
}
static int r1_read(void *ctx,uint8_t *out){
 R1Target *t=ctx;if(!r1_meta(t->fd)||!r1_user())return 0;size_t n=0;unsigned errors=0;
 while(n<R1_EXTENT){ssize_t got=pread(t->fd,out+n,R1_EXTENT-n>4096?4096:R1_EXTENT-n,(off_t)n);if(got<0&&errno==EINTR&&++errors<4)continue;if(got<=0)return 0;n+=(size_t)got;}
 uint8_t extra;ssize_t end=pread(t->fd,&extra,1,R1_EXTENT);
 return end==0&&r1_meta(t->fd)&&r1_user();
}
static long r1_write(void *ctx,uint32_t offset,const uint8_t *bytes){
 R1Target *t=ctx;if(!R1_BOUND_WRITE||offset!=R1_OFFSET||!r1_meta(t->fd)||!r1_user())return -1;
 if(t->writes++&&!(t->action==R1_CLEAR&&t->writes==2&&r1_attempt(R1_RESTORE)))return -1;
 int fd=open(R1_LEAF,O_RDWR|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return -1;if(!r1_meta(fd)||!r1_user()){close(fd);return -1;}
 /* Exactly one syscall, even on EINTR/short/error. Kernel pages may have
  * partly changed; engine must read the full extent before rollback. */
 ssize_t n=pwrite(fd,bytes,16,(off_t)offset);if(close(fd))return -1;return n;
}
static int r1_state_lock(void){
 struct stat st;if(lstat(R1_STATE,&st)||!S_ISDIR(st.st_mode)||st.st_uid!=0||st.st_gid!=0||(st.st_mode&07777)!=0700||major(st.st_dev)!=R1_STATE_DEV_MAJOR||minor(st.st_dev)!=R1_STATE_DEV_MINOR)return -1;
 int fd=open(R1_STATE "/transaction.lock",O_RDWR|O_CREAT|O_CLOEXEC|O_NOFOLLOW,0600);
 if(fd<0)return -1;if(fstat(fd,&st)||!S_ISREG(st.st_mode)||st.st_uid!=0||st.st_gid!=0||(st.st_mode&07777)!=0600||st.st_nlink!=1||flock(fd,LOCK_EX|LOCK_NB)){close(fd);return -1;}return fd;
}
static const char *r1_bool(int v){return v?"true":"false";}
static int r1_emit(R1Result r){
 printf("{\"opaque_record1_tool\":1,\"input_valid\":%s,\"read_stable\":%s,\"existing_record1\":%s,\"outside_original\":%s,\"before_original\":%s,\"write_attempted\":%s,\"write_count_exact\":%s,\"full_readback_verified\":%s,\"rollback_attempted\":%s,\"rollback_verified\":%s,\"original_after_failure_verified\":%s,\"same_original_transport_verified\":%s,\"restore_transport_verified\":%s,\"clear_payload_verified\":%s,\"success\":%s,\"changed_then_restored_coldboot_verified\":false,\"persistent_unlock_verified\":false}\n",
 r1_bool(r.input_valid),r1_bool(r.read_stable),r1_bool(r.existing_record1),r1_bool(r.other_bytes_original),r1_bool(r.before_original),r1_bool(r.write_attempted),r1_bool(r.write_count_exact),r1_bool(r.readback_verified),r1_bool(r.rollback_attempted),r1_bool(r.rollback_verified),r1_bool(r.original_after_failure_verified),r1_bool(r.same_original_transport_verified),r1_bool(r.restore_transport_verified),r1_bool(r.clear_payload_verified),r1_bool(r.success));
 return r.success?0:2;
}
int main(int argc,char **argv){
 R1Result empty={0};enum R1Action a=R1_PREFLIGHT;umask(077);
 if(argc==2){if(!strcmp(argv[1],"--preflight"))a=R1_PREFLIGHT;else if(!strcmp(argv[1],"--same-original"))a=R1_SAME_ORIGINAL;else if(!strcmp(argv[1],"--clear"))a=R1_CLEAR;else if(!strcmp(argv[1],"--restore-original"))a=R1_RESTORE;else return r1_emit(empty);}else if(argc!=1)return r1_emit(empty);
 if(!R1_BOUND_READ||R1_ACTUAL_EXTENT!=R1_EXTENT||getuid()!=0||geteuid()!=0||((a!=R1_PREFLIGHT)&&(a!=R1_RESTORE&&a!=R1_ALLOW_ACTION))||(a!=R1_PREFLIGHT&&!R1_BOUND_WRITE))return r1_emit(empty);
 struct utsname u;if(uname(&u)||strcmp(u.release,R1_KERNEL))return r1_emit(empty);
 int lock=-1;if(a!=R1_PREFLIGHT){lock=r1_state_lock();if(lock<0)return r1_emit(empty);if(!r1_attempt(a)){close(lock);return r1_emit(empty);}}
 int fd=open(R1_LEAF,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0){if(lock>=0)close(lock);return r1_emit(empty);}R1Target t={fd,a,0};
 R1Config config={R1_ACTUAL_EXTENT,R1_OFFSET,R1_ORIGINAL_BYTES,R1_WHOLE_SHA,R1_BOUND_WRITE};R1IO io={&t,r1_read,r1_write};
 R1Result result=r1_run(&config,&io,a);if(close(fd))result.success=0;if(lock>=0&&close(lock))result.success=0;return r1_emit(result);
}
