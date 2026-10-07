#include "exif.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
static unsigned cases;
static void eq(const unsigned char*p,size_t n,unsigned want){assert(iq4_stock_jpeg_orientation_55(p,n)==want);++cases;}
static size_t make(unsigned char*p,int le,unsigned value){
 static const unsigned char jpeg[]={0xff,0xd8,0xff,0xe1,0,34,'E','x','i','f',0,0,
  'I','I',42,0,8,0,0,0,1,0,0x12,1,3,0,1,0,0,0,1,0,0,0,0,0,0,0,0xff,0xd9};
 memcpy(p,jpeg,sizeof jpeg);if(le)p[30]=(unsigned char)value;
 else{p[12]='M';p[13]='M';p[14]=0;p[15]=42;p[16]=0;p[17]=0;p[18]=0;p[19]=8;
  p[20]=0;p[21]=1;p[22]=1;p[23]=0x12;p[24]=0;p[25]=3;p[26]=0;p[27]=0;p[28]=0;p[29]=1;p[30]=0;p[31]=(unsigned char)value;}
 return sizeof jpeg;
}
int main(void){
 unsigned char a[128],b[128];size_t n;
 const unsigned char plain[]={0xff,0xd8,0xff,0xd9};eq(plain,sizeof plain,1);eq(NULL,0,0);
 for(unsigned le=0;le<2;++le)for(unsigned value=1;value<=8;++value){n=make(a,(int)le,value);eq(a,n,value);}
 n=make(a,1,3);for(size_t limit=0;limit<n;++limit)eq(a,limit,0);
 n=make(a,1,0);eq(a,n,0);n=make(a,0,9);eq(a,n,0);
 n=make(a,1,3);a[24]=4;eq(a,n,0);n=make(a,1,3);a[26]=2;eq(a,n,0);
 n=make(a,1,3);a[16]=0xff;eq(a,n,0);n=make(a,1,3);a[20]=2;eq(a,n,0);
 n=make(a,1,3);a[12]='Q';eq(a,n,0);n=make(a,1,3);a[14]=41;eq(a,n,0);
 n=make(a,1,3);a[22]=0x13;eq(a,n,1);n=make(a,1,3);a[6]='X';eq(a,n,1);
 n=make(a,1,3);size_t m=make(b,0,6);memcpy(a+n-2,b+2,m-2);eq(a,n+m-4,0);
 n=make(a,1,3);m=make(b,0,3);memcpy(a+n-2,b+2,m-2);eq(a,n+m-4,3);
 n=make(a,1,3);a[4]=0xff;eq(a,n,0);n=make(a,1,3);a[5]=1;eq(a,n,0);
 n=make(a,1,3);a[2]=0;eq(a,n,0);
 printf("Exif orientation parser: %u focused cases passed.\n",cases);return 0;
}
