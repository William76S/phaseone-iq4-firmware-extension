#include "card.h"
#include <string.h>
int f3_fdinfo_mount_id_05(const char*p,size_t n,uint64_t*out){
 if(!p||!out||!n||n>512||p[n-1]!='\n')return 0;
 unsigned found=0;uint64_t result=0;
 for(size_t at=0;at<n;){size_t end=at;while(end<n&&p[end]!='\n'){if(!p[end])return 0;++end;}
  if(end==n)return 0;
  if(end-at>=7&&!memcmp(p+at,"mnt_id:",7)){
   if(found++)return 0;size_t i=at+7;if(i==end||!(p[i]=='\t'||p[i]==' '))return 0;
   while(i<end&&(p[i]=='\t'||p[i]==' '))++i;size_t first=i;uint64_t v=0;
   for(;i<end;++i){unsigned c=(unsigned char)p[i];if(c<'0'||c>'9'||v>(UINT64_MAX-(c-'0'))/10)return 0;v=v*10+c-'0';}
   if(i==first||!v||v>UINT32_MAX)return 0;result=v;
  }
  at=end+1;
 }
 if(found!=1)return 0;*out=result;return 1;
}
