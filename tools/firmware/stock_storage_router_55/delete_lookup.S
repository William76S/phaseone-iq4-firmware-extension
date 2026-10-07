.text
.p2align 2
.global iq4_stock_delete_lookup_wrapper_55
.type iq4_stock_delete_lookup_wrapper_55,%function
iq4_stock_delete_lookup_wrapper_55:
 .cfi_startproc
 stp x29,x30,[sp,#-64]!
 .cfi_def_cfa_offset 64
 .cfi_offset x29,-64
 .cfi_offset x30,-56
 mov x29,sp
 str x19,[sp,#16]
 .cfi_offset x19,-48
 str x1,[sp,#24]
 bl iq4_stock_original_catalog_lookup_55
 str x0,[sp,#32]
 ldr x1,[sp,#24]
 bl iq4_stock_delete_lookup_guard_55
 cbnz w0,1f
 ldr x0,[sp,#32]
 ldrb w19,[x0,#14]
1:
 ldr x0,[sp,#32]
 ldp x29,x30,[sp],#64
 .cfi_def_cfa_offset 0
 .cfi_restore x29
 .cfi_restore x30
 .cfi_restore x19
 ret
 .cfi_endproc
.size iq4_stock_delete_lookup_wrapper_55,.-iq4_stock_delete_lookup_wrapper_55
.section .note.GNU-stack,"",%progbits
