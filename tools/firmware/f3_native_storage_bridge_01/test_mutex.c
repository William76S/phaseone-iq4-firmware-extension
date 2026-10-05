#include <pthread.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>
static int lock_result,unlock_result,lock_calls,unlock_calls;
static int fixture_lock(pthread_mutex_t*p){assert(p);++lock_calls;return lock_result;}
static int fixture_unlock(pthread_mutex_t*p){assert(p);++unlock_calls;return unlock_result;}
#define IQ4_STORAGE_MUTEX_SYNTHETIC_HOST
#define pthread_mutex_lock fixture_lock
#define pthread_mutex_unlock fixture_unlock
#include "mutex.c"
int main(int argc,char**argv){assert(argc==2);int success=!strcmp(argv[1],"success");
 if(!strcmp(argv[1],"lock"))lock_result=22;else if(!strcmp(argv[1],"unlock"))unlock_result=1;else if(!strcmp(argv[1],"pending"))initialized=1;else assert(success);
 assert(iq4_f3_native_storage_mutex_initialize_01()==success);assert(iq4_f3_storage_mutex_ready_01()==success);int l=lock_calls,u=unlock_calls;assert(iq4_f3_native_storage_mutex_initialize_01()==success&&lock_calls==l&&unlock_calls==u);
 assert(l==(!strcmp(argv[1],"pending")?0:1));assert(u==((!strcmp(argv[1],"pending")||lock_result)?0:1));puts("PASS mutex initialization success/failure has no false ready or retry");return 0;}
