#ifndef IQ4_F4_NATIVE_SESSION_02_H
#define IQ4_F4_NATIVE_SESSION_02_H
#include "worker.h"
#include "../f4_native_menu_03/menu.h"
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4F4MovieResult02 {IQ4_F4_MOVIE_READY=0,IQ4_F4_MOVIE_PENDING=1,IQ4_F4_MOVIE_FAIL=2,IQ4_F4_MOVIE_UNKNOWN=3};
/* Finite owned boundary to sdk_reference's actual native card/movie adapter.
 * acquire/poll/release execute on the ORIGINAL UI task; prepare/finalize execute
 * on plain owned worker using already held dirfd. No native TLS emulation.
 * finalize closes file+directory FDs before release. published is actual only.
 * Unknown keeps every owner and forbids a new call/session/retry. */
typedef struct {void*context;
 int(*acquire_on_ui)(void*);int(*poll_on_ui)(void*);
 int(*prepare_on_worker)(void*,uint32_t,uint32_t,struct Iq4Mkv**);
 /* complete_producer means actual drained source and successful synchronous
  * codec task; movie finalizer seals once, never double-patches the Segment. */
 int(*finalize_on_worker)(void*,struct Iq4Mkv*,int complete_producer,uint32_t*published);
 int(*release_on_ui)(void*);
 int(*cancel_pending_on_ui)(void*);
 int(*set_destination_on_ui)(void*,uint32_t);
 uint32_t(*destination_on_ui)(void*);
} Iq4F4MoviePorts02;
typedef struct Iq4F4Session02 Iq4F4Session02;
size_t iq4_f4_session_storage_bytes_02(void);
/* Actual initialized source and retained buffers. This creates one ordinary
 * pthread once, BEFORE any native frame lock; it neither acquires cards nor
 * starts recording. The session and Source control observer never hot-free. */
int iq4_f4_session_init_on_ui_02(void*,size_t,void*source,Iq4F4SelfRead02,void*,
 unsigned char*packet,uint32_t,int quality,const Iq4F4MoviePorts02*);
Iq4F4MenuPorts03 iq4_f4_session_menu_ports_02(void*);
/* Process shutdown only after Idle/known cleanup. UI doesn't join. A later
 * non-UI reaper may join after worker returned; unknown can never shut down. */
int iq4_f4_session_request_shutdown_on_ui_02(void*);
int iq4_f4_session_join_returned_not_ui_02(void*);
#ifdef __cplusplus
}
#endif
#endif
