/* Original LV Settings SetMenu, Ratio Mask only. Preserve argument and
 * floating-point registers, flags, SP and LR before original navigation. */
.text
.p2align 2
.global iq4_extensions_lv_menu_wrapper_01
.type iq4_extensions_lv_menu_wrapper_01,%function
iq4_extensions_lv_menu_wrapper_01:
 .cfi_startproc
 sub sp,sp,#0x100
 .cfi_def_cfa_offset 0x100
 stp x29,x30,[sp,#0xf0]
 .cfi_offset x29,-16
 .cfi_offset x30,-8
 mov x29,sp
 .cfi_def_cfa_register x29
 stp x0,x1,[sp]
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
 mov x2,x30
 bl iq4_f1_before_native_menu_04
 ldp q0,q1,[sp,#0x50]
 ldp q2,q3,[sp,#0x70]
 ldp q4,q5,[sp,#0x90]
 ldp q6,q7,[sp,#0xb0]
 ldr x9,[sp,#0x48]
 msr nzcv,x9
 ldp x0,x1,[sp]
 ldp x2,x3,[sp,#0x10]
 ldp x4,x5,[sp,#0x20]
 ldp x6,x7,[sp,#0x30]
 ldr x8,[sp,#0x40]
 ldp x29,x30,[sp,#0xf0]
 .cfi_def_cfa sp,0x100
 .cfi_restore x29
 .cfi_restore x30
 add sp,sp,#0x100
 .cfi_def_cfa_offset 0
 b iq4_stock_menu_set_01
 .cfi_endproc
.size iq4_extensions_lv_menu_wrapper_01,.-iq4_extensions_lv_menu_wrapper_01
.section .note.GNU-stack,"",%progbits
