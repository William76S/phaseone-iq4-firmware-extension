/* The actual new runtime admission is compiled here. These explicit binding
 * fixtures test its finite predicate only; no native queue or rendering. */
#define IQ4_STOCK_JPEG_TEST 1
#include "runtime.cpp"
#include <assert.h>
#include <stdio.h>
int main(){
 unsigned cases=0;
 const uintptr_t worker=0x20002000,ice=0x20006000,ifm=0x20009000;
 auto reset=[&](){bound=1;active=1;held=0;half_worker=worker;half_ice=ice;binding.ifm=ifm;};
 auto admit=[&](uintptr_t w,uintptr_t c,uintptr_t a,uintptr_t b){++cases;return iq4_stock_half_request_owner_59(w,c,a,b);};
 reset();assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==1);
 assert(admit(worker,ice+0x788,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 assert(admit(worker,ice+0x789,ifm+0x3fa6e14,ifm+0x7f4cc28)==0);
 assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc2c)==0);
 assert(admit(worker+16,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 assert(admit(0,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 bound=0;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();active=0;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();active=2;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();held=1;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();half_ice=0;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();half_ice=UINTPTR_MAX-0x788;assert(admit(worker,0,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();binding.ifm=0;assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==0);
 reset();binding.ifm=UINTPTR_MAX-UINT64_C(0x7f4cc28)+1;
 assert(admit(worker,ice+0x789,0,0)==0);
 reset();assert(admit(worker,ice+0x789,ifm+0x3fa6e10,ifm+0x7f4cc28)==1);
 assert(cases==15);printf("request owner predicate: %u cases passed\n",cases);
}
