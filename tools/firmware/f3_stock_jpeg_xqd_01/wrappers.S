.text
.p2align 2
.global iq4_stock_jpeg_ctor_wrapper_01
.type iq4_stock_jpeg_ctor_wrapper_01,%function
iq4_stock_jpeg_ctor_wrapper_01:
 .cfi_startproc
 sub sp,sp,#0x20
 .cfi_def_cfa_offset 0x20
 stp x29,x30,[sp,#0x10]
 .cfi_offset x29,-16
 .cfi_offset x30,-8
 mov x29,sp
 .cfi_def_cfa_register x29
 add x6,sp,#0x20
 bl iq4_stock_jpeg_ctor_01
 ldp x29,x30,[sp,#0x10]
 .cfi_def_cfa sp,0x20
 .cfi_restore x29
 .cfi_restore x30
 add sp,sp,#0x20
 .cfi_def_cfa_offset 0
 ret
 .cfi_endproc
.size iq4_stock_jpeg_ctor_wrapper_01,.-iq4_stock_jpeg_ctor_wrapper_01
