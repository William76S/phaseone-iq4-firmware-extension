/* IQ4 RAM entry 02: fixed paths/modes, default inert build.
 * No SDK, private camera ABI, frame/hardware access, PID signal, ptrace,
 * persistent config/EEPROM/key write, arbitrary command or path interpreter.
 */
#define _GNU_SOURCE
#include <errno.h>
#include <dirent.h>
#include <fcntl.h>
#include <poll.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/file.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/types.h>
#include <sys/un.h>
#include <sys/wait.h>
#include <sys/xattr.h>
#include <time.h>
#include <unistd.h>
#include "config.h"
#include "status.h"
#include "sha256.h"
#ifndef F4_OWNER_UID
#define F4_OWNER_UID 0
#define F4_OWNER_GID 0
#endif
int f4_parse_stat(const char *,size_t,uint64_t,uint64_t *);
#define S_PATH(name) F4_STATE "/" name
static const char line_old[]="    ${P1LINUX_PATH} ${P1LINUX_ARGS}\n";
static const char line_new[]="    /run/f1launch   ${P1LINUX_ARGS}\n";
static int fail(const char *s){fprintf(stderr,"{\"ram_entry\":2,\"result\":\"%s\"}\n",s);return 2;}
static int absent(const char *p){struct stat st;return lstat(p,&st)<0&&errno==ENOENT;}
static uint64_t millis(void){struct timespec t;if(clock_gettime(CLOCK_MONOTONIC,&t)||t.tv_sec<0)return 0;return (uint64_t)t.tv_sec*1000+(uint64_t)t.tv_nsec/1000000;}
static int all_write(int fd,const void *data,size_t n){const unsigned char*p=data;while(n){ssize_t r=write(fd,p,n);if(r<0&&errno==EINTR)continue;if(r<=0)return 0;p+=r;n-=(size_t)r;}return 1;}
static int read_bounded(const char *path,void *data,size_t capacity,size_t *used){
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;size_t n=0;int okay=1;
 while(n<capacity){ssize_t r=read(fd,(char*)data+n,capacity-n);if(r<0&&errno==EINTR)continue;if(r<0){okay=0;break;}if(!r)break;n+=(size_t)r;}
 if(n==capacity){char extra;ssize_t r=read(fd,&extra,1);if(r!=0)okay=0;}
 if(close(fd))okay=0;*used=n;return okay;
}
static int hash_fd(int fd,char out[65],uint64_t limit){
 if(lseek(fd,0,SEEK_SET)<0)return 0;F4Sha s;f4_sha_init(&s);unsigned char b[4096];uint64_t count=0;
 for(;;){ssize_t n=read(fd,b,sizeof(b));if(n<0&&errno==EINTR)continue;if(n<0)return 0;if(!n)break;if((uint64_t)n>limit-count)return 0;count+=(uint64_t)n;f4_sha_update(&s,b,(size_t)n);}
 f4_sha_end(&s,out);return 1;
}
static int plain_fd(int fd,mode_t mode,uint64_t size){struct stat st;return !fstat(fd,&st)&&S_ISREG(st.st_mode)&&st.st_uid==F4_OWNER_UID&&st.st_gid==F4_OWNER_GID&&(st.st_mode&07777)==mode&&st.st_size>=0&&(uint64_t)st.st_size==size;}
static int file_hash(const char *p,const char *sha,mode_t mode,uint64_t size){int fd=open(p,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;char h[65];int okay=plain_fd(fd,mode,size)&&hash_fd(fd,h,size)&&!strcmp(h,sha);if(close(fd))okay=0;return okay;}
static int own_dir(void){struct stat st;return !lstat(F4_STATE,&st)&&S_ISDIR(st.st_mode)&&st.st_uid==F4_OWNER_UID&&st.st_gid==F4_OWNER_GID&&(st.st_mode&07777)==0700&&major(st.st_dev)==F4_RUN_MAJOR&&minor(st.st_dev)==F4_RUN_MINOR;}
static int fsync_dir(const char *p){int fd=open(p,O_RDONLY|O_DIRECTORY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;int okay=!fsync(fd);if(close(fd))okay=0;return okay;}
static int status(const char *phase){
 const char *tmp=S_PATH("status.next"),*dst=S_PATH("status.json");
 if(!absent(tmp))return 0;int fd=open(tmp,O_WRONLY|O_CREAT|O_EXCL|O_CLOEXEC|O_NOFOLLOW,0600);if(fd<0)return 0;
 char text[160];int n=snprintf(text,sizeof(text),"{\"ram_entry\":2,\"phase\":\"%s\",\"user_signals\":0,\"unload_verified\":false}\n",phase);
 int okay=n>0&&(size_t)n<sizeof(text)&&all_write(fd,text,(size_t)n)&&!fsync(fd);if(close(fd))okay=0;
 if(!okay)return 0;return !rename(tmp,dst)&&fsync_dir(F4_STATE);
}
static int root_mount_gate(void){
 if(!F4_ENABLED||getuid()!=0||geteuid()!=0||!F4_ROOT_MOUNT_ID||!F4_RUN_MOUNT_ID)return 0;
 char cmd[4096];size_t n;if(!read_bounded("/proc/cmdline",cmd,sizeof(cmd)-1,&n))return 0;cmd[n]=0;
 int ram=0;char *save=NULL;for(char *t=strtok_r(cmd," \n",&save);t;t=strtok_r(NULL," \n",&save))if(!strcmp(t,"root=/dev/ram0"))ram++;
 if(ram!=1)return 0;FILE *f=fopen("/proc/self/mountinfo","re");if(!f)return 0;
 char row[4096],root[256],mount[256],type[64],source[256];unsigned id,parent,ma,mi;int roots=0,runs=0,okay=1;
 while(fgets(row,sizeof(row),f)){
  if(!strchr(row,'\n')){okay=0;break;}char *dash=strstr(row," - ");
  if(!dash||sscanf(row,"%u %u %u:%u %255s %255s",&id,&parent,&ma,&mi,root,mount)!=6||sscanf(dash+3,"%63s %255s",type,source)!=2){okay=0;break;}
  if(!strcmp(mount,"/")){roots++;if(id!=F4_ROOT_MOUNT_ID||ma!=1||mi!=0||strcmp(root,"/")||(strcmp(type,"ext4")&&strcmp(type,"ext2"))||(strcmp(source,"/dev/ram0")&&strcmp(source,"/dev/root")))okay=0;}
  else if(!strcmp(mount,"/run")){runs++;if(id!=F4_RUN_MOUNT_ID||ma!=F4_RUN_MAJOR||mi!=F4_RUN_MINOR||strcmp(type,"tmpfs")||strcmp(root,"/"))okay=0;
   char *options=strchr(row,' ');for(int i=0;i<4&&options;i++)options=strchr(options+1,' ');
   if(!options){okay=0;break;}char *end=strchr(options+1,' ');if(!end){okay=0;break;}*end=0;
   if(strstr(options,"noexec")||strstr(options,"ro,")||!strcmp(options+1,"ro"))okay=0;
  }else{
   size_t len=strlen(mount);if((!strncmp(F4_RUNNER,mount,len)&&(F4_RUNNER[len]=='/'||!F4_RUNNER[len]))||(!strncmp(F4_STATE,mount,len)&&(F4_STATE[len]=='/'||!F4_STATE[len]))||(!strncmp(F4_LAUNCHER,mount,len)&&(F4_LAUNCHER[len]=='/'||!F4_LAUNCHER[len])))okay=0;
  }
 }
 if(ferror(f)||fclose(f))okay=0;return okay&&roots==1&&runs==1;
}
static int flags_gate(void){
 static const char *bad[]={"/run/boot_is_factory","/run/p1linux_respawn_reboot","/run/p1linux_respawn_run_install_mode","/run/p1linux_respawn_do_nothing","/run/media/storage/debug","/run/media/storage/User/p1linux.bin"};
 for(unsigned i=0;i<sizeof(bad)/sizeof(*bad);i++)if(!absent(bad[i]))return 0;
 struct stat st;return !lstat("/run/boot_is_user",&st)&&S_ISREG(st.st_mode)&&!lstat("/run/essential_boot_done",&st)&&S_ISREG(st.st_mode);
}
static int user_file_gate(void){char real[4096];return realpath(F4_ARGV0,real)&&!strcmp(real,F4_USER)&&file_hash(F4_USER,F4_USER_SHA,0755,F4_USER_SIZE);}
static int proc_stat(uint64_t pid,uint64_t *tick,uint64_t *ppid,int p1){
 char path[64],b[4096];size_t n;snprintf(path,sizeof(path),"/proc/%llu/stat",(unsigned long long)pid);if(!read_bounded(path,b,sizeof(b)-1,&n))return 0;b[n]=0;
 if(p1){if(!f4_parse_stat(b,n,pid,tick))return 0;}
 char *last=strrchr(b,')');if(!last||last[1]!=' '||last[3]!=' ')return 0;
 char *p=last+4,*end;for(int field=4;field<=22;field++){errno=0;if(*p=='-'){if(field==22||field==4)return 0;p++;}unsigned long long v=strtoull(p,&end,10);if(errno||end==p||(*end!=' '&&*end!='\n'))return 0;if(field==4)*ppid=v;if(field==22){if(!p1)*tick=v;return v!=0;}p=end+1;}return 0;
}
static int proc_exe(uint64_t pid,const char *expected){char p[64],b[4096];snprintf(p,sizeof(p),"/proc/%llu/exe",(unsigned long long)pid);ssize_t n=readlink(p,b,sizeof(b)-1);if(n<0||(size_t)n>=sizeof(b)-1)return 0;b[n]=0;return !strcmp(b,expected);}
static int old_umask_gate(void){char path[64],text[8192];size_t n;snprintf(path,sizeof(path),"/proc/%llu/status",(unsigned long long)F4_OLD_PID);if(!read_bounded(path,text,sizeof(text)-1,&n))return 0;text[n]=0;char *v=strstr(text,"Umask:\t");if(!v||(v!=text&&v[-1]!='\n'))return 0;v+=7;char *end;errno=0;unsigned long mask=strtoul(v,&end,8);return !errno&&end!=v&&*end=='\n'&&mask==F4_USER_UMASK&&mask<=0777;}
static int old_user_gate(void){uint64_t t,p;return F4_OLD_PID>1&&F4_OLD_TICKS!=0&&proc_stat(F4_OLD_PID,&t,&p,1)&&t==F4_OLD_TICKS&&proc_exe(F4_OLD_PID,F4_USER)&&old_umask_gate()&&proc_stat(F4_OLD_PID,&t,&p,1)&&t==F4_OLD_TICKS;}
static int old_user_gone(void){uint64_t t,p;if(proc_stat(F4_OLD_PID,&t,&p,0))return t!=F4_OLD_TICKS;char path[64];snprintf(path,sizeof(path),"/proc/%llu",(unsigned long long)F4_OLD_PID);return absent(path);}
static int runner_parent_gate(void){
 uint64_t t,p;pid_t parent=getppid();if(parent<=1||!proc_stat((uint64_t)parent,&t,&p,0)||p!=1||!proc_exe((uint64_t)parent,"/bin/busybox.nosuid")||!file_hash("/bin/busybox.nosuid",F4_BUSYBOX_SHA,0755,F4_BUSYBOX_SIZE))return 0;
 char path[64],bytes[4096];size_t n;snprintf(path,sizeof(path),"/proc/%ld/cmdline",(long)parent);
 static const char expect[]="/bin/sh\0" F4_RUNNER "\0";
 return read_bounded(path,bytes,sizeof(bytes),&n)&&n==sizeof(expect)-1&&!memcmp(bytes,expect,n);
}
static int runner_check(const char *path,int candidate,int original_inode){
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;struct stat st;char h[65];
 int okay=plain_fd(fd,0755,F4_RUNNER_SIZE)&&!fstat(fd,&st)&&major(st.st_dev)==F4_RUNNER_MAJOR&&minor(st.st_dev)==F4_RUNNER_MINOR&&(!original_inode||(uint64_t)st.st_ino==F4_RUNNER_INODE)&&flistxattr(fd,NULL,0)==0&&hash_fd(fd,h,F4_RUNNER_SIZE)&&!strcmp(h,candidate?F4_CANDIDATE_SHA:F4_RUNNER_SHA);
 if(close(fd))okay=0;return okay;
}
static int mutation_lock(void){int fd=open(S_PATH("mutation.lock"),O_RDWR|O_CREAT|O_CLOEXEC|O_NOFOLLOW,0600);if(fd<0)return -1;struct stat st;if(fstat(fd,&st)||!S_ISREG(st.st_mode)||st.st_uid!=F4_OWNER_UID||st.st_gid!=F4_OWNER_GID||(st.st_mode&07777)!=0600||flock(fd,LOCK_EX|LOCK_NB)){close(fd);return -1;}return fd;}
static int restore_core(void){
 /* Caller holds mutation.lock and has rechecked actual RAM mounts/private dir. */
 if(runner_check(F4_RUNNER,0,1))return 1;
 if(!runner_check(F4_RUNNER,1,0)||!runner_check(F4_ORIGINAL,0,1))return 0;
 if(rename(F4_ORIGINAL,F4_RUNNER)||!fsync_dir(F4_SCRIPT_DIR))return 0;
 return runner_check(F4_RUNNER,0,1);
}
static int restore(void){if(!root_mount_gate()||!own_dir())return 0;int fd=mutation_lock();if(fd<0)return 0;int okay=restore_core();if(close(fd))okay=0;return okay;}
static int create_bytes(const char *path,const void *bytes,size_t n,mode_t mode){
 int fd=open(path,O_WRONLY|O_CREAT|O_EXCL|O_CLOEXEC|O_NOFOLLOW,mode);if(fd<0)return 0;
 int okay=all_write(fd,bytes,n)&&!fchmod(fd,mode)&&!fsync(fd);if(close(fd))okay=0;return okay;
}
static int env_valid(const char *b,size_t n){
 if(!n||n>16384||b[n-1])return 0;size_t off=0;unsigned entries=0;
 while(off<n){const char *v=b+off;size_t len=strnlen(v,n-off);if(!len||len==n-off||++entries>256)return 0;
  const char *eq=memchr(v,'=',len);if(!eq||eq==v||!strncmp(v,"LD_",3))return 0;
  for(const char *p=v;p<eq;p++)if(!((*p>='a'&&*p<='z')||(*p>='A'&&*p<='Z')||*p=='_'||(p!=v&&*p>='0'&&*p<='9')))return 0;
  for(size_t earlier=0;earlier<off;earlier+=strlen(b+earlier)+1)if(!strncmp(b+earlier,v,(size_t)(eq-v))&&b[earlier+(eq-v)]=='=')return 0;
  off+=len+1;
 }return off==n;
}
static int prepare(void){
 if(!root_mount_gate()||!own_dir()||!flags_gate()||!user_file_gate()||!old_user_gate()||!runner_check(F4_RUNNER,0,1)||!absent(F4_ORIGINAL)||!absent(F4_CANDIDATE)||!absent(S_PATH("disabled"))||!absent(S_PATH("env.1"))||!absent(S_PATH("env.2"))||!absent(S_PATH("runner.1"))||!absent(S_PATH("runner.2")))return 0;
 char p[64],argv[4096],env1[16384],env2[16384],runner[8192];size_t a,n,z,r;
 snprintf(p,sizeof(p),"/proc/%llu/cmdline",(unsigned long long)F4_OLD_PID);if(!read_bounded(p,argv,sizeof(argv),&a)||a!=sizeof(F4_ARGV0)||memcmp(argv,F4_ARGV0,a))return 0;
 snprintf(p,sizeof(p),"/proc/%llu/environ",(unsigned long long)F4_OLD_PID);
 if(!read_bounded(p,env1,sizeof(env1),&n)||!read_bounded(p,env2,sizeof(env2),&z)||n!=z||memcmp(env1,env2,n)||!env_valid(env1,n)||!old_user_gate())return 0;
 if(!read_bounded(F4_RUNNER,runner,sizeof(runner),&r)||r!=F4_RUNNER_SIZE)return 0;
 char *call=NULL;unsigned count=0;for(size_t i=0;i+sizeof(line_old)-1<=r;i++)if(!memcmp(runner+i,line_old,sizeof(line_old)-1)){call=runner+i;count++;}
 if(count!=1||sizeof(line_old)!=sizeof(line_new))return 0;
 if(!create_bytes(S_PATH("env.1"),env1,n,0600)||!create_bytes(S_PATH("env.2"),env2,n,0600)||!create_bytes(S_PATH("runner.1"),runner,r,0600)||!create_bytes(S_PATH("runner.2"),runner,r,0600))return 0;
 if(!file_hash(S_PATH("runner.1"),F4_RUNNER_SHA,0600,r)||!file_hash(S_PATH("runner.2"),F4_RUNNER_SHA,0600,r))return 0;
 if(link(F4_RUNNER,F4_ORIGINAL)||!runner_check(F4_ORIGINAL,0,1))return 0;
 memcpy(call,line_new,sizeof(line_new)-1);F4Sha digest;char h[65];f4_sha_init(&digest);f4_sha_update(&digest,runner,r);f4_sha_end(&digest,h);if(strcmp(h,F4_CANDIDATE_SHA))return 0;
 if(!create_bytes(F4_CANDIDATE,runner,r,0755)||!runner_check(F4_CANDIDATE,1,0))return 0;
 return fsync_dir(F4_STATE)&&fsync_dir(F4_SCRIPT_DIR)&&old_user_gate();
}
static int module_gate(void){struct stat st;if(lstat(F4_MODULE,&st)||!S_ISREG(st.st_mode)||st.st_size<=0||st.st_size>1048576)return 0;return file_hash(F4_MODULE,F4_MODULE_SHA,0500,(uint64_t)st.st_size);}
static int tool_gate(void){
 char expected[66],a[65],b[65];size_t n;struct stat digest_stat;
 if(lstat(S_PATH("entry.sha256"),&digest_stat)||!S_ISREG(digest_stat.st_mode)||digest_stat.st_uid!=0||digest_stat.st_gid!=0||(digest_stat.st_mode&07777)!=0600||digest_stat.st_size!=65||!read_bounded(S_PATH("entry.sha256"),expected,65,&n)||n!=65||expected[64]!='\n')return 0;expected[64]=0;
 for(unsigned i=0;i<64;i++)if(!((expected[i]>='0'&&expected[i]<='9')||(expected[i]>='a'&&expected[i]<='f')))return 0;
 int fd=open(F4_TOOL,O_RDONLY|O_CLOEXEC|O_NOFOLLOW),other=open(F4_LAUNCHER,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);struct stat sa,sb;int okay=fd>=0&&other>=0;
 if(okay)okay=!fstat(fd,&sa)&&!fstat(other,&sb)&&sa.st_size>0&&sa.st_size<1048576&&sa.st_size==sb.st_size&&plain_fd(fd,0500,(uint64_t)sa.st_size)&&plain_fd(other,0500,(uint64_t)sb.st_size)&&hash_fd(fd,a,(uint64_t)sa.st_size)&&hash_fd(other,b,(uint64_t)sb.st_size)&&!strcmp(a,expected)&&!strcmp(b,expected);
 if(fd>=0&&close(fd))okay=0;if(other>=0&&close(other))okay=0;return okay;
}
static int stage_launcher(void){
 if(!root_mount_gate()||!own_dir()||!flags_gate()||!user_file_gate()||!old_user_gate()||!runner_check(F4_RUNNER,0,1)||!module_gate()||!absent(F4_LAUNCHER))return fail("stage_launcher_gate_refused");
 char expected[66],actual[65];size_t n;struct stat st;int fd=open(F4_TOOL,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);
 int okay=fd>=0&&!fstat(fd,&st)&&st.st_size>0&&st.st_size<1048576&&plain_fd(fd,0500,(uint64_t)st.st_size)&&hash_fd(fd,actual,(uint64_t)st.st_size)&&read_bounded(S_PATH("entry.sha256"),expected,65,&n)&&n==65&&expected[64]=='\n';
 if(fd>=0)close(fd);if(okay){expected[64]=0;okay=!strcmp(expected,actual);}
 if(!okay||link(F4_TOOL,F4_LAUNCHER)||!fsync_dir("/run")||!tool_gate())return fail("stage_launcher_link_or_hash_refused");
 puts("{\"ram_entry\":2,\"result\":\"launcher_staged_ram_only\",\"user_signals\":0,\"runner_modified\":false}");return 0;
}
static int sock_address(struct sockaddr_un *u){memset(u,0,sizeof(*u));u->sun_family=AF_UNIX;return snprintf(u->sun_path,sizeof(u->sun_path),"%s",S_PATH("control.sock"))>0&&strlen(S_PATH("control.sock"))<sizeof(u->sun_path);}
static int peer_path(int fd,const char *expected,pid_t *pid){struct ucred peer;socklen_t n=sizeof(peer);if(getsockopt(fd,SOL_SOCKET,SO_PEERCRED,&peer,&n)||n!=sizeof(peer)||peer.uid!=0||peer.gid!=0||peer.pid<=1||!proc_exe((uint64_t)peer.pid,expected))return 0;*pid=peer.pid;return 1;}
static int connect_control(void){
 struct stat st;if(lstat(S_PATH("control.sock"),&st)||!S_ISSOCK(st.st_mode)||st.st_uid!=0||(st.st_mode&07777)!=0600)return -1;
 struct sockaddr_un u;if(!sock_address(&u))return -1;int fd=socket(AF_UNIX,SOCK_SEQPACKET|SOCK_CLOEXEC|SOCK_NONBLOCK,0);if(fd<0)return -1;
 if(connect(fd,(struct sockaddr*)&u,sizeof(u))){close(fd);return -1;}pid_t peer;if(!peer_path(fd,F4_TOOL,&peer)){close(fd);return -1;}return fd;
}
static int ack(int fd,const char *request){
 if(send(fd,request,5,MSG_DONTWAIT|MSG_NOSIGNAL)!=5)return 0;struct pollfd p={fd,POLLIN,0};int r=poll(&p,1,1000);char b[16];return r==1&&(p.revents&POLLIN)&&recv(fd,b,sizeof(b),MSG_DONTWAIT|MSG_TRUNC)==6&&!memcmp(b,"F4OK2\n",6);
}
static int close_inherited(int keep){
 DIR *d=opendir("/proc/self/fd");if(!d)return 0;int own=dirfd(d),okay=1;unsigned seen=0;struct dirent *e;
 while((e=readdir(d))){if(e->d_name[0]=='.')continue;char *end;long value=strtol(e->d_name,&end,10);if(*end||value<0||value>1048576||++seen>4096){okay=0;break;}if(value>2&&value!=keep&&value!=own)close((int)value);}
 if(closedir(d))okay=0;return okay;
}
static int supervisor(int ready){
 if(ready<=2){int other=fcntl(ready,F_DUPFD_CLOEXEC,3);if(other<0)return 0;close(ready);ready=other;}
 if(setsid()<0)return 0;int null=open("/dev/null",O_RDWR|O_CLOEXEC);if(null<0)return 0;
 for(int fd=0;fd<3;fd++)if(dup2(null,fd)<0)return 0;if(null>2&&null!=ready)close(null);
 if(!close_inherited(ready))return 0;
 int owner=open(S_PATH("owner.lock"),O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC|O_NOFOLLOW,0600);if(owner<0||flock(owner,LOCK_EX|LOCK_NB))return 0;
 struct sockaddr_un u;if(!sock_address(&u)||!absent(S_PATH("control.sock")))return 0;
 int listener=socket(AF_UNIX,SOCK_SEQPACKET|SOCK_CLOEXEC|SOCK_NONBLOCK,0);if(listener<0||bind(listener,(struct sockaddr*)&u,sizeof(u))||chmod(S_PATH("control.sock"),0600)||listen(listener,2)||!status("supervisor_ready"))return 0;
 if(!all_write(ready,"R",1))return 0;close(ready);uint64_t start=millis();if(!start)return 0;
 int client=-1,authorized=0,marked=0;pid_t peer_pid=0;uint64_t peer_ticks=0,ppid=0;
 while(millis()>=start&&millis()-start<F4_DEADLINE_MS){
  struct pollfd fds[2]={{listener,POLLIN,0},{client,POLLIN,0}};int n=poll(fds,client>=0?2:1,100);if(n<0&&errno==EINTR)continue;if(n<0)break;
  if(fds[0].revents&POLLIN){int incoming=accept4(listener,NULL,NULL,SOCK_CLOEXEC|SOCK_NONBLOCK);if(incoming>=0){if(client<0){client=incoming;authorized=0;peer_pid=0;}else close(incoming);}}
  if(client>=0&&(fds[1].revents&POLLIN)){
   char b[32];ssize_t got=recv(client,b,sizeof(b),MSG_DONTWAIT|MSG_TRUNC);
   unsigned ctor_startup=0;int ctor_packet=f1_status_decode((const uint8_t*)b,(size_t)(got>0?got:0),&ctor_startup);
   if(got==5&&!memcmp(b,"F4D2\n",5)&&peer_path(client,F4_TOOL,&peer_pid)){
    int okay=restore();if(okay)okay=status("disabled_runner_original_mapping_not_unloaded");if(okay)(void)send(client,"F4OK2\n",6,MSG_DONTWAIT|MSG_NOSIGNAL);break;
   }
   if(!authorized&&got==5&&!memcmp(b,"F4L2\n",5)&&!marked&&peer_path(client,F4_LAUNCHER,&peer_pid)&&proc_stat((uint64_t)peer_pid,&peer_ticks,&ppid,0)&&runner_check(F4_RUNNER,0,1)&&absent(S_PATH("disabled"))){
    char record[96];int bytes=snprintf(record,sizeof(record),"%ld %llu\n",(long)peer_pid,(unsigned long long)peer_ticks);
    if(bytes>0&&create_bytes(S_PATH("loaded.pid"),record,(size_t)bytes,0600)&&send(client,"F4OK2\n",6,MSG_DONTWAIT|MSG_NOSIGNAL)==6)authorized=1;else{close(client);client=-1;}
   }else if(authorized&&ctor_packet&&proc_exe((uint64_t)peer_pid,F4_USER)){
    uint64_t tick,unused;if(proc_stat((uint64_t)peer_pid,&tick,&unused,1)&&tick==peer_ticks){
     char record[256];int bytes=snprintf(record,sizeof(record),"{\"schema\":\"iq4_f1_display_ctor_status_v6\",\"constructor_seen\":true,\"pid\":%ld,\"start_ticks\":%llu,\"startup_code\":%u,\"user_gate_ready\":%s,\"ui_ready\":false,\"mask_enabled\":false}\n",(long)peer_pid,(unsigned long long)tick,ctor_startup,ctor_startup==4?"true":"false");
     if(bytes>0&&(size_t)bytes<sizeof(record)&&create_bytes(S_PATH("marker.observed"),record,(size_t)bytes,0600)&&fsync_dir(F4_STATE)){marked=1;(void)status("F1_ctor_status_observed_not_UI_or_mask_ready");}
    }close(client);client=-1;
   }else{close(client);client=-1;}
  }else if(client>=0&&(fds[1].revents&(POLLHUP|POLLERR|POLLNVAL))){close(client);client=-1;}
 }
 if(client>=0)close(client);int restored=restore();(void)status(restored?"deadline_runner_original_no_user_signal":"deadline_restore_refused_originals_retained");close(listener);close(owner);
 /* Keep all original/backup/status files. No unlink on failed recovery. */
 return restored;
}
static int arm(void){
 if(!module_gate()||!tool_gate()||!prepare())return fail("arm_gate_or_prepare_refused_originals_retained");
 int ready[2];if(pipe2(ready,O_CLOEXEC|O_NONBLOCK))return fail("ready_pipe_failed");pid_t child=fork();
 if(child<0){close(ready[0]);close(ready[1]);return fail("supervisor_fork_failed");}
 if(!child){close(ready[0]);_exit(supervisor(ready[1])?0:2);}close(ready[1]);struct pollfd p={ready[0],POLLIN,0};char b=0;int okay=poll(&p,1,2000)==1&&read(ready[0],&b,1)==1&&b=='R';close(ready[0]);
 if(!okay)return fail("supervisor_not_ready_no_runner_replacement");
 int lock=mutation_lock();if(lock<0)return fail("mutation_lock_busy");
 okay=root_mount_gate()&&own_dir()&&old_user_gate()&&flags_gate()&&runner_check(F4_RUNNER,0,1)&&runner_check(F4_ORIGINAL,0,1)&&runner_check(F4_CANDIDATE,1,0);
 if(okay)okay=!rename(F4_CANDIDATE,F4_RUNNER)&&fsync_dir(F4_SCRIPT_DIR)&&runner_check(F4_RUNNER,1,0);
 if(!okay)(void)restore_core();close(lock);if(!okay)return fail("arm_refused_restore_attempted_no_user_signal");
 if(!status("armed_waiting_for_separately_verified_native_user_exit"))return fail("armed_status_failed_supervisor_deadline_still_active");
 puts("{\"ram_entry\":2,\"result\":\"armed\",\"user_signals\":0,\"native_exit_requested\":false}");return 0;
}
static int load_environment(char bytes[16384],char *env[259],size_t *count){
 struct stat a,b;if(lstat(S_PATH("env.1"),&a)||lstat(S_PATH("env.2"),&b)||!S_ISREG(a.st_mode)||!S_ISREG(b.st_mode)||a.st_uid!=0||a.st_gid!=0||b.st_uid!=0||b.st_gid!=0||(a.st_mode&07777)!=0600||(b.st_mode&07777)!=0600||a.st_nlink!=1||b.st_nlink!=1)return 0;
 char second[16384];size_t n,z;if(!read_bounded(S_PATH("env.1"),bytes,16384,&n)||!read_bounded(S_PATH("env.2"),second,sizeof(second),&z)||n!=z||memcmp(bytes,second,n)||!env_valid(bytes,n))return 0;
 size_t off=0,i=0;while(off<n){env[i++]=bytes+off;off+=strlen(bytes+off)+1;}env[i]=NULL;*count=i;return 1;
}
static int launch(void){
 /* No source/owner identity condition may move this restoration below exec. */
 if(!restore())return fail("launch_restore_failed_no_user_exec");
 if(!runner_parent_gate()||!old_user_gone()||!flags_gate()||!user_file_gate())return fail("launch_owner_or_old_user_still_alive_refused");
 char bytes[16384];char *env[259];size_t count;if(!load_environment(bytes,env,&count))return fail("private_environment_snapshot_refused_no_user_exec");
 char *argv[]={(char*)F4_ARGV0,NULL};
 int fd=-1;int preload=absent(S_PATH("disabled"))&&module_gate()&&tool_gate()&&fcntl(198,F_GETFD)<0&&errno==EBADF;
 for(size_t i=0;i<count;i++)if(!strncmp(env[i],"IQ4_F1_MODULE_ENTRY_01=",sizeof("IQ4_F1_MODULE_ENTRY_01=")-1))preload=0;
 if(preload){fd=connect_control();if(fd<0||!ack(fd,"F4L2\n"))preload=0;}
 int owned_198=0;
 if(preload){if(dup2(fd,198)<0)preload=0;else{owned_198=1;if(fcntl(198,F_SETFD,0)<0)preload=0;}}
 if(fd>=0&&fd!=198)close(fd);
 if(!preload&&owned_198){close(198);owned_198=0;}
 static char setting[]="LD_PRELOAD=" F4_MODULE;
 static char observe_setting[]="IQ4_F1_MODULE_ENTRY_01=OBSERVE";
 umask(F4_USER_UMASK);
 if(preload){env[count]=setting;env[count+1]=observe_setting;env[count+2]=NULL;execve(F4_ARGV0,argv,env);env[count]=NULL;if(owned_198)close(198);}
 /* Module/handshake/loader exec syscall failure: same untouched User, original
  * environment. A fatal loader/constructor then falls back via original init.
  */
 execve(F4_ARGV0,argv,env);return fail("stock_exec_failed_runner_already_original");
}
static int disable(void){
 if(!root_mount_gate()||!own_dir()||!user_file_gate())return fail("disable_root_or_user_identity_refused");
 if(absent(S_PATH("disabled"))&&!create_bytes(S_PATH("disabled"),"disabled\n",9,0600))return fail("disable_marker_create_failed");
 if(!restore())return fail("disable_restore_refused_originals_retained");
 int fd=connect_control();if(fd>=0){(void)ack(fd,"F4D2\n");close(fd);}
 (void)status("disabled_runner_original_mapping_not_unloaded");
 puts("{\"ram_entry\":2,\"result\":\"disabled_runner_original\",\"user_signals\":0,\"unload_verified\":false}");return 0;
}
#include "observe_read.inc"
#ifndef F4_NO_MAIN
int main(int argc,char **argv){
 umask(077);
 if(!F4_ENABLED)return fail("preview_build_mutation_and_launch_disabled");
 if(argc==1&&!strcmp(argv[0],F4_LAUNCHER))return launch();
 if(argc==1||(argc==2&&!strcmp(argv[1],"--preflight"))){int okay=root_mount_gate()&&own_dir()&&flags_gate()&&user_file_gate()&&old_user_gate()&&runner_check(F4_RUNNER,0,1)&&module_gate()&&tool_gate();printf("{\"ram_entry\":2,\"result\":\"preflight\",\"ready\":%s,\"writes\":0,\"user_signals\":0}\n",okay?"true":"false");return okay?0:2;}
 if(argc==2&&!strcmp(argv[1],"--observe-read"))return f1_observe_read();
 if(argc==2&&!strcmp(argv[1],"--arm"))return arm();
 if(argc==2&&!strcmp(argv[1],"--stage-launcher"))return stage_launcher();
 if(argc==2&&!strcmp(argv[1],"--disable"))return disable();
 return fail("unsupported_mode_or_argv_no_action");
}
#endif
