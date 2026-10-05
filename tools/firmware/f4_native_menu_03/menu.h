#ifndef IQ4_F4_NATIVE_MENU_03_H
#define IQ4_F4_NATIVE_MENU_03_H
#include "../f4_native_source_02/source.h"
#ifdef __cplusplus
extern "C" {
#endif
enum Iq4F4UiPhase03 { IQ4_F4_UI_UNAVAILABLE=0,IQ4_F4_UI_IDLE=1,IQ4_F4_UI_PREPARING=2,
 IQ4_F4_UI_RECORDING=3,IQ4_F4_UI_FINALIZING=4,IQ4_F4_UI_ERROR=5,IQ4_F4_UI_HOLD=6 };
enum Iq4F4UiAction03 {IQ4_F4_UI_START=0,IQ4_F4_UI_STOP=1,IQ4_F4_UI_STOP_EXIT=2,IQ4_F4_UI_CARD_NEXT=3};
enum Iq4F4UiResult03 {IQ4_F4_UI_REJECTED=0,IQ4_F4_UI_PENDING=1,IQ4_F4_UI_COMPLETE=2,IQ4_F4_UI_UNKNOWN=3};
typedef struct {uint32_t phase,width,height,error;uint64_t encoded,dropped,notifications;
 uint32_t published_and_owners_released,known_empty_cancelled_and_released,destination_fs_id,card_request_held;} Iq4F4UiView03;
/* Own coordinator ABI, not native object ABI. control is nonblocking on UI:
 * enqueue owned worker prepare/stop, never codec/write/wait in menu callback.
 * COMPLETE for Exit requires source fence + file publication + card release. */
typedef struct {void*context;int(*control_on_ui)(void*,uint32_t);
 int(*view_on_ui)(void*,Iq4F4UiView03*);} Iq4F4MenuPorts03;
/* Called before stock BL4eea58, then original SetMenu once. Root's F1 hook may
 * call BOTH owned mask and this function; do not introduce a second patch. */
int iq4_f4_menu_install_03(void*selector,void*root,uintptr_t return_pc,Iq4F4SelfRead02,void*read_context);
int iq4_f4_menu_connect_on_ui_03(void*source,const Iq4F4MenuPorts03*);
/* May bind the owned coordinator at construction before LV exists. First Start
 * must initialise source from the actual later UI owner and call connect.
 * This binds no source pointer, frame lease or capability boolean. */
int iq4_f4_menu_bind_ports_on_ui_03(const Iq4F4MenuPorts03*);
int iq4_f4_menu_page_guard_03(void*ignored);
/* Narrow native Back BL4fb454 wrapper invokes before this original pop;
 * original boolean/result is forwarded without forging a successful pop. */
int iq4_f4_menu_before_native_pop_03(void*navigator);
int iq4_f4_menu_refresh_on_ui_03(void);
/* Original UI control-event completion closes the selector only after actual
 * publish/release/source fence. One Stop and Exit does not need another frame
 * or a second user click. Normal Back remains a separate stock pop. */
int iq4_f4_menu_finish_exit_on_ui_03(void);
int iq4_f4_menu_native_pop_wrapper_03(void*navigator);
#ifdef __cplusplus
}
#endif
#endif
