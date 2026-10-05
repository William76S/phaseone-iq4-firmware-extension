#include <stddef.h>
/* bcmp's contract is zero iff equal, otherwise nonzero; no sign promise.
   Volatile reads prevent the compiler replacing this body with bcmp itself. */
int bcmp(const void*a,const void*b,size_t n){
 const volatile unsigned char*p=a,*q=b;
 for(size_t i=0;i<n;++i)if(p[i]!=q[i])return 1;
 return 0;
}
