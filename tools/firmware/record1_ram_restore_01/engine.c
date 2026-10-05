/* Opaque existing record1 only. No decoder, scalar PIN/key/level/counter API.
 * All buffers are bounded owned snapshots; every writer invocation is16B.
 */
#include "engine.h"
#include "../f4_ram_entry_02/sha256.h"
#include <string.h>
static void r1_hash(const uint8_t *b,char h[65]){F4Sha s;f4_sha_init(&s);f4_sha_update(&s,b,R1_EXTENT);f4_sha_end(&s,h);}
static int r1_digest(const uint8_t *b,const char *expected){char h[65];r1_hash(b,h);return !strcmp(h,expected);}
int r1_locate_existing(const uint8_t *b,uint32_t *offset){
 const uint8_t *s=b+0x400;static const uint8_t magic[6]={0xfe,0x12,1,0,0x14,0};
 if(memcmp(s,magic,sizeof(magic)))return 0;uint8_t seen[256]={0};uint32_t p=20,found=0;
 while(p<0x800){uint8_t key=s[p];if(key==255){if(found){*offset=found;return 1;}return 0;}
  if(p+2>=0x800)return 0;uint32_t len=s[p+1],end=p+2+len;
  if(!len||seen[key]||end>0x7ff||(key==1&&len!=16)||(key==23&&len!=4)||(key==24&&len!=1))return 0;
  seen[key]=1;if(key==1)found=0x400+p+2;p=end;
 }return 0;
}
static int r1_pair(const R1IO *io,uint8_t *a,uint8_t *b){return io->read_whole(io->context,a)&&io->read_whole(io->context,b)&&!memcmp(a,b,R1_EXTENT);}
static int r1_other_original(const R1Config *c,uint8_t *image){
 uint8_t saved[16];memcpy(saved,image+c->offset,16);memcpy(image+c->offset,c->original,16);
 int okay=r1_digest(image,c->whole_sha);memcpy(image+c->offset,saved,16);return okay;
}
static int r1_shape(const R1Config *c,const uint8_t *image){uint32_t p=0;return r1_locate_existing(image,&p)&&p==c->offset;}
R1Result r1_run(const R1Config *c,const R1IO *io,enum R1Action action){
 R1Result r={0};uint8_t a[R1_EXTENT],b[R1_EXTENT],wanted[16];char observed_before[65];
 if(!c||!io||!io->read_whole||!io->write16||c->extent!=R1_EXTENT||c->offset<0x414||c->offset>0xbff-16||c->whole_sha[64]||action<R1_PREFLIGHT||action>R1_RESTORE)return r;
 for(unsigned i=0;i<64;i++)if(!((c->whole_sha[i]>='0'&&c->whole_sha[i]<='9')||(c->whole_sha[i]>='a'&&c->whole_sha[i]<='f')))return r;
 r.input_valid=1;
 if(!r1_pair(io,a,b))return r;r.read_stable=1;
 if(!r1_shape(c,a))return r;r.existing_record1=1;
 r.before_original=r1_digest(a,c->whole_sha);
 r1_hash(a,observed_before);
 r.other_bytes_original=r1_other_original(c,a);if(!r.other_bytes_original)return r;
 if(action==R1_PREFLIGHT){r.success=1;return r;}
 if(!c->write_enabled)return r;
 if(action!=R1_RESTORE&&!r.before_original)return r;
 memcpy(wanted,c->original,16);if(action==R1_CLEAR)memset(wanted,255,16);
 /* Read twice again immediately before the one bounded write. Any change
  * aborts, even if it affects only the permitted payload. */
 if(!r1_pair(io,b,a)||!r1_digest(a,observed_before)||!r1_shape(c,a)||!r1_other_original(c,a))return r;
 if(action!=R1_RESTORE&&!r1_digest(a,c->whole_sha))return r;
 r.write_attempted=1;r.write_count_exact=io->write16(io->context,c->offset,wanted)==16;
 int stable=r1_pair(io,a,b);
 if(stable&&r1_shape(c,a)&&r1_other_original(c,a)&&!memcmp(a+c->offset,wanted,16)){
  r.readback_verified=1;r.success=r.write_count_exact;
  if(action==R1_SAME_ORIGINAL)r.same_original_transport_verified=r.success;
  if(action==R1_RESTORE)r.restore_transport_verified=r.success;
  if(action==R1_CLEAR)r.clear_payload_verified=r.success;
  /* An error reported after bytes changed never becomes successful action. */
  if(r.success||action!=R1_CLEAR)return r;
 }
 /* A failed clear may restore the original16 exactly once, only if actual
  * full readback proves every other byte/header/record still original.
  * No whole-image write, repeated clear, blind retry or foreign overwrite. */
 if(action!=R1_CLEAR||!stable||!r1_shape(c,a)||!r1_other_original(c,a))return r;
 if(r1_digest(a,c->whole_sha)){r.original_after_failure_verified=1;return r;}
 r.rollback_attempted=1;long count=io->write16(io->context,c->offset,c->original);
 if(count==16&&r1_pair(io,a,b)&&r1_shape(c,a)&&r1_digest(a,c->whole_sha))r.rollback_verified=1;
 return r;
}
