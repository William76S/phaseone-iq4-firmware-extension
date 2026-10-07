/* Original Storage JPEG Size append4f0528->4e58b8 always executes once.
 * Only then attach an independent export settings submenu. Preserve the
 * original result/caller register state and native unwind path. */
.text
.p2align 2
.global iq4_stock_jpeg_menu_append_01
.type iq4_stock_jpeg_menu_append_01,%function
iq4_stock_jpeg_menu_append_01:
    .cfi_startproc
    sub sp,sp,#0x120
    .cfi_def_cfa_offset 0x120
    stp x29,x30,[sp,#0x110]
    .cfi_offset x29,-16
    .cfi_offset x30,-8
    mov x29,sp
    .cfi_def_cfa_register x29
    stp x0,x1,[sp,#0x100]
    movz x16,#0x58b8
    movk x16,#0x4e,lsl #16
    blr x16
    stp x0,x1,[sp,#0x00]
    stp x2,x3,[sp,#0x10]
    stp x4,x5,[sp,#0x20]
    stp x6,x7,[sp,#0x30]
    str x8,[sp,#0x40]
    mrs x9,nzcv
    str x9,[sp,#0x48]
    stp q0,q1,[sp,#0x50]
    stp q2,q3,[sp,#0x70]
    stp q4,q5,[sp,#0x90]
    stp q6,q7,[sp,#0xb0]
    ldp x0,x1,[sp,#0x100]
    ldr x2,[sp,#0x118]
    bl iq4_stock_jpeg_after_menu_append_01
    ldp q0,q1,[sp,#0x50]
    ldp q2,q3,[sp,#0x70]
    ldp q4,q5,[sp,#0x90]
    ldp q6,q7,[sp,#0xb0]
    ldr x9,[sp,#0x48]
    msr nzcv,x9
    ldp x0,x1,[sp,#0x00]
    ldp x2,x3,[sp,#0x10]
    ldp x4,x5,[sp,#0x20]
    ldp x6,x7,[sp,#0x30]
    ldr x8,[sp,#0x40]
    ldp x29,x30,[sp,#0x110]
    .cfi_def_cfa sp,0x120
    .cfi_restore x29
    .cfi_restore x30
    add sp,sp,#0x120
    .cfi_def_cfa_offset 0
    ret
    .cfi_endproc
.size iq4_stock_jpeg_menu_append_01,.-iq4_stock_jpeg_menu_append_01
.section .note.GNU-stack,"",%progbits
