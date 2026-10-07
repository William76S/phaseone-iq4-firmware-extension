#include "stages.h"
#include <assert.h>
#include <stdio.h>
int main(){
 const uint32_t complete[]={1,3,4,6,32};
 for(uint32_t n:complete)assert(iq4_half_stage_counts_valid_60(n,n)==1);
 assert(iq4_half_stage_counts_valid_60(0,0)==0);
 assert(iq4_half_stage_counts_valid_60(33,33)==0);
 assert(iq4_half_stage_counts_valid_60(4,3)==0);
 assert(iq4_half_stage_counts_valid_60(4,5)==0);
 assert(iq4_half_stage_counts_valid_60(32,0)==0);
 puts("10 focused stage-count cases passed");
}
