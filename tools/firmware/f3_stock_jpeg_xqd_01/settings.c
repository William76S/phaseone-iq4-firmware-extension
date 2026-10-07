#define _GNU_SOURCE
#include "settings.h"
#include <stdint.h>
#include <stddef.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
#include <stdio.h>
extern const char *iq4_stock_jpeg_settings_test_root;
extern int iq4_stock_jpeg_settings_test_fault(unsigned);
extern int iq4_stock_jpeg_settings_test_ubifs;
#else
#include <sys/syscall.h>
#include <sys/vfs.h>
#if !defined(__aarch64__) || !defined(__linux__)
#error AArch64 Linux target required
#endif
_Static_assert(sizeof(struct stat)==128 && offsetof(struct stat,st_ino)==8 &&
               offsetof(struct stat,st_mode)==16 && offsetof(struct stat,st_size)==48,
               "AArch64 kernel stat layout");
_Static_assert(sizeof(struct statfs)==120 && SYS_openat==56 && SYS_fstat==80 &&
               SYS_fstatfs==44 && SYS_newfstatat==79 && SYS_renameat2==276 &&
               SYS_fsync==82 && SYS_close==57,"AArch64 Linux filesystem ABI");
extern long iq4_f3_original_syscall_03(long,...);
extern int *iq4_f3_original_errno_location_03(void);
#endif

/* Deliberately outside User/Factory and original configuration namespaces.
 * Reuses the frozen Ratio Mask checked atomic settings implementation with a
 * separate namespace and magic. mode is destination index; other fields are
 * fixed reserved values for this first revision.
 * A normal upgrade replaces User, while the UBIFS root remains independent.
 * No boot scripts, EEPROM, security, calibration or card paths are modified. */
static const char current[]="iq4-stock-jpeg.cfg";
static const char backup[]="iq4-stock-jpeg.cfg.bak";
#define LEGACY_RECORD_SIZE 24u
#define RECORD_SIZE 28u
enum Op { OP_OPEN=1,OP_STAT,OP_LSTAT,OP_READ,OP_WRITE,OP_FSYNC,OP_CLOSE,
          OP_RENAME,OP_UNLINK,OP_FS,OP_ID };
static unsigned sequence;
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
unsigned iq4_stock_jpeg_settings_test_sequence(void){return __atomic_load_n(&sequence,__ATOMIC_RELAXED);}
#endif
static int error_code(void) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    return errno;
#else
    return *iq4_f3_original_errno_location_03();
#endif
}
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
static int fault(unsigned op) {int e=iq4_stock_jpeg_settings_test_fault(op);if(e)errno=e;return e;}
#endif
static int opendir_leaf(int d,const char *p,int flags) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_OPEN))return -1;return openat(d,p,flags,0600);
#else
    return (int)iq4_f3_original_syscall_03(SYS_openat,d,p,flags,0600);
#endif
}
static int fdstat(int d,struct stat *s) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_STAT))return -1;return fstat(d,s);
#else
    return (int)iq4_f3_original_syscall_03(SYS_fstat,d,s);
#endif
}
static int leafstat(int d,const char *p,struct stat *s) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_LSTAT))return -1;return fstatat(d,p,s,AT_SYMLINK_NOFOLLOW);
#else
    return (int)iq4_f3_original_syscall_03(SYS_newfstatat,d,p,s,AT_SYMLINK_NOFOLLOW);
#endif
}
static long readbytes(int d,void *p,size_t n) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_READ))return -1;return read(d,p,n);
#else
    return iq4_f3_original_syscall_03(SYS_read,d,p,n);
#endif
}
static long writebytes(int d,const void *p,size_t n) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_WRITE))return -1;return write(d,p,n);
#else
    return iq4_f3_original_syscall_03(SYS_write,d,p,n);
#endif
}
static int syncfd(int d) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_FSYNC))return -1;return fsync(d);
#else
    return (int)iq4_f3_original_syscall_03(SYS_fsync,d);
#endif
}
static int closefd(int d) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    /* Model a Linux close error after descriptor release; never retry close. */
    int e=fault(OP_CLOSE);int r=close(d);return e?-1:r;
#else
    return (int)iq4_f3_original_syscall_03(SYS_close,d);
#endif
}
static int moveleaf(int d,const char *from,const char *to,int absent) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_RENAME))return -1;
    if(absent){struct stat s;if(!fstatat(d,to,&s,AT_SYMLINK_NOFOLLOW)){errno=EEXIST;return -1;}}
    return renameat(d,from,d,to);
#else
    return (int)iq4_f3_original_syscall_03(SYS_renameat2,d,from,d,to,absent?1u:0u);
#endif
}
static int unlinkleaf(int d,const char *p) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_UNLINK))return -1;return unlinkat(d,p,0);
#else
    return (int)iq4_f3_original_syscall_03(SYS_unlinkat,d,p,0);
#endif
}
static int ubifs(int d) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    (void)d;return !fault(OP_FS)&&iq4_stock_jpeg_settings_test_ubifs;
#else
    struct statfs s;
    return iq4_f3_original_syscall_03(SYS_fstatfs,d,&s)==0 &&
           (uint64_t)s.f_type==UINT64_C(0x24051905);
#endif
}
static unsigned process_id(void) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    if(fault(OP_ID))return 0;return (unsigned)getpid();
#else
    long n=iq4_f3_original_syscall_03(SYS_getpid);return n>0?(unsigned)n:0;
#endif
}
static int rootfd(void) {
#ifdef IQ4_STOCK_JPEG_SETTINGS_HOST
    int d=opendir_leaf(AT_FDCWD,iq4_stock_jpeg_settings_test_root,O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
#else
    int base=opendir_leaf(AT_FDCWD,"/",O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    if(base<0)return -1;
    int parent=opendir_leaf(base,"mnt",O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    int closed=closefd(base);if(parent<0)return -1;if(closed){closefd(parent);return -1;}
    int d=opendir_leaf(parent,"qspi",O_RDONLY|O_DIRECTORY|O_NOFOLLOW|O_CLOEXEC);
    closed=closefd(parent);if(d<0)return -1;if(closed){closefd(d);return -1;}
#endif
    if(d>=0&&!ubifs(d)){closefd(d);return -1;}return d;
}
static uint32_t get32(const unsigned char *p) {return (uint32_t)p[0]|(uint32_t)p[1]<<8|(uint32_t)p[2]<<16|(uint32_t)p[3]<<24;}
static void put32(unsigned char *p,uint32_t n){for(unsigned i=0;i<4;++i)p[i]=(unsigned char)(n>>(i*8));}
static uint32_t checksum(const unsigned char *p,unsigned n){uint32_t h=2166136261u;for(unsigned i=0;i<n;++i)h=(h^p[i])*16777619u;return h;}
static int values(const struct Iq4StockJpegSettings *s){
    return s&&s->mode<=1u&&s->opacity==65u&&s->remembered_mode==1u;
}
static void encode(unsigned char *p,const struct Iq4StockJpegSettings *s){
    static const unsigned char magic[8]={'I','Q','4','J','P','G','D','S'};
    for(unsigned i=0;i<8;++i)p[i]=magic[i];
    put32(p+8,2);put32(p+12,s->mode);put32(p+16,s->opacity);
    put32(p+20,s->remembered_mode);put32(p+24,checksum(p,24));
}
static int decode(const unsigned char *p,unsigned n,struct Iq4StockJpegSettings *s){
    static const unsigned char magic[8]={'I','Q','4','J','P','G','D','S'};
    if(n!=LEGACY_RECORD_SIZE&&n!=RECORD_SIZE)return 0;
    for(unsigned i=0;i<8;++i)if(p[i]!=magic[i])return 0;
    unsigned version=get32(p+8);
    if((version==1&&n!=LEGACY_RECORD_SIZE)||(version==2&&n!=RECORD_SIZE)||
       (version!=1&&version!=2)||get32(p+n-4)!=checksum(p,n-4))return 0;
    s->mode=get32(p+12);s->opacity=get32(p+16);
    s->remembered_mode=version==1?(s->mode?s->mode:1u):get32(p+20);
    return values(s);
}
static int same(const struct stat *a,const struct stat *b){return a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_size==b->st_size&&a->st_mode==b->st_mode&&a->st_nlink==b->st_nlink;}
static int unchanged(int d,const char *p,const struct stat *old,int absent){struct stat s;int r=leafstat(d,p,&s);return absent?(r<0&&error_code()==ENOENT):(!r&&same(old,&s));}
/* UNKNOWN bytes, symlinks, special files and hardlinks are never overwritten. */
static int readrecord(int d,const char *name,unsigned char *bytes,unsigned *length,struct stat *identity){
    struct stat before,held,after;struct Iq4StockJpegSettings s;
    if(leafstat(d,name,&before))return error_code()==ENOENT?IQ4_STOCK_JPEG_SETTINGS_ABSENT:IQ4_STOCK_JPEG_SETTINGS_IO;
    if(!S_ISREG(before.st_mode)||before.st_nlink!=1||
       (before.st_size!=RECORD_SIZE&&before.st_size!=LEGACY_RECORD_SIZE))return IQ4_STOCK_JPEG_SETTINGS_INVALID;
    unsigned nbytes=(unsigned)before.st_size;
    int f=opendir_leaf(d,name,O_RDONLY|O_NOFOLLOW|O_CLOEXEC);if(f<0)return IQ4_STOCK_JPEG_SETTINGS_IO;
    int result=IQ4_STOCK_JPEG_SETTINGS_IO;
    if(!fdstat(f,&held)&&same(&before,&held)){
        unsigned used=0,attempts=0;while(used<nbytes&&attempts++<64){long n=readbytes(f,bytes+used,nbytes-used);if(n<0){if(error_code()==EINTR)continue;break;}if(!n)break;used+=(unsigned)n;}
        unsigned char extra;long tail=used==nbytes?readbytes(f,&extra,1):-1;
        if(used==nbytes&&tail==0&&!fdstat(f,&after)&&same(&held,&after)&&unchanged(d,name,&after,0))result=decode(bytes,nbytes,&s)?IQ4_STOCK_JPEG_SETTINGS_OK:IQ4_STOCK_JPEG_SETTINGS_INVALID;
    }
    if(closefd(f))result=IQ4_STOCK_JPEG_SETTINGS_IO;
    if(result==IQ4_STOCK_JPEG_SETTINGS_OK){*identity=before;*length=nbytes;}return result;
}
static void hex8(char *p,unsigned n){static const char digit[]="0123456789abcdef";for(unsigned i=0;i<8;++i)p[i]=digit[(n>>(28-4*i))&15];}
static int publish(int d,const char *name,const unsigned char *bytes,unsigned nbytes,const struct stat *old,int absent){
    char temporary[]=".iq4-stock-jpeg-00000000-00000000.tmp";unsigned pid=process_id();if(!pid)return IQ4_STOCK_JPEG_SETTINGS_IO;
    hex8(temporary+16,pid);int f=-1;
    /* A reboot may reuse a PID and leave a former temporary leaf. Skip a
     * bounded number of names; never truncate or remove a collision. */
    for(unsigned attempt=0;attempt<16;++attempt){
        hex8(temporary+25,__atomic_add_fetch(&sequence,1,__ATOMIC_RELAXED));
        f=opendir_leaf(d,temporary,O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC);
        if(f>=0||error_code()!=EEXIST)break;
    }
    if(f<0)return IQ4_STOCK_JPEG_SETTINGS_IO;
    struct stat own;int own_ok=!fdstat(f,&own)&&S_ISREG(own.st_mode)&&own.st_nlink==1;
    unsigned used=0,attempts=0;
    while(own_ok&&used<nbytes&&attempts++<64){long n=writebytes(f,bytes+used,nbytes-used);if(n<0){if(error_code()==EINTR)continue;break;}if(!n)break;used+=(unsigned)n;}
    int ready=own_ok&&used==nbytes&&!syncfd(f);struct stat finished;
    if(ready)ready=!fdstat(f,&finished)&&finished.st_ino==own.st_ino&&finished.st_dev==own.st_dev&&finished.st_size==(off_t)nbytes&&finished.st_nlink==1;
    if(closefd(f))ready=0;
    if(ready)ready=unchanged(d,temporary,&finished,0)&&unchanged(d,name,old,absent);
    if(ready&&!moveleaf(d,temporary,name,absent))return syncfd(d)?IQ4_STOCK_JPEG_SETTINGS_IO:IQ4_STOCK_JPEG_SETTINGS_OK;
    /* Delete only the newly-created file, after exact inode validation. */
    struct stat left;if(own_ok&&!leafstat(d,temporary,&left)&&left.st_dev==own.st_dev&&left.st_ino==own.st_ino)unlinkleaf(d,temporary);
    return IQ4_STOCK_JPEG_SETTINGS_IO;
}
enum Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_load_01(struct Iq4StockJpegSettings *out){
    if(!out)return IQ4_STOCK_JPEG_SETTINGS_INVALID;*out=(struct Iq4StockJpegSettings){0,65,1};
    int d=rootfd();if(d<0)return IQ4_STOCK_JPEG_SETTINGS_IO;
    unsigned char bytes[RECORD_SIZE];unsigned nbytes=0;struct stat s;int result=readrecord(d,current,bytes,&nbytes,&s);
    if(result==IQ4_STOCK_JPEG_SETTINGS_OK)decode(bytes,nbytes,out);if(closefd(d))result=IQ4_STOCK_JPEG_SETTINGS_IO;
    if(result!=IQ4_STOCK_JPEG_SETTINGS_OK)*out=(struct Iq4StockJpegSettings){0,65,1};return result;
}
enum Iq4StockJpegSettingsResult iq4_stock_jpeg_settings_save_01(const struct Iq4StockJpegSettings *value){
    if(!values(value))return IQ4_STOCK_JPEG_SETTINGS_INVALID;
    int d=rootfd();if(d<0)return IQ4_STOCK_JPEG_SETTINGS_IO;
    unsigned char previous[RECORD_SIZE],saved_backup[RECORD_SIZE],next[RECORD_SIZE];unsigned previous_n=0,backup_n=0;struct stat old,bak;
    int state=readrecord(d,current,previous,&previous_n,&old),bs=readrecord(d,backup,saved_backup,&backup_n,&bak),result=IQ4_STOCK_JPEG_SETTINGS_IO;
    if(state==IQ4_STOCK_JPEG_SETTINGS_INVALID||bs==IQ4_STOCK_JPEG_SETTINGS_INVALID)result=IQ4_STOCK_JPEG_SETTINGS_INVALID;
    else if((state==IQ4_STOCK_JPEG_SETTINGS_OK||state==IQ4_STOCK_JPEG_SETTINGS_ABSENT)&&(bs==IQ4_STOCK_JPEG_SETTINGS_OK||bs==IQ4_STOCK_JPEG_SETTINGS_ABSENT)){
        encode(next,value);unsigned same_bytes=state==IQ4_STOCK_JPEG_SETTINGS_OK&&previous_n==RECORD_SIZE;
        if(same_bytes)for(unsigned i=0;i<RECORD_SIZE;++i)if(next[i]!=previous[i])same_bytes=0;
        /* A prior rename can have succeeded while its directory fsync failed.
         * An identical-value retry must complete that sync before success. */
        if(same_bytes)result=syncfd(d)?IQ4_STOCK_JPEG_SETTINGS_IO:IQ4_STOCK_JPEG_SETTINGS_OK;
        else if(state==IQ4_STOCK_JPEG_SETTINGS_ABSENT||publish(d,backup,previous,previous_n,&bak,bs==IQ4_STOCK_JPEG_SETTINGS_ABSENT)==IQ4_STOCK_JPEG_SETTINGS_OK)
            result=publish(d,current,next,RECORD_SIZE,&old,state==IQ4_STOCK_JPEG_SETTINGS_ABSENT);
    }
    if(closefd(d))result=IQ4_STOCK_JPEG_SETTINGS_IO;return result;
}
