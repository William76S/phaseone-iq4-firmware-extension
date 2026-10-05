
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_executor_build_01_final/native_calls.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <f3_executor_read_01>:
       0: aa0203e3     	mov	x3, x2
       4: aa0103e2     	mov	x2, x1
       8: aa0003e1     	mov	x1, x0
       c: aa1f03e0     	mov	x0, xzr
      10: 14000000     	b	0x10 <f3_executor_read_01+0x10>
		0000000000000010:  R_AARCH64_JUMP26	iq4_native_self_read_01

0000000000000014 <f3_executor_current_01>:
      14: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
      18: f9000bf3     	str	x19, [sp, #0x10]
      1c: 910003fd     	mov	x29, sp
      20: aa0003f3     	mov	x19, x0
      24: 52816188     	mov	w8, #0xb0c              // =2828
      28: 72a00e28     	movk	w8, #0x71, lsl #16
      2c: d63f0100     	blr	x8
      30: f9000260     	str	x0, [x19]
      34: 52800020     	mov	w0, #0x1                // =1
      38: f9400bf3     	ldr	x19, [sp, #0x10]
      3c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      40: d65f03c0     	ret
      44: 94000000     	bl	0x44 <f3_executor_current_01+0x30>
		0000000000000044:  R_AARCH64_CALL26	__cxa_begin_catch
      48: 94000000     	bl	0x48 <f3_executor_current_01+0x34>
		0000000000000048:  R_AARCH64_CALL26	__cxa_end_catch
      4c: 2a1f03e0     	mov	w0, wzr
      50: 17fffffa     	b	0x38 <f3_executor_current_01+0x24>

0000000000000054 <f3_executor_tid_01>:
      54: 14000000     	b	0x54 <f3_executor_tid_01>
		0000000000000054:  R_AARCH64_JUMP26	iq4_native_current_tid_01

0000000000000058 <f3_executor_event_ctor_01>:
      58: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
      5c: 910003fd     	mov	x29, sp
      60: 529e2588     	mov	w8, #0xf12c             // =61740
      64: 90000001     	adrp	x1, 0x0 <f3_executor_read_01>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
      68: 91000021     	add	x1, x1, #0x0
		0000000000000068:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
      6c: 72a00e08     	movk	w8, #0x70, lsl #16
      70: d63f0100     	blr	x8
      74: 52800020     	mov	w0, #0x1                // =1
      78: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      7c: d65f03c0     	ret
      80: 94000000     	bl	0x80 <f3_executor_event_ctor_01+0x28>
		0000000000000080:  R_AARCH64_CALL26	__cxa_begin_catch
      84: 94000000     	bl	0x84 <f3_executor_event_ctor_01+0x2c>
		0000000000000084:  R_AARCH64_CALL26	__cxa_end_catch
      88: 2a1f03e0     	mov	w0, wzr
      8c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      90: d65f03c0     	ret

0000000000000094 <f3_executor_listener_ctor_01>:
      94: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
      98: 910003fd     	mov	x29, sp
      9c: 5280a488     	mov	w8, #0x524              // =1316
      a0: 72a00e28     	movk	w8, #0x71, lsl #16
      a4: d63f0100     	blr	x8
      a8: 52800020     	mov	w0, #0x1                // =1
      ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      b0: d65f03c0     	ret
      b4: 94000000     	bl	0xb4 <f3_executor_listener_ctor_01+0x20>
		00000000000000b4:  R_AARCH64_CALL26	__cxa_begin_catch
      b8: 94000000     	bl	0xb8 <f3_executor_listener_ctor_01+0x24>
		00000000000000b8:  R_AARCH64_CALL26	__cxa_end_catch
      bc: 2a1f03e0     	mov	w0, wzr
      c0: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      c4: d65f03c0     	ret

00000000000000c8 <f3_executor_event_notify_01>:
      c8: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
      cc: 910003fd     	mov	x29, sp
      d0: 529e5f08     	mov	w8, #0xf2f8             // =62200
      d4: 72a00e08     	movk	w8, #0x70, lsl #16
      d8: d63f0100     	blr	x8
      dc: 52800020     	mov	w0, #0x1                // =1
      e0: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      e4: d65f03c0     	ret
      e8: 94000000     	bl	0xe8 <f3_executor_event_notify_01+0x20>
		00000000000000e8:  R_AARCH64_CALL26	__cxa_begin_catch
      ec: 94000000     	bl	0xec <f3_executor_event_notify_01+0x24>
		00000000000000ec:  R_AARCH64_CALL26	__cxa_end_catch
      f0: 2a1f03e0     	mov	w0, wzr
      f4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      f8: d65f03c0     	ret

00000000000000fc <f3_executor_selected_get_01>:
      fc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     100: f9000bf3     	str	x19, [sp, #0x10]
     104: 910003fd     	mov	x29, sp
     108: aa0103f3     	mov	x19, x1
     10c: 52991008     	mov	w8, #0xc880             // =51328
     110: 72a00808     	movk	w8, #0x40, lsl #16
     114: d63f0100     	blr	x8
     118: b9000260     	str	w0, [x19]
     11c: 52800020     	mov	w0, #0x1                // =1
     120: f9400bf3     	ldr	x19, [sp, #0x10]
     124: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     128: d65f03c0     	ret
     12c: 94000000     	bl	0x12c <f3_executor_selected_get_01+0x30>
		000000000000012c:  R_AARCH64_CALL26	__cxa_begin_catch
     130: 94000000     	bl	0x130 <f3_executor_selected_get_01+0x34>
		0000000000000130:  R_AARCH64_CALL26	__cxa_end_catch
     134: 2a1f03e0     	mov	w0, wzr
     138: 17fffffa     	b	0x120 <f3_executor_selected_get_01+0x24>

000000000000013c <f3_executor_pthread_self_01>:
     13c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     140: 910003fd     	mov	x29, sp
     144: 52963a08     	mov	w8, #0xb1d0             // =45520
     148: 72a00808     	movk	w8, #0x40, lsl #16
     14c: d63f0100     	blr	x8
     150: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     154: d65f03c0     	ret
     158: 94000000     	bl	0x158 <f3_executor_pthread_self_01+0x1c>
		0000000000000158:  R_AARCH64_CALL26	__cxa_begin_catch
     15c: 94000000     	bl	0x15c <f3_executor_pthread_self_01+0x20>
		000000000000015c:  R_AARCH64_CALL26	__cxa_end_catch
     160: aa1f03e0     	mov	x0, xzr
     164: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     168: d65f03c0     	ret

000000000000016c <f3_executor_clock_01>:
     16c: d10043ff     	sub	sp, sp, #0x10
     170: 52800020     	mov	w0, #0x1                // =1
     174: 910003e1     	mov	x1, sp
     178: 52800e28     	mov	w8, #0x71               // =113
     17c: d4000001     	svc	#0
     180: a8c12be8     	ldp	x8, x10, [sp], #0x10
     184: 52993fe9     	mov	w9, #0xc9ff             // =51711
     188: d28fa08c     	mov	x12, #0x7d04            // =32004
     18c: 72a77349     	movk	w9, #0x3b9a, lsl #16
     190: f2a4b82c     	movk	x12, #0x25c1, lsl #16
     194: 9b09210b     	madd	x11, x8, x9, x8
     198: f2c0004c     	movk	x12, #0x2, lsl #32
     19c: eb0c011f     	cmp	x8, x12
     1a0: fa49d142     	ccmp	x10, x9, #0x2, le
     1a4: fa409908     	ccmp	x8, #0x0, #0x8, ls
     1a8: fa40a800     	ccmp	x0, #0x0, #0x0, ge
     1ac: 8b0a0168     	add	x8, x11, x10
     1b0: 9a8813e0     	csel	x0, xzr, x8, ne
     1b4: d65f03c0     	ret

00000000000001b8 <f3_executor_pause_01>:
     1b8: 90000008     	adrp	x8, 0x0 <f3_executor_read_01>
		00000000000001b8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.cst16
     1bc: 91000108     	add	x8, x8, #0x0
		00000000000001bc:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.cst16
     1c0: 3dc00100     	ldr	q0, [x8]
     1c4: 3c9f0fe0     	str	q0, [sp, #-0x10]!
     1c8: 910003e0     	mov	x0, sp
     1cc: 52800ca8     	mov	w8, #0x65               // =101
     1d0: aa1f03e1     	mov	x1, xzr
     1d4: d4000001     	svc	#0
     1d8: f100001f     	cmp	x0, #0x0
     1dc: ba441804     	ccmn	x0, #0x4, #0x4, ne
     1e0: 1a9f17e0     	cset	w0, eq
     1e4: 910043ff     	add	sp, sp, #0x10
     1e8: d65f03c0     	ret
