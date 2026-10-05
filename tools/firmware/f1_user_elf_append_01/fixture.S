/* Synthetic linker fixture ONLY. No mask or UI functionality; never execute. */
.macro fn name
.text
.p2align 2
.global \name
.type \name,%function
\name:
.cfi_startproc
 ret
.cfi_endproc
.size \name,.-\name
.endm
fn iq4_f1_lv_draw_wrapper_12
fn iq4_f1_firmware_unlock_01
fn iq4_f1_lv_ctor_wrapper_01
fn iq4_f1_firmware_initialize_01
fn iq4_f1_mode_get_01
fn iq4_f1_mode_set_on_ui_01
.text
.global fixture_relocs
.type fixture_relocs,%function
fixture_relocs:
.cfi_startproc
 adrp x0,fixture_data
 add x0,x0,:lo12:fixture_data
 ldr x1,[x0,:lo12:fixture_data]
 bl iq4_f1_mode_get_01
 ret
.cfi_endproc
.size fixture_relocs,.-fixture_relocs
.data
.p2align 3
.global fixture_data
.type fixture_data,%object
fixture_data:
 .quad iq4_f1_mode_get_01
.size fixture_data,.-fixture_data
.section .note.GNU-stack,"",%progbits
#ifdef TEST_TERMINATE_IMPORT
.text
.global fixture_terminate
.type fixture_terminate,%function
fixture_terminate:
.cfi_startproc
 bl _ZSt9terminatev
 ret
.cfi_endproc
.size fixture_terminate,.-fixture_terminate
#endif
