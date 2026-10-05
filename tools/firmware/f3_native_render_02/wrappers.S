/* Four exact original BL slots, three wrappers. No target execution by build. */
.text
.p2align 2
.macro enter
    sub sp,sp,#0x240
    .cfi_def_cfa_offset 0x240
    str x29,[sp,#0x200]
    str x30,[sp,#0x208]
    .cfi_offset x29,-64
    .cfi_offset x30,-56
    mov x29,sp
    .cfi_def_cfa_register x29
.endm
.macro save
    stp x0,x1,[sp,#0x80]
    stp x2,x3,[sp,#0x90]
    stp x4,x5,[sp,#0xa0]
    stp x6,x7,[sp,#0xb0]
    stp x8,x9,[sp,#0xc0]
    stp x10,x11,[sp,#0xd0]
    stp x12,x13,[sp,#0xe0]
    stp x14,x15,[sp,#0xf0]
    stp x16,x17,[sp,#0x100]
    str x18,[sp,#0x110]
    stp q0,q1,[sp,#0x120]
    stp q2,q3,[sp,#0x140]
    stp q4,q5,[sp,#0x160]
    stp q6,q7,[sp,#0x180]
    mrs x9,nzcv
    str x9,[sp,#0x1a0]
.endm
.macro restore
    ldp q0,q1,[sp,#0x120]
    ldp q2,q3,[sp,#0x140]
    ldp q4,q5,[sp,#0x160]
    ldp q6,q7,[sp,#0x180]
    ldr x9,[sp,#0x1a0]
    msr nzcv,x9
    ldp x0,x1,[sp,#0x80]
    ldp x2,x3,[sp,#0x90]
    ldp x4,x5,[sp,#0xa0]
    ldp x6,x7,[sp,#0xb0]
    ldp x8,x9,[sp,#0xc0]
    ldp x10,x11,[sp,#0xd0]
    ldp x12,x13,[sp,#0xe0]
    ldp x14,x15,[sp,#0xf0]
    ldp x16,x17,[sp,#0x100]
    ldr x18,[sp,#0x110]
.endm
.macro leave
    ldr x29,[sp,#0x200]
    ldr x30,[sp,#0x208]
    .cfi_def_cfa sp,0x240
    .cfi_restore x29
    .cfi_restore x30
    add sp,sp,#0x240
    .cfi_def_cfa_offset 0
    ret
.endm
.global iq4_f3_decode_native_reader_wrapper_02
.type iq4_f3_decode_native_reader_wrapper_02,%function
iq4_f3_decode_native_reader_wrapper_02:
    .cfi_startproc
    enter
    save
    /* Ten eight-byte stack argument slots, whose scalar values use only the
     * low32 bits. Do not compare their uninitialized high32 padding. */
    add x11,sp,#0x240
    ldp x9,x10,[x11]
    stp x9,x10,[sp]
    ldp x9,x10,[x11,#0x10]
    stp x9,x10,[sp,#0x10]
    ldp x9,x10,[x11,#0x20]
    stp x9,x10,[sp,#0x20]
    ldp x9,x10,[x11,#0x30]
    stp x9,x10,[sp,#0x30]
    ldp x9,x10,[x11,#0x40]
    stp x9,x10,[sp,#0x40]
    add x0,sp,#0x80
    mov x1,sp
    /* This is the SP at the following native BL. The original reader's
     * 0x140 frame is relative to it, not to this wrapper's caller SP. */
    mov x2,sp
    ldr x3,[sp,#0x208]
    bl iq4_f3_decode_reader_before_02
    restore
    bl iq4_f3_original_raw_reader_02
    save
    ldr x0,[sp,#0x208]
    bl iq4_f3_decode_reader_after_02
    restore
    leave
    .cfi_endproc
.size iq4_f3_decode_native_reader_wrapper_02,.-iq4_f3_decode_native_reader_wrapper_02
.p2align 2
.global iq4_f3_decode_native_row_wrapper_02
.type iq4_f3_decode_native_row_wrapper_02,%function
iq4_f3_decode_native_row_wrapper_02:
    .cfi_startproc
    enter
    save
    stp x19,x21,[sp,#0x1b0]
    stp x0,x1,[sp,#0x1c0]
    stp x2,x3,[sp,#0x1d0]
    add x0,sp,#0x1c0
    mov x1,x19
    mov x2,x21
    ldr x3,[sp,#0x208]
    bl iq4_f3_decode_row_before_02
    restore
    bl iq4_f3_original_row_decode_02
    save
    add x0,sp,#0x1c0
    ldp x1,x2,[sp,#0x1b0]
    ldr x3,[sp,#0x208]
    bl iq4_f3_decode_row_after_02
    restore
    leave
    .cfi_endproc
.size iq4_f3_decode_native_row_wrapper_02,.-iq4_f3_decode_native_row_wrapper_02
.p2align 2
.global iq4_f3_decode_native_join_wrapper_02
.type iq4_f3_decode_native_join_wrapper_02,%function
iq4_f3_decode_native_join_wrapper_02:
    .cfi_startproc
    enter
    str x0,[sp,#0x1b0]
    bl iq4_f3_original_decode_pool_join_02
    save
    add x0,sp,#0x240
    ldr x1,[sp,#0x1b0]
    ldr x2,[sp,#0x208]
    bl iq4_f3_decode_join_after_02
    restore
    leave
    .cfi_endproc
.size iq4_f3_decode_native_join_wrapper_02,.-iq4_f3_decode_native_join_wrapper_02
.section .note.GNU-stack,"",%progbits
