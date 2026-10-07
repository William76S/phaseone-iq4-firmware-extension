#define _GNU_SOURCE
#include "settings.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
const char*iq4_stock_jpeg_settings_test_root;int iq4_stock_jpeg_settings_test_ubifs=1;
int iq4_stock_jpeg_settings_test_fault(unsigned op){(void)op;return 0;}
int main(void){char root[]="/tmp/iq4-stock-settings.XXXXXX";assert(mkdtemp(root));iq4_stock_jpeg_settings_test_root=root;char sentinel[256];snprintf(sentinel,sizeof sentinel,"%s/iq4-ratio-mask.cfg",root);int fd=open(sentinel,O_CREAT|O_EXCL|O_WRONLY,0600);const char prior[]="independent ratio configuration";assert(fd>=0&&write(fd,prior,sizeof prior)==sizeof prior&&!close(fd));
 struct Iq4StockJpegSettings s={9,9,9};assert(iq4_stock_jpeg_settings_load_01(&s)==IQ4_STOCK_JPEG_SETTINGS_ABSENT&&s.mode==0&&s.opacity==65&&s.remembered_mode==1);s.mode=1;assert(iq4_stock_jpeg_settings_save_01(&s)==IQ4_STOCK_JPEG_SETTINGS_OK);s.mode=0;assert(iq4_stock_jpeg_settings_load_01(&s)==IQ4_STOCK_JPEG_SETTINGS_OK&&s.mode==1);fd=open(sentinel,O_RDONLY);char b[64]={0};assert(fd>=0&&read(fd,b,sizeof b)==sizeof prior&&!memcmp(b,prior,sizeof prior)&&!close(fd));char cleanup[320];snprintf(cleanup,sizeof cleanup,"rm -rf -- '%s'",root);assert(!system(cleanup));puts("PASS own atomic destination config reload; ratio config unchanged; UBIFS host fixture explicit");}
