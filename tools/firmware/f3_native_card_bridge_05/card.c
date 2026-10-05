#include "card.h"
#include <string.h>
#include "signatures.inc"
static uintptr_t sole_task;
static const char client_name[]="Iq4F3Storage05";
static int rd(struct F3Card05*c,uintptr_t p,void*out,size_t n){return p&&n&&p<=UINTPTR_MAX-n&&c->memory.read(c->memory.context,p,out,n)==1;}
static int twice(struct F3Card05*c,uintptr_t p,void*out,size_t n){unsigned char other[512];return n<=sizeof(other)&&rd(c,p,out,n)&&rd(c,p,other,n)&&!memcmp(out,other,n);}
static int signature(struct F3Card05*c){unsigned char chunk[128];for(size_t i=0;i<sizeof(f3_signatures05)/sizeof(f3_signatures05[0]);++i){const struct F3Signature05*s=&f3_signatures05[i];for(size_t off=0;off<s->size;off+=sizeof(chunk)){size_t n=s->size-off;if(n>sizeof(chunk))n=sizeof(chunk);if(!rd(c,s->va+off,chunk,n)||memcmp(chunk,s->data+off,n))return 0;}}return 1;}
static int power_shape(struct F3Card05*c,unsigned i,int require_bit,int require_mode){uintptr_t vt=0,name=0,client=0;uint32_t mask=0,mode=0;uint8_t disabled=1;
 if(!c->power[i]||!twice(c,c->power[i],&vt,8)||vt!=0xdb6628||!twice(c,c->power[i]+0x68,&name,8)||name!=(i?0x9f3fe8:0x9f4000)||!twice(c,c->power[i]+0x178,&disabled,1)||disabled)return 0;
 if(c->registered[i]&&(!twice(c,c->power[i]+0x70+8*c->client[i],&client,8)||client!=(uintptr_t)client_name))return 0;
 if(!twice(c,c->power[i]+0x17c,&mask,4)||!twice(c,c->power[i]+0x320,&mode,4))return 0;
 return (!require_bit||(mask&(1u<<c->client[i])))&&(!require_mode||mode==1);
}
static int owners(struct F3Card05*c){uintptr_t head=0,tail=0,p,seen[128];unsigned count=0;
 if(!twice(c,0x41fc5e8,&head,8)||!twice(c,0x41fc5f0,&tail,8)||!head||!tail)return 0;p=head;
 while(p){if(count==128)return 0;for(unsigned j=0;j<count;++j)if(seen[j]==p)return 0;seen[count++]=p;uintptr_t name=0,next=0,vt=0;if(!twice(c,p+0x68,&name,8)||!twice(c,p+0x170,&next,8)||!twice(c,p,&vt,8))return 0;
  for(unsigned i=0;i<2;++i)if(name==(i?0x9f3fe8:0x9f4000)){if(c->power[i]||vt!=0xdb6628)return 0;c->power[i]=p;}
  if(!next&&p!=tail)return 0;p=next;
 }
 return c->power[0]&&c->power[1];
}
static int root(struct F3Card05*c,uint32_t id,uintptr_t*out,char path[256]){uint8_t row[32],other[256];uintptr_t p=0,vt=0;unsigned index=id==10?11:12;
 if(!twice(c,0xf55cb8+index*32,row,sizeof(row)))return 0;uint32_t actual=0,flag=0;memcpy(&actual,row,4);memcpy(&flag,row+24,4);memcpy(&p,row+16,8);
 if(actual!=id||flag!=2||!p||!twice(c,p,&vt,8)||vt!=0xd91450||!rd(c,p+0x15,path,256)||!rd(c,p+0x15,other,256)||memcmp(path,other,256))return 0;
 const char*expected=id==10?"/run/media/sdcard/":"/run/media/xqdcard/";size_t n=strlen(expected);if(memcmp(path,expected,n+1))return 0;*out=p;return 1;
}
static int root_unchanged(struct F3Card05*c){uintptr_t a,b;char ra[256],ja[256];return root(c,c->raw_id,&a,ra)&&root(c,c->jpeg_id,&b,ja)&&a==c->fs[0]&&b==c->fs[1]&&!memcmp(ra,c->raw_root,256)&&!memcmp(ja,c->jpeg_root,256);}
static int same_dir(const struct F3FdStat*a,const struct F3FdStat*b){return (a->mode&0170000u)==0040000u&&(b->mode&0170000u)==0040000u&&a->device==b->device&&a->inode==b->inode;}
void f3_card_hold_05(struct F3Card05*c){if(c){c->hold=1;c->state=4;}}
static int close_fd(struct F3Card05*c,int*fd){if(*fd<0)return 1;int v=*fd;struct F3SysResult r=c->io.close(v);if(r.value){f3_card_hold_05(c);return 0;}*fd=-1;return 1;}
static int current_root(struct F3Card05*c,const char*path,int held,uint64_t mount,const struct F3FdStat*original){struct F3FdStat a,b;uint64_t hm=0,fm=0;
 if(c->io.stat_fd(held,&a).value||!same_dir(original,&a)||c->io.mount_id(held,&hm,&c->aux_fd).value||hm!=mount)return 0;
 struct F3SysResult o=c->io.open_root(path);if(o.value<0)return 0;c->probe_fd=(int)o.value;
 int ok=!c->io.stat_fd(c->probe_fd,&b).value&&same_dir(&a,&b)&&!c->io.mount_id(c->probe_fd,&fm,&c->aux_fd).value&&fm==mount;
 if(c->aux_fd>=0){f3_card_hold_05(c);return 0;}if(!close_fd(c,&c->probe_fd))return 0;return ok;
}
static int media_parent(struct F3Card05*c,uint64_t*out){struct F3SysResult p=c->io.open_media_parent();if(p.value<0)return 0;c->probe_fd=(int)p.value;struct F3FdStat st;
 int ok=!c->io.stat_fd(c->probe_fd,&st).value&&(st.mode&0170000u)==0040000u&&!c->io.mount_id(c->probe_fd,out,&c->aux_fd).value;
 if(c->aux_fd>=0){f3_card_hold_05(c);return 0;}if(!close_fd(c,&c->probe_fd))return 0;return ok;
}
int f3_card_valid_05(struct F3Card05*c){if(!c||c->state!=2||c->hold||__atomic_load_n(&sole_task,__ATOMIC_ACQUIRE)!=(uintptr_t)c)return 0;
 for(unsigned i=0;i<2;++i)if(c->required[i]&&(!c->requested[i]||!power_shape(c,i,1,1))){f3_card_hold_05(c);return 0;}
 uint64_t parent=0;if(!root_unchanged(c)||!media_parent(c,&parent)||parent!=c->parent_mount||c->raw_mount==parent||c->jpeg_mount==parent||!current_root(c,c->raw_root,c->raw_dir,c->raw_mount,&c->raw_stat)||!current_root(c,c->jpeg_root,c->jpeg_dir,c->jpeg_mount,&c->jpeg_stat)||!root_unchanged(c)){f3_card_hold_05(c);return 0;}
 for(unsigned i=0;i<2;++i)if(c->required[i]&&!power_shape(c,i,1,1)){f3_card_hold_05(c);return 0;}return 1;
}
static uint64_t epoch(void*p){struct F3Card05*c=p;return f3_card_valid_05(c)?c->jpeg_mount:0;}
static int valid(void*p){return f3_card_valid_05(p);}
struct F3CardGuard f3_card_guard_05(struct F3Card05*c){return(struct F3CardGuard){c,epoch,valid};}
static enum F3CardOutcome05 release_requests(struct F3Card05*c){for(unsigned rev=2;rev;--rev){unsigned i=rev-1;if(!c->requested[i])continue;uint32_t mode=0,mask=0;
 if(!power_shape(c,i,1,0)||c->calls.release(c->calls.context,c->power[i],c->client[i],&mode)!=F3_CARD_OK||!power_shape(c,i,0,0)||!twice(c,c->power[i]+0x17c,&mask,4)||(mask&(1u<<c->client[i]))){f3_card_hold_05(c);return F3_CARD_UNKNOWN;}c->requested[i]=0;}
 return F3_CARD_OK;
}
static enum F3CardOutcome05 fail_known(struct F3Card05*c){if(c->hold)return F3_CARD_UNKNOWN;if(!close_fd(c,&c->jpeg_dir)||!close_fd(c,&c->raw_dir)||release_requests(c)!=F3_CARD_OK)return F3_CARD_UNKNOWN;c->state=3;__atomic_store_n(&sole_task,0,__ATOMIC_RELEASE);return F3_CARD_FAIL;}
enum F3CardOutcome05 f3_card_begin_05(struct F3Card05*c,const struct F3CardRead05*m,const struct F3LeaseCalls05*a,const struct F3CardIo05*io,uint32_t rid,uint32_t jid){
 if(!c||c->state||!m||!m->read||!a||!a->register_client||!a->wait_request||!a->release||!io||!io->open_root||!io->open_media_parent||!io->mount_id||!io->stat_fd||!io->close||(rid!=10&&rid!=11)||(jid!=10&&jid!=11))return F3_CARD_FAIL;
 uintptr_t empty=0;if(!__atomic_compare_exchange_n(&sole_task,&empty,(uintptr_t)c,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return F3_CARD_FAIL;
 c->memory=*m;c->calls=*a;c->io=*io;c->raw_id=rid;c->jpeg_id=jid;c->raw_dir=c->jpeg_dir=c->probe_fd=c->aux_fd=-1;c->state=1;c->required[rid-10]=c->required[jid-10]=1;
 if(!signature(c)||!owners(c)||!root(c,rid,&c->fs[0],c->raw_root)||!root(c,jid,&c->fs[1],c->jpeg_root))return fail_known(c);
 for(unsigned i=0;i<2;++i)if(c->required[i]){if(!power_shape(c,i,0,0))return fail_known(c);uintptr_t slots[32];if(!twice(c,c->power[i]+0x70,slots,sizeof(slots)))return fail_known(c);
  unsigned matches=0;for(unsigned j=0;j<32;++j)if(slots[j]==(uintptr_t)client_name){c->client[i]=j;++matches;}
  if(matches>1)return fail_known(c);
  if(!matches&&c->calls.register_client(c->calls.context,c->power[i],client_name,&c->client[i])!=F3_CARD_OK){f3_card_hold_05(c);return F3_CARD_UNKNOWN;}
  if(c->client[i]>=32)return fail_known(c);c->registered[i]=1;
  if(!power_shape(c,i,0,0))return fail_known(c);
  uint32_t wait=0;c->requested[i]=1;enum F3CardOutcome05 r=c->calls.wait_request(c->calls.context,c->power[i],c->client[i],6000,&wait);
  if(r!=F3_CARD_OK||wait>2){f3_card_hold_05(c);return F3_CARD_UNKNOWN;}if(wait||!power_shape(c,i,1,1))return fail_known(c);
 }
 if(!root_unchanged(c)){f3_card_hold_05(c);return F3_CARD_UNKNOWN;}
 if(!media_parent(c,&c->parent_mount))return fail_known(c);
 struct F3SysResult r=io->open_root(c->raw_root);if(r.value<0)return fail_known(c);c->raw_dir=(int)r.value;
 r=io->open_root(c->jpeg_root);if(r.value<0)return fail_known(c);c->jpeg_dir=(int)r.value;
 if(io->stat_fd(c->raw_dir,&c->raw_stat).value||io->stat_fd(c->jpeg_dir,&c->jpeg_stat).value||!same_dir(&c->raw_stat,&c->raw_stat)||!same_dir(&c->jpeg_stat,&c->jpeg_stat)||io->mount_id(c->raw_dir,&c->raw_mount,&c->aux_fd).value||io->mount_id(c->jpeg_dir,&c->jpeg_mount,&c->aux_fd).value){if(c->aux_fd>=0){f3_card_hold_05(c);return F3_CARD_UNKNOWN;}return fail_known(c);}
 if(c->raw_mount==c->parent_mount||c->jpeg_mount==c->parent_mount)return fail_known(c);
 c->state=2;if(!f3_card_valid_05(c))return F3_CARD_UNKNOWN;return F3_CARD_OK;
}
enum F3CardOutcome05 f3_card_close_dirs_05(struct F3Card05*c){if(!f3_card_valid_05(c))return F3_CARD_UNKNOWN;
 if(!close_fd(c,&c->jpeg_dir)||!close_fd(c,&c->raw_dir))return F3_CARD_UNKNOWN;c->state=5;return F3_CARD_OK;
}
enum F3CardOutcome05 f3_card_release_requests_05(struct F3Card05*c){if(!c||c->hold||c->state!=5||c->raw_dir>=0||c->jpeg_dir>=0||__atomic_load_n(&sole_task,__ATOMIC_ACQUIRE)!=(uintptr_t)c)return F3_CARD_UNKNOWN;
 if(release_requests(c)!=F3_CARD_OK)return F3_CARD_UNKNOWN;c->state=3;__atomic_store_n(&sole_task,0,__ATOMIC_RELEASE);return F3_CARD_OK;
}
enum F3CardOutcome05 f3_card_finish_05(struct F3Card05*c){if(f3_card_close_dirs_05(c)!=F3_CARD_OK)return F3_CARD_UNKNOWN;return f3_card_release_requests_05(c);
}
