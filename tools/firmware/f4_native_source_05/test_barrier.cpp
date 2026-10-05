#include "native_calls.h"
#include <cassert>
#include <cstdio>
static unsigned calls;static bool fail;
extern "C" void iq4_f4_test_original_queue_lock_05(void *p){
 assert((uintptr_t)p==0xf553c0);++calls;if(fail)throw 19;
}
int main(){
 assert(iq4_f4_native_queue_lock_05(0)==0&&calls==0);
 assert(iq4_f4_native_queue_lock_05(0xf553c0)==1&&calls==1);
 fail=true;assert(iq4_f4_native_queue_lock_05(0xf553c0)==0&&calls==2);
 assert(calls==2);puts("3 real C++ exception barrier groups PASS; no original target calls");
}
