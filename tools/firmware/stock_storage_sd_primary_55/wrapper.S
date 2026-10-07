.text
.balign 4
.global iq4_stock_storage_policy_wrapper_55
.type iq4_stock_storage_policy_wrapper_55,%function
iq4_stock_storage_policy_wrapper_55:
 .cfi_startproc
 stp x29,x30,[sp,#-32]!
 .cfi_def_cfa_offset 32
 .cfi_offset x29,-32
 .cfi_offset x30,-24
 mov x29,sp
 str x19,[sp,#16]
 .cfi_offset x19,-16
 mov x19,x0
 bl iq4_stock_storage_original_policy_55
 mov x0,x19
 bl iq4_stock_storage_after_policy_55
 ldr x19,[sp,#16]
 .cfi_restore x19
 ldp x29,x30,[sp],#32
 .cfi_restore x29
 .cfi_restore x30
 .cfi_def_cfa_offset 0
 ret
 .cfi_endproc
.size iq4_stock_storage_policy_wrapper_55,.-iq4_stock_storage_policy_wrapper_55
