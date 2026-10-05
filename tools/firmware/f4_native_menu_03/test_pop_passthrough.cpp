#include "native_calls.h"
#include <assert.h>
#include <stdio.h>
static unsigned calls;static unsigned behaviour;
extern "C" bool iq4_f4_synthetic_stock_pop_03(void*p){assert(p==(void*)1234);++calls;if(behaviour==2)throw 82;return behaviour==1;}
int main(){
 behaviour=0;assert(iq4_f4_menu_pop_passthrough_03((void*)1234)==0&&calls==1);
 behaviour=1;assert(iq4_f4_menu_pop_passthrough_03((void*)1234)==1&&calls==2);
 behaviour=2;bool observed=false;try{(void)iq4_f4_menu_pop_passthrough_03((void*)1234);}catch(int n){assert(n==82);observed=true;}
 assert(observed&&calls==3);
 int result=5;assert(iq4_f4_menu_pop_03((void*)1234,&result)==0&&result==5&&calls==4);
 puts("stock Pop original result/unowned exception pass-through; owned exception barrier PASS (synthetic)");
}
