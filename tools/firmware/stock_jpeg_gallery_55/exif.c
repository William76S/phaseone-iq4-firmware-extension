#include "exif.h"
static uint16_t u16(const uint8_t*p,int le){return le?(uint16_t)((uint16_t)p[0]|((uint16_t)p[1]<<8)):(uint16_t)(((uint16_t)p[0]<<8)|p[1]);}
static uint32_t u32(const uint8_t*p,int le){return le?((uint32_t)p[0]|((uint32_t)p[1]<<8)|((uint32_t)p[2]<<16)|((uint32_t)p[3]<<24)):(((uint32_t)p[0]<<24)|((uint32_t)p[1]<<16)|((uint32_t)p[2]<<8)|p[3]);}
static int tag(const uint8_t*t,size_t n,uint32_t*out,int*present){
 if(n<8)return 0;int le=t[0]=='I'&&t[1]=='I';
 if(!le&&!(t[0]=='M'&&t[1]=='M'))return 0;if(u16(t+2,le)!=42)return 0;
 uint32_t offset=u32(t+4,le);if(offset<8||offset>n-2)return 0;
 uint16_t count=u16(t+offset,le);size_t available=n-offset-2;
 if(available<4||(size_t)count>(available-4)/12)return 0;
 for(uint32_t i=0;i<count;++i){const uint8_t*p=t+offset+2+(size_t)i*12;
  if(u16(p,le)!=0x112)continue;
  if(u16(p+2,le)!=3||u32(p+4,le)!=1)return 0;
  uint32_t value=u16(p+8,le);if(!value||value>8||(*present&&value!=*out))return 0;
  *out=value;*present=1;
 }
 return 1;
}
uint32_t iq4_stock_jpeg_orientation_55(const uint8_t*bytes,size_t n){
 if(!bytes||n<4||bytes[0]!=0xff||bytes[1]!=0xd8)return 0;
 size_t p=2;uint32_t result=1;int present=0;
 while(p<n){
  if(bytes[p++]!=0xff)return 0;
  while(p<n&&bytes[p]==0xff)++p;if(p==n)return 0;
  uint8_t marker=bytes[p++];
  if(marker==0xd9)return result;
  if(marker==0x01)continue;
  if(marker==0x00||marker==0xd8||(marker>=0xd0&&marker<=0xd7))return 0;
  if(n-p<2)return 0;size_t length=((size_t)bytes[p]<<8)|bytes[p+1];
  if(length<2||length>n-p)return 0;
  const uint8_t*s=bytes+p+2;size_t payload=length-2;
  if(marker==0xe1&&payload>=6&&s[0]=='E'&&s[1]=='x'&&s[2]=='i'&&s[3]=='f'&&s[4]==0&&s[5]==0){
   if(!tag(s+6,payload-6,&result,&present))return 0;
  }
  p+=length;
  if(marker==0xda)return result; /* entropy is the JPEG decoder's task */
 }
 return 0;
}
