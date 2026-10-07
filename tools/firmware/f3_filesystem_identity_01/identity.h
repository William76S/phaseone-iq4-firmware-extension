#ifndef IQ4_F3_FILESYSTEM_IDENTITY_01
#define IQ4_F3_FILESYSTEM_IDENTITY_01
#include <stdint.h>
#include <stddef.h>
#include <string.h>
typedef int (*Iq4FsRead01)(void*,uintptr_t,void*,size_t);
/* Registry ownership/mount identity remains checked by f3_card_valid_05.
 * Permit a separate native filesystem object only for manual Gallery input.
 * Compare its native root, never its mutable current directory or pointer
 * identity alone. No native allocation, setter or filesystem operation. */
static int iq4_f3_same_card_root_01(Iq4FsRead01 read,void*ctx,uintptr_t fs,uint32_t id,const char*root){
 if(!read||!fs||(fs&7)||fs>UINTPTR_MAX-0x115||!root||(id!=10&&id!=11))return 0;
 const char*expected=id==10?"/run/media/sdcard/":"/run/media/xqdcard/";
 size_t n=strlen(expected)+1;for(size_t i=0;i<n;++i)if(root[i]!=expected[i])return 0;
 uintptr_t a=0,b=0;char x[32],y[32];
 if(read(ctx,fs,&a,8)!=1||read(ctx,fs,&b,8)!=1||a!=0xd91450||a!=b)return 0;
 if(read(ctx,fs+0x15,x,n)!=1||read(ctx,fs+0x15,y,n)!=1||memcmp(x,y,n)||memcmp(x,expected,n))return 0;
 return read(ctx,fs,&b,8)==1&&b==a;
}
#endif
