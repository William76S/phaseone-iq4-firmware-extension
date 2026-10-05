#ifndef IQ4_F3_FILE_ARENA_01_H
#define IQ4_F3_FILE_ARENA_01_H
#include "../f3_native_fs_adapter_04/fs.h"
#ifdef __cplusplus
extern "C" {
#endif
/* Mapping storage is a concrete disk reservation, not evidence of the native
 * renderer's upper bound, working set, performance or completed pixels. */
enum F3ArenaStatus { F3_ARENA_OK, F3_ARENA_ARGUMENT, F3_ARENA_STATE,
                    F3_ARENA_IO, F3_ARENA_HOLD, F3_ARENA_BUSY };
enum F3ArenaState { F3_ARENA_EMPTY, F3_ARENA_CREATED, F3_ARENA_RESERVED,
                   F3_ARENA_MAPPED, F3_ARENA_RELEASED };
#define F3_ARENA_MAX_BYTES (UINT64_C(4294967296)-UINT64_C(4096))
#define F3_ARENA_ZERO_BYTES 65536u
struct F3ArenaApi {
 struct F3Posix io;
 struct F3SysResult (*truncate)(int,uint64_t);
 /* -2 means unsupported allocation: only then is full zero-write fallback used. */
 struct F3SysResult (*allocate)(int,uint64_t);
 struct F3SysResult (*map_shared)(int,uint64_t);
 struct F3SysResult (*flush_map)(void*,uint64_t);
 struct F3SysResult (*unmap)(void*,uint64_t);
};
struct F3Arena {
 struct F3ArenaApi api;
 struct F3CardGuard guard;
 struct F3FdStat directory, file;
 int dirfd, fd;
 uint32_t state, hold, loan_active, reservation_method;
 uint64_t epoch, capture_id, nonce, bytes;
 void *base;
 char leaf[64];
};
/* Fresh zero-initialized context; dirfd is held by actual serialized card owner.
 * Does not adopt old paths or existing files. Namespace must remain exclusive. */
enum F3ArenaStatus f3_arena_create_01(struct F3Arena*,const struct F3ArenaApi*,
 const struct F3CardGuard*,int,uint64_t,uint64_t,uint64_t,uint64_t,
 uint8_t *zero_workspace,size_t);
/* Marks synchronous native use. end is called only after actual join/destruct
 * in the coordinator. A host loan token alone cannot attest native completion. */
enum F3ArenaStatus f3_arena_loan_01(struct F3Arena*,void**,uint64_t*);
enum F3ArenaStatus f3_arena_end_loan_01(struct F3Arena*);
enum F3ArenaStatus f3_arena_release_01(struct F3Arena*);
void f3_arena_linux_api_01(struct F3ArenaApi*);
#ifdef __cplusplus
}
#endif
#endif
