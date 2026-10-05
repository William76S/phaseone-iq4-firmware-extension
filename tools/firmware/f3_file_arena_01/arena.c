#include "arena.h"
#include <string.h>
#define TYPEMASK 0170000u
#define DIRECTORY 0040000u
#define REGULAR 0100000u
static enum F3ArenaStatus held(struct F3Arena *a) {
 if(a) a->hold=1;
 return F3_ARENA_HOLD;
}
static int same(const struct F3FdStat *a,const struct F3FdStat *b) {
 return a->device==b->device && a->inode==b->inode &&
        (a->mode&TYPEMASK)==(b->mode&TYPEMASK);
}
static int live(struct F3Arena *a) {
 struct F3FdStat d;
 return a && !a->hold && a->guard.actual_epoch && a->guard.native_owner_valid &&
  a->guard.actual_epoch(a->guard.context)==a->epoch &&
  a->guard.native_owner_valid(a->guard.context)==1 &&
  a->api.io.stat_fd(a->dirfd,&d).value==0 && same(&d,&a->directory);
}
static int own_file(struct F3Arena *a,uint64_t bytes) {
 struct F3FdStat f,p;
 if(a->fd<0 || a->api.io.stat_fd(a->fd,&f).value ||
    a->api.io.stat_leaf(a->dirfd,a->leaf,&p).value) return 0;
 return same(&f,&a->file) && same(&f,&p) &&
  (f.mode&TYPEMASK)==REGULAR && f.nlink==1 && p.nlink==1 &&
  f.size==bytes && p.size==bytes;
}
static enum F3ArenaStatus io_failure(struct F3Arena *a) {
 return live(a)?F3_ARENA_IO:held(a);
}
static void leaf(char *b,uint64_t id,uint64_t nonce) {
 const char hex[]="0123456789abcdef"; unsigned n=0;
 const char *prefix=".iq4-arena-",*suffix=".tmp";
 while(*prefix) b[n++]=*prefix++;
 for(int i=15;i>=0;--i) b[n++]=hex[(id>>(4*i))&15];
 b[n++]='-';
 for(int i=15;i>=0;--i) b[n++]=hex[(nonce>>(4*i))&15];
 while(*suffix) b[n++]=*suffix++;
 b[n]=0;
}
enum F3ArenaStatus f3_arena_create_01(struct F3Arena *a,
 const struct F3ArenaApi *p,const struct F3CardGuard *g,int dir,
 uint64_t epoch,uint64_t id,uint64_t nonce,uint64_t bytes,
 uint8_t *zero,size_t cap) {
 struct F3SysResult r;
 if(!a || !p || !g || !zero || cap<F3_ARENA_ZERO_BYTES || dir<0 ||
    !epoch || !id || !nonce || !bytes || bytes>F3_ARENA_MAX_BYTES ||
    (bytes&4095) || !g->actual_epoch || !g->native_owner_valid ||
    !p->io.open_leaf || !p->io.stat_fd || !p->io.stat_leaf ||
    !p->io.write || !p->io.sync || !p->io.close || !p->io.unlink_leaf ||
    !p->truncate || !p->allocate || !p->map_shared || !p->flush_map || !p->unmap)
  return F3_ARENA_ARGUMENT;
 if(a->state!=F3_ARENA_EMPTY || a->hold) return F3_ARENA_STATE;
 a->api=*p; a->guard=*g; a->dirfd=dir; a->fd=-1;
 a->epoch=epoch; a->capture_id=id; a->nonce=nonce; a->bytes=bytes;
 if(p->io.stat_fd(dir,&a->directory).value ||
    (a->directory.mode&TYPEMASK)!=DIRECTORY) return F3_ARENA_ARGUMENT;
 if(!live(a)) return held(a);
 leaf(a->leaf,id,nonce);
 r=p->io.open_leaf(dir,a->leaf,1);
 if(r.value<0) return io_failure(a);
 a->fd=(int)r.value; a->state=F3_ARENA_CREATED;
 if(p->io.stat_fd(a->fd,&a->file).value || !own_file(a,0) || !live(a)) return held(a);
 r=p->allocate(a->fd,bytes);
 if(!live(a)) return held(a);
 if(r.value==-2) {
  /* A sparse truncate is not a reservation. Write every byte on unsupported
   * filesystems, checking real counts and lease on both sides of each call. */
  if(p->truncate(a->fd,0).value) return io_failure(a);
  if(!live(a)) return held(a);
  memset(zero,0,F3_ARENA_ZERO_BYTES);
  for(uint64_t done=0;done<bytes;) {
   uint32_t n=(uint32_t)((bytes-done)>F3_ARENA_ZERO_BYTES?
                         F3_ARENA_ZERO_BYTES:(bytes-done));
   if(!live(a)) return held(a);
   r=p->io.write(a->fd,zero,n);
   if(!live(a)) return held(a);
   if(r.value<=0 || r.value>n) return F3_ARENA_IO;
   done+=(uint64_t)r.value;
  }
  a->reservation_method=2;
 } else if(r.value!=0) return io_failure(a);
 else a->reservation_method=1;
 if(!live(a)) return held(a);
 if(p->truncate(a->fd,bytes).value || p->io.sync(a->fd).value) return io_failure(a);
 if(!own_file(a,bytes) || !live(a)) return held(a);
 a->state=F3_ARENA_RESERVED;
 r=p->map_shared(a->fd,bytes);
 if(r.value==-1) return io_failure(a);
 /* mmap is already live if successful. Save it before another guard, so an
   * epoch loss cannot hide a mapping from quarantine/diagnostic state. */
 a->base=(void*)(uintptr_t)(uint64_t)r.value; a->state=F3_ARENA_MAPPED;
 if(!a->base || ((uintptr_t)a->base&4095) || !live(a)) return held(a);
 return F3_ARENA_OK;
}
enum F3ArenaStatus f3_arena_loan_01(struct F3Arena *a,void **base,uint64_t *bytes) {
 if(!a || !base || !bytes) return F3_ARENA_ARGUMENT;
 *base=0; *bytes=0;
 if(a->hold || !live(a)) return held(a);
 if(a->state!=F3_ARENA_MAPPED || a->loan_active) return F3_ARENA_STATE;
 if(!own_file(a,a->bytes) || !live(a)) return held(a);
 a->loan_active=1; *base=a->base; *bytes=a->bytes; return F3_ARENA_OK;
}
enum F3ArenaStatus f3_arena_end_loan_01(struct F3Arena *a) {
 if(!a) return F3_ARENA_ARGUMENT;
 if(a->hold || !live(a)) return held(a);
 if(a->state!=F3_ARENA_MAPPED || !a->loan_active) return F3_ARENA_STATE;
 if(!own_file(a,a->bytes) || !live(a)) return held(a);
 a->loan_active=0; return F3_ARENA_OK;
}
enum F3ArenaStatus f3_arena_release_01(struct F3Arena *a) {
 struct F3FdStat f,p;
 if(!a) return F3_ARENA_ARGUMENT;
 if(a->hold || !live(a)) return held(a);
 if(a->loan_active) return F3_ARENA_BUSY;
 if(a->state<F3_ARENA_CREATED || a->state>F3_ARENA_MAPPED || a->fd<0)
  return F3_ARENA_STATE;
 /* Partial reservation is still owned; never identify it by assumed length. */
 if(a->api.io.stat_fd(a->fd,&f).value ||
    a->api.io.stat_leaf(a->dirfd,a->leaf,&p).value || !same(&f,&a->file) ||
    !same(&f,&p) || f.nlink!=1 || p.nlink!=1 || !live(a)) return held(a);
 if(a->state==F3_ARENA_MAPPED) {
  if(a->api.flush_map(a->base,a->bytes).value) return io_failure(a);
  if(!live(a)) return held(a);
  if(a->api.unmap(a->base,a->bytes).value) return held(a);
  a->base=0; a->state=F3_ARENA_RESERVED;
  if(!live(a)) return held(a);
 }
 /* Sole private namespace owner remains held across stat/unlink; not an
  * inode-conditional unlink. No other source/RAW/output path is touched. */
 if(a->api.io.unlink_leaf(a->dirfd,a->leaf).value) return io_failure(a);
 if(!live(a)) return held(a);
 if(a->api.io.close(a->fd).value) return held(a);
 a->fd=-1; a->state=F3_ARENA_RELEASED;
 if(!live(a)) return held(a);
 if(a->api.io.sync(a->dirfd).value) return io_failure(a);
 return live(a)?F3_ARENA_OK:held(a);
}
