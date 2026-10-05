#ifndef IQ4_F3_NATIVE_FS_03_H
#define IQ4_F3_NATIVE_FS_03_H
#include "../f3_stream_transaction_02/stream.h"
#ifdef __cplusplus
extern "C" {
#endif
struct F3SysResult {int64_t value;int32_t error;};
struct F3FdStat {uint64_t device,inode,size,nlink;uint32_t mode;int64_t mtime_sec,mtime_nsec;};
/* Own POSIX contract, populated by verified original syscall wrappers, not a vendor C++ ABI. */
struct F3Posix {
 struct F3SysResult(*open_leaf)(int,const char*,int); /* write1 exclusive,read0 O_NOFOLLOW */
 struct F3SysResult(*stat_fd)(int,struct F3FdStat*);
 struct F3SysResult(*stat_leaf)(int,const char*,struct F3FdStat*);
 struct F3SysResult(*read)(int,void*,uint32_t);
 struct F3SysResult(*read_at)(int,void*,uint32_t,uint64_t);
 struct F3SysResult(*write)(int,const void*,uint32_t);
 struct F3SysResult(*sync)(int);
 struct F3SysResult(*close)(int);
 struct F3SysResult(*move_noreplace)(int,const char*,const char*);
 struct F3SysResult(*unlink_leaf)(int,const char*);
};
/* Actual card lease epoch is required. Runtime memory reader must safely bound own mappings. */
struct F3CardGuard {void*context;uint64_t(*actual_epoch)(void*);int(*native_owner_valid)(void*);};
struct F3Fs {
 struct F3Posix api;struct F3CardGuard guard;
 int jpeg_dir,raw_dir,raw_fd,write_fd,read_fd;
 struct F3FdStat jpeg_directory,raw_directory,raw_stat,jpeg_stat;
 uint64_t epoch,capture_id,task_nonce,raw_producer_bytes;
 uint32_t bound,hold,owned_stage,stage_sealed,published,raw_removed;
 char raw_leaf[64],temporary_leaf[64],final_leaf[64],raw_sha256[65];
};
/* FDs must already be actual directories opened and held by the task/card lease.
 * Only fixed internal names are generated. No absolute or caller supplied path. */
int f3_fs_prepare_03(struct F3Fs*,const struct F3Posix*,const struct F3CardGuard*,int jpeg_dir,int raw_dir,uint64_t epoch,uint64_t capture_id,uint64_t nonce);
/* Exclusive newly-created stage owned by this context. Native complete RAW producer
 * may target returned fixed leaf in this held dir. Never adopts an existing source. */
int f3_fs_create_stage_03(struct F3Fs*);
/* Must follow actual native full-IIQ completion. Hash is whole final source, not prefix.
 * Checks actual fd/path identity, fsync, whole bounded SHA, metadata, directory sync.
 * No code here interprets RAW pixels or proves full RAW image provenance. */
int f3_fs_seal_stage_03(struct F3Fs*,uint64_t bytes,const char expected_sha256[65],uint32_t native_full_raw_completed,uint8_t*,size_t,struct F3File*);
/* Manual source: uppercase basename+IIQ, actual held fd/stat; deletion remains off.
 * On success takes ownership of an independent fd opened by this task, never
 * borrows/transfers a still-owned native File or catalogue reader descriptor. */
int f3_fs_manual_raw_03(struct F3Fs*,const char*leaf,int raw_fd,struct F3File*);
struct F3Ports f3_fs_ports_03(struct F3Fs*);
/* Close only after normal transaction end; UNKNOWN refuses all cleanup. Caller owns dirs. */
int f3_fs_release_raw_03(struct F3Fs*);
/* Runtime read-only check: registry exact id10 and owner value, complete LinuxFS vtable.
 * No factory calls, no guessed live pointer or probing of unmapped memory. */
int f3_fs_native_owner_guard_03(int(*read_mem)(void*,uintptr_t,void*,size_t),void*,uintptr_t owner);
void f3_fs_linux_api_03(struct F3Posix*);
#ifdef __cplusplus
}
#endif
#endif
