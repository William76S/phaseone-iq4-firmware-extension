.text
.p2align 2
.global iq4_ratio_quick_append_wrapper_01
.type iq4_ratio_quick_append_wrapper_01,%function
iq4_ratio_quick_append_wrapper_01:
    .cfi_startproc
    sub sp,sp,#0x40
    .cfi_def_cfa_offset 0x40
    stp x29,x30,[sp,#0x30]
    .cfi_offset x29,-16
    .cfi_offset x30,-8
    mov x29,sp
    .cfi_def_cfa_register x29
    stp x0,x1,[sp]
    /* Native LV ctor BL@519204: LV is [entry SP+B8]. */
    ldr x2,[sp,#0xf8]
    str x2,[sp,#0x10]
    bl iq4_stock_quick_append_01
    str x0,[sp,#0x18]
    ldp x0,x1,[sp]
    ldr x2,[sp,#0x10]
    bl iq4_ratio_quick_append_on_ui_01
    ldr x0,[sp,#0x18]
    ldp x29,x30,[sp,#0x30]
    .cfi_def_cfa sp,0x40
    .cfi_restore x29
    .cfi_restore x30
    add sp,sp,#0x40
    .cfi_def_cfa_offset 0
    ret
    .cfi_endproc
.size iq4_ratio_quick_append_wrapper_01,.-iq4_ratio_quick_append_wrapper_01

.global iq4_ratio_quick_cleanup_wrapper_01
.type iq4_ratio_quick_cleanup_wrapper_01,%function
iq4_ratio_quick_cleanup_wrapper_01:
    .cfi_startproc
    sub sp,sp,#0x20
    .cfi_def_cfa_offset 0x20
    stp x29,x30,[sp,#0x10]
    .cfi_offset x29,-16
    .cfi_offset x30,-8
    mov x29,sp
    .cfi_def_cfa_register x29
    str x0,[sp]
    bl iq4_ratio_quick_cleanup_on_ui_01
    ldr x0,[sp]
    ldp x29,x30,[sp,#0x10]
    .cfi_def_cfa sp,0x20
    .cfi_restore x29
    .cfi_restore x30
    add sp,sp,#0x20
    .cfi_def_cfa_offset 0
    b iq4_stock_quick_dialog_dtor_01
    .cfi_endproc
.size iq4_ratio_quick_cleanup_wrapper_01,.-iq4_ratio_quick_cleanup_wrapper_01
.section .note.GNU-stack,"",%progbits
