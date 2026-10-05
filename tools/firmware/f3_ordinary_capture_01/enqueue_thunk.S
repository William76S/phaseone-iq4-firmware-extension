.text
.p2align 2
.global iq4_f3_ordinary_enqueue_thunk_01
.type iq4_f3_ordinary_enqueue_thunk_01,%function
/* Only the exact 79d300 call site supplies CM in original callee-saved x19.
 * Tail branch keeps the original BL return address and the original unwinder.
 * x0=NodeManager and x1=node remain the actual native queue arguments. */
iq4_f3_ordinary_enqueue_thunk_01:
 .cfi_startproc
 mov x2,x19
 b iq4_f3_ordinary_enqueue_wrapper_01
 .cfi_endproc
.size iq4_f3_ordinary_enqueue_thunk_01,.-iq4_f3_ordinary_enqueue_thunk_01
.p2align 2
.global iq4_f3_ordinary_queue_unlock_thunk_01
.type iq4_f3_ordinary_queue_unlock_thunk_01,%function
/* Exact 8c7184 normal cleanup call: stack belongs to 8c709c, w19 is the
 * original bool from 8c7804, x0 points to the still-held mutex RAII guard.
 * Exception cleanup 8c7198 remains completely stock. */
iq4_f3_ordinary_queue_unlock_thunk_01:
 .cfi_startproc
 ldr x1,[sp,#0x28]
 ldr x2,[sp,#0x20]
 mov w3,w19
 b iq4_f3_ordinary_queue_unlock_wrapper_01
 .cfi_endproc
.size iq4_f3_ordinary_queue_unlock_thunk_01,.-iq4_f3_ordinary_queue_unlock_thunk_01
.section .note.GNU-stack,"",@progbits
