/* Tail-branch leaves original49d9d4 in LR. C++ entry emits its own real EH
 * metadata. It never catches an exception from original71384c. */
.text
.p2align 2
.global iq4_f3_ifm_wait_wrapper_01
.type iq4_f3_ifm_wait_wrapper_01,%function
iq4_f3_ifm_wait_wrapper_01:
 .cfi_startproc
 b iq4_f3_ifm_wait_entry_01
 .cfi_endproc
.size iq4_f3_ifm_wait_wrapper_01,.-iq4_f3_ifm_wait_wrapper_01
.section .note.GNU-stack,"",%progbits
