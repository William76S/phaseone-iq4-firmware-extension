#ifndef IQ4_RECORD1_ENGINE01_H
#define IQ4_RECORD1_ENGINE01_H
#include <stddef.h>
#include <stdint.h>
#define R1_EXTENT 0x4000U
#define R1_BYTES 16U
enum R1Action {R1_PREFLIGHT=0,R1_SAME_ORIGINAL=1,R1_CLEAR=2,R1_RESTORE=3};
typedef struct {uint32_t extent,offset;uint8_t original[R1_BYTES];char whole_sha[65];int write_enabled;} R1Config;
/* read_whole succeeds only after exact extent, EOF, metadata and runtime
 * identity checks. write16 is one call, never a short-write retry loop.
 * IO is private to this fixed tool; no command, pointer or path input API.
 */
typedef struct {void *context;int (*read_whole)(void *,uint8_t *);long (*write16)(void *,uint32_t,const uint8_t *);} R1IO;
typedef struct {int input_valid,read_stable,existing_record1,other_bytes_original,
  before_original,write_attempted,write_count_exact,readback_verified,
  rollback_attempted,rollback_verified,original_after_failure_verified,restore_transport_verified,
  same_original_transport_verified,clear_payload_verified,success;
  /* These require external native reload/cold boot acceptance, never set by
   * an EEPROM byte tool, including successful same-original writes. */
  int changed_then_restored_coldboot_verified,persistent_unlock_verified;
} R1Result;
int r1_locate_existing(const uint8_t *,uint32_t *);
R1Result r1_run(const R1Config *,const R1IO *,enum R1Action);
#endif
