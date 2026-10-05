
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_storage_bridge_01/build/storage_wrappers.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_storage_output_append_wrapper_01>:
       0: d10443ff     	sub	sp, sp, #0x110
       4: a9107bfd     	stp	x29, x30, [sp, #0x100]
       8: 910003fd     	mov	x29, sp
       c: a90007e0     	stp	x0, x1, [sp]
      10: a9010fe2     	stp	x2, x3, [sp, #0x10]
      14: a90217e4     	stp	x4, x5, [sp, #0x20]
      18: a9031fe6     	stp	x6, x7, [sp, #0x30]
      1c: f90023e8     	str	x8, [sp, #0x40]
      20: d53b4209     	mrs	x9, NZCV
      24: f90027e9     	str	x9, [sp, #0x48]
      28: ad0287e0     	stp	q0, q1, [sp, #0x50]
      2c: ad038fe2     	stp	q2, q3, [sp, #0x70]
      30: ad0497e4     	stp	q4, q5, [sp, #0x90]
      34: ad059fe6     	stp	q6, q7, [sp, #0xb0]
      38: aa1e03e2     	mov	x2, x30
      3c: 94000000     	bl	0x3c <iq4_f3_storage_output_append_wrapper_01+0x3c>
		000000000000003c:  R_AARCH64_CALL26	iq4_f3_storage_output_child_01
      40: f90007e0     	str	x0, [sp, #0x8]
      44: ad4287e0     	ldp	q0, q1, [sp, #0x50]
      48: ad438fe2     	ldp	q2, q3, [sp, #0x70]
      4c: ad4497e4     	ldp	q4, q5, [sp, #0x90]
      50: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
      54: f94027e9     	ldr	x9, [sp, #0x48]
      58: d51b4209     	msr	NZCV, x9
      5c: a94007e0     	ldp	x0, x1, [sp]
      60: a9410fe2     	ldp	x2, x3, [sp, #0x10]
      64: a94217e4     	ldp	x4, x5, [sp, #0x20]
      68: a9431fe6     	ldp	x6, x7, [sp, #0x30]
      6c: f94023e8     	ldr	x8, [sp, #0x40]
      70: a9507bfd     	ldp	x29, x30, [sp, #0x100]
      74: 910443ff     	add	sp, sp, #0x110
      78: d28b1710     	mov	x16, #0x58b8            // =22712
      7c: f2a009d0     	movk	x16, #0x4e, lsl #16
      80: d61f0200     	br	x16

0000000000000084 <iq4_f3_storage_regular_enter_01>:
      84: d10443ff     	sub	sp, sp, #0x110
      88: a9107bfd     	stp	x29, x30, [sp, #0x100]
      8c: 910003fd     	mov	x29, sp
      90: a90007e0     	stp	x0, x1, [sp]
      94: a9010fe2     	stp	x2, x3, [sp, #0x10]
      98: a90217e4     	stp	x4, x5, [sp, #0x20]
      9c: a9031fe6     	stp	x6, x7, [sp, #0x30]
      a0: f90023e8     	str	x8, [sp, #0x40]
      a4: d53b4209     	mrs	x9, NZCV
      a8: f90027e9     	str	x9, [sp, #0x48]
      ac: ad0287e0     	stp	q0, q1, [sp, #0x50]
      b0: ad038fe2     	stp	q2, q3, [sp, #0x70]
      b4: ad0497e4     	stp	q4, q5, [sp, #0x90]
      b8: ad059fe6     	stp	q6, q7, [sp, #0xb0]
      bc: f9409fe0     	ldr	x0, [sp, #0x138]
      c0: b94137e1     	ldr	w1, [sp, #0x134]
      c4: f9408fe2     	ldr	x2, [sp, #0x118]
      c8: 52800003     	mov	w3, #0x0                // =0
      cc: 94000000     	bl	0xcc <iq4_f3_storage_regular_enter_01+0x48>
		00000000000000cc:  R_AARCH64_CALL26	iq4_f3_storage_enter_01
      d0: b90137e0     	str	w0, [sp, #0x134]
      d4: d360fc00     	lsr	x0, x0, #32
      d8: b90143e0     	str	w0, [sp, #0x140]
      dc: ad4287e0     	ldp	q0, q1, [sp, #0x50]
      e0: ad438fe2     	ldp	q2, q3, [sp, #0x70]
      e4: ad4497e4     	ldp	q4, q5, [sp, #0x90]
      e8: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
      ec: f94027e9     	ldr	x9, [sp, #0x48]
      f0: d51b4209     	msr	NZCV, x9
      f4: a94007e0     	ldp	x0, x1, [sp]
      f8: a9410fe2     	ldp	x2, x3, [sp, #0x10]
      fc: a94217e4     	ldp	x4, x5, [sp, #0x20]
     100: a9431fe6     	ldp	x6, x7, [sp, #0x30]
     104: f94023e8     	ldr	x8, [sp, #0x40]
     108: a9507bfd     	ldp	x29, x30, [sp, #0x100]
     10c: 910443ff     	add	sp, sp, #0x110
     110: f94017e0     	ldr	x0, [sp, #0x28]
     114: d2931110     	mov	x16, #0x9888            // =39048
     118: f2a00bd0     	movk	x16, #0x5e, lsl #16
     11c: d61f0200     	br	x16

0000000000000120 <iq4_f3_storage_regular_leave_01>:
     120: d10443ff     	sub	sp, sp, #0x110
     124: a9107bfd     	stp	x29, x30, [sp, #0x100]
     128: 910003fd     	mov	x29, sp
     12c: a90007e0     	stp	x0, x1, [sp]
     130: a9010fe2     	stp	x2, x3, [sp, #0x10]
     134: a90217e4     	stp	x4, x5, [sp, #0x20]
     138: a9031fe6     	stp	x6, x7, [sp, #0x30]
     13c: f90023e8     	str	x8, [sp, #0x40]
     140: d53b4209     	mrs	x9, NZCV
     144: f90027e9     	str	x9, [sp, #0x48]
     148: ad0287e0     	stp	q0, q1, [sp, #0x50]
     14c: ad038fe2     	stp	q2, q3, [sp, #0x70]
     150: ad0497e4     	stp	q4, q5, [sp, #0x90]
     154: ad059fe6     	stp	q6, q7, [sp, #0xb0]
     158: b94143e0     	ldr	w0, [sp, #0x140]
     15c: 94000000     	bl	0x15c <iq4_f3_storage_regular_leave_01+0x3c>
		000000000000015c:  R_AARCH64_CALL26	iq4_f3_storage_leave_01
     160: ad4287e0     	ldp	q0, q1, [sp, #0x50]
     164: ad438fe2     	ldp	q2, q3, [sp, #0x70]
     168: ad4497e4     	ldp	q4, q5, [sp, #0x90]
     16c: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
     170: f94027e9     	ldr	x9, [sp, #0x48]
     174: d51b4209     	msr	NZCV, x9
     178: a94007e0     	ldp	x0, x1, [sp]
     17c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
     180: a94217e4     	ldp	x4, x5, [sp, #0x20]
     184: a9431fe6     	ldp	x6, x7, [sp, #0x30]
     188: f94023e8     	ldr	x8, [sp, #0x40]
     18c: a9507bfd     	ldp	x29, x30, [sp, #0x100]
     190: 910443ff     	add	sp, sp, #0x110
     194: 9100e3e0     	add	x0, sp, #0x38
     198: d2931890     	mov	x16, #0x98c4            // =39108
     19c: f2a00bd0     	movk	x16, #0x5e, lsl #16
     1a0: d61f0200     	br	x16

00000000000001a4 <iq4_f3_storage_silent_enter_01>:
     1a4: d10443ff     	sub	sp, sp, #0x110
     1a8: a9107bfd     	stp	x29, x30, [sp, #0x100]
     1ac: 910003fd     	mov	x29, sp
     1b0: a90007e0     	stp	x0, x1, [sp]
     1b4: a9010fe2     	stp	x2, x3, [sp, #0x10]
     1b8: a90217e4     	stp	x4, x5, [sp, #0x20]
     1bc: a9031fe6     	stp	x6, x7, [sp, #0x30]
     1c0: f90023e8     	str	x8, [sp, #0x40]
     1c4: d53b4209     	mrs	x9, NZCV
     1c8: f90027e9     	str	x9, [sp, #0x48]
     1cc: ad0287e0     	stp	q0, q1, [sp, #0x50]
     1d0: ad038fe2     	stp	q2, q3, [sp, #0x70]
     1d4: ad0497e4     	stp	q4, q5, [sp, #0x90]
     1d8: ad059fe6     	stp	q6, q7, [sp, #0xb0]
     1dc: f94097e0     	ldr	x0, [sp, #0x128]
     1e0: b94127e1     	ldr	w1, [sp, #0x124]
     1e4: f9408fe2     	ldr	x2, [sp, #0x118]
     1e8: 52800023     	mov	w3, #0x1                // =1
     1ec: 94000000     	bl	0x1ec <iq4_f3_storage_silent_enter_01+0x48>
		00000000000001ec:  R_AARCH64_CALL26	iq4_f3_storage_enter_01
     1f0: b90127e0     	str	w0, [sp, #0x124]
     1f4: d360fc00     	lsr	x0, x0, #32
     1f8: b90133e0     	str	w0, [sp, #0x130]
     1fc: ad4287e0     	ldp	q0, q1, [sp, #0x50]
     200: ad438fe2     	ldp	q2, q3, [sp, #0x70]
     204: ad4497e4     	ldp	q4, q5, [sp, #0x90]
     208: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
     20c: f94027e9     	ldr	x9, [sp, #0x48]
     210: d51b4209     	msr	NZCV, x9
     214: a94007e0     	ldp	x0, x1, [sp]
     218: a9410fe2     	ldp	x2, x3, [sp, #0x10]
     21c: a94217e4     	ldp	x4, x5, [sp, #0x20]
     220: a9431fe6     	ldp	x6, x7, [sp, #0x30]
     224: f94023e8     	ldr	x8, [sp, #0x40]
     228: a9507bfd     	ldp	x29, x30, [sp, #0x100]
     22c: 910443ff     	add	sp, sp, #0x110
     230: f9400fe0     	ldr	x0, [sp, #0x18]
     234: d2932090     	mov	x16, #0x9904            // =39172
     238: f2a00bd0     	movk	x16, #0x5e, lsl #16
     23c: d61f0200     	br	x16

0000000000000240 <iq4_f3_storage_silent_leave_01>:
     240: d10443ff     	sub	sp, sp, #0x110
     244: a9107bfd     	stp	x29, x30, [sp, #0x100]
     248: 910003fd     	mov	x29, sp
     24c: a90007e0     	stp	x0, x1, [sp]
     250: a9010fe2     	stp	x2, x3, [sp, #0x10]
     254: a90217e4     	stp	x4, x5, [sp, #0x20]
     258: a9031fe6     	stp	x6, x7, [sp, #0x30]
     25c: f90023e8     	str	x8, [sp, #0x40]
     260: d53b4209     	mrs	x9, NZCV
     264: f90027e9     	str	x9, [sp, #0x48]
     268: ad0287e0     	stp	q0, q1, [sp, #0x50]
     26c: ad038fe2     	stp	q2, q3, [sp, #0x70]
     270: ad0497e4     	stp	q4, q5, [sp, #0x90]
     274: ad059fe6     	stp	q6, q7, [sp, #0xb0]
     278: b94133e0     	ldr	w0, [sp, #0x130]
     27c: 94000000     	bl	0x27c <iq4_f3_storage_silent_leave_01+0x3c>
		000000000000027c:  R_AARCH64_CALL26	iq4_f3_storage_leave_01
     280: ad4287e0     	ldp	q0, q1, [sp, #0x50]
     284: ad438fe2     	ldp	q2, q3, [sp, #0x70]
     288: ad4497e4     	ldp	q4, q5, [sp, #0x90]
     28c: ad459fe6     	ldp	q6, q7, [sp, #0xb0]
     290: f94027e9     	ldr	x9, [sp, #0x48]
     294: d51b4209     	msr	NZCV, x9
     298: a94007e0     	ldp	x0, x1, [sp]
     29c: a9410fe2     	ldp	x2, x3, [sp, #0x10]
     2a0: a94217e4     	ldp	x4, x5, [sp, #0x20]
     2a4: a9431fe6     	ldp	x6, x7, [sp, #0x30]
     2a8: f94023e8     	ldr	x8, [sp, #0x40]
     2ac: a9507bfd     	ldp	x29, x30, [sp, #0x100]
     2b0: 910443ff     	add	sp, sp, #0x110
     2b4: 9100a3e0     	add	x0, sp, #0x28
     2b8: d2932210     	mov	x16, #0x9910            // =39184
     2bc: f2a00bd0     	movk	x16, #0x5e, lsl #16
     2c0: d61f0200     	br	x16

00000000000002c4 <iq4_f3_storage_ui_set_call_01>:
     2c4: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     2c8: 910003fd     	mov	x29, sp
     2cc: d2930d10     	mov	x16, #0x9868            // =39016
     2d0: f2a00bd0     	movk	x16, #0x5e, lsl #16
     2d4: d63f0200     	blr	x16

00000000000002d8 <iq4_f3_storage_ui_set_return_01>:
     2d8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     2dc: d65f03c0     	ret
