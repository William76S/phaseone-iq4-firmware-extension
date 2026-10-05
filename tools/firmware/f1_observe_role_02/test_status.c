#include "status.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static void need(int b){if(!b)abort();}
int main(void){uint8_t b[16],x[16];unsigned v=99;unsigned tests=0;
 for(unsigned state=0;state<8;state++){f1_status_encode(b,state);need(f1_status_decode(b,16,&v)&&v==state);tests++;}
 f1_status_encode(b,4);
 for(unsigned i=0;i<16;i++){memcpy(x,b,16);x[i]^=0x80;need(!f1_status_decode(x,16,&v));tests++;}
 need(!f1_status_decode(b,15,&v)&&!f1_status_decode(b,17,&v));tests+=2;
 printf("%u finite constructor status checks PASS; no target/vendor execution\n",tests);return 0;
}
