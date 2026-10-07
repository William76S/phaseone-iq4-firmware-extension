#define _GNU_SOURCE
#include "../../src/runtime/ratio_mask_settings.h"
#include <assert.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
const char *iq4_ratio_settings_test_root;
int iq4_ratio_settings_test_ubifs=1;
extern unsigned iq4_ratio_settings_test_sequence(void);
static unsigned calls,fail_call,crash_call,syncs,fail_sync;
int iq4_ratio_settings_test_fault(unsigned op){++calls;if(calls==crash_call)_exit(91);if(op==6&&++syncs==fail_sync)return EIO;return calls==fail_call?EIO:0;}
static char path[128];
static unsigned groups;
static void fresh(void){strcpy(path,"/tmp/iq4-ratio-settings-XXXXXX");assert(mkdtemp(path));iq4_ratio_settings_test_root=path;calls=fail_call=crash_call=syncs=fail_sync=0;iq4_ratio_settings_test_ubifs=1;}
static void cleanup(void){DIR *p=opendir(path);assert(p);struct dirent *e;int d=dirfd(p);while((e=readdir(p))){if(!strcmp(e->d_name,".")||!strcmp(e->d_name,".."))continue;struct stat s;assert(!fstatat(d,e->d_name,&s,AT_SYMLINK_NOFOLLOW));assert(!unlinkat(d,e->d_name,S_ISDIR(s.st_mode)?AT_REMOVEDIR:0));}assert(!closedir(p)&&!rmdir(path));}
static void expect_state(unsigned mode,unsigned opacity,unsigned remembered){struct Iq4RatioMaskSettings s;assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_OK&&s.mode==mode&&s.opacity==opacity&&s.remembered_mode==remembered);}
static void expect(unsigned mode,unsigned opacity){expect_state(mode,opacity,mode?mode:1);}
static void write_leaf(const char *leaf,const void *bytes,size_t n){int d=open(path,O_RDONLY|O_DIRECTORY);assert(d>=0);int f=openat(d,leaf,O_WRONLY|O_CREAT|O_EXCL,0600);assert(f>=0&&write(f,bytes,n)==(ssize_t)n&&!close(f)&&!close(d));}
static void old_state(void){const struct Iq4RatioMaskSettings old={3,25,3};assert(iq4_ratio_settings_save_01(&old)==IQ4_RATIO_SETTINGS_OK);}
static const unsigned char legacy_on[24]={0x49,0x51,0x34,0x52,0x41,0x54,0x49,0x4f,0x01,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x19,0x00,0x00,0x00,0x73,0x7b,0xc4,0x91};
static const unsigned char legacy_off[24]={0x49,0x51,0x34,0x52,0x41,0x54,0x49,0x4f,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x41,0x00,0x00,0x00,0x88,0xc3,0x20,0x0d};
static void exact_leaf(const char *name,const void *bytes,size_t n){unsigned char got[29];int d=open(path,O_RDONLY|O_DIRECTORY),f=openat(d,name,O_RDONLY|O_NOFOLLOW);assert(d>=0&&f>=0&&read(f,got,sizeof got)==(ssize_t)n&&!memcmp(got,bytes,n)&&!close(f)&&!close(d));}
static void seal_record(unsigned char *bytes,unsigned n){uint32_t h=2166136261u;for(unsigned i=0;i<n-4;++i)h=(h^bytes[i])*16777619u;for(unsigned i=0;i<4;++i)bytes[n-4+i]=(unsigned char)(h>>(i*8));}
static void legacy_recoverable(void){struct Iq4RatioMaskSettings got;assert(iq4_ratio_settings_load_01(&got)==IQ4_RATIO_SETTINGS_OK);assert(got.remembered_mode==3&&got.opacity==25&&(got.mode==0||got.mode==3));if(!got.mode)exact_leaf("iq4-ratio-mask.cfg.bak",legacy_on,sizeof legacy_on);}
static void assert_recoverable(void){
    struct Iq4RatioMaskSettings got;assert(iq4_ratio_settings_load_01(&got)==IQ4_RATIO_SETTINGS_OK);
    assert((got.mode==3&&got.opacity==25&&got.remembered_mode==3)||(got.mode==7&&got.opacity==80&&got.remembered_mode==7));
    if(got.mode==7){char b[28];int d=open(path,O_RDONLY|O_DIRECTORY),f=openat(d,"iq4-ratio-mask.cfg.bak",O_RDONLY|O_NOFOLLOW);assert(f>=0&&read(f,b,sizeof b)==28);assert((unsigned char)b[12]==3&&(unsigned char)b[16]==25&&(unsigned char)b[20]==3);assert(!close(f)&&!close(d));}
}
int main(void){
    struct Iq4RatioMaskSettings s;
    fresh();assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_ABSENT&&s.mode==0&&s.opacity==65&&s.remembered_mode==1);++groups;
    for(unsigned mode=0;mode<8;++mode)for(unsigned opacity=0;opacity<=100;opacity+=5){s=(struct Iq4RatioMaskSettings){mode,opacity,mode?mode:1};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);expect(mode,opacity);}groups+=168;
    for(unsigned remembered=1;remembered<=7;++remembered)for(unsigned opacity=0;opacity<=100;opacity+=5){s=(struct Iq4RatioMaskSettings){0,opacity,remembered};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);expect_state(0,opacity,remembered);}groups+=147;
    for(unsigned remembered=1;remembered<=7;++remembered){s=(struct Iq4RatioMaskSettings){remembered,65,remembered};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);s.mode=0;assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);pid_t child=fork();assert(child>=0);if(!child){struct Iq4RatioMaskSettings got;assert(iq4_ratio_settings_load_01(&got)==IQ4_RATIO_SETTINGS_OK&&got.mode==0&&got.remembered_mode==remembered);got.mode=got.remembered_mode;assert(iq4_ratio_settings_save_01(&got)==IQ4_RATIO_SETTINGS_OK);_exit(0);}int status;assert(waitpid(child,&status,0)==child&&WIFEXITED(status)&&WEXITSTATUS(status)==0);expect_state(remembered,65,remembered);++groups;}
    s=(struct Iq4RatioMaskSettings){0,65,0};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);s=(struct Iq4RatioMaskSettings){0,65,8};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);s=(struct Iq4RatioMaskSettings){3,65,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);groups+=3;
    s=(struct Iq4RatioMaskSettings){8,65,1};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);s=(struct Iq4RatioMaskSettings){2,66,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);groups+=2;cleanup();
    const char *bad[]={"wrong magic","","IQ4RATIO\1"};
    for(unsigned i=0;i<3;++i){fresh();write_leaf("iq4-ratio-mask.cfg",bad[i],strlen(bad[i]));assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_INVALID&&s.mode==0&&s.opacity==65&&s.remembered_mode==1);s=(struct Iq4RatioMaskSettings){2,50,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);int d=open(path,O_RDONLY|O_DIRECTORY);struct stat st;assert(!fstatat(d,"iq4-ratio-mask.cfg",&st,0)&&st.st_size==(off_t)strlen(bad[i]));assert(!close(d));++groups;cleanup();}
    fresh();old_state();int d=open(path,O_RDONLY|O_DIRECTORY),f=openat(d,"iq4-ratio-mask.cfg",O_RDWR);char byte;assert(f>=0&&pread(f,&byte,1,16)==1);byte^=1;assert(pwrite(f,&byte,1,16)==1&&!close(f)&&!close(d));assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_INVALID);s=(struct Iq4RatioMaskSettings){2,50,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);++groups;cleanup();
    for(unsigned special=0;special<3;++special){fresh();d=open(path,O_RDONLY|O_DIRECTORY);assert(d>=0);if(!special)assert(!symlinkat("/dev/null",d,"iq4-ratio-mask.cfg"));else if(special==1)assert(!mkdirat(d,"iq4-ratio-mask.cfg",0700));else{write_leaf("foreign","KEEP",4);assert(!linkat(d,"foreign",d,"iq4-ratio-mask.cfg",0));}assert(!close(d));s=(struct Iq4RatioMaskSettings){2,50,2};assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_INVALID&&iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);++groups;cleanup();}
    fresh();old_state();write_leaf("iq4-ratio-mask.cfg.bak","FOREIGN",7);s=(struct Iq4RatioMaskSettings){2,50,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);expect(3,25);++groups;cleanup();
    fresh();old_state();iq4_ratio_settings_test_ubifs=0;assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_IO);s=(struct Iq4RatioMaskSettings){2,50,2};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_IO);iq4_ratio_settings_test_ubifs=1;expect(3,25);++groups;cleanup();
    fresh();char collision[64];assert(snprintf(collision,sizeof collision,".iq4-ratio-mask-%08x-%08x.tmp",(unsigned)getpid(),iq4_ratio_settings_test_sequence()+1)>0);write_leaf(collision,"KEEP",4);s=(struct Iq4RatioMaskSettings){4,90,4};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);expect(4,90);d=open(path,O_RDONLY|O_DIRECTORY);f=openat(d,collision,O_RDONLY);char keep[4];assert(f>=0&&read(f,keep,4)==4&&!memcmp(keep,"KEEP",4)&&!close(f)&&!close(d));++groups;cleanup();
    /* Rename has completed when its final directory fsync fails. A same-value
     * retry must perform that fsync again, not claim success merely from bytes. */
    fresh();old_state();syncs=0;fail_sync=4;s=(struct Iq4RatioMaskSettings){7,80,7};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_IO&&syncs==4);fail_sync=0;expect(7,80);
    syncs=0;fail_sync=1;assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_IO&&syncs==1);fail_sync=0;syncs=0;assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK&&syncs==1);expect(7,80);++groups;cleanup();
    fresh();old_state();calls=0;s=(struct Iq4RatioMaskSettings){7,80,7};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);unsigned total=calls;assert(total>20);cleanup();
    for(unsigned i=1;i<=total;++i){fresh();old_state();calls=0;fail_call=i;s=(struct Iq4RatioMaskSettings){7,80,7};int r=iq4_ratio_settings_save_01(&s);fail_call=0;assert(r==IQ4_RATIO_SETTINGS_IO||r==IQ4_RATIO_SETTINGS_OK);assert_recoverable();++groups;cleanup();}
    for(unsigned i=1;i<=total;++i){fresh();old_state();pid_t child=fork();assert(child>=0);if(!child){calls=0;crash_call=i;s=(struct Iq4RatioMaskSettings){7,80,7};iq4_ratio_settings_save_01(&s);_exit(0);}int status;assert(waitpid(child,&status,0)==child&&WIFEXITED(status));assert_recoverable();++groups;cleanup();}
    for(unsigned variant=0;variant<2;++variant){fresh();const unsigned char *legacy=variant?legacy_off:legacy_on;write_leaf("iq4-ratio-mask.cfg",legacy,24);expect_state(variant?0:3,variant?65:25,variant?1:3);exact_leaf("iq4-ratio-mask.cfg",legacy,24);s=(struct Iq4RatioMaskSettings){0,variant?65:25,variant?1:3};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);expect_state(s.mode,s.opacity,s.remembered_mode);exact_leaf("iq4-ratio-mask.cfg.bak",legacy,24);++groups;cleanup();}
    fresh();write_leaf("iq4-ratio-mask.cfg",legacy_on,24);write_leaf("iq4-ratio-mask.cfg.bak",legacy_off,24);s=(struct Iq4RatioMaskSettings){0,25,3};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);exact_leaf("iq4-ratio-mask.cfg.bak",legacy_on,24);++groups;cleanup();
    fresh();old_state();unsigned char before[28];d=open(path,O_RDONLY|O_DIRECTORY);f=openat(d,"iq4-ratio-mask.cfg",O_RDONLY);assert(read(f,before,28)==28&&!close(f)&&!close(d));s=(struct Iq4RatioMaskSettings){0,25,3};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);exact_leaf("iq4-ratio-mask.cfg.bak",before,28);++groups;cleanup();
    /* Valid checksum does not authorize a future schema or inconsistent
     * enabled/remembered state; preserve their exact existing bytes. */
    for(unsigned invalid=0;invalid<2;++invalid){fresh();old_state();unsigned char bytes[28];d=open(path,O_RDONLY|O_DIRECTORY);f=openat(d,"iq4-ratio-mask.cfg",O_RDWR);assert(read(f,bytes,28)==28);if(invalid)bytes[20]=2;else bytes[8]=3;seal_record(bytes,28);assert(pwrite(f,bytes,28,0)==28&&!close(f)&&!close(d));assert(iq4_ratio_settings_load_01(&s)==IQ4_RATIO_SETTINGS_INVALID&&s.mode==0&&s.remembered_mode==1);s=(struct Iq4RatioMaskSettings){0,25,3};assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_INVALID);exact_leaf("iq4-ratio-mask.cfg",bytes,28);++groups;cleanup();}
    fresh();write_leaf("iq4-ratio-mask.cfg",legacy_on,24);s=(struct Iq4RatioMaskSettings){0,25,3};calls=0;assert(iq4_ratio_settings_save_01(&s)==IQ4_RATIO_SETTINGS_OK);unsigned migration_total=calls;cleanup();
    for(unsigned i=1;i<=migration_total;++i){fresh();write_leaf("iq4-ratio-mask.cfg",legacy_on,24);calls=0;fail_call=i;s=(struct Iq4RatioMaskSettings){0,25,3};int r=iq4_ratio_settings_save_01(&s);fail_call=0;assert(r==IQ4_RATIO_SETTINGS_IO||r==IQ4_RATIO_SETTINGS_OK);legacy_recoverable();++groups;cleanup();}
    for(unsigned i=1;i<=migration_total;++i){fresh();write_leaf("iq4-ratio-mask.cfg",legacy_on,24);pid_t child=fork();assert(child>=0);if(!child){calls=0;crash_call=i;s=(struct Iq4RatioMaskSettings){0,25,3};iq4_ratio_settings_save_01(&s);_exit(0);}int status;assert(waitpid(child,&status,0)==child&&WIFEXITED(status));legacy_recoverable();++groups;cleanup();}
    printf("PASS %u groups: 168 save/reload pairs, 147 remembered-off states, 7 process reopen toggles, v1/v2 exact-byte backup migration, invalid/special-file preservation, UBIFS gate, stale temp preserved, identical-value durability retry, %u update failures/interruptions + %u migration failures/interruptions; host filesystem only\n",groups,total,migration_total);
    return 0;
}
