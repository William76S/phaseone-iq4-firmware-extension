.text
.p2align 2
.global iq4_jpeg_pair_sd_raw_wrapper_61
.type iq4_jpeg_pair_sd_raw_wrapper_61,%function
iq4_jpeg_pair_sd_raw_wrapper_61:
 .cfi_startproc
 mov x1,sp
 stp x29,x30,[sp,-16]!
 .cfi_def_cfa_offset 16
 .cfi_offset x29,-16
 .cfi_offset x30,-8
 mov x29,sp
 mov w2,10
 bl iq4_jpeg_pair_raw_delete_61
 ldp x29,x30,[sp],16
 .cfi_def_cfa_offset 0
 .cfi_restore x29
 .cfi_restore x30
 ret
 .cfi_endproc
.size iq4_jpeg_pair_sd_raw_wrapper_61,.-iq4_jpeg_pair_sd_raw_wrapper_61
.p2align 2
.global iq4_jpeg_pair_xqd_raw_wrapper_61
.type iq4_jpeg_pair_xqd_raw_wrapper_61,%function
iq4_jpeg_pair_xqd_raw_wrapper_61:
 .cfi_startproc
 mov x1,sp
 stp x29,x30,[sp,-16]!
 .cfi_def_cfa_offset 16
 .cfi_offset x29,-16
 .cfi_offset x30,-8
 mov x29,sp
 mov w2,11
 bl iq4_jpeg_pair_raw_delete_61
 ldp x29,x30,[sp],16
 .cfi_def_cfa_offset 0
 .cfi_restore x29
 .cfi_restore x30
 ret
 .cfi_endproc
.size iq4_jpeg_pair_xqd_raw_wrapper_61,.-iq4_jpeg_pair_xqd_raw_wrapper_61

.p2align 2
.global iq4_jpeg_only_delete_wrapper_61
.type iq4_jpeg_only_delete_wrapper_61,%function
iq4_jpeg_only_delete_wrapper_61:
 .cfi_startproc
 stp x29,x30,[sp,-32]!
 .cfi_def_cfa_offset 32
 .cfi_offset x29,-32
 .cfi_offset x30,-24
 mov x29,sp
 bl iq4_pair_original_sd_mode_get_61
 str x0,[sp,16]
 add x0,sp,32
 bl iq4_jpeg_only_delete_61
 ldr x0,[sp,16]
 ldp x29,x30,[sp],32
 .cfi_def_cfa_offset 0
 .cfi_restore x29
 .cfi_restore x30
 ret
 .cfi_endproc
.size iq4_jpeg_only_delete_wrapper_61,.-iq4_jpeg_only_delete_wrapper_61
.section .note.GNU-stack,"",@progbits
