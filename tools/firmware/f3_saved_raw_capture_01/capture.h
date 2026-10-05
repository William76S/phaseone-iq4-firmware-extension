#ifndef IQ4_F3_SAVED_RAW_CAPTURE_01_H
#define IQ4_F3_SAVED_RAW_CAPTURE_01_H
#include "../f3_native_card_bridge_06/card.h"
#include "../native_activity_01/activity.h"
#ifdef __cplusplus
extern "C" {
#endif
/* This is our receipt, never a vendor object or a copy of a retired RAW node.
 * Original SD File owns writer_fd until checked native close returns. */
enum F3CaptureState01 {F3_CAPTURE_EMPTY01=0,F3_CAPTURE_ARMED01=1,
 F3_CAPTURE_WRITING01=2,F3_CAPTURE_SAVED01=3,F3_CAPTURE_DONE01=4,F3_CAPTURE_HOLD01=5};
struct F3CapturePolicy01Small {uint32_t mode,size_mode,quality;};
struct F3CaptureTicket01 {uintptr_t manager,node;uint64_t sequence;
 struct F3CapturePolicy01Small policy;};
struct F3CapturedRaw01 {
 struct F3CaptureTicket01 ticket;uint32_t state,hold,exclusive_created,store_returned,
  store_success,close_returned,close_success,writer_bound;
 uintptr_t storage,native_fs,native_file;uint64_t writer_thread;
 int dcim_dir,parent_dir,raw_fd,writer_fd;
 struct F3FdStat created,final_stat,parent_stat;char directory[9],leaf[32],sha256[65];
 struct F3Card05 *card;
 struct Iq4ActivityLease01 activity;
};
/* Directory operations have fixed component rules. Target implementation uses
 * original syscall PLT/openat(O_DIRECTORY|O_NOFOLLOW), no guessed C++ fs call. */
struct F3CaptureDirectories01 {
 struct F3SysResult(*open_child)(int,const char*);
};
struct F3CaptureOps01 {
 struct F3Posix files;struct F3CaptureDirectories01 dirs;
 struct F3CardRead05 memory;
 struct F3Card05*(*acquire_sd)(void*); /* actual Card05 begin (10,10), not a bool */
 /* Called synchronously only after original 7arg Store true+checked Close true,
  * whole readback+identity+directory sync. Node pointers are identity only.
  * Consumer retains source/card if unknown, returns 1 only after its cleanup. */
 int(*saved)(void*,struct F3CapturedRaw01*);
 void*context;
};
/* Fresh global runtime configuration before any capture. Fixed native bindings
 * are provided by ORIGINAL_BINDINGS.json; no target executable is run by build. */
int f3_capture_configure_01(const struct F3CaptureOps01*);
const struct F3CapturedRaw01*f3_capture_status_01(void);
/* Actual inline hook callback, after original STR manager+48=node. */
#ifdef __cplusplus
void iq4_f3_raw_acquired_after_01(uintptr_t,uintptr_t) noexcept;
#else
void iq4_f3_raw_acquired_after_01(uintptr_t,uintptr_t);
#endif
/* Independent core (used by native wrappers and SDK-free fault fixtures). */
int f3_capture_path_01(const char*,char directory[9],char leaf[32]);
int f3_capture_open_01(struct F3CapturedRaw01*,const struct F3CaptureOps01*,
 uintptr_t native_fs,uintptr_t native_file,const char*,uint64_t writer_thread);
int f3_capture_close_result_01(struct F3CapturedRaw01*,uintptr_t native_file,int returned,int success);
int f3_capture_saved_01(struct F3CapturedRaw01*,const struct F3CaptureOps01*,int store_success);
int f3_capture_fresh_01(struct F3CapturedRaw01*,const struct F3CaptureOps01*);
/* Never deletes public RAW; deletion belongs to coordinator06 after renderer
 * cleanup plus a separately closed public-capture deletion contract. */
int f3_capture_release_files_01(struct F3CapturedRaw01*,const struct F3CaptureOps01*);
void f3_capture_hold_01(struct F3CapturedRaw01*);
void f3_capture_linux_directories_01(struct F3CaptureDirectories01*);
#ifdef __cplusplus
}
#endif
#endif
