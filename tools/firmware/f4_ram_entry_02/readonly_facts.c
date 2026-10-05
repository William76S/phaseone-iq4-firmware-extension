/* Fixed-path readonly metadata/hash/xattrs probe. Never modifies the runner,
 * User, environment, EEPROM or any config. No args, no arbitrary path input.
 * Reuses production readonly helpers; unused mutation branches are discarded.
 */
#define F4_NO_MAIN
#include "entry.c"
typedef struct {struct stat st;char sha[65];ssize_t xattrs;int xattr_errno,stable,match;} F4Facts;
static int f4_same_stat(const struct stat *a,const struct stat *b){
 return a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_size==b->st_size&&a->st_mode==b->st_mode&&a->st_uid==b->st_uid&&a->st_gid==b->st_gid&&a->st_nlink==b->st_nlink&&a->st_mtim.tv_sec==b->st_mtim.tv_sec&&a->st_mtim.tv_nsec==b->st_mtim.tv_nsec&&a->st_ctim.tv_sec==b->st_ctim.tv_sec&&a->st_ctim.tv_nsec==b->st_ctim.tv_nsec;
}
static int f4_file_facts(const char *path,uint64_t size,const char *expected,int xattrs,F4Facts *out){
 memset(out,0,sizeof(*out));out->xattrs=-1;
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return 0;struct stat after;
 int okay=!fstat(fd,&out->st)&&S_ISREG(out->st.st_mode)&&out->st.st_size>=0&&(uint64_t)out->st.st_size==size&&hash_fd(fd,out->sha,size);
 if(okay&&xattrs){errno=0;out->xattrs=flistxattr(fd,NULL,0);out->xattr_errno=out->xattrs<0?errno:0;}
 if(okay)okay=!fstat(fd,&after)&&(out->stable=f4_same_stat(&out->st,&after));
 if(okay)out->match=!strcmp(out->sha,expected);if(close(fd))okay=0;return okay;
}
int main(int argc,char **argv){
 (void)argv;if(argc!=1||getuid()!=0||geteuid()!=0)return fail("readonly_facts_root_or_argv_refused");
 F4Facts runner,user;if(!f4_file_facts(F4_RUNNER,F4_RUNNER_SIZE,F4_RUNNER_SHA,1,&runner)||!f4_file_facts(F4_USER,F4_USER_SIZE,F4_USER_SHA,0,&user))return fail("readonly_fixed_files_unreadable_or_unstable");
 printf("{\"readonly_facts\":2,\"file_writes\":0,\"User_file_sha256\":\"%s\",\"User_matches\":%s,\"User_stable\":%s,\"runner_sha256\":\"%s\",\"runner_matches\":%s,\"runner_stable\":%s,\"runner_inode\":%llu,\"runner_mode\":%u,\"runner_uid\":%u,\"runner_gid\":%u,\"runner_nlink\":%llu,\"runner_major\":%u,\"runner_minor\":%u,\"runner_xattr_name_bytes\":%lld,\"runner_xattr_errno\":%d}\n",
  user.sha,user.match?"true":"false",user.stable?"true":"false",runner.sha,runner.match?"true":"false",runner.stable?"true":"false",(unsigned long long)runner.st.st_ino,(unsigned)(runner.st.st_mode&07777),(unsigned)runner.st.st_uid,(unsigned)runner.st.st_gid,(unsigned long long)runner.st.st_nlink,major(runner.st.st_dev),minor(runner.st.st_dev),(long long)runner.xattrs,runner.xattr_errno);
 return runner.match&&user.match?0:2;
}
