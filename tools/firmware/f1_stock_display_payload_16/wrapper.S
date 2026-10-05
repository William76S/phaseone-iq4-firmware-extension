/* Exact one callsite: stock BL 51ddcc (9b64fd97), return 51ddd0.
 * No entry initializer, TLS, logger, OS function, or source pixel write.
 * The untouched stock 477038 receives the original x0..x8 exactly once.
 * Post-stock caller-volatile GPR/vector/condition/FP status is restored after
 * our C-only non-throwing observer/fill; the caller's x29/x30 are preserved.
 * Finite CFI describes this exact frame so native exceptions can traverse it.
 * The ELF backend must merge these FDEs into the real original EH lookup; target
 * unwinding is not claimed to have run merely because ET_REL has valid CFI.
 */
.text
.p2align 2
.global iq4_f1_lv_draw_wrapper_16
.type iq4_f1_lv_draw_wrapper_16,%function
iq4_f1_lv_draw_wrapper_16:
    .cfi_startproc
    sub sp,sp,#0x320
    .cfi_def_cfa_offset 0x320
    stp x0,x1,[sp,#0x00]
    stp x2,x3,[sp,#0x10]
    stp x4,x5,[sp,#0x20]
    stp x6,x7,[sp,#0x30]
    str x8,[sp,#0x40]
    add x16,sp,#0x320
    str x16,[sp,#0x48]
    str x29,[sp,#0x50]
    str x30,[sp,#0x58]
    str x29,[sp,#0x310]
    str x30,[sp,#0x318]
    .cfi_offset x29,-16
    .cfi_offset x30,-8
    mov x29,sp
    .cfi_def_cfa_register x29
    movz x16,#0x7038
    movk x16,#0x47,lsl #16
    blr x16
    stp x0,x1,[sp,#0x60]
    stp x2,x3,[sp,#0x70]
    stp x4,x5,[sp,#0x80]
    stp x6,x7,[sp,#0x90]
    stp x8,x9,[sp,#0xa0]
    stp x10,x11,[sp,#0xb0]
    stp x12,x13,[sp,#0xc0]
    stp x14,x15,[sp,#0xd0]
    stp x16,x17,[sp,#0xe0]
    str x18,[sp,#0xf0]
    mrs x16,nzcv
    str x16,[sp,#0xf8]
    mrs x16,fpcr
    str x16,[sp,#0x100]
    mrs x16,fpsr
    str x16,[sp,#0x108]
    stp q0,q1,[sp,#0x110]
    stp q2,q3,[sp,#0x130]
    stp q4,q5,[sp,#0x150]
    stp q6,q7,[sp,#0x170]
    stp q8,q9,[sp,#0x190]
    stp q10,q11,[sp,#0x1b0]
    stp q12,q13,[sp,#0x1d0]
    stp q14,q15,[sp,#0x1f0]
    stp q16,q17,[sp,#0x210]
    stp q18,q19,[sp,#0x230]
    stp q20,q21,[sp,#0x250]
    stp q22,q23,[sp,#0x270]
    stp q24,q25,[sp,#0x290]
    stp q26,q27,[sp,#0x2b0]
    stp q28,q29,[sp,#0x2d0]
    stp q30,q31,[sp,#0x2f0]
    mov x0,sp
    bl iq4_f1_after_stock_draw_16
    ldp q0,q1,[sp,#0x110]
    ldp q2,q3,[sp,#0x130]
    ldp q4,q5,[sp,#0x150]
    ldp q6,q7,[sp,#0x170]
    ldp q8,q9,[sp,#0x190]
    ldp q10,q11,[sp,#0x1b0]
    ldp q12,q13,[sp,#0x1d0]
    ldp q14,q15,[sp,#0x1f0]
    ldp q16,q17,[sp,#0x210]
    ldp q18,q19,[sp,#0x230]
    ldp q20,q21,[sp,#0x250]
    ldp q22,q23,[sp,#0x270]
    ldp q24,q25,[sp,#0x290]
    ldp q26,q27,[sp,#0x2b0]
    ldp q28,q29,[sp,#0x2d0]
    ldp q30,q31,[sp,#0x2f0]
    ldr x16,[sp,#0x100]
    msr fpcr,x16
    ldr x16,[sp,#0x108]
    msr fpsr,x16
    ldr x16,[sp,#0xf8]
    msr nzcv,x16
    ldp x0,x1,[sp,#0x60]
    ldp x2,x3,[sp,#0x70]
    ldp x4,x5,[sp,#0x80]
    ldp x6,x7,[sp,#0x90]
    ldp x8,x9,[sp,#0xa0]
    ldp x10,x11,[sp,#0xb0]
    ldp x12,x13,[sp,#0xc0]
    ldp x14,x15,[sp,#0xd0]
    ldp x16,x17,[sp,#0xe0]
    ldr x18,[sp,#0xf0]
    ldr x29,[sp,#0x310]
    ldr x30,[sp,#0x318]
    .cfi_def_cfa sp,0x320
    .cfi_restore x29
    .cfi_restore x30
    add sp,sp,#0x320
    .cfi_def_cfa_offset 0
    ret
    .cfi_endproc
.size iq4_f1_lv_draw_wrapper_16,.-iq4_f1_lv_draw_wrapper_16
.section .note.GNU-stack,"",%progbits
