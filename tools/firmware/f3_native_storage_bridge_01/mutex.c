#include <pthread.h>
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#if defined(__aarch64__) && defined(__linux__)
_Static_assert(_Alignof(pthread_mutex_t)==8,"Exact stock alignment");
_Static_assert(sizeof(pthread_mutex_t)==48,"Exact stock glibc 2.28 AArch64 mutex");
_Static_assert(offsetof(pthread_mutex_t,__data.__lock)==0,"stock lock word");
_Static_assert(offsetof(pthread_mutex_t,__data.__kind)==16,"stock kind word");
#endif
static pthread_mutex_t storage_mutex=PTHREAD_MUTEX_INITIALIZER;
static uint32_t initialized;
#ifdef IQ4_STORAGE_MUTEX_SYNTHETIC_HOST
static int original_lock(pthread_mutex_t*p){return pthread_mutex_lock(p);}
static int original_unlock(pthread_mutex_t*p){return pthread_mutex_unlock(p);}
#else
static int original_lock(pthread_mutex_t*p){return ((int(*)(pthread_mutex_t*))(uintptr_t)0x40aae0)(p);}
static int original_unlock(pthread_mutex_t*p){return ((int(*)(pthread_mutex_t*))(uintptr_t)0x40a730)(p);}
#endif
int iq4_f3_native_storage_mutex_initialize_01(void){
 uint32_t before=0;if(!__atomic_compare_exchange_n(&initialized,&before,1,0,__ATOMIC_ACQ_REL,__ATOMIC_ACQUIRE))return before==2;
 /* Target PTHREAD_MUTEX_INITIALIZER is the exact 48-byte zero representation
  * produced by original pthread_mutex_init(NULL) at 0x9424..0x9430. */
#if defined(__aarch64__) && defined(__linux__)
 const unsigned char*bytes=(const unsigned char*)&storage_mutex;
 for(size_t i=0;i<sizeof storage_mutex;++i)if(bytes[i]){__atomic_store_n(&initialized,3,__ATOMIC_RELEASE);return 0;}
#endif
 int r=original_lock(&storage_mutex);if(!r)r=original_unlock(&storage_mutex);
 __atomic_store_n(&initialized,r?3u:2u,__ATOMIC_RELEASE);return r==0;
}
int iq4_f3_storage_mutex_ready_01(void){return __atomic_load_n(&initialized,__ATOMIC_ACQUIRE)==2;}
int iq4_f3_storage_mutex_lock_01(void){return original_lock(&storage_mutex);}
int iq4_f3_storage_mutex_unlock_01(void){return original_unlock(&storage_mutex);}
