.text
.p2align 2
.global iq4_stock_half_inner_wait_wrapper_55
.type iq4_stock_half_inner_wait_wrapper_55,%function
iq4_stock_half_inner_wait_wrapper_55:
 .cfi_startproc
 stp x29,x30,[sp,#-32]!
 .cfi_def_cfa_offset 32
 .cfi_offset x29,-32
 .cfi_offset x30,-24
 mov x29,sp
 add x3,sp,#32
 bl iq4_stock_half_inner_wait_55
 ldp x29,x30,[sp],#32
 .cfi_def_cfa_offset 0
 .cfi_restore x29
 .cfi_restore x30
 ret
 .cfi_endproc
.size iq4_stock_half_inner_wait_wrapper_55,.-iq4_stock_half_inner_wait_wrapper_55
.section .note.GNU-stack,"",%progbits
