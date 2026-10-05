/* Scratch inodes only. Default does nothing; no runner/User/SDK/control access.
 * A future sole executor must supply actual parent identity and stage/lease
 * evidence separately. Successful host fixtures never establish camera gates. */
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#if defined(__linux__)
#include <sys/sysmacros.h>
#else
#include <sys/types.h>
#endif
#include <unistd.h>

static const unsigned char original[] = "IQ4 F1 scratch original inode only\n";
static const unsigned char candidate[] = "IQ4 F1 scratch candidate inode only\n";
static const char *phase = "arguments";
static int failure_errno;
static unsigned calls;

static int check(int ok) {
    calls++;
    if (!ok && !failure_errno) failure_errno = errno ? errno : EINVAL;
    return ok;
}
static int u64(const char *s, uint64_t *out) {
    if (!*s || (*s == '0' && s[1])) return 0;
    for (const char *p=s; *p; ++p) if (*p<'0' || *p>'9') return 0;
    errno=0; char *end; unsigned long long n=strtoull(s,&end,10);
    if (errno || *end) return 0;
    *out=(uint64_t)n; return 1;
}
static int id_equal(const struct stat *a, const struct stat *b) {
    return a->st_dev==b->st_dev && a->st_ino==b->st_ino &&
           a->st_uid==b->st_uid && a->st_gid==b->st_gid &&
           a->st_mode==b->st_mode && a->st_size==b->st_size;
}
static int regular(int fd, struct stat *s, size_t n, nlink_t links) {
    return !fstat(fd,s) && S_ISREG(s->st_mode) &&
           s->st_uid==getuid() && s->st_gid==getgid() &&
           (s->st_mode&07777)==0600 && s->st_size==(off_t)n &&
           s->st_nlink==links;
}
static int verify(int dir, const char *name, const struct stat *expected,
                  const unsigned char *bytes, size_t n, nlink_t links) {
    struct stat path, held; unsigned char buf[128];
    if (n>sizeof buf || fstatat(dir,name,&path,AT_SYMLINK_NOFOLLOW) ||
        !id_equal(&path,expected) || path.st_nlink!=links) return 0;
    int fd=openat(dir,name,O_RDONLY|O_NOFOLLOW|O_CLOEXEC);
    if (fd<0) return 0;
    ssize_t got=pread(fd,buf,sizeof buf,0);
    int ok=regular(fd,&held,n,links) && id_equal(&held,expected) &&
           got==(ssize_t)n && !memcmp(buf,bytes,n);
    if (close(fd)) ok=0;
    return ok;
}
static int make_file(int dir, const char *name, const unsigned char *bytes,
                     size_t n, struct stat *s) {
    int fd=openat(dir,name,O_RDWR|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC,0600);
    if (fd<0) return 0;
    ssize_t written=pwrite(fd,bytes,n,0);
    int ok=written==(ssize_t)n && !fsync(fd) && regular(fd,s,n,1);
    if (close(fd)) ok=0;
    return ok;
}
static int missing(int dir,const char *name) {
    struct stat s; errno=0;
    return fstatat(dir,name,&s,AT_SYMLINK_NOFOLLOW)==-1 && errno==ENOENT;
}

int main(int argc, char **argv) {
    if (argc==1) {
        puts("{\"action\":\"F1_scratch_probe_default_off\",\"target_access\":false,\"writes\":false}");
        return ferror(stdout)?2:0;
    }
    uint64_t maj=0,min=0,ino=0;
    if (argc!=6 || strcmp(argv[1],"--run-scratch") ||
        !u64(argv[2],&maj) || !u64(argv[3],&min) || !u64(argv[4],&ino) ||
        !ino || maj>UINT32_MAX || min>UINT32_MAX || strlen(argv[5])!=12) return 2;
    for (unsigned i=0;i<12;i++)
        if (!((argv[5][i]>='0' && argv[5][i]<='9') ||
              (argv[5][i]>='a' && argv[5][i]<='f'))) return 2;
#ifndef F1_SCRATCH_HOST_FIXTURE
#if !defined(__linux__)
    return 2;
#endif
    if (getuid()!=0 || geteuid()!=0 || getgid()!=0) return 2;
    const char *parent_path="/p1/scripts";
#else
    const char *parent_path=getenv("IQ4_F1_HOST_FIXTURE_PARENT");
    if (!parent_path || parent_path[0]!='/') return 2;
#endif
    char dirname[64];
    if (snprintf(dirname,sizeof dirname,".iq4_f1_scratch01_%s",argv[5])<=0) return 2;
    int parent=-1,dir=-1; int created=0,success=0,cleaned=0;
    struct stat before,after,owned,a,b;
    memset(&owned,0,sizeof owned); memset(&a,0,sizeof a); memset(&b,0,sizeof b);
    phase="hold_exact_parent";
    parent=open(parent_path,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    if (!check(parent>=0 && !fstat(parent,&before) && S_ISDIR(before.st_mode) &&
        before.st_uid==getuid() && !(before.st_mode&0022) &&
        (uint64_t)major(before.st_dev)==maj && (uint64_t)minor(before.st_dev)==min &&
        (uint64_t)before.st_ino==ino)) goto done;
    phase="exclusive_scratch_directory";
    if (!check(missing(parent,dirname))) goto done;
    if (!check(!mkdirat(parent,dirname,0700))) goto done;
    created=1;
    dir=openat(parent,dirname,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    if (!check(dir>=0 && !fstat(dir,&owned) && S_ISDIR(owned.st_mode) &&
        owned.st_dev==before.st_dev && owned.st_uid==getuid() &&
        owned.st_gid==getgid() && (owned.st_mode&07777)==0700)) goto done;
    phase="create_fsync_original_and_candidate";
    if (!check(make_file(dir,"live",original,sizeof original-1,&a)) ||
        !check(make_file(dir,"candidate",candidate,sizeof candidate-1,&b)) ||
        !check(a.st_dev==b.st_dev && a.st_dev==before.st_dev && a.st_ino!=b.st_ino) ||
        !check(!fsync(dir))) goto done;
    phase="hardlink_original";
    if (!check(!linkat(dir,"live",dir,"original",0)) ||
        !check(verify(dir,"live",&a,original,sizeof original-1,2)) ||
        !check(verify(dir,"original",&a,original,sizeof original-1,2)) ||
        !check(!fsync(dir))) goto done;
    phase="atomic_candidate_rename_and_directory_fsync";
    if (!check(!renameat(dir,"candidate",dir,"live")) ||
        !check(!fsync(dir)) || !check(missing(dir,"candidate")) ||
        !check(verify(dir,"live",&b,candidate,sizeof candidate-1,1)) ||
        !check(verify(dir,"original",&a,original,sizeof original-1,1))) goto done;
    phase="restore_exact_scratch_inode";
    if (!check(!linkat(dir,"original",dir,"restore",0)) ||
        !check(!renameat(dir,"restore",dir,"live")) || !check(!fsync(dir)) ||
        !check(missing(dir,"restore")) ||
        !check(verify(dir,"live",&a,original,sizeof original-1,2)) ||
        !check(verify(dir,"original",&a,original,sizeof original-1,2))) goto done;
    success=1;
    phase="remove_only_verified_own_scratch_inodes";
    if (!check(!unlinkat(dir,"original",0)) ||
        !check(verify(dir,"live",&a,original,sizeof original-1,1)) ||
        !check(!unlinkat(dir,"live",0)) || !check(!fsync(dir)) ||
        !check(!fstatat(parent,dirname,&after,AT_SYMLINK_NOFOLLOW) &&
               id_equal(&after,&owned)) ||
        !check(!unlinkat(parent,dirname,AT_REMOVEDIR)) ||
        !check(!fsync(parent)) || !check(missing(parent,dirname))) goto done;
    cleaned=1; phase="complete";
done:
    /* Failure deliberately retains created scratch state. No guessed cleanup
     * or unrelated unlink is issued; partial paths require held-owner review.
     * Caller must enforce no foreign root mutation. Compare/unlink is not an
     * atomic pathname lease; this program does not claim otherwise. */
    if (dir>=0 && close(dir)) {cleaned=0;failure_errno=errno;}
    if (parent>=0 && close(parent)) {cleaned=0;failure_errno=errno;}
    printf("{\"action\":\"F1_scratch_inode_restore_probe\",\"phase\":\"%s\","
           "\"checked_operations\":%u,\"errno\":%d,\"scratch_created\":%s,"
           "\"same_fs_restore_exact_inode_and_bytes\":%s,\"cleanup_complete\":%s,"
           "\"scratch_original_inode\":%llu,\"scratch_candidate_inode\":%llu,"
           "\"runner_modified\":false,\"User_modified\":false,\"EEP_access\":false,"
           "\"cold_recovery_verified\":false,\"atomic_compare_unlink_claimed\":false}\n",
           phase,calls,failure_errno,created?"true":"false",success?"true":"false",
           cleaned?"true":"false",(unsigned long long)a.st_ino,(unsigned long long)b.st_ino);
    return success && cleaned && !failure_errno && !ferror(stdout)?0:2;
}
