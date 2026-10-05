
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_core_native_receipt_build_01_combined_decode/wrappers.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_core_native_wrapper_01>:
       0: d10603ff     	sub	sp, sp, #0x180
       4: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
       8: 910003fd     	mov	x29, sp
       c: a9102be9     	stp	x9, x10, [sp, #0x100]
      10: a91133eb     	stp	x11, x12, [sp, #0x110]
      14: a9123bed     	stp	x13, x14, [sp, #0x120]
      18: a91343ef     	stp	x15, x16, [sp, #0x130]
      1c: a9144bf1     	stp	x17, x18, [sp, #0x140]
      20: a90107e0     	stp	x0, x1, [sp, #0x10]
      24: a9020fe2     	stp	x2, x3, [sp, #0x20]
      28: a90317e4     	stp	x4, x5, [sp, #0x30]
      2c: a9041fe6     	stp	x6, x7, [sp, #0x40]
      30: f9002be8     	str	x8, [sp, #0x50]
      34: d53b4209     	mrs	x9, NZCV
      38: f9002fe9     	str	x9, [sp, #0x58]
      3c: ad0307e0     	stp	q0, q1, [sp, #0x60]
      40: ad040fe2     	stp	q2, q3, [sp, #0x80]
      44: ad0517e4     	stp	q4, q5, [sp, #0xa0]
      48: ad061fe6     	stp	q6, q7, [sp, #0xc0]
      4c: f940c3e9     	ldr	x9, [sp, #0x180]
      50: f90003e9     	str	x9, [sp]
      54: 910043e0     	add	x0, sp, #0x10
      58: aa0903e1     	mov	x1, x9
      5c: f94077e2     	ldr	x2, [sp, #0xe8]
      60: 94000000     	bl	0x60 <iq4_f3_core_native_wrapper_01+0x60>
		0000000000000060:  R_AARCH64_CALL26	iq4_f3_core_before_01
      64: ad4307e0     	ldp	q0, q1, [sp, #0x60]
      68: ad440fe2     	ldp	q2, q3, [sp, #0x80]
      6c: ad4517e4     	ldp	q4, q5, [sp, #0xa0]
      70: ad461fe6     	ldp	q6, q7, [sp, #0xc0]
      74: f9402fe9     	ldr	x9, [sp, #0x58]
      78: d51b4209     	msr	NZCV, x9
      7c: a94107e0     	ldp	x0, x1, [sp, #0x10]
      80: a9420fe2     	ldp	x2, x3, [sp, #0x20]
      84: a94317e4     	ldp	x4, x5, [sp, #0x30]
      88: a9441fe6     	ldp	x6, x7, [sp, #0x40]
      8c: f9402be8     	ldr	x8, [sp, #0x50]
      90: a9502be9     	ldp	x9, x10, [sp, #0x100]
      94: a95133eb     	ldp	x11, x12, [sp, #0x110]
      98: a9523bed     	ldp	x13, x14, [sp, #0x120]
      9c: a95343ef     	ldp	x15, x16, [sp, #0x130]
      a0: a9544bf1     	ldp	x17, x18, [sp, #0x140]
      a4: 94000000     	bl	0xa4 <iq4_f3_core_native_wrapper_01+0xa4>
		00000000000000a4:  R_AARCH64_CALL26	iq4_f3_original_core_01
      a8: a9102be9     	stp	x9, x10, [sp, #0x100]
      ac: a91133eb     	stp	x11, x12, [sp, #0x110]
      b0: a9123bed     	stp	x13, x14, [sp, #0x120]
      b4: a91343ef     	stp	x15, x16, [sp, #0x130]
      b8: a9144bf1     	stp	x17, x18, [sp, #0x140]
      bc: a90107e0     	stp	x0, x1, [sp, #0x10]
      c0: a9020fe2     	stp	x2, x3, [sp, #0x20]
      c4: a90317e4     	stp	x4, x5, [sp, #0x30]
      c8: a9041fe6     	stp	x6, x7, [sp, #0x40]
      cc: f9002be8     	str	x8, [sp, #0x50]
      d0: d53b4209     	mrs	x9, NZCV
      d4: f9002fe9     	str	x9, [sp, #0x58]
      d8: ad0307e0     	stp	q0, q1, [sp, #0x60]
      dc: ad040fe2     	stp	q2, q3, [sp, #0x80]
      e0: ad0517e4     	stp	q4, q5, [sp, #0xa0]
      e4: ad061fe6     	stp	q6, q7, [sp, #0xc0]
      e8: 94000000     	bl	0xe8 <iq4_f3_core_native_wrapper_01+0xe8>
		00000000000000e8:  R_AARCH64_CALL26	iq4_f3_core_after_01
      ec: ad4307e0     	ldp	q0, q1, [sp, #0x60]
      f0: ad440fe2     	ldp	q2, q3, [sp, #0x80]
      f4: ad4517e4     	ldp	q4, q5, [sp, #0xa0]
      f8: ad461fe6     	ldp	q6, q7, [sp, #0xc0]
      fc: f9402fe9     	ldr	x9, [sp, #0x58]
     100: d51b4209     	msr	NZCV, x9
     104: a94107e0     	ldp	x0, x1, [sp, #0x10]
     108: a9420fe2     	ldp	x2, x3, [sp, #0x20]
     10c: a94317e4     	ldp	x4, x5, [sp, #0x30]
     110: a9441fe6     	ldp	x6, x7, [sp, #0x40]
     114: f9402be8     	ldr	x8, [sp, #0x50]
     118: a9502be9     	ldp	x9, x10, [sp, #0x100]
     11c: a95133eb     	ldp	x11, x12, [sp, #0x110]
     120: a9523bed     	ldp	x13, x14, [sp, #0x120]
     124: a95343ef     	ldp	x15, x16, [sp, #0x130]
     128: a9544bf1     	ldp	x17, x18, [sp, #0x140]
     12c: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
     130: 910603ff     	add	sp, sp, #0x180
     134: d65f03c0     	ret

0000000000000138 <iq4_f3_core_native_join_wrapper_01>:
     138: d10603ff     	sub	sp, sp, #0x180
     13c: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
     140: 910003fd     	mov	x29, sp
     144: f900abe0     	str	x0, [sp, #0x150]
     148: 94000000     	bl	0x148 <iq4_f3_core_native_join_wrapper_01+0x10>
		0000000000000148:  R_AARCH64_CALL26	iq4_f3_original_pool_join_01
     14c: a9102be9     	stp	x9, x10, [sp, #0x100]
     150: a91133eb     	stp	x11, x12, [sp, #0x110]
     154: a9123bed     	stp	x13, x14, [sp, #0x120]
     158: a91343ef     	stp	x15, x16, [sp, #0x130]
     15c: a9144bf1     	stp	x17, x18, [sp, #0x140]
     160: a90107e0     	stp	x0, x1, [sp, #0x10]
     164: a9020fe2     	stp	x2, x3, [sp, #0x20]
     168: a90317e4     	stp	x4, x5, [sp, #0x30]
     16c: a9041fe6     	stp	x6, x7, [sp, #0x40]
     170: f9002be8     	str	x8, [sp, #0x50]
     174: d53b4209     	mrs	x9, NZCV
     178: f9002fe9     	str	x9, [sp, #0x58]
     17c: ad0307e0     	stp	q0, q1, [sp, #0x60]
     180: ad040fe2     	stp	q2, q3, [sp, #0x80]
     184: ad0517e4     	stp	q4, q5, [sp, #0xa0]
     188: ad061fe6     	stp	q6, q7, [sp, #0xc0]
     18c: 910603e0     	add	x0, sp, #0x180
     190: f940abe1     	ldr	x1, [sp, #0x150]
     194: f94077e2     	ldr	x2, [sp, #0xe8]
     198: 94000000     	bl	0x198 <iq4_f3_core_native_join_wrapper_01+0x60>
		0000000000000198:  R_AARCH64_CALL26	iq4_f3_core_join_returned_01
     19c: ad4307e0     	ldp	q0, q1, [sp, #0x60]
     1a0: ad440fe2     	ldp	q2, q3, [sp, #0x80]
     1a4: ad4517e4     	ldp	q4, q5, [sp, #0xa0]
     1a8: ad461fe6     	ldp	q6, q7, [sp, #0xc0]
     1ac: f9402fe9     	ldr	x9, [sp, #0x58]
     1b0: d51b4209     	msr	NZCV, x9
     1b4: a94107e0     	ldp	x0, x1, [sp, #0x10]
     1b8: a9420fe2     	ldp	x2, x3, [sp, #0x20]
     1bc: a94317e4     	ldp	x4, x5, [sp, #0x30]
     1c0: a9441fe6     	ldp	x6, x7, [sp, #0x40]
     1c4: f9402be8     	ldr	x8, [sp, #0x50]
     1c8: a9502be9     	ldp	x9, x10, [sp, #0x100]
     1cc: a95133eb     	ldp	x11, x12, [sp, #0x110]
     1d0: a9523bed     	ldp	x13, x14, [sp, #0x120]
     1d4: a95343ef     	ldp	x15, x16, [sp, #0x130]
     1d8: a9544bf1     	ldp	x17, x18, [sp, #0x140]
     1dc: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
     1e0: 910603ff     	add	sp, sp, #0x180
     1e4: d65f03c0     	ret

00000000000001e8 <iq4_f3_core_native_terminal_wrapper_01>:
     1e8: d10603ff     	sub	sp, sp, #0x180
     1ec: a90e7bfd     	stp	x29, x30, [sp, #0xe0]
     1f0: 910003fd     	mov	x29, sp
     1f4: 94000000     	bl	0x1f4 <iq4_f3_core_native_terminal_wrapper_01+0xc>
		00000000000001f4:  R_AARCH64_CALL26	iq4_f3_original_pipeline_clock_01
     1f8: a9102be9     	stp	x9, x10, [sp, #0x100]
     1fc: a91133eb     	stp	x11, x12, [sp, #0x110]
     200: a9123bed     	stp	x13, x14, [sp, #0x120]
     204: a91343ef     	stp	x15, x16, [sp, #0x130]
     208: a9144bf1     	stp	x17, x18, [sp, #0x140]
     20c: a90107e0     	stp	x0, x1, [sp, #0x10]
     210: a9020fe2     	stp	x2, x3, [sp, #0x20]
     214: a90317e4     	stp	x4, x5, [sp, #0x30]
     218: a9041fe6     	stp	x6, x7, [sp, #0x40]
     21c: f9002be8     	str	x8, [sp, #0x50]
     220: d53b4209     	mrs	x9, NZCV
     224: f9002fe9     	str	x9, [sp, #0x58]
     228: ad0307e0     	stp	q0, q1, [sp, #0x60]
     22c: ad040fe2     	stp	q2, q3, [sp, #0x80]
     230: ad0517e4     	stp	q4, q5, [sp, #0xa0]
     234: ad061fe6     	stp	q6, q7, [sp, #0xc0]
     238: 910603e0     	add	x0, sp, #0x180
     23c: f94077e1     	ldr	x1, [sp, #0xe8]
     240: 94000000     	bl	0x240 <iq4_f3_core_native_terminal_wrapper_01+0x58>
		0000000000000240:  R_AARCH64_CALL26	iq4_f3_core_terminal_01
     244: ad4307e0     	ldp	q0, q1, [sp, #0x60]
     248: ad440fe2     	ldp	q2, q3, [sp, #0x80]
     24c: ad4517e4     	ldp	q4, q5, [sp, #0xa0]
     250: ad461fe6     	ldp	q6, q7, [sp, #0xc0]
     254: f9402fe9     	ldr	x9, [sp, #0x58]
     258: d51b4209     	msr	NZCV, x9
     25c: a94107e0     	ldp	x0, x1, [sp, #0x10]
     260: a9420fe2     	ldp	x2, x3, [sp, #0x20]
     264: a94317e4     	ldp	x4, x5, [sp, #0x30]
     268: a9441fe6     	ldp	x6, x7, [sp, #0x40]
     26c: f9402be8     	ldr	x8, [sp, #0x50]
     270: a9502be9     	ldp	x9, x10, [sp, #0x100]
     274: a95133eb     	ldp	x11, x12, [sp, #0x110]
     278: a9523bed     	ldp	x13, x14, [sp, #0x120]
     27c: a95343ef     	ldp	x15, x16, [sp, #0x130]
     280: a9544bf1     	ldp	x17, x18, [sp, #0x140]
     284: a94e7bfd     	ldp	x29, x30, [sp, #0xe0]
     288: 910603ff     	add	sp, sp, #0x180
     28c: d65f03c0     	ret
