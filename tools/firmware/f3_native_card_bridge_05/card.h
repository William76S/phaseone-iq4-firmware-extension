#ifndef IQ4_F3_NATIVE_CARD_BRIDGE_05_H
#define IQ4_F3_NATIVE_CARD_BRIDGE_05_H
#include "../f3_native_fs_adapter_04/fs.h"
#ifdef __cplusplus
extern "C" {
#endif
enum F3CardOutcome05 {F3_CARD_OK=0,F3_CARD_FAIL=1,F3_CARD_UNKNOWN=2};
struct F3CardRead05 {void *context;int(*read)(void*,uintptr_t,void*,size_t);};
/* Our C boundary. Target implementation catches original C++ exceptions. */
struct F3LeaseCalls05 {
 void *context;
 enum F3CardOutcome05(*register_client)(void*,uintptr_t,const char*,uint32_t*);
 enum F3CardOutcome05(*wait_request)(void*,uintptr_t,uint32_t,uint32_t,uint32_t*);
 enum F3CardOutcome05(*release)(void*,uintptr_t,uint32_t,uint32_t*);
};
struct F3CardIo05 {
 struct F3SysResult(*open_root)(const char*);
 struct F3SysResult(*open_media_parent)(void); /* fixed /run/media, never caller path */
 /* Actual kernel fdinfo mnt_id; no default/generation synthesized on missing field. */
 struct F3SysResult(*mount_id)(int,uint64_t*,int*retained_aux_fd);
 struct F3SysResult(*stat_fd)(int,struct F3FdStat*);
 struct F3SysResult(*close)(int);
};
struct F3Card05 {
 struct F3CardRead05 memory;struct F3LeaseCalls05 calls;struct F3CardIo05 io;
 uintptr_t power[2],fs[2];uint32_t client[2],registered[2],requested[2],required[2];
 uint32_t raw_id,jpeg_id,state,hold;
 int raw_dir,jpeg_dir,probe_fd,aux_fd;
 uint64_t raw_mount,jpeg_mount,parent_mount;struct F3FdStat raw_stat,jpeg_stat;
 char raw_root[256],jpeg_root[256];
};
/* Resolves actual SDWrite/XQDWrite objects from native bounded global list and
 * id10/id11 FS registry. Calls register/wait only after exact native signatures.
 * A single process-wide task lock serializes our namespace. Registration lives
 * until original process exit: no unproved vendor unregister or SO unload. */
enum F3CardOutcome05 f3_card_begin_05(struct F3Card05*,const struct F3CardRead05*,
 const struct F3LeaseCalls05*,const struct F3CardIo05*,uint32_t raw_fs_id,uint32_t jpeg_fs_id);
int f3_card_valid_05(struct F3Card05*);
struct F3CardGuard f3_card_guard_05(struct F3Card05*);
/* Call only after actual source/render/arena/file cleanup succeeded; UNKNOWN
 * refuses. Directory FDs close BEFORE native requests release. No retry. */
enum F3CardOutcome05 f3_card_finish_05(struct F3Card05*);
/* Coordinators retaining a source lease may close directories, release that
 * source lease, then release native requests. These are single-use phases. */
enum F3CardOutcome05 f3_card_close_dirs_05(struct F3Card05*);
enum F3CardOutcome05 f3_card_release_requests_05(struct F3Card05*);
void f3_card_hold_05(struct F3Card05*);
int f3_fdinfo_mount_id_05(const char*,size_t,uint64_t*);
void f3_card_linux_io_05(struct F3CardIo05*);
void f3_card_native_calls_05(struct F3LeaseCalls05*);
#ifdef __cplusplus
}
#endif
#endif
