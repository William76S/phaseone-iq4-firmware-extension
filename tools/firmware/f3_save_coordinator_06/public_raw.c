#include "public_raw.h"
#include "../f3_stream_transaction_02/sha256.h"
#include <string.h>
#include <limits.h>
static int valid(const struct F3CardGuard*g,uint64_t e){return g&&g->actual_epoch&&g->native_owner_valid&&g->native_owner_valid(g->context)==1&&g->actual_epoch(g->context)==e;}
static int hold(struct F3PublicRaw06*s){s->hold=1;s->state=3;return F3_PUBLIC_HOLD06;}
static int same(const struct F3FdStat*a,const struct F3FdStat*b){return a->device==b->device&&a->inode==b->inode&&a->size==b->size&&a->mode==b->mode&&a->nlink==b->nlink&&a->mtime_sec==b->mtime_sec&&a->mtime_nsec==b->mtime_nsec;}
static int hash(struct F3PublicRaw06*s,const struct F3Posix*p,const struct F3CardGuard*g,uint64_t epoch,int dir,int fd,const char*leaf,const struct F3CapturedRaw01*c,uint8_t*scratch,size_t cap){
 struct F3FdStat a,b,n;F4Sha h;char digest[65];
 if(!valid(g,epoch))return hold(s);
 if(p->stat_fd(fd,&a).value||p->stat_leaf(dir,leaf,&n).value)return hold(s);
 if(!same(&a,&c->final_stat)||!same(&a,&n))return F3_PUBLIC_PRESERVED06;
 f4_sha_init(&h);for(uint64_t off=0;off<a.size;){uint64_t remaining=a.size-off;uint32_t count=remaining>cap?(uint32_t)cap:(uint32_t)remaining;
  if(!valid(g,epoch))return hold(s);struct F3SysResult r=p->read_at(fd,scratch,count,off);
  if(!valid(g,epoch)||r.value!=count)return hold(s);f4_sha_update(&h,scratch,count);off+=count;}
 if(p->read_at(fd,scratch,1,a.size).value!=0||!valid(g,epoch))return hold(s);
 f4_sha_end(&h,digest);
 if(p->stat_fd(fd,&b).value||p->stat_leaf(dir,leaf,&n).value||!valid(g,epoch))return hold(s);
 return same(&a,&b)&&same(&b,&n)&&!memcmp(digest,c->sha256,65)?1:0;
}
int f3_public_discard_06(struct F3PublicRaw06*s,const struct F3Posix*p,const struct F3CardGuard*g,uint64_t epoch,int dir,uint64_t generation,const struct F3CapturedRaw01*c,uint32_t published,uint8_t*scratch,size_t cap){
 if(!s||s->hold)return F3_PUBLIC_HOLD06;
 if(s->state||!p||!p->open_leaf||!p->stat_fd||!p->stat_leaf||!p->read_at||!p->sync||!p->close||!p->move_noreplace||!p->unlink_leaf||!epoch||dir<0||!generation||!c||!scratch||!cap||cap>UINT32_MAX||!published||c->hold||c->parent_dir!=dir||!c->exclusive_created||!c->writer_bound||!c->close_success||!c->store_success||c->writer_fd>=0||c->raw_fd<0||!c->final_stat.size||c->sha256[64])return F3_PUBLIC_PRESERVED06;
 for(unsigned i=0;i<64;++i)if(!((c->sha256[i]>='0'&&c->sha256[i]<='9')||(c->sha256[i]>='a'&&c->sha256[i]<='f')))return F3_PUBLIC_PRESERVED06;
 int fresh=hash(s,p,g,epoch,dir,c->raw_fd,c->leaf,c,scratch,cap);if(fresh!=1)return fresh;
 s->quarantine_fd=-1;s->state=1;const char*prefix=".iq4-f3-discard-";unsigned n=0;while(*prefix)s->quarantine_leaf[n++]=*prefix++;
 static const char hx[]="0123456789abcdef";for(int i=15;i>=0;--i)s->quarantine_leaf[n++]=hx[(generation>>(i*4))&15];memcpy(s->quarantine_leaf+n,".tmp",5);
 struct F3SysResult r=p->move_noreplace(dir,c->leaf,s->quarantine_leaf);
 if(r.value)return valid(g,epoch)?F3_PUBLIC_PRESERVED06:hold(s);
 if(!valid(g,epoch))return hold(s);
 r=p->open_leaf(dir,s->quarantine_leaf,0);
 if(r.value>=0&&r.value<=INT_MAX)s->quarantine_fd=(int)r.value;else return hold(s);
 fresh=hash(s,p,g,epoch,dir,s->quarantine_fd,s->quarantine_leaf,c,scratch,cap);
 if(fresh!=1){
  /* A public rename may have selected a replacement. Never unlink it. */
  if(!s->hold&&valid(g,epoch)){s->restore_attempted=1;r=p->move_noreplace(dir,s->quarantine_leaf,c->leaf);s->restore_succeeded=r.value==0;}
  return hold(s);
 }
 if(p->sync(dir).value||!valid(g,epoch))return hold(s);
 /* Only our exclusive private name is used here. Same activity namespace stays
  * serialized through unlink. No foreign user filename is deleted. */
 if(p->unlink_leaf(dir,s->quarantine_leaf).value)return hold(s);
 if(!valid(g,epoch)||p->sync(dir).value)return hold(s);
 if(p->close(s->quarantine_fd).value)return hold(s);
 s->quarantine_fd=-1; /* close returned before the next owner check */
 if(!valid(g,epoch))return hold(s);s->state=2;return F3_PUBLIC_REMOVED06;
}
