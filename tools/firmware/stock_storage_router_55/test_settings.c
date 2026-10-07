#define _GNU_SOURCE
#include "settings.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
const char *iq4_storage55_settings_test_root;
int iq4_storage55_settings_test_ubifs=1;
int iq4_storage55_settings_test_fault(unsigned op){(void)op;return 0;}
int main(void){char root[]="/tmp/iq4-storage55-config-XXXXXX";assert(mkdtemp(root));iq4_storage55_settings_test_root=root;
 struct Iq4Storage55Settings current={99,99,99};assert(iq4_storage55_settings_load_01(&current)==IQ4_STORAGE55_SETTINGS_ABSENT&&current.mode==0);
 for(unsigned mode=0;mode<3;++mode){struct Iq4Storage55Settings s={mode,65,1};assert(iq4_storage55_settings_save_01(&s)==IQ4_STORAGE55_SETTINGS_OK);assert(iq4_storage55_settings_load_01(&current)==IQ4_STORAGE55_SETTINGS_OK&&current.mode==mode);}
 struct Iq4Storage55Settings bad={3,65,1};assert(iq4_storage55_settings_save_01(&bad)==IQ4_STORAGE55_SETTINGS_INVALID);assert(iq4_storage55_settings_load_01(&current)==IQ4_STORAGE55_SETTINGS_OK&&current.mode==2);
 char path[256];snprintf(path,sizeof path,"%s/iq4-storage55.cfg",root);assert(!unlink(path));assert(!symlink("unrelated-private-config",path));assert(iq4_storage55_settings_save_01(&current)==IQ4_STORAGE55_SETTINGS_INVALID);assert(!unlink(path));snprintf(path,sizeof path,"%s/iq4-storage55.cfg.bak",root);assert(!unlink(path));assert(!rmdir(root));
 puts("PASS format0/1/2 atomic config roundtrip; invalid choice/symlink refused in isolated temp directory");}
