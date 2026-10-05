// Exact caller 4eef2c. Original ctor uses x0..7 and one 8B stack argument.
// Forward that stack word, hidden x8 and every register argument unchanged.
.text
.p2align 4
.global iq4_f1_lv_ctor_wrapper_01
.type iq4_f1_lv_ctor_wrapper_01,%function
iq4_f1_lv_ctor_wrapper_01:
 .cfi_startproc
 sub sp,sp,#256
 .cfi_def_cfa_offset 256
 stp x29,x30,[sp,#16]
 .cfi_offset x29,-240
 .cfi_offset x30,-232
 mov x29,sp
 stp x0,x2,[sp,#32]
 ldr x9,[sp,#256]
 str x9,[sp]
 bl iq4_stock_lv_ctor_01
 stp x0,x1,[sp,#48]
 stp x2,x3,[sp,#64]
 stp x4,x5,[sp,#80]
 stp x6,x7,[sp,#96]
 str x8,[sp,#112]
 stp q0,q1,[sp,#128]
 stp q2,q3,[sp,#160]
 mrs x9,fpcr
 mrs x10,fpsr
 stp x9,x10,[sp,#192]
 ldp x0,x1,[sp,#32]
 ldr x2,[sp,#24] // actual original caller LR, not a supplied constant receipt
 bl iq4_f1_publish_ctor_on_return_01
 ldp x9,x10,[sp,#192]
 msr fpcr,x9
 msr fpsr,x10
 ldp q0,q1,[sp,#128]
 ldp q2,q3,[sp,#160]
 ldp x0,x1,[sp,#48]
 ldp x2,x3,[sp,#64]
 ldp x4,x5,[sp,#80]
 ldp x6,x7,[sp,#96]
 ldr x8,[sp,#112]
 ldp x29,x30,[sp,#16]
 add sp,sp,#256
 .cfi_def_cfa_offset 0
 ret
 .cfi_endproc
.size iq4_f1_lv_ctor_wrapper_01,.-iq4_f1_lv_ctor_wrapper_01
.section .note.GNU-stack,"",%progbits
