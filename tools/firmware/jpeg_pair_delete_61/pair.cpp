#include "pair.h"
#include "pins.h"
#include "../native_runtime_01/self_read.h"
#include <stddef.h>
#include <string.h>
#include <sys/stat.h>

#ifndef IQ4_JPEG_PAIR_TEST
static_assert(sizeof(struct stat)==128&&offsetof(struct stat,st_mode)==16,"original A64 Linux __xstat version 0 layout");
#endif

/* Original DeleteFile has already removed its catalog record at these sites.
 * Never look up the retired index, retain the freed node, request another card,
 * or derive a path from the user's current format/destination selection. */
#ifdef IQ4_JPEG_PAIR_TEST
extern "C" uintptr_t iq4_pair_test_call_61(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t);
#endif
static uintptr_t call(uintptr_t pc,uintptr_t a=0,uintptr_t b=0,uintptr_t c=0,uintptr_t d=0){
#ifdef IQ4_JPEG_PAIR_TEST
 return iq4_pair_test_call_61(pc,a,b,c,d);
#else
 return ((uintptr_t(*)(uintptr_t,uintptr_t,uintptr_t,uintptr_t))pc)(a,b,c,d);
#endif
}
static int rd(uintptr_t p,void*out,size_t n){return p>=4096&&n&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(nullptr,p,out,n)==1;}
template<class T>static int stable(uintptr_t p,T*out){T second;return rd(p,out,sizeof(T))&&rd(p,&second,sizeof(T))&&!memcmp(out,&second,sizeof(T));}
static int exact_pins(){
 for(const auto&p:JpegPairPins61){unsigned char bytes[64];
  if(p.bytes>sizeof bytes||!rd(p.address,bytes,p.bytes)||memcmp(bytes,p.expected,p.bytes))return 0;
 }return 1;
}
static int fail(uintptr_t sp){
 /* These are genuine native DeleteFile stack slots. The later native popup,
  * File.close/dtor and timing cleanup remain on the original control flow. */
 unsigned char zero=0;
 if(sp>=4096&&sp<=UINTPTR_MAX-0x140){memcpy((void*)(sp+0x12b),&zero,1);memcpy((void*)(sp+0x13f),&zero,1);}
 return 0;
}
static int string_at(uintptr_t p,char*out,size_t n){return rd(p,out,n)&&memchr(out,0,n);}
static int clean_relative(const char*s){
 if(!s[0]||strchr(s,'\\'))return 0;
 if(s[0]=='/')++s;if(!s[0])return 0;
 for(const char*p=s;*p;++p)if((unsigned char)*p<32||(*p=='.'&&(p==s||p[-1]=='/')&&(p[1]==0||p[1]=='/'||(p[1]=='.'&&(p[2]==0||p[2]=='/')))))return 0;
 return 1;
}
static int stat_path(const char*path,struct stat*out,int*error){
 memset(out,0,sizeof *out);int rc=(int)call(0x9ef138,(uintptr_t)path,(uintptr_t)out);
 if(rc==0){*error=0;return 1;}
 if(rc!=-1)return 0;
 uintptr_t ep=call(0x40a4e0);return stable(ep,error)?-1:0;
}
extern "C" int iq4_jpeg_pair_raw_delete_61(uintptr_t raw_file,uintptr_t sp,uint32_t card){
 if(sp<4096||sp>UINTPTR_MAX-0x140||(card!=10&&card!=11))return 0;
 try{
  uintptr_t cat,fs,dir,vt,file_fs;char root[32],directory[64],relative[64],base[32],expected[64],absolute[256];
  unsigned char local_raw=0,file_open=0;uint32_t fd=0;
  if(!exact_pins()||!stable(sp+0x28,&cat)||cat>UINTPTR_MAX-0x800||
     !stable(cat,&vt)||vt!=0xb7ece0||
     !stable(sp+(card==11?0x121:0x122),&local_raw)||local_raw!=1||
     !stable(cat+(card==11?0x7d0:0x7a0),&fs)||!stable(fs,&vt)||vt!=0xd91450||
     !stable(cat+(card==11?0x7e0:0x7b0),&dir)||
     !stable(raw_file,&vt)||vt!=0xd90410||!stable(raw_file+8,&file_fs)||file_fs!=fs||
     !stable(raw_file+0x14,&file_open)||file_open!=1||!stable(raw_file+0x10,&fd)||fd>0x7fffffff||
     !string_at(fs+0x15,root,sizeof root)||strcmp(root,card==11?"/run/media/xqdcard/":"/run/media/sdcard/")||
     !string_at(dir,directory,sizeof directory)||!clean_relative(directory)||
     !string_at(sp+0x58,relative,sizeof relative)||!clean_relative(relative)||
     !string_at(sp+0x38,base,sizeof base)||!base[0]||strchr(base,'/')||strchr(base,'\\')||strchr(base,'.'))return fail(sp);
  const size_t dn=strlen(directory),bn=strlen(base);if(dn+bn+6>=sizeof expected)return fail(sp);
  memcpy(expected,directory,dn);expected[dn]='/';memcpy(expected+dn+1,base,bn);memcpy(expected+dn+bn+1,".IIQ",5);
  if(strcmp(expected,relative))return fail(sp);
  memcpy(relative+strlen(relative)-4,".JPG",5);memset(absolute,0,sizeof absolute);
  if(call(0x827348,fs,(uintptr_t)relative,(uintptr_t)absolute)!=1||!memchr(absolute,0,sizeof absolute)||
     memcmp(absolute,root,strlen(root))||!clean_relative(absolute+strlen(root)))return fail(sp);
  struct stat image;int error=0;int exists=stat_path(absolute,&image,&error);
  if(exists==0||(exists<0&&error!=2))return fail(sp);
  if(exists>0){
   if(!S_ISREG(image.st_mode)||call(0x826a8c,fs,(uintptr_t)relative)!=1)return fail(sp);
   exists=stat_path(absolute,&image,&error);if(exists!=-1||error!=2)return fail(sp);
  }
  /* No companion or a successfully removed companion: invoke the exact native
   * RAW deletion once. Its result was ignored by the stock caller; we check it. */
  if(call(0x82595c,raw_file)!=1)return fail(sp);
  unsigned char zero=0;memcpy((void*)(sp+(card==11?0x11f:0x120)),&zero,1);
  return 1;
 }catch(...){return fail(sp);}
}

/* The native record has already been removed, so the registry API compares
 * cached identity/name only. It never dereferences the retired node. */
extern "C" int iq4_stock_jpeg_gallery_delete_card_61(uintptr_t,uintptr_t,const char*,uint32_t*);
extern "C" int iq4_stock_jpeg_gallery_delete_path_61(uintptr_t,uintptr_t,const char*,uint32_t,const char*);
extern "C" int iq4_stock_jpeg_gallery_forget_deleted_61(uintptr_t,uintptr_t,const char*,uint32_t);
static int only_failure(uintptr_t sp){fail(sp);try{call(0x8bf7e4,260);}catch(...){}return 0;}
extern "C" int iq4_jpeg_only_delete_61(uintptr_t sp){
 if(sp<4096||sp>UINTPTR_MAX-0x140)return 0;
 unsigned char xqd=0,sd=0,jpeg=0,eligible=0;char name[32];
 /* Ordinary RAW and non-JPEG records keep the exact factory getter branch. */
 if(!stable(sp+0x121,&xqd)||!stable(sp+0x122,&sd)||xqd||sd||
    !stable(sp+0x120,&jpeg)||!jpeg||!stable(sp+0x123,&eligible)||eligible>1||
    !string_at(sp+0x38,name,sizeof name))return 0;
 size_t nn=strlen(name);if(nn<5||nn>12||memcmp(name+nn-4,".JPG",5))return 0;
 /* Own this single true-JPEG record. In all outcomes suppress the native
  * fixed-SD branches; a registry rejection must not fall back onto another card. */
 unsigned char zero=0;memcpy((void*)(sp+0x123),&zero,1);
 uintptr_t power=0;uint32_t token=32;bool requested=false;int good=0;
 try{
  uintptr_t cat,node,fs,dir,vt;uint32_t card=0,mask=0;char root[32],directory[64],relative[80],absolute[260];
  if(!exact_pins()||!stable(sp+0x28,&cat)||cat>UINTPTR_MAX-0x800||!stable(cat,&vt)||vt!=0xb7ece0||
     !stable(sp+0x110,&node)||iq4_stock_jpeg_gallery_delete_card_61(cat,node,name,&card)!=1||
     (card!=10&&card!=11)||!stable(cat+(card==11?0x7d0:0x7a0),&fs)||!stable(fs,&vt)||vt!=0xd91450||
     !stable(cat+(card==11?0x7e0:0x7b0),&dir)||!string_at(dir,directory,sizeof directory)||!clean_relative(directory)||
     !string_at(fs+0x15,root,sizeof root)||strcmp(root,card==11?"/run/media/xqdcard/":"/run/media/sdcard/")||
     !stable(cat+(card==11?0x7b8:0x788),&power)||!stable(power,&vt)||vt!=0xdb6628||
     !stable(cat+(card==11?0x7c0:0x790),&token)||token>=32||!stable(power+0x17c,&mask))return only_failure(sp);
  size_t dn=strlen(directory);if(dn+nn+2>sizeof relative)return only_failure(sp);
  memcpy(relative,directory,dn);relative[dn]='/';memcpy(relative+dn+1,name,nn+1);
  /* Borrow a pre-existing native DeleteFile client. If it was already held,
   * never release somebody else's request; otherwise clear our exact bit. */
  requested=!(mask&(1u<<token));
  if(call(0x8ca888,power,token,500)!=0)good=0;
  else{
   memset(absolute,0,sizeof absolute);
   if(call(0x827348,fs,(uintptr_t)relative,(uintptr_t)absolute)==1&&memchr(absolute,0,sizeof absolute)&&
      !memcmp(absolute,root,strlen(root))&&clean_relative(absolute+strlen(root))&&
      iq4_stock_jpeg_gallery_delete_path_61(cat,node,name,card,absolute)==1){
    struct stat image;int error=0;int exists=stat_path(absolute,&image,&error);
    if(exists>0&&S_ISREG(image.st_mode)&&call(0x826a8c,fs,(uintptr_t)relative)==1){
     exists=stat_path(absolute,&image,&error);
     good=exists==-1&&error==2&&iq4_stock_jpeg_gallery_forget_deleted_61(cat,node,name,card)==1;
    }
   }
  }
 }catch(...){good=0;}
 if(requested&&power&&token<32){
  try{call(0x8ca708,power,token);uint32_t after;if(!stable(power+0x17c,&after)||(after&(1u<<token)))good=0;}catch(...){good=0;}
 }
 return good?1:only_failure(sp);
}
