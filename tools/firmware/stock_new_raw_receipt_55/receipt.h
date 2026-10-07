#pragma once
#include <stdint.h>
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
/* Positive ordinary capture: Both stores snapshot only; JPEG-only additionally
 * requires an exclusively created full RAW inode. Card bits:
 * XQD=2, SD=4, matching native completion flags. Format IIQ=0/JPEG=1/Both=2.
 * `node` below is catalog slot+20. The original UI path installs the capture
 * node there; acquire verifies this relation, never matches a name alone. */
struct Iq4NewRawPolicy55 {
 uint32_t format,size,sd_mode,jpeg_mask,raw_mask,generation;
};
struct Iq4NewRawTicket55 { uint64_t serial; };
enum { IQ4_NEW_RAW_REJECT55=0, IQ4_NEW_RAW_OK55=1,
 IQ4_NEW_RAW_KEPT55=2, IQ4_NEW_RAW_UNKNOWN55=-1 };
struct Iq4NewRawOps55 {
 void *context;
 int (*read)(void*,uintptr_t,void*,size_t);
 int (*policy)(void*,struct Iq4NewRawPolicy55*);
 /* Recheck SAME native catalog slot/index/node/base under its original mutex,
  * and after cleanup confirm no Source/Output/Backup consumer remains. */
 int (*catalog)(void*,uintptr_t,uint32_t,const char*,uint32_t,int);
 /* Native clear-presence operation only AFTER exact owned inode removal.
  * Original 496e90(IFM,index,mask), not a caller-written catalog byte. */
 int (*removed)(void*,uintptr_t,uint32_t,uint32_t);
 uintptr_t xqd_fs,sd_fs;
 /* Same IFM/catalog node, exact RAW presence2, pending128 absent, and original
  * BackupStorage source/output clients quiescent. Reads under catalog mutex. */
 int (*backup_quiet)(void*,uintptr_t ifm,uintptr_t node,uint32_t index);
};
int iq4_new_raw_bind_55(const struct Iq4NewRawOps55*);
int iq4_new_raw_settings_enter_55(void);
void iq4_new_raw_settings_leave_55(void);
uint32_t iq4_new_raw_active_55(void);
int iq4_new_raw_acquire_55(uintptr_t catalog_node,uint32_t index,
 const struct Iq4NewRawPolicy55*,uint32_t raw_flags,uint32_t jpeg_mask,
 struct Iq4NewRawTicket55*);
int iq4_new_raw_backup_suppressed_55(uintptr_t catalog_node,uint32_t index);
int iq4_new_raw_publication_55(struct Iq4NewRawTicket55,uint32_t fsynced_mask);
/* Call after original JPEG cleanup AND native tokens/consumers have ended.
 * Failure/unknown preserves RAW. Return OK means every owned source inode was
 * removed and its containing directory synced; native catalog was updated. */
int iq4_new_raw_end_55(struct Iq4NewRawTicket55,int original_job_ok);
int iq4_new_raw_policy_55(uintptr_t catalog_node,uint32_t index,
 struct Iq4NewRawPolicy55*);
#ifdef __cplusplus
}
#endif
