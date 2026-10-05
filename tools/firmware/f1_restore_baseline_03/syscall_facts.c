/* Fixed-path readonly facts. No file creation, write, unlink, rename, mount,
 * device ioctl, process signal, SDK, PIN/config/EEPROM read or UI invocation.
 * Running it is a separate Root decision; this source includes no stager.
 */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/sysmacros.h>
#include <sys/xattr.h>
#include <unistd.h>
static const char* const paths[]={
 "/","/p1","/p1/scripts","/run","/run/media/storage","/run/media/storage/User","/mnt/qspi","/mnt/qspi/User",
 "/p1/scripts/boot_run_p1linux.sh","/etc/inittab","/mnt/qspi/User/p1linux","/run/media/storage/User/p1linux",
 "/run/boot_is_user","/run/essential_boot_done","/run/boot_is_factory","/run/p1linux_respawn_reboot",
 "/run/p1linux_respawn_run_install_mode","/run/p1linux_respawn_do_nothing","/run/media/storage/debug","/mnt/qspi/debug",
 "/run/media/storage/User/p1linux.bin","/mnt/qspi/User/p1linux.bin","/run/f1launch","/run/iq4_f1_observe02",
 "/p1/scripts/.iq4_f1_original02","/p1/scripts/.iq4_f1_candidate02"
};
static int same(const struct stat*a,const struct stat*b){return a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_mode==b->st_mode&&a->st_uid==b->st_uid&&a->st_gid==b->st_gid&&a->st_size==b->st_size&&a->st_nlink==b->st_nlink&&a->st_mtim.tv_sec==b->st_mtim.tv_sec&&a->st_mtim.tv_nsec==b->st_mtim.tv_nsec&&a->st_ctim.tv_sec==b->st_ctim.tv_sec&&a->st_ctim.tv_nsec==b->st_ctim.tv_nsec;}
static void node(unsigned index,int follow){
 struct stat a,b;memset(&a,0,sizeof a);memset(&b,0,sizeof b);errno=0;int rc=follow?stat(paths[index],&a):lstat(paths[index],&a);int error=rc<0?errno:0;
 int stable=0;if(rc==0)stable=!(follow?stat(paths[index],&b):lstat(paths[index],&b))&&same(&a,&b);
 printf("{\"index\":%u,\"follow\":%s,\"rc\":%d,\"errno\":%d,\"stable\":%s,\"dev_major\":%u,\"dev_minor\":%u,\"inode\":%llu,\"mode\":%u,\"uid\":%u,\"gid\":%u,\"size\":%lld,\"nlink\":%llu,\"mtime_sec\":%lld,\"mtime_nsec\":%ld,\"ctime_sec\":%lld,\"ctime_nsec\":%ld}",index,follow?"true":"false",rc,error,stable?"true":"false",major(a.st_dev),minor(a.st_dev),(unsigned long long)a.st_ino,(unsigned)a.st_mode,(unsigned)a.st_uid,(unsigned)a.st_gid,(long long)a.st_size,(unsigned long long)a.st_nlink,(long long)a.st_mtim.tv_sec,a.st_mtim.tv_nsec,(long long)a.st_ctim.tv_sec,a.st_ctim.tv_nsec);
}
static void runner_xattrs(void){
 struct stat a,b,path;int fd=open(paths[8],O_RDONLY|O_CLOEXEC|O_NOFOLLOW);int err=fd<0?errno:0;ssize_t count=-1;int stable=0;
 if(fd>=0){errno=0;int sr=fstat(fd,&a);if(!sr&&S_ISREG(a.st_mode)){errno=0;count=flistxattr(fd,NULL,0);err=count<0?errno:0;stable=!fstat(fd,&b)&&same(&a,&b)&&!lstat(paths[8],&path)&&same(&a,&path);}else err=sr<0?errno:EINVAL;if(close(fd)){err=errno;stable=0;}}
 printf("{\"fd_opened\":%s,\"name_bytes\":%lld,\"errno\":%d,\"stable\":%s,\"attribute_values_read\":false}",fd>=0?"true":"false",(long long)count,err,stable?"true":"false");
}
int main(int argc,char**argv){
 (void)argv;if(argc!=1)return 2;
 /* No init/main of User or vendor method is called. No safety fact is inferred
  * from success: errno, type, alias identity, stable inode and mount provenance
  * remain explicit observations for Root's separate recovery assessment. */
 printf("{\"schema\":\"iq4_f1_fixed_syscall_facts_v3\",\"uid\":%u,\"euid\":%u,\"file_write_calls\":0,\"device_control_calls\":0,\"nodes\":[",(unsigned)getuid(),(unsigned)geteuid());
 for(unsigned i=0;i<sizeof paths/sizeof paths[0];i++){if(i)putchar(',');node(i,0);}
 printf("],\"followed_alias_parents\":[");node(4,1);putchar(',');node(5,1);printf("],\"runner_xattrs\":");runner_xattrs();printf("}\n");
 return ferror(stdout)?2:0;
}
