#include "identity.h"
#include <assert.h>
#include <stdio.h>
static unsigned char bytes[0x218];static int mutate,reads;
static int rd(void*c,uintptr_t p,void*out,size_t n){(void)c;if(p<0x1000||p+n>0x1218)return 0;memcpy(out,bytes+(p-0x1000),n);if(mutate&&++reads==3)bytes[0x15]='!';return 1;}
int main(void){uintptr_t vt=0xd91450;memcpy(bytes,&vt,8);const char*x="/run/media/xqdcard/";memcpy(bytes+0x15,x,strlen(x)+1);
 assert(iq4_f3_same_card_root_01(rd,0,0x1000,11,x)); /* clone address, same root */
 assert(!iq4_f3_same_card_root_01(rd,0,0x1000,10,"/run/media/sdcard/"));
 assert(!iq4_f3_same_card_root_01(rd,0,0x1000,11,"/run/media/sdcard/"));
 bytes[0x15+strlen(x)]='x';assert(!iq4_f3_same_card_root_01(rd,0,0x1000,11,x));bytes[0x15+strlen(x)]=0;
 bytes[0]=0;assert(!iq4_f3_same_card_root_01(rd,0,0x1000,11,x));memcpy(bytes,&vt,8);
 assert(!iq4_f3_same_card_root_01(rd,0,0,11,x));mutate=1;reads=0;assert(!iq4_f3_same_card_root_01(rd,0,0x1000,11,x));puts("PASS 7 native root identity cases");}
