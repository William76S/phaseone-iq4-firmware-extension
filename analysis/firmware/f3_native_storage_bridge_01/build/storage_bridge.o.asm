
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_storage_bridge_01/build/storage_bridge.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_native_storage_bound_01>:
       0: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000000:  R_AARCH64_ADR_PREL_PG_HI21	.bss
       4: 91000108     	add	x8, x8, #0x0
		0000000000000004:  R_AARCH64_ADD_ABS_LO12_NC	.bss
       8: 88dffd08     	ldar	w8, [x8]
       c: 34000068     	cbz	w8, 0x18 <iq4_f3_native_storage_bound_01+0x18>
      10: 2a1f03e0     	mov	w0, wzr
      14: d65f03c0     	ret
      18: 14000001     	b	0x1c <identities>

000000000000001c <identities>:
      1c: d10143ff     	sub	sp, sp, #0x50
      20: a9027bfd     	stp	x29, x30, [sp, #0x20]
      24: f9001bf5     	str	x21, [sp, #0x30]
      28: a9044ff4     	stp	x20, x19, [sp, #0x40]
      2c: 910083fd     	add	x29, sp, #0x20
      30: 90000014     	adrp	x20, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000030:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x48
      34: f9400293     	ldr	x19, [x20]
		0000000000000034:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
      38: b4001273     	cbz	x19, 0x284 <identities+0x268>
      3c: 91002268     	add	x8, x19, #0x8
      40: d343fd08     	lsr	x8, x8, #3
      44: f108051f     	cmp	x8, #0x201
      48: 540011e3     	b.lo	0x284 <identities+0x268>
      4c: d10023a2     	sub	x2, x29, #0x8
      50: aa1f03e0     	mov	x0, xzr
      54: aa1303e1     	mov	x1, x19
      58: 52800103     	mov	w3, #0x8                // =8
      5c: 94000000     	bl	0x5c <identities+0x40>
		000000000000005c:  R_AARCH64_CALL26	iq4_native_self_read_01
      60: 7100041f     	cmp	w0, #0x1
      64: 54001101     	b.ne	0x284 <identities+0x268>
      68: 910063a2     	add	x2, x29, #0x18
      6c: aa1f03e0     	mov	x0, xzr
      70: aa1303e1     	mov	x1, x19
      74: 52800103     	mov	w3, #0x8                // =8
      78: 94000000     	bl	0x78 <identities+0x5c>
		0000000000000078:  R_AARCH64_CALL26	iq4_native_self_read_01
      7c: 7100041f     	cmp	w0, #0x1
      80: 54001021     	b.ne	0x284 <identities+0x268>
      84: 529f1513     	mov	w19, #0xf8a8            // =63656
      88: f85f83a9     	ldur	x9, [x29, #-0x8]
      8c: 2a1f03e0     	mov	w0, wzr
      90: 72a01773     	movk	w19, #0xbb, lsl #16
      94: d11fc268     	sub	x8, x19, #0x7f0
      98: eb08013f     	cmp	x9, x8
      9c: 54000f61     	b.ne	0x288 <identities+0x26c>
      a0: f9400fa9     	ldr	x9, [x29, #0x18]
      a4: eb08013f     	cmp	x9, x8
      a8: 54000f01     	b.ne	0x288 <identities+0x26c>
      ac: f9400295     	ldr	x21, [x20]
		00000000000000ac:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
      b0: 910442a8     	add	x8, x21, #0x110
      b4: d343fd08     	lsr	x8, x8, #3
      b8: f108051f     	cmp	x8, #0x201
      bc: 54000e43     	b.lo	0x284 <identities+0x268>
      c0: 910422a1     	add	x1, x21, #0x108
      c4: d10023a2     	sub	x2, x29, #0x8
      c8: aa1f03e0     	mov	x0, xzr
      cc: 52800103     	mov	w3, #0x8                // =8
      d0: 94000000     	bl	0xd0 <identities+0xb4>
		00000000000000d0:  R_AARCH64_CALL26	iq4_native_self_read_01
      d4: 7100041f     	cmp	w0, #0x1
      d8: 54000d61     	b.ne	0x284 <identities+0x268>
      dc: 910422a1     	add	x1, x21, #0x108
      e0: 910063a2     	add	x2, x29, #0x18
      e4: aa1f03e0     	mov	x0, xzr
      e8: 52800103     	mov	w3, #0x8                // =8
      ec: 94000000     	bl	0xec <identities+0xd0>
		00000000000000ec:  R_AARCH64_CALL26	iq4_native_self_read_01
      f0: 7100041f     	cmp	w0, #0x1
      f4: 54000c81     	b.ne	0x284 <identities+0x268>
      f8: f85f83a8     	ldur	x8, [x29, #-0x8]
      fc: 2a1f03e0     	mov	w0, wzr
     100: eb13011f     	cmp	x8, x19
     104: 54000c21     	b.ne	0x288 <identities+0x26c>
     108: f9400fa8     	ldr	x8, [x29, #0x18]
     10c: eb13011f     	cmp	x8, x19
     110: 54000bc1     	b.ne	0x288 <identities+0x26c>
     114: f9400295     	ldr	x21, [x20]
		0000000000000114:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
     118: 910842a8     	add	x8, x21, #0x210
     11c: d343fd08     	lsr	x8, x8, #3
     120: f108051f     	cmp	x8, #0x201
     124: 54000b03     	b.lo	0x284 <identities+0x268>
     128: 910822a1     	add	x1, x21, #0x208
     12c: d10023a2     	sub	x2, x29, #0x8
     130: aa1f03e0     	mov	x0, xzr
     134: 52800103     	mov	w3, #0x8                // =8
     138: 94000000     	bl	0x138 <identities+0x11c>
		0000000000000138:  R_AARCH64_CALL26	iq4_native_self_read_01
     13c: 7100041f     	cmp	w0, #0x1
     140: 54000a21     	b.ne	0x284 <identities+0x268>
     144: 910822a1     	add	x1, x21, #0x208
     148: 910063a2     	add	x2, x29, #0x18
     14c: aa1f03e0     	mov	x0, xzr
     150: 52800103     	mov	w3, #0x8                // =8
     154: 94000000     	bl	0x154 <identities+0x138>
		0000000000000154:  R_AARCH64_CALL26	iq4_native_self_read_01
     158: 7100041f     	cmp	w0, #0x1
     15c: 54000941     	b.ne	0x284 <identities+0x268>
     160: f85f83a8     	ldur	x8, [x29, #-0x8]
     164: 2a1f03e0     	mov	w0, wzr
     168: eb13011f     	cmp	x8, x19
     16c: 540008e1     	b.ne	0x288 <identities+0x26c>
     170: f9400fa8     	ldr	x8, [x29, #0x18]
     174: eb13011f     	cmp	x8, x19
     178: 54000881     	b.ne	0x288 <identities+0x26c>
     17c: f9400293     	ldr	x19, [x20]
		000000000000017c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
     180: 91046268     	add	x8, x19, #0x118
     184: d343fd08     	lsr	x8, x8, #3
     188: f108051f     	cmp	x8, #0x201
     18c: 540007c3     	b.lo	0x284 <identities+0x268>
     190: 91044261     	add	x1, x19, #0x110
     194: 910043e2     	add	x2, sp, #0x10
     198: aa1f03e0     	mov	x0, xzr
     19c: 52800103     	mov	w3, #0x8                // =8
     1a0: 94000000     	bl	0x1a0 <identities+0x184>
		00000000000001a0:  R_AARCH64_CALL26	iq4_native_self_read_01
     1a4: 7100041f     	cmp	w0, #0x1
     1a8: 540006e1     	b.ne	0x284 <identities+0x268>
     1ac: 91044261     	add	x1, x19, #0x110
     1b0: 910063a2     	add	x2, x29, #0x18
     1b4: aa1f03e0     	mov	x0, xzr
     1b8: 52800103     	mov	w3, #0x8                // =8
     1bc: 94000000     	bl	0x1bc <identities+0x1a0>
		00000000000001bc:  R_AARCH64_CALL26	iq4_native_self_read_01
     1c0: 7100041f     	cmp	w0, #0x1
     1c4: 54000601     	b.ne	0x284 <identities+0x268>
     1c8: f9400be8     	ldr	x8, [sp, #0x10]
     1cc: f9400fa9     	ldr	x9, [x29, #0x18]
     1d0: eb09011f     	cmp	x8, x9
     1d4: 54000581     	b.ne	0x284 <identities+0x268>
     1d8: f9400293     	ldr	x19, [x20]
		00000000000001d8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
     1dc: 91086268     	add	x8, x19, #0x218
     1e0: d343fd08     	lsr	x8, x8, #3
     1e4: f108051f     	cmp	x8, #0x201
     1e8: 540004e3     	b.lo	0x284 <identities+0x268>
     1ec: 91084261     	add	x1, x19, #0x210
     1f0: 910023e2     	add	x2, sp, #0x8
     1f4: aa1f03e0     	mov	x0, xzr
     1f8: 52800103     	mov	w3, #0x8                // =8
     1fc: 94000000     	bl	0x1fc <identities+0x1e0>
		00000000000001fc:  R_AARCH64_CALL26	iq4_native_self_read_01
     200: 7100041f     	cmp	w0, #0x1
     204: 54000401     	b.ne	0x284 <identities+0x268>
     208: 91084261     	add	x1, x19, #0x210
     20c: 910063a2     	add	x2, x29, #0x18
     210: aa1f03e0     	mov	x0, xzr
     214: 52800103     	mov	w3, #0x8                // =8
     218: 94000000     	bl	0x218 <identities+0x1fc>
		0000000000000218:  R_AARCH64_CALL26	iq4_native_self_read_01
     21c: 7100041f     	cmp	w0, #0x1
     220: 54000321     	b.ne	0x284 <identities+0x268>
     224: f94007e8     	ldr	x8, [sp, #0x8]
     228: f9400fa9     	ldr	x9, [x29, #0x18]
     22c: eb09011f     	cmp	x8, x9
     230: 540002a1     	b.ne	0x284 <identities+0x268>
     234: 9000000a     	adrp	x10, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000234:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x10
     238: f9400be9     	ldr	x9, [sp, #0x10]
     23c: f940014a     	ldr	x10, [x10]
		000000000000023c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x10
     240: eb0a013f     	cmp	x9, x10
     244: 54000201     	b.ne	0x284 <identities+0x268>
     248: eb08013f     	cmp	x9, x8
     24c: 2a1f03e0     	mov	w0, wzr
     250: 540001c0     	b.eq	0x288 <identities+0x26c>
     254: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000254:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     258: f9400129     	ldr	x9, [x9]
		0000000000000258:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x8
     25c: eb09011f     	cmp	x8, x9
     260: 54000141     	b.ne	0x288 <identities+0x26c>
     264: aa0803e0     	mov	x0, x8
     268: 52800081     	mov	w1, #0x4                // =4
     26c: 94000382     	bl	0x1074 <event_shape>
     270: 340000c0     	cbz	w0, 0x288 <identities+0x26c>
     274: f9400be0     	ldr	x0, [sp, #0x10]
     278: 52800041     	mov	w1, #0x2                // =2
     27c: 9400037e     	bl	0x1074 <event_shape>
     280: 14000002     	b	0x288 <identities+0x26c>
     284: 2a1f03e0     	mov	w0, wzr
     288: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     28c: f9401bf5     	ldr	x21, [sp, #0x30]
     290: a9427bfd     	ldp	x29, x30, [sp, #0x20]
     294: 910143ff     	add	sp, sp, #0x50
     298: d65f03c0     	ret

000000000000029c <iq4_f3_native_storage_override_mask_01>:
     29c: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		000000000000029c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     2a0: 91000108     	add	x8, x8, #0x0
		00000000000002a0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     2a4: 88dffd00     	ldar	w0, [x8]
     2a8: d65f03c0     	ret

00000000000002ac <iq4_f3_storage_enter_01>:
     2ac: d10103ff     	sub	sp, sp, #0x40
     2b0: a9017bfd     	stp	x29, x30, [sp, #0x10]
     2b4: a90257f6     	stp	x22, x21, [sp, #0x20]
     2b8: a9034ff4     	stp	x20, x19, [sp, #0x30]
     2bc: 910043fd     	add	x29, sp, #0x10
     2c0: b81fc3a1     	stur	w1, [x29, #-0x4]
     2c4: b4000360     	cbz	x0, 0x330 <iq4_f3_storage_enter_01+0x84>
     2c8: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000002c8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     2cc: 91000108     	add	x8, x8, #0x0
		00000000000002cc:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
     2d0: 2a0303f5     	mov	w21, w3
     2d4: 91002109     	add	x9, x8, #0x8
     2d8: c8dffd08     	ldar	x8, [x8]
     2dc: aa0203f4     	mov	x20, x2
     2e0: c8dffd29     	ldar	x9, [x9]
     2e4: aa0003f3     	mov	x19, x0
     2e8: eb09001f     	cmp	x0, x9
     2ec: 540000a1     	b.ne	0x300 <iq4_f3_storage_enter_01+0x54>
     2f0: 52800036     	mov	w22, #0x1               // =1
     2f4: 94000000     	bl	0x2f4 <iq4_f3_storage_enter_01+0x48>
		00000000000002f4:  R_AARCH64_CALL26	iq4_f3_storage_mutex_ready_01
     2f8: 35000100     	cbnz	w0, 0x318 <iq4_f3_storage_enter_01+0x6c>
     2fc: 1400000d     	b	0x330 <iq4_f3_storage_enter_01+0x84>
     300: eb08027f     	cmp	x19, x8
     304: 1a9f07e8     	cset	w8, ne
     308: 54000141     	b.ne	0x330 <iq4_f3_storage_enter_01+0x84>
     30c: 531f7916     	lsl	w22, w8, #1
     310: 94000000     	bl	0x310 <iq4_f3_storage_enter_01+0x64>
		0000000000000310:  R_AARCH64_CALL26	iq4_f3_storage_mutex_ready_01
     314: 340000e0     	cbz	w0, 0x330 <iq4_f3_storage_enter_01+0x84>
     318: 94000000     	bl	0x318 <iq4_f3_storage_enter_01+0x6c>
		0000000000000318:  R_AARCH64_CALL26	iq4_f3_storage_mutex_lock_01
     31c: 52800028     	mov	w8, #0x1                // =1
     320: 34000140     	cbz	w0, 0x348 <iq4_f3_storage_enter_01+0x9c>
     324: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000324:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     328: 91000129     	add	x9, x9, #0x0
		0000000000000328:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     32c: 889ffd28     	stlr	w8, [x9]
     330: b85fc3a0     	ldur	w0, [x29, #-0x4]
     334: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     338: a94257f6     	ldp	x22, x21, [sp, #0x20]
     33c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     340: 910103ff     	add	sp, sp, #0x40
     344: d65f03c0     	ret
     348: 1ad62108     	lsl	w8, w8, w22
     34c: 34000235     	cbz	w21, 0x390 <iq4_f3_storage_enter_01+0xe4>
     350: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000350:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_storage_ui_set_return_01
     354: f9400129     	ldr	x9, [x9]
		0000000000000354:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_storage_ui_set_return_01
     358: eb09029f     	cmp	x20, x9
     35c: 54000380     	b.eq	0x3cc <iq4_f3_storage_enter_01+0x120>
     360: b85fc3a9     	ldur	w9, [x29, #-0x4]
     364: 34000509     	cbz	w9, 0x404 <iq4_f3_storage_enter_01+0x158>
     368: 7100093f     	cmp	w9, #0x2
     36c: 54000a48     	b.hi	0x4b4 <iq4_f3_storage_enter_01+0x208>
     370: 2a2803e8     	mvn	w8, w8
     374: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000374:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     378: 91000129     	add	x9, x9, #0x0
		0000000000000378:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     37c: 885ffd2a     	ldaxr	w10, [x9]
     380: 0a08014a     	and	w10, w10, w8
     384: 880bfd2a     	stlxr	w11, w10, [x9]
     388: 35ffffab     	cbnz	w11, 0x37c <iq4_f3_storage_enter_01+0xd0>
     38c: 1400004a     	b	0x4b4 <iq4_f3_storage_enter_01+0x208>
     390: 52942d89     	mov	w9, #0xa16c             // =41324
     394: 72a00d49     	movk	w9, #0x6a, lsl #16
     398: 9101612a     	add	x10, x9, #0x58
     39c: eb0a029f     	cmp	x20, x10
     3a0: 540000e1     	b.ne	0x3bc <iq4_f3_storage_enter_01+0x110>
     3a4: 350000d6     	cbnz	w22, 0x3bc <iq4_f3_storage_enter_01+0x110>
     3a8: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000003a8:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_storage_ui_set_return_01
     3ac: f9400129     	ldr	x9, [x9]
		00000000000003ac:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_storage_ui_set_return_01
     3b0: eb09029f     	cmp	x20, x9
     3b4: 540000c0     	b.eq	0x3cc <iq4_f3_storage_enter_01+0x120>
     3b8: 14000025     	b	0x44c <iq4_f3_storage_enter_01+0x1a0>
     3bc: 9000000a     	adrp	x10, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000003bc:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_storage_ui_set_return_01
     3c0: f940014a     	ldr	x10, [x10]
		00000000000003c0:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_storage_ui_set_return_01
     3c4: eb0a029f     	cmp	x20, x10
     3c8: 540003a1     	b.ne	0x43c <iq4_f3_storage_enter_01+0x190>
     3cc: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000003cc:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     3d0: 91000129     	add	x9, x9, #0x0
		00000000000003d0:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     3d4: 88dffd29     	ldar	w9, [x9]
     3d8: 350000c9     	cbnz	w9, 0x3f0 <iq4_f3_storage_enter_01+0x144>
     3dc: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000003dc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     3e0: 91000129     	add	x9, x9, #0x0
		00000000000003e0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     3e4: 88dffd29     	ldar	w9, [x9]
     3e8: 6a08013f     	tst	w9, w8
     3ec: 54000540     	b.eq	0x494 <iq4_f3_storage_enter_01+0x1e8>
     3f0: d10013a0     	sub	x0, x29, #0x4
     3f4: 91030261     	add	x1, x19, #0xc0
     3f8: 52800082     	mov	w2, #0x4                // =4
     3fc: 94000000     	bl	0x3fc <iq4_f3_storage_enter_01+0x150>
		00000000000003fc:  R_AARCH64_CALL26	memcpy
     400: 1400002d     	b	0x4b4 <iq4_f3_storage_enter_01+0x208>
     404: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000404:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     408: 91000129     	add	x9, x9, #0x0
		0000000000000408:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     40c: 885ffd2a     	ldaxr	w10, [x9]
     410: 2a08014a     	orr	w10, w10, w8
     414: 880bfd2a     	stlxr	w11, w10, [x9]
     418: 35ffffab     	cbnz	w11, 0x40c <iq4_f3_storage_enter_01+0x160>
     41c: 2a2803e8     	mvn	w8, w8
     420: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000420:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     424: 91000129     	add	x9, x9, #0x0
		0000000000000424:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     428: 885ffd2a     	ldaxr	w10, [x9]
     42c: 0a08014a     	and	w10, w10, w8
     430: 880bfd2a     	stlxr	w11, w10, [x9]
     434: 35ffffab     	cbnz	w11, 0x428 <iq4_f3_storage_enter_01+0x17c>
     438: 1400001f     	b	0x4b4 <iq4_f3_storage_enter_01+0x208>
     43c: eb09029f     	cmp	x20, x9
     440: 54fff901     	b.ne	0x360 <iq4_f3_storage_enter_01+0xb4>
     444: 710006df     	cmp	w22, #0x1
     448: 54fff8c1     	b.ne	0x360 <iq4_f3_storage_enter_01+0xb4>
     44c: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		000000000000044c:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     450: 91000129     	add	x9, x9, #0x0
		0000000000000450:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     454: 88dffd29     	ldar	w9, [x9]
     458: 350002e9     	cbnz	w9, 0x4b4 <iq4_f3_storage_enter_01+0x208>
     45c: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		000000000000045c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x18
     460: 91000129     	add	x9, x9, #0x0
		0000000000000460:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x18
     464: 88dffd29     	ldar	w9, [x9]
     468: 6a08013f     	tst	w9, w8
     46c: 54000241     	b.ne	0x4b4 <iq4_f3_storage_enter_01+0x208>
     470: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000470:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     474: 91000129     	add	x9, x9, #0x0
		0000000000000474:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     478: 88dffd29     	ldar	w9, [x9]
     47c: 6a08013f     	tst	w9, w8
     480: 540001a0     	b.eq	0x4b4 <iq4_f3_storage_enter_01+0x208>
     484: b85fc3a8     	ldur	w8, [x29, #-0x4]
     488: 7100091f     	cmp	w8, #0x2
     48c: 54000109     	b.ls	0x4ac <iq4_f3_storage_enter_01+0x200>
     490: 14000009     	b	0x4b4 <iq4_f3_storage_enter_01+0x208>
     494: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000494:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     498: 91000129     	add	x9, x9, #0x0
		0000000000000498:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     49c: 885ffd2a     	ldaxr	w10, [x9]
     4a0: 2a08014a     	orr	w10, w10, w8
     4a4: 880bfd2a     	stlxr	w11, w10, [x9]
     4a8: 35ffffab     	cbnz	w11, 0x49c <iq4_f3_storage_enter_01+0x1f0>
     4ac: 52800048     	mov	w8, #0x2                // =2
     4b0: b81fc3a8     	stur	w8, [x29, #-0x4]
     4b4: b85fc3a8     	ldur	w8, [x29, #-0x4]
     4b8: b2600100     	orr	x0, x8, #0x100000000
     4bc: 17ffff9e     	b	0x334 <iq4_f3_storage_enter_01+0x88>

00000000000004c0 <iq4_f3_storage_leave_01>:
     4c0: 7100041f     	cmp	w0, #0x1
     4c4: 54000141     	b.ne	0x4ec <iq4_f3_storage_leave_01+0x2c>
     4c8: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     4cc: 910003fd     	mov	x29, sp
     4d0: 94000000     	bl	0x4d0 <iq4_f3_storage_leave_01+0x10>
		00000000000004d0:  R_AARCH64_CALL26	iq4_f3_storage_mutex_unlock_01
     4d4: 340000a0     	cbz	w0, 0x4e8 <iq4_f3_storage_leave_01+0x28>
     4d8: 52800028     	mov	w8, #0x1                // =1
     4dc: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000004dc:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     4e0: 91000129     	add	x9, x9, #0x0
		00000000000004e0:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     4e4: 889ffd28     	stlr	w8, [x9]
     4e8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     4ec: d65f03c0     	ret

00000000000004f0 <iq4_f3_native_mode_set_on_ui_01>:
     4f0: d10303ff     	sub	sp, sp, #0xc0
     4f4: a9067bfd     	stp	x29, x30, [sp, #0x60]
     4f8: a9076ffc     	stp	x28, x27, [sp, #0x70]
     4fc: a90867fa     	stp	x26, x25, [sp, #0x80]
     500: a9095ff8     	stp	x24, x23, [sp, #0x90]
     504: a90a57f6     	stp	x22, x21, [sp, #0xa0]
     508: a90b4ff4     	stp	x20, x19, [sp, #0xb0]
     50c: 910183fd     	add	x29, sp, #0x60
     510: 51003008     	sub	w8, w0, #0xc
     514: 2a0003f4     	mov	w20, w0
     518: 2a1f03e0     	mov	w0, wzr
     51c: 3100091f     	cmn	w8, #0x2
     520: 54000da3     	b.lo	0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>
     524: 7100083f     	cmp	w1, #0x2
     528: 54000d68     	b.hi	0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>
     52c: 90000016     	adrp	x22, 0x0 <iq4_f3_native_storage_bound_01>
		000000000000052c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x38
     530: f94002c8     	ldr	x8, [x22]
		0000000000000530:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x38
     534: b4000ce8     	cbz	x8, 0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     538: 910063e0     	add	x0, sp, #0x18
     53c: 2a0103f3     	mov	w19, w1
     540: 94000000     	bl	0x540 <iq4_f3_native_mode_set_on_ui_01+0x50>
		0000000000000540:  R_AARCH64_CALL26	iq4_f4_native_current_02
     544: 34000c60     	cbz	w0, 0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     548: f9400ff5     	ldr	x21, [sp, #0x18]
     54c: f94002c8     	ldr	x8, [x22]
		000000000000054c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x38
     550: eb0802bf     	cmp	x21, x8
     554: 54000be1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     558: 910022a8     	add	x8, x21, #0x8
     55c: d343fd08     	lsr	x8, x8, #3
     560: f108051f     	cmp	x8, #0x201
     564: 54000b63     	b.lo	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     568: 910043e2     	add	x2, sp, #0x10
     56c: aa1f03e0     	mov	x0, xzr
     570: aa1503e1     	mov	x1, x21
     574: 52800103     	mov	w3, #0x8                // =8
     578: 94000000     	bl	0x578 <iq4_f3_native_mode_set_on_ui_01+0x88>
		0000000000000578:  R_AARCH64_CALL26	iq4_native_self_read_01
     57c: 7100041f     	cmp	w0, #0x1
     580: 54000a81     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     584: 910083e2     	add	x2, sp, #0x20
     588: aa1f03e0     	mov	x0, xzr
     58c: aa1503e1     	mov	x1, x21
     590: 52800103     	mov	w3, #0x8                // =8
     594: 94000000     	bl	0x594 <iq4_f3_native_mode_set_on_ui_01+0xa4>
		0000000000000594:  R_AARCH64_CALL26	iq4_native_self_read_01
     598: 7100041f     	cmp	w0, #0x1
     59c: 540009a1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     5a0: f9400be9     	ldr	x9, [sp, #0x10]
     5a4: 5283e908     	mov	w8, #0x1f48             // =8008
     5a8: 72a01728     	movk	w8, #0xb9, lsl #16
     5ac: eb08013f     	cmp	x9, x8
     5b0: 54000901     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     5b4: f94013e9     	ldr	x9, [sp, #0x20]
     5b8: eb08013f     	cmp	x9, x8
     5bc: 540008a1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     5c0: f9400ff5     	ldr	x21, [sp, #0x18]
     5c4: 910742a8     	add	x8, x21, #0x1d0
     5c8: d343fd08     	lsr	x8, x8, #3
     5cc: f108051f     	cmp	x8, #0x201
     5d0: 54000803     	b.lo	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     5d4: 910722a1     	add	x1, x21, #0x1c8
     5d8: 910023e2     	add	x2, sp, #0x8
     5dc: aa1f03e0     	mov	x0, xzr
     5e0: 52800103     	mov	w3, #0x8                // =8
     5e4: 94000000     	bl	0x5e4 <iq4_f3_native_mode_set_on_ui_01+0xf4>
		00000000000005e4:  R_AARCH64_CALL26	iq4_native_self_read_01
     5e8: 7100041f     	cmp	w0, #0x1
     5ec: 54000721     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     5f0: 910722a1     	add	x1, x21, #0x1c8
     5f4: 910083e2     	add	x2, sp, #0x20
     5f8: aa1f03e0     	mov	x0, xzr
     5fc: 52800103     	mov	w3, #0x8                // =8
     600: 94000000     	bl	0x600 <iq4_f3_native_mode_set_on_ui_01+0x110>
		0000000000000600:  R_AARCH64_CALL26	iq4_native_self_read_01
     604: 7100041f     	cmp	w0, #0x1
     608: 54000641     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     60c: f94007f5     	ldr	x21, [sp, #0x8]
     610: f94013e8     	ldr	x8, [sp, #0x20]
     614: eb0802bf     	cmp	x21, x8
     618: 540005c1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     61c: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		000000000000061c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x40
     620: f9400108     	ldr	x8, [x8]
		0000000000000620:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x40
     624: eb0802bf     	cmp	x21, x8
     628: 54000541     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     62c: 910022a8     	add	x8, x21, #0x8
     630: d343fd08     	lsr	x8, x8, #3
     634: f108051f     	cmp	x8, #0x201
     638: 540004c3     	b.lo	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     63c: 910043e2     	add	x2, sp, #0x10
     640: aa1f03e0     	mov	x0, xzr
     644: aa1503e1     	mov	x1, x21
     648: 52800103     	mov	w3, #0x8                // =8
     64c: 94000000     	bl	0x64c <iq4_f3_native_mode_set_on_ui_01+0x15c>
		000000000000064c:  R_AARCH64_CALL26	iq4_native_self_read_01
     650: 7100041f     	cmp	w0, #0x1
     654: 540003e1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     658: 910083e2     	add	x2, sp, #0x20
     65c: aa1f03e0     	mov	x0, xzr
     660: aa1503e1     	mov	x1, x21
     664: 52800103     	mov	w3, #0x8                // =8
     668: 94000000     	bl	0x668 <iq4_f3_native_mode_set_on_ui_01+0x178>
		0000000000000668:  R_AARCH64_CALL26	iq4_native_self_read_01
     66c: 7100041f     	cmp	w0, #0x1
     670: 54000301     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     674: f9400be9     	ldr	x9, [sp, #0x10]
     678: 529e6b08     	mov	w8, #0xf358             // =62296
     67c: 72a01708     	movk	w8, #0xb8, lsl #16
     680: eb08013f     	cmp	x9, x8
     684: 54000261     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     688: f94013e9     	ldr	x9, [sp, #0x20]
     68c: eb08013f     	cmp	x9, x8
     690: 54000201     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     694: f94007e8     	ldr	x8, [sp, #0x8]
     698: 910003e1     	mov	x1, sp
     69c: 91002100     	add	x0, x8, #0x8
     6a0: 94000251     	bl	0xfe4 <word>
     6a4: 34000160     	cbz	w0, 0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     6a8: f94003e8     	ldr	x8, [sp]
     6ac: f9400fe9     	ldr	x9, [sp, #0x18]
     6b0: eb09011f     	cmp	x8, x9
     6b4: 540000e1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     6b8: 94000000     	bl	0x6b8 <iq4_f3_native_mode_set_on_ui_01+0x1c8>
		00000000000006b8:  R_AARCH64_CALL26	iq4_f3_storage_mutex_ready_01
     6bc: 340000c0     	cbz	w0, 0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>
     6c0: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000006c0:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     6c4: 91000108     	add	x8, x8, #0x0
		00000000000006c4:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     6c8: 88dffd08     	ldar	w8, [x8]
     6cc: 34000148     	cbz	w8, 0x6f4 <iq4_f3_native_mode_set_on_ui_01+0x204>
     6d0: 2a1f03e0     	mov	w0, wzr
     6d4: a94b4ff4     	ldp	x20, x19, [sp, #0xb0]
     6d8: a94a57f6     	ldp	x22, x21, [sp, #0xa0]
     6dc: a9495ff8     	ldp	x24, x23, [sp, #0x90]
     6e0: a94867fa     	ldp	x26, x25, [sp, #0x80]
     6e4: a9476ffc     	ldp	x28, x27, [sp, #0x70]
     6e8: a9467bfd     	ldp	x29, x30, [sp, #0x60]
     6ec: 910303ff     	add	sp, sp, #0xc0
     6f0: d65f03c0     	ret
     6f4: 97fffe4a     	bl	0x1c <identities>
     6f8: 34fffee0     	cbz	w0, 0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>
     6fc: aa1f03f7     	mov	x23, xzr
     700: 5280081a     	mov	w26, #0x40              // =64
     704: 52800308     	mov	w8, #0x18               // =24
     708: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000708:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
     70c: 91000129     	add	x9, x9, #0x0
		000000000000070c:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
     710: 9b0826fb     	madd	x27, x23, x8, x9
     714: f940077c     	ldr	x28, [x27, #0x8]
     718: b400039c     	cbz	x28, 0x788 <iq4_f3_native_mode_set_on_ui_01+0x298>
     71c: f9400379     	ldr	x25, [x27]
     720: aa1f03f8     	mov	x24, xzr
     724: aa1c03e8     	mov	x8, x28
     728: f1010116     	subs	x22, x8, #0x40
     72c: 8b180321     	add	x1, x25, x24
     730: 9a9a3115     	csel	x21, x8, x26, lo
     734: ab0102bf     	cmn	x21, x1
     738: 1a9f37e8     	cset	w8, hs
     73c: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     740: 54fffc83     	b.lo	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     744: 3707fc68     	tbnz	w8, #0x0, 0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     748: 910083e2     	add	x2, sp, #0x20
     74c: aa1f03e0     	mov	x0, xzr
     750: aa1503e3     	mov	x3, x21
     754: 94000000     	bl	0x754 <iq4_f3_native_mode_set_on_ui_01+0x264>
		0000000000000754:  R_AARCH64_CALL26	iq4_native_self_read_01
     758: 7100041f     	cmp	w0, #0x1
     75c: 54fffba1     	b.ne	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     760: f9400b68     	ldr	x8, [x27, #0x10]
     764: 910083e0     	add	x0, sp, #0x20
     768: aa1503e2     	mov	x2, x21
     76c: 8b180101     	add	x1, x8, x24
     770: 94000000     	bl	0x770 <iq4_f3_native_mode_set_on_ui_01+0x280>
		0000000000000770:  R_AARCH64_CALL26	memcmp
     774: 35fffae0     	cbnz	w0, 0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     778: 91010318     	add	x24, x24, #0x40
     77c: aa1603e8     	mov	x8, x22
     780: eb1c031f     	cmp	x24, x28
     784: 54fffd23     	b.lo	0x728 <iq4_f3_native_mode_set_on_ui_01+0x238>
     788: 910006f7     	add	x23, x23, #0x1
     78c: f10066ff     	cmp	x23, #0x19
     790: 54fffba1     	b.ne	0x704 <iq4_f3_native_mode_set_on_ui_01+0x214>
     794: 94000000     	bl	0x794 <iq4_f3_native_mode_set_on_ui_01+0x2a4>
		0000000000000794:  R_AARCH64_CALL26	f3_coordinator_ready_06
     798: 34fff9e0     	cbz	w0, 0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>
     79c: 94000000     	bl	0x79c <iq4_f3_native_mode_set_on_ui_01+0x2ac>
		000000000000079c:  R_AARCH64_CALL26	f3_capture_backend_capabilities_03
     7a0: 51002a98     	sub	w24, w20, #0xa
     7a4: 52800028     	mov	w8, #0x1                // =1
     7a8: 1ad82117     	lsl	w23, w8, w24
     7ac: 6a17001f     	tst	w0, w23
     7b0: 54fff900     	b.eq	0x6d0 <iq4_f3_native_mode_set_on_ui_01+0x1e0>
     7b4: 90000015     	adrp	x21, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000007b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x4
     7b8: 910002b5     	add	x21, x21, #0x0
		00000000000007b8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x4
     7bc: 910083e2     	add	x2, sp, #0x20
     7c0: 52800060     	mov	w0, #0x3                // =3
     7c4: aa1503e1     	mov	x1, x21
     7c8: a9027fff     	stp	xzr, xzr, [sp, #0x20]
     7cc: 94000000     	bl	0x7cc <iq4_f3_native_mode_set_on_ui_01+0x2dc>
		00000000000007cc:  R_AARCH64_CALL26	iq4_activity_try_01
     7d0: 35000880     	cbnz	w0, 0x8e0 <iq4_f3_native_mode_set_on_ui_01+0x3f0>
     7d4: 90000016     	adrp	x22, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000007d4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     7d8: 910002d6     	add	x22, x22, #0x0
		00000000000007d8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
     7dc: 910063e1     	add	x1, sp, #0x18
     7e0: f8785ac8     	ldr	x8, [x22, w24, uxtw #3]
     7e4: 91030100     	add	x0, x8, #0xc0
     7e8: 94000041     	bl	0x8ec <scalar>
     7ec: 340005e0     	cbz	w0, 0x8a8 <iq4_f3_native_mode_set_on_ui_01+0x3b8>
     7f0: b9401be8     	ldr	w8, [sp, #0x18]
     7f4: 71000d1f     	cmp	w8, #0x3
     7f8: 54000582     	b.hs	0x8a8 <iq4_f3_native_mode_set_on_ui_01+0x3b8>
     7fc: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000007fc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c
     800: b9400109     	ldr	w9, [x8]
		0000000000000800:  R_AARCH64_LDST32_ABS_LO12_NC	.bss+0x1c
     804: 6a17013f     	tst	w9, w23
     808: 54000061     	b.ne	0x814 <iq4_f3_native_mode_set_on_ui_01+0x324>
     80c: 2a170129     	orr	w9, w9, w23
     810: b9000109     	str	w9, [x8]
		0000000000000810:  R_AARCH64_LDST32_ABS_LO12_NC	.bss+0x1c
     814: f8785ac0     	ldr	x0, [x22, w24, uxtw #3]
     818: 910043e2     	add	x2, sp, #0x10
     81c: 52800041     	mov	w1, #0x2                // =2
     820: 94000000     	bl	0x820 <iq4_f3_native_mode_set_on_ui_01+0x330>
		0000000000000820:  R_AARCH64_CALL26	iq4_f3_native_storage_write_read_01
     824: 34000480     	cbz	w0, 0x8b4 <iq4_f3_native_mode_set_on_ui_01+0x3c4>
     828: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000828:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     82c: 91000108     	add	x8, x8, #0x0
		000000000000082c:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     830: 88dffd08     	ldar	w8, [x8]
     834: 350001c8     	cbnz	w8, 0x86c <iq4_f3_native_mode_set_on_ui_01+0x37c>
     838: b94013e8     	ldr	w8, [sp, #0x10]
     83c: 7100091f     	cmp	w8, #0x2
     840: 54000161     	b.ne	0x86c <iq4_f3_native_mode_set_on_ui_01+0x37c>
     844: 97fffdf6     	bl	0x1c <identities>
     848: 34000120     	cbz	w0, 0x86c <iq4_f3_native_mode_set_on_ui_01+0x37c>
     84c: 88dffea8     	ldar	w8, [x21]
     850: 6a17011f     	tst	w8, w23
     854: 540000c0     	b.eq	0x86c <iq4_f3_native_mode_set_on_ui_01+0x37c>
     858: 2a1403e0     	mov	w0, w20
     85c: 2a1303e1     	mov	w1, w19
     860: 94000000     	bl	0x860 <iq4_f3_native_mode_set_on_ui_01+0x370>
		0000000000000860:  R_AARCH64_CALL26	iq4_f3_mode_set_for_card_on_ui_06
     864: 2a0003f3     	mov	w19, w0
     868: 350000e0     	cbnz	w0, 0x884 <iq4_f3_native_mode_set_on_ui_01+0x394>
     86c: 2a3703e8     	mvn	w8, w23
     870: 885ffea9     	ldaxr	w9, [x21]
     874: 0a080129     	and	w9, w9, w8
     878: 880afea9     	stlxr	w10, w9, [x21]
     87c: 35ffffaa     	cbnz	w10, 0x870 <iq4_f3_native_mode_set_on_ui_01+0x380>
     880: 2a1f03f3     	mov	w19, wzr
     884: 910083e0     	add	x0, sp, #0x20
     888: 94000000     	bl	0x888 <iq4_f3_native_mode_set_on_ui_01+0x398>
		0000000000000888:  R_AARCH64_CALL26	iq4_activity_release_01
     88c: 340002c0     	cbz	w0, 0x8e4 <iq4_f3_native_mode_set_on_ui_01+0x3f4>
     890: 2a1f03f3     	mov	w19, wzr
     894: 52800028     	mov	w8, #0x1                // =1
     898: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000898:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     89c: 91000129     	add	x9, x9, #0x0
		000000000000089c:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     8a0: 889ffd28     	stlr	w8, [x9]
     8a4: 14000010     	b	0x8e4 <iq4_f3_native_mode_set_on_ui_01+0x3f4>
     8a8: 910083e0     	add	x0, sp, #0x20
     8ac: 94000000     	bl	0x8ac <iq4_f3_native_mode_set_on_ui_01+0x3bc>
		00000000000008ac:  R_AARCH64_CALL26	iq4_activity_release_01
     8b0: 1400000c     	b	0x8e0 <iq4_f3_native_mode_set_on_ui_01+0x3f0>
     8b4: 2a3703e8     	mvn	w8, w23
     8b8: 885ffea9     	ldaxr	w9, [x21]
     8bc: 0a080129     	and	w9, w9, w8
     8c0: 880afea9     	stlxr	w10, w9, [x21]
     8c4: 35ffffaa     	cbnz	w10, 0x8b8 <iq4_f3_native_mode_set_on_ui_01+0x3c8>
     8c8: 52800028     	mov	w8, #0x1                // =1
     8cc: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000008cc:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     8d0: 91000129     	add	x9, x9, #0x0
		00000000000008d0:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     8d4: 910083e0     	add	x0, sp, #0x20
     8d8: 889ffd28     	stlr	w8, [x9]
     8dc: 94000000     	bl	0x8dc <iq4_f3_native_mode_set_on_ui_01+0x3ec>
		00000000000008dc:  R_AARCH64_CALL26	iq4_activity_hold_01
     8e0: 2a1f03f3     	mov	w19, wzr
     8e4: 2a1303e0     	mov	w0, w19
     8e8: 17ffff7b     	b	0x6d4 <iq4_f3_native_mode_set_on_ui_01+0x1e4>

00000000000008ec <scalar>:
     8ec: 91001008     	add	x8, x0, #0x4
     8f0: d342fd08     	lsr	x8, x8, #2
     8f4: f110051f     	cmp	x8, #0x401
     8f8: 54000062     	b.hs	0x904 <scalar+0x18>
     8fc: 2a1f03e0     	mov	w0, wzr
     900: d65f03c0     	ret
     904: d100c3ff     	sub	sp, sp, #0x30
     908: a9017bfd     	stp	x29, x30, [sp, #0x10]
     90c: a9024ff4     	stp	x20, x19, [sp, #0x20]
     910: 910043fd     	add	x29, sp, #0x10
     914: aa0003f4     	mov	x20, x0
     918: aa0103f3     	mov	x19, x1
     91c: aa1f03e0     	mov	x0, xzr
     920: aa1403e1     	mov	x1, x20
     924: aa1303e2     	mov	x2, x19
     928: 52800083     	mov	w3, #0x4                // =4
     92c: 94000000     	bl	0x92c <scalar+0x40>
		000000000000092c:  R_AARCH64_CALL26	iq4_native_self_read_01
     930: 7100041f     	cmp	w0, #0x1
     934: 540001a1     	b.ne	0x968 <scalar+0x7c>
     938: d10013a2     	sub	x2, x29, #0x4
     93c: aa1f03e0     	mov	x0, xzr
     940: aa1403e1     	mov	x1, x20
     944: 52800083     	mov	w3, #0x4                // =4
     948: 94000000     	bl	0x948 <scalar+0x5c>
		0000000000000948:  R_AARCH64_CALL26	iq4_native_self_read_01
     94c: 7100041f     	cmp	w0, #0x1
     950: 540000c1     	b.ne	0x968 <scalar+0x7c>
     954: b9400268     	ldr	w8, [x19]
     958: b85fc3a9     	ldur	w9, [x29, #-0x4]
     95c: 6b09011f     	cmp	w8, w9
     960: 1a9f17e0     	cset	w0, eq
     964: 14000002     	b	0x96c <scalar+0x80>
     968: 2a1f03e0     	mov	w0, wzr
     96c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
     970: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     974: 9100c3ff     	add	sp, sp, #0x30
     978: d65f03c0     	ret

000000000000097c <iq4_f3_storage_output_child_01>:
     97c: d103c3ff     	sub	sp, sp, #0xf0
     980: a9097bfd     	stp	x29, x30, [sp, #0x90]
     984: a90a6ffc     	stp	x28, x27, [sp, #0xa0]
     988: a90b67fa     	stp	x26, x25, [sp, #0xb0]
     98c: a90c5ff8     	stp	x24, x23, [sp, #0xc0]
     990: a90d57f6     	stp	x22, x21, [sp, #0xd0]
     994: a90e4ff4     	stp	x20, x19, [sp, #0xe0]
     998: 910243fd     	add	x29, sp, #0x90
     99c: aa0203f5     	mov	x21, x2
     9a0: aa0103f3     	mov	x19, x1
     9a4: aa0003f4     	mov	x20, x0
     9a8: 94000000     	bl	0x9a8 <iq4_f3_storage_output_child_01+0x2c>
		00000000000009a8:  R_AARCH64_CALL26	iq4_extensions_installation_stage_02
     9ac: b40030b3     	cbz	x19, 0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9b0: b4003094     	cbz	x20, 0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9b4: 52809e88     	mov	w8, #0x4f4              // =1268
     9b8: 72a009e8     	movk	w8, #0x4f, lsl #16
     9bc: eb0802bf     	cmp	x21, x8
     9c0: 54003001     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9c4: 7101901f     	cmp	w0, #0x64
     9c8: 54002fc1     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9cc: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000009cc:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     9d0: b9400108     	ldr	w8, [x8]
		00000000000009d0:  R_AARCH64_LDST32_ABS_LO12_NC	.bss
     9d4: 35002f68     	cbnz	w8, 0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9d8: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000009d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     9dc: 39400108     	ldrb	w8, [x8]
		00000000000009dc:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x20
     9e0: 37002f08     	tbnz	w8, #0x0, 0xfc0 <iq4_f3_storage_output_child_01+0x644>
     9e4: aa1f03f7     	mov	x23, xzr
     9e8: 52800316     	mov	w22, #0x18              // =24
     9ec: 90000019     	adrp	x25, 0x0 <iq4_f3_native_storage_bound_01>
		00000000000009ec:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro
     9f0: 91000339     	add	x25, x25, #0x0
		00000000000009f0:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro
     9f4: 5280081a     	mov	w26, #0x40              // =64
     9f8: a900cff4     	stp	x20, x19, [sp, #0x8]
     9fc: 9b1666fb     	madd	x27, x23, x22, x25
     a00: f940077c     	ldr	x28, [x27, #0x8]
     a04: b400039c     	cbz	x28, 0xa74 <iq4_f3_storage_output_child_01+0xf8>
     a08: f9400373     	ldr	x19, [x27]
     a0c: aa1f03f4     	mov	x20, xzr
     a10: aa1c03e8     	mov	x8, x28
     a14: f1010118     	subs	x24, x8, #0x40
     a18: 8b140261     	add	x1, x19, x20
     a1c: 9a9a3115     	csel	x21, x8, x26, lo
     a20: ab0102bf     	cmn	x21, x1
     a24: 1a9f37e8     	cset	w8, hs
     a28: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
     a2c: 54002c83     	b.lo	0xfbc <iq4_f3_storage_output_child_01+0x640>
     a30: 37002c68     	tbnz	w8, #0x0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     a34: d10103a2     	sub	x2, x29, #0x40
     a38: aa1f03e0     	mov	x0, xzr
     a3c: aa1503e3     	mov	x3, x21
     a40: 94000000     	bl	0xa40 <iq4_f3_storage_output_child_01+0xc4>
		0000000000000a40:  R_AARCH64_CALL26	iq4_native_self_read_01
     a44: 7100041f     	cmp	w0, #0x1
     a48: 54002ba1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     a4c: f9400b68     	ldr	x8, [x27, #0x10]
     a50: d10103a0     	sub	x0, x29, #0x40
     a54: aa1503e2     	mov	x2, x21
     a58: 8b140101     	add	x1, x8, x20
     a5c: 94000000     	bl	0xa5c <iq4_f3_storage_output_child_01+0xe0>
		0000000000000a5c:  R_AARCH64_CALL26	memcmp
     a60: 35002ae0     	cbnz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     a64: 91010294     	add	x20, x20, #0x40
     a68: aa1803e8     	mov	x8, x24
     a6c: eb1c029f     	cmp	x20, x28
     a70: 54fffd23     	b.lo	0xa14 <iq4_f3_storage_output_child_01+0x98>
     a74: 910006f7     	add	x23, x23, #0x1
     a78: f10066ff     	cmp	x23, #0x19
     a7c: 54fffc01     	b.ne	0x9fc <iq4_f3_storage_output_child_01+0x80>
     a80: f94007f4     	ldr	x20, [sp, #0x8]
     a84: 91002288     	add	x8, x20, #0x8
     a88: d343fd08     	lsr	x8, x8, #3
     a8c: f108051f     	cmp	x8, #0x201
     a90: 54002963     	b.lo	0xfbc <iq4_f3_storage_output_child_01+0x640>
     a94: 910123e2     	add	x2, sp, #0x48
     a98: aa1f03e0     	mov	x0, xzr
     a9c: aa1403e1     	mov	x1, x20
     aa0: 52800103     	mov	w3, #0x8                // =8
     aa4: 94000000     	bl	0xaa4 <iq4_f3_storage_output_child_01+0x128>
		0000000000000aa4:  R_AARCH64_CALL26	iq4_native_self_read_01
     aa8: 7100041f     	cmp	w0, #0x1
     aac: 54002881     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     ab0: d10103a2     	sub	x2, x29, #0x40
     ab4: aa1f03e0     	mov	x0, xzr
     ab8: aa1403e1     	mov	x1, x20
     abc: 52800103     	mov	w3, #0x8                // =8
     ac0: 94000000     	bl	0xac0 <iq4_f3_storage_output_child_01+0x144>
		0000000000000ac0:  R_AARCH64_CALL26	iq4_native_self_read_01
     ac4: 7100041f     	cmp	w0, #0x1
     ac8: 540027a1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     acc: f94027e8     	ldr	x8, [sp, #0x48]
     ad0: 529f3717     	mov	w23, #0xf9b8            // =63928
     ad4: f9400bf3     	ldr	x19, [sp, #0x10]
     ad8: 72a01717     	movk	w23, #0xb8, lsl #16
     adc: eb17011f     	cmp	x8, x23
     ae0: 54002701     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     ae4: f85c03a8     	ldur	x8, [x29, #-0x40]
     ae8: eb17011f     	cmp	x8, x23
     aec: 540026a1     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     af0: 91006288     	add	x8, x20, #0x18
     af4: d342fd08     	lsr	x8, x8, #2
     af8: f110051f     	cmp	x8, #0x401
     afc: 54002623     	b.lo	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b00: 91005281     	add	x1, x20, #0x14
     b04: 910073e2     	add	x2, sp, #0x1c
     b08: aa1f03e0     	mov	x0, xzr
     b0c: 52800083     	mov	w3, #0x4                // =4
     b10: 94000000     	bl	0xb10 <iq4_f3_storage_output_child_01+0x194>
		0000000000000b10:  R_AARCH64_CALL26	iq4_native_self_read_01
     b14: 7100041f     	cmp	w0, #0x1
     b18: 54002541     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b1c: 91005281     	add	x1, x20, #0x14
     b20: d10103a2     	sub	x2, x29, #0x40
     b24: aa1f03e0     	mov	x0, xzr
     b28: 52800083     	mov	w3, #0x4                // =4
     b2c: 94000000     	bl	0xb2c <iq4_f3_storage_output_child_01+0x1b0>
		0000000000000b2c:  R_AARCH64_CALL26	iq4_native_self_read_01
     b30: 7100041f     	cmp	w0, #0x1
     b34: 54002461     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b38: b9401fe8     	ldr	w8, [sp, #0x1c]
     b3c: 7106151f     	cmp	w8, #0x185
     b40: 54002401     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b44: b85c03a8     	ldur	w8, [x29, #-0x40]
     b48: 90000016     	adrp	x22, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000b48:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x20
     b4c: 7106151f     	cmp	w8, #0x185
     b50: 54002381     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b54: 91002268     	add	x8, x19, #0x8
     b58: d343fd08     	lsr	x8, x8, #3
     b5c: f108051f     	cmp	x8, #0x201
     b60: 54002303     	b.lo	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b64: 910123e2     	add	x2, sp, #0x48
     b68: aa1f03e0     	mov	x0, xzr
     b6c: aa1303e1     	mov	x1, x19
     b70: 52800103     	mov	w3, #0x8                // =8
     b74: 94000000     	bl	0xb74 <iq4_f3_storage_output_child_01+0x1f8>
		0000000000000b74:  R_AARCH64_CALL26	iq4_native_self_read_01
     b78: 7100041f     	cmp	w0, #0x1
     b7c: 54002221     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b80: d10103a2     	sub	x2, x29, #0x40
     b84: aa1f03e0     	mov	x0, xzr
     b88: aa1303e1     	mov	x1, x19
     b8c: 52800103     	mov	w3, #0x8                // =8
     b90: 94000000     	bl	0xb90 <iq4_f3_storage_output_child_01+0x214>
		0000000000000b90:  R_AARCH64_CALL26	iq4_native_self_read_01
     b94: 7100041f     	cmp	w0, #0x1
     b98: 54002141     	b.ne	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     b9c: f94027e9     	ldr	x9, [sp, #0x48]
     ba0: 910e22e8     	add	x8, x23, #0x388
     ba4: eb08013f     	cmp	x9, x8
     ba8: 540020a1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     bac: f85c03a9     	ldur	x9, [x29, #-0x40]
     bb0: eb08013f     	cmp	x9, x8
     bb4: 54002041     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     bb8: f9400be8     	ldr	x8, [sp, #0x10]
     bbc: 91008108     	add	x8, x8, #0x20
     bc0: d343fd08     	lsr	x8, x8, #3
     bc4: f108051f     	cmp	x8, #0x201
     bc8: 54001fa3     	b.lo	0xfbc <iq4_f3_storage_output_child_01+0x640>
     bcc: f9400be8     	ldr	x8, [sp, #0x10]
     bd0: 910103e2     	add	x2, sp, #0x40
     bd4: aa1f03e0     	mov	x0, xzr
     bd8: 52800103     	mov	w3, #0x8                // =8
     bdc: 91006101     	add	x1, x8, #0x18
     be0: 94000000     	bl	0xbe0 <iq4_f3_storage_output_child_01+0x264>
		0000000000000be0:  R_AARCH64_CALL26	iq4_native_self_read_01
     be4: 7100041f     	cmp	w0, #0x1
     be8: 54001ea1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     bec: f9400be8     	ldr	x8, [sp, #0x10]
     bf0: d10103a2     	sub	x2, x29, #0x40
     bf4: aa1f03e0     	mov	x0, xzr
     bf8: 52800103     	mov	w3, #0x8                // =8
     bfc: 91006101     	add	x1, x8, #0x18
     c00: 94000000     	bl	0xc00 <iq4_f3_storage_output_child_01+0x284>
		0000000000000c00:  R_AARCH64_CALL26	iq4_native_self_read_01
     c04: 7100041f     	cmp	w0, #0x1
     c08: 54001da1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c0c: f94023e0     	ldr	x0, [sp, #0x40]
     c10: d343fc08     	lsr	x8, x0, #3
     c14: f10a051f     	cmp	x8, #0x281
     c18: 54001d23     	b.lo	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c1c: f85c03a8     	ldur	x8, [x29, #-0x40]
     c20: eb08001f     	cmp	x0, x8
     c24: 54001cc1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c28: 910123e1     	add	x1, sp, #0x48
     c2c: 940000ee     	bl	0xfe4 <word>
     c30: 34001c60     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     c34: 529f1513     	mov	w19, #0xf8a8            // =63656
     c38: f94027e8     	ldr	x8, [sp, #0x48]
     c3c: 72a01773     	movk	w19, #0xbb, lsl #16
     c40: d1064269     	sub	x9, x19, #0x190
     c44: eb09011f     	cmp	x8, x9
     c48: 54001ba1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c4c: f94023f4     	ldr	x20, [sp, #0x40]
     c50: 910123e1     	add	x1, sp, #0x48
     c54: d1102295     	sub	x21, x20, #0x408
     c58: aa1503e0     	mov	x0, x21
     c5c: 940000e2     	bl	0xfe4 <word>
     c60: 34001ae0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     c64: f94027e8     	ldr	x8, [sp, #0x48]
     c68: d11fc269     	sub	x9, x19, #0x7f0
     c6c: eb09011f     	cmp	x8, x9
     c70: 54001a61     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c74: d10c0280     	sub	x0, x20, #0x300
     c78: 910123e1     	add	x1, sp, #0x48
     c7c: 940000da     	bl	0xfe4 <word>
     c80: 340019e0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     c84: f94027e8     	ldr	x8, [sp, #0x48]
     c88: eb13011f     	cmp	x8, x19
     c8c: 54001981     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     c90: d1080280     	sub	x0, x20, #0x200
     c94: 910123e1     	add	x1, sp, #0x48
     c98: 940000d3     	bl	0xfe4 <word>
     c9c: 34001900     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     ca0: f94027e8     	ldr	x8, [sp, #0x48]
     ca4: eb13011f     	cmp	x8, x19
     ca8: 540018a1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     cac: d10be280     	sub	x0, x20, #0x2f8
     cb0: 9100a3e1     	add	x1, sp, #0x28
     cb4: 940000cc     	bl	0xfe4 <word>
     cb8: 34001820     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     cbc: d107e280     	sub	x0, x20, #0x1f8
     cc0: 910083e1     	add	x1, sp, #0x20
     cc4: 940000c8     	bl	0xfe4 <word>
     cc8: 340017a0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     ccc: a94223e0     	ldp	x0, x8, [sp, #0x20]
     cd0: eb00011f     	cmp	x8, x0
     cd4: 54001740     	b.eq	0xfbc <iq4_f3_storage_output_child_01+0x640>
     cd8: 52800081     	mov	w1, #0x4                // =4
     cdc: 940000e6     	bl	0x1074 <event_shape>
     ce0: 340016e0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     ce4: f94017e0     	ldr	x0, [sp, #0x28]
     ce8: 52800041     	mov	w1, #0x2                // =2
     cec: 940000e2     	bl	0x1074 <event_shape>
     cf0: 34001660     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     cf4: d10103a0     	sub	x0, x29, #0x40
     cf8: 94000000     	bl	0xcf8 <iq4_f3_storage_output_child_01+0x37c>
		0000000000000cf8:  R_AARCH64_CALL26	iq4_f4_native_current_02
     cfc: 34001600     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     d00: f85c03a0     	ldur	x0, [x29, #-0x40]
     d04: 910123e1     	add	x1, sp, #0x48
     d08: 940000b7     	bl	0xfe4 <word>
     d0c: 34001580     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     d10: f94027e8     	ldr	x8, [sp, #0x48]
     d14: d16e4508     	sub	x8, x8, #0xb91, lsl #12 // =0xb91000
     d18: f13d211f     	cmp	x8, #0xf48
     d1c: 54001501     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     d20: f85c03a8     	ldur	x8, [x29, #-0x40]
     d24: 9100e3e1     	add	x1, sp, #0x38
     d28: 91072100     	add	x0, x8, #0x1c8
     d2c: 940000ae     	bl	0xfe4 <word>
     d30: 34001460     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     d34: f9401fe0     	ldr	x0, [sp, #0x38]
     d38: 910123e1     	add	x1, sp, #0x48
     d3c: 940000aa     	bl	0xfe4 <word>
     d40: 340013e0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     d44: f94027e8     	ldr	x8, [sp, #0x48]
     d48: d11982e9     	sub	x9, x23, #0x660
     d4c: eb09011f     	cmp	x8, x9
     d50: 54001361     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     d54: f9401fe8     	ldr	x8, [sp, #0x38]
     d58: 9100c3e1     	add	x1, sp, #0x30
     d5c: 91002100     	add	x0, x8, #0x8
     d60: 940000a1     	bl	0xfe4 <word>
     d64: 340012c0     	cbz	w0, 0xfbc <iq4_f3_storage_output_child_01+0x640>
     d68: f9401be8     	ldr	x8, [sp, #0x30]
     d6c: f85c03a9     	ldur	x9, [x29, #-0x40]
     d70: eb09011f     	cmp	x8, x9
     d74: 54001241     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     d78: 9000001a     	adrp	x26, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000d78:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x28
     d7c: f9400349     	ldr	x9, [x26]
		0000000000000d7c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     d80: b4000329     	cbz	x9, 0xde4 <iq4_f3_storage_output_child_01+0x468>
     d84: f94007ea     	ldr	x10, [sp, #0x8]
     d88: eb0a013f     	cmp	x9, x10
     d8c: 54001181     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     d90: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000d90:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x30
     d94: f9400bea     	ldr	x10, [sp, #0x10]
     d98: f9400129     	ldr	x9, [x9]
		0000000000000d98:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x30
     d9c: eb0a013f     	cmp	x9, x10
     da0: 540010e1     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     da4: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000da4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x38
     da8: f9400129     	ldr	x9, [x9]
		0000000000000da8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x38
     dac: eb08013f     	cmp	x9, x8
     db0: 54001061     	b.ne	0xfbc <iq4_f3_storage_output_child_01+0x640>
     db4: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000db4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x48
     db8: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000db8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x40
     dbc: f9401fea     	ldr	x10, [sp, #0x38]
     dc0: f9400108     	ldr	x8, [x8]
		0000000000000dc0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
     dc4: f9400129     	ldr	x9, [x9]
		0000000000000dc4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x40
     dc8: 9000000b     	adrp	x11, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000dc8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x50
     dcc: f9400bf3     	ldr	x19, [sp, #0x10]
     dd0: eb15011f     	cmp	x8, x21
     dd4: f9400168     	ldr	x8, [x11]
		0000000000000dd4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
     dd8: fa4a0120     	ccmp	x9, x10, #0x0, eq
     ddc: 9a930113     	csel	x19, x8, x19, eq
     de0: 14000078     	b	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     de4: 52800029     	mov	w9, #0x1                // =1
     de8: f9401feb     	ldr	x11, [sp, #0x38]
     dec: 90000019     	adrp	x25, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000dec:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x58
     df0: 91000339     	add	x25, x25, #0x0
		0000000000000df0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x58
     df4: 9000000a     	adrp	x10, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000df4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x38
     df8: 390002c9     	strb	w9, [x22]
		0000000000000df8:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x20
     dfc: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000dfc:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x40
     e00: d10042f7     	sub	x23, x23, #0x10
     e04: 52800313     	mov	w19, #0x18              // =24
     e08: aa1903f8     	mov	x24, x25
     e0c: f9000148     	str	x8, [x10]
		0000000000000e0c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x38
     e10: f900012b     	str	x11, [x9]
		0000000000000e10:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x40
     e14: aa1703e0     	mov	x0, x23
     e18: aa1803e1     	mov	x1, x24
     e1c: 94000072     	bl	0xfe4 <word>
     e20: 34000c60     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     e24: f1000673     	subs	x19, x19, #0x1
     e28: 910022f7     	add	x23, x23, #0x8
     e2c: 91002318     	add	x24, x24, #0x8
     e30: 54ffff21     	b.ne	0xe14 <iq4_f3_storage_output_child_01+0x498>
     e34: 5280e718     	mov	w24, #0x738             // =1848
     e38: 90000017     	adrp	x23, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e38:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     e3c: 910002f7     	add	x23, x23, #0x0
		0000000000000e3c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     e40: 72a01738     	movk	w24, #0xb9, lsl #16
     e44: 528002d3     	mov	w19, #0x16              // =22
     e48: aa1803e0     	mov	x0, x24
     e4c: aa1703e1     	mov	x1, x23
     e50: 94000065     	bl	0xfe4 <word>
     e54: 34000ac0     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     e58: f1000673     	subs	x19, x19, #0x1
     e5c: 91002318     	add	x24, x24, #0x8
     e60: 910022f7     	add	x23, x23, #0x8
     e64: 54ffff21     	b.ne	0xe48 <iq4_f3_storage_output_child_01+0x4cc>
     e68: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e68:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x11f4
     e6c: 91000108     	add	x8, x8, #0x0
		0000000000000e6c:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x11f4
     e70: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e70:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x1260
     e74: 91000129     	add	x9, x9, #0x0
		0000000000000e74:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x1260
     e78: 9000000a     	adrp	x10, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e78:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x140
     e7c: 9100014a     	add	x10, x10, #0x0
		0000000000000e7c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x140
     e80: a902a728     	stp	x8, x9, [x25, #0x28]
     e84: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e84:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x1320
     e88: 91000108     	add	x8, x8, #0x0
		0000000000000e88:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x1320
     e8c: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e8c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x13d0
     e90: 91000129     	add	x9, x9, #0x0
		0000000000000e90:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x13d0
     e94: 528ae882     	mov	w2, #0x5744             // =22340
     e98: a9002548     	stp	x8, x9, [x10]
     e9c: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000e9c:  R_AARCH64_ADR_PREL_PG_HI21	.text+0x14d4
     ea0: 91000108     	add	x8, x8, #0x0
		0000000000000ea0:  R_AARCH64_ADD_ABS_LO12_NC	.text+0x14d4
     ea4: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000ea4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x50
     ea8: 91000000     	add	x0, x0, #0x0
		0000000000000ea8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x50
     eac: 52802301     	mov	w1, #0x118              // =280
     eb0: 72a009c2     	movk	w2, #0x4e, lsl #16
     eb4: aa1903e3     	mov	x3, x25
     eb8: f9001d48     	str	x8, [x10, #0x38]
     ebc: 9400019f     	bl	0x1538 <construct>
     ec0: 34000760     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     ec4: 5293a602     	mov	w2, #0x9d30             // =40240
     ec8: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000ec8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     ecc: 91000000     	add	x0, x0, #0x0
		0000000000000ecc:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1c8
     ed0: 90000003     	adrp	x3, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000ed0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     ed4: 91000063     	add	x3, x3, #0x0
		0000000000000ed4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     ed8: 52800701     	mov	w1, #0x38               // =56
     edc: 72a009c2     	movk	w2, #0x4e, lsl #16
     ee0: 94000196     	bl	0x1538 <construct>
     ee4: 34000640     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     ee8: 5293a602     	mov	w2, #0x9d30             // =40240
     eec: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000eec:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d0
     ef0: 91000000     	add	x0, x0, #0x0
		0000000000000ef0:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1d0
     ef4: 90000003     	adrp	x3, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000ef4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     ef8: 91000063     	add	x3, x3, #0x0
		0000000000000ef8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     efc: 52800701     	mov	w1, #0x38               // =56
     f00: 72a009c2     	movk	w2, #0x4e, lsl #16
     f04: 9400018d     	bl	0x1538 <construct>
     f08: 34000520     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     f0c: 5293a602     	mov	w2, #0x9d30             // =40240
     f10: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f10:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d8
     f14: 91000000     	add	x0, x0, #0x0
		0000000000000f14:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x1d8
     f18: 90000003     	adrp	x3, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f18:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x118
     f1c: 91000063     	add	x3, x3, #0x0
		0000000000000f1c:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x118
     f20: 52800701     	mov	w1, #0x38               // =56
     f24: 72a009c2     	movk	w2, #0x4e, lsl #16
     f28: 94000184     	bl	0x1538 <construct>
     f2c: 34000400     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     f30: 90000013     	adrp	x19, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f30:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x50
     f34: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f34:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
     f38: f9400260     	ldr	x0, [x19]
		0000000000000f38:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
     f3c: f9400101     	ldr	x1, [x8]
		0000000000000f3c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
     f40: 94000000     	bl	0xf40 <iq4_f3_storage_output_child_01+0x5c4>
		0000000000000f40:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     f44: 34000340     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     f48: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f48:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d0
     f4c: f9400260     	ldr	x0, [x19]
		0000000000000f4c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
     f50: f9400101     	ldr	x1, [x8]
		0000000000000f50:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d0
     f54: 94000000     	bl	0xf54 <iq4_f3_storage_output_child_01+0x5d8>
		0000000000000f54:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     f58: 340002a0     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     f5c: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f5c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d8
     f60: f9400260     	ldr	x0, [x19]
		0000000000000f60:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
     f64: f9400101     	ldr	x1, [x8]
		0000000000000f64:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d8
     f68: 94000000     	bl	0xf68 <iq4_f3_storage_output_child_01+0x5ec>
		0000000000000f68:  R_AARCH64_CALL26	iq4_f4_menu_append_03
     f6c: 34000200     	cbz	w0, 0xfac <iq4_f3_storage_output_child_01+0x630>
     f70: a94227ea     	ldp	x10, x9, [sp, #0x20]
     f74: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f74:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x48
     f78: f9000115     	str	x21, [x8]
		0000000000000f78:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x48
     f7c: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000f7c:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
     f80: 91000108     	add	x8, x8, #0x0
		0000000000000f80:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
     f84: c89ffd0a     	stlr	x10, [x8]
     f88: 91002108     	add	x8, x8, #0x8
     f8c: c89ffd09     	stlr	x9, [x8]
     f90: a940a7e8     	ldp	x8, x9, [sp, #0x8]
     f94: f9400273     	ldr	x19, [x19]
		0000000000000f94:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
     f98: 390002df     	strb	wzr, [x22]
		0000000000000f98:  R_AARCH64_LDST8_ABS_LO12_NC	.bss+0x20
     f9c: f9000348     	str	x8, [x26]
		0000000000000f9c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x28
     fa0: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000fa0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x30
     fa4: f9000109     	str	x9, [x8]
		0000000000000fa4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x30
     fa8: 14000006     	b	0xfc0 <iq4_f3_storage_output_child_01+0x644>
     fac: 52800028     	mov	w8, #0x1                // =1
     fb0: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_bound_01>
		0000000000000fb0:  R_AARCH64_ADR_PREL_PG_HI21	.bss
     fb4: 91000129     	add	x9, x9, #0x0
		0000000000000fb4:  R_AARCH64_ADD_ABS_LO12_NC	.bss
     fb8: 889ffd28     	stlr	w8, [x9]
     fbc: f9400bf3     	ldr	x19, [sp, #0x10]
     fc0: aa1303e0     	mov	x0, x19
     fc4: a94e4ff4     	ldp	x20, x19, [sp, #0xe0]
     fc8: a94d57f6     	ldp	x22, x21, [sp, #0xd0]
     fcc: a94c5ff8     	ldp	x24, x23, [sp, #0xc0]
     fd0: a94b67fa     	ldp	x26, x25, [sp, #0xb0]
     fd4: a94a6ffc     	ldp	x28, x27, [sp, #0xa0]
     fd8: a9497bfd     	ldp	x29, x30, [sp, #0x90]
     fdc: 9103c3ff     	add	sp, sp, #0xf0
     fe0: d65f03c0     	ret

0000000000000fe4 <word>:
     fe4: 91002008     	add	x8, x0, #0x8
     fe8: d343fd08     	lsr	x8, x8, #3
     fec: f108051f     	cmp	x8, #0x201
     ff0: 54000062     	b.hs	0xffc <word+0x18>
     ff4: 2a1f03e0     	mov	w0, wzr
     ff8: d65f03c0     	ret
     ffc: d100c3ff     	sub	sp, sp, #0x30
    1000: a9017bfd     	stp	x29, x30, [sp, #0x10]
    1004: a9024ff4     	stp	x20, x19, [sp, #0x20]
    1008: 910043fd     	add	x29, sp, #0x10
    100c: aa0003f4     	mov	x20, x0
    1010: aa0103f3     	mov	x19, x1
    1014: aa1f03e0     	mov	x0, xzr
    1018: aa1403e1     	mov	x1, x20
    101c: aa1303e2     	mov	x2, x19
    1020: 52800103     	mov	w3, #0x8                // =8
    1024: 94000000     	bl	0x1024 <word+0x40>
		0000000000001024:  R_AARCH64_CALL26	iq4_native_self_read_01
    1028: 7100041f     	cmp	w0, #0x1
    102c: 540001a1     	b.ne	0x1060 <word+0x7c>
    1030: 910023e2     	add	x2, sp, #0x8
    1034: aa1f03e0     	mov	x0, xzr
    1038: aa1403e1     	mov	x1, x20
    103c: 52800103     	mov	w3, #0x8                // =8
    1040: 94000000     	bl	0x1040 <word+0x5c>
		0000000000001040:  R_AARCH64_CALL26	iq4_native_self_read_01
    1044: 7100041f     	cmp	w0, #0x1
    1048: 540000c1     	b.ne	0x1060 <word+0x7c>
    104c: f9400268     	ldr	x8, [x19]
    1050: f94007e9     	ldr	x9, [sp, #0x8]
    1054: eb09011f     	cmp	x8, x9
    1058: 1a9f17e0     	cset	w0, eq
    105c: 14000002     	b	0x1064 <word+0x80>
    1060: 2a1f03e0     	mov	w0, wzr
    1064: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1068: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    106c: 9100c3ff     	add	sp, sp, #0x30
    1070: d65f03c0     	ret

0000000000001074 <event_shape>:
    1074: d10143ff     	sub	sp, sp, #0x50
    1078: a9027bfd     	stp	x29, x30, [sp, #0x20]
    107c: a90357f6     	stp	x22, x21, [sp, #0x30]
    1080: a9044ff4     	stp	x20, x19, [sp, #0x40]
    1084: 910083fd     	add	x29, sp, #0x20
    1088: d343fc08     	lsr	x8, x0, #3
    108c: aa0003f3     	mov	x19, x0
    1090: 2a1f03e0     	mov	w0, wzr
    1094: f108051f     	cmp	x8, #0x201
    1098: 54000a43     	b.lo	0x11e0 <event_shape+0x16c>
    109c: 92400a68     	and	x8, x19, #0x7
    10a0: b5000a08     	cbnz	x8, 0x11e0 <event_shape+0x16c>
    10a4: 91002268     	add	x8, x19, #0x8
    10a8: d343fd08     	lsr	x8, x8, #3
    10ac: f108051f     	cmp	x8, #0x201
    10b0: 54000963     	b.lo	0x11dc <event_shape+0x168>
    10b4: 2a0103f5     	mov	w21, w1
    10b8: 910043e2     	add	x2, sp, #0x10
    10bc: aa1f03e0     	mov	x0, xzr
    10c0: aa1303e1     	mov	x1, x19
    10c4: 52800103     	mov	w3, #0x8                // =8
    10c8: 94000000     	bl	0x10c8 <event_shape+0x54>
		00000000000010c8:  R_AARCH64_CALL26	iq4_native_self_read_01
    10cc: 7100041f     	cmp	w0, #0x1
    10d0: 54000861     	b.ne	0x11dc <event_shape+0x168>
    10d4: d10023a2     	sub	x2, x29, #0x8
    10d8: aa1f03e0     	mov	x0, xzr
    10dc: aa1303e1     	mov	x1, x19
    10e0: 52800103     	mov	w3, #0x8                // =8
    10e4: 94000000     	bl	0x10e4 <event_shape+0x70>
		00000000000010e4:  R_AARCH64_CALL26	iq4_native_self_read_01
    10e8: 7100041f     	cmp	w0, #0x1
    10ec: 54000781     	b.ne	0x11dc <event_shape+0x168>
    10f0: 52944516     	mov	w22, #0xa228            // =41512
    10f4: f9400be9     	ldr	x9, [sp, #0x10]
    10f8: 2a1f03e0     	mov	w0, wzr
    10fc: 72a01796     	movk	w22, #0xbc, lsl #16
    1100: 912782c8     	add	x8, x22, #0x9e0
    1104: eb08013f     	cmp	x9, x8
    1108: 540006c1     	b.ne	0x11e0 <event_shape+0x16c>
    110c: f85f83a9     	ldur	x9, [x29, #-0x8]
    1110: eb08013f     	cmp	x9, x8
    1114: 54000661     	b.ne	0x11e0 <event_shape+0x16c>
    1118: d1002274     	sub	x20, x19, #0x8
    111c: 910043e2     	add	x2, sp, #0x10
    1120: aa1f03e0     	mov	x0, xzr
    1124: aa1403e1     	mov	x1, x20
    1128: 52800103     	mov	w3, #0x8                // =8
    112c: 94000000     	bl	0x112c <event_shape+0xb8>
		000000000000112c:  R_AARCH64_CALL26	iq4_native_self_read_01
    1130: 7100041f     	cmp	w0, #0x1
    1134: 54000541     	b.ne	0x11dc <event_shape+0x168>
    1138: d10023a2     	sub	x2, x29, #0x8
    113c: aa1f03e0     	mov	x0, xzr
    1140: aa1403e1     	mov	x1, x20
    1144: 52800103     	mov	w3, #0x8                // =8
    1148: 94000000     	bl	0x1148 <event_shape+0xd4>
		0000000000001148:  R_AARCH64_CALL26	iq4_native_self_read_01
    114c: 7100041f     	cmp	w0, #0x1
    1150: 54000461     	b.ne	0x11dc <event_shape+0x168>
    1154: f9400be8     	ldr	x8, [sp, #0x10]
    1158: 2a1f03e0     	mov	w0, wzr
    115c: eb16011f     	cmp	x8, x22
    1160: 54000401     	b.ne	0x11e0 <event_shape+0x16c>
    1164: f85f83a8     	ldur	x8, [x29, #-0x8]
    1168: eb16011f     	cmp	x8, x22
    116c: 540003a1     	b.ne	0x11e0 <event_shape+0x16c>
    1170: 52827d88     	mov	w8, #0x13ec             // =5100
    1174: 8b080268     	add	x8, x19, x8
    1178: f140051f     	cmp	x8, #0x1, lsl #12       // =0x1000
    117c: 54000309     	b.ls	0x11dc <event_shape+0x168>
    1180: 52827d74     	mov	w20, #0x13eb            // =5099
    1184: d10023a2     	sub	x2, x29, #0x8
    1188: aa1f03e0     	mov	x0, xzr
    118c: 8b140261     	add	x1, x19, x20
    1190: 52800023     	mov	w3, #0x1                // =1
    1194: 94000000     	bl	0x1194 <event_shape+0x120>
		0000000000001194:  R_AARCH64_CALL26	iq4_native_self_read_01
    1198: 7100041f     	cmp	w0, #0x1
    119c: 54000201     	b.ne	0x11dc <event_shape+0x168>
    11a0: 8b140261     	add	x1, x19, x20
    11a4: 910033e2     	add	x2, sp, #0xc
    11a8: aa1f03e0     	mov	x0, xzr
    11ac: 52800023     	mov	w3, #0x1                // =1
    11b0: 94000000     	bl	0x11b0 <event_shape+0x13c>
		00000000000011b0:  R_AARCH64_CALL26	iq4_native_self_read_01
    11b4: 7100041f     	cmp	w0, #0x1
    11b8: 54000121     	b.ne	0x11dc <event_shape+0x168>
    11bc: 385f83a8     	ldurb	w8, [x29, #-0x8]
    11c0: 394033e9     	ldrb	w9, [sp, #0xc]
    11c4: 6b09011f     	cmp	w8, w9
    11c8: 540000a1     	b.ne	0x11dc <event_shape+0x168>
    11cc: 12001ea9     	and	w9, w21, #0xff
    11d0: 6b09011f     	cmp	w8, w9
    11d4: 1a9f17e0     	cset	w0, eq
    11d8: 14000002     	b	0x11e0 <event_shape+0x16c>
    11dc: 2a1f03e0     	mov	w0, wzr
    11e0: a9444ff4     	ldp	x20, x19, [sp, #0x40]
    11e4: a94357f6     	ldp	x22, x21, [sp, #0x30]
    11e8: a9427bfd     	ldp	x29, x30, [sp, #0x20]
    11ec: 910143ff     	add	sp, sp, #0x50
    11f0: d65f03c0     	ret

00000000000011f4 <menu_name>:
    11f4: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		00000000000011f4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x50
    11f8: aa0003e8     	mov	x8, x0
    11fc: 90000000     	adrp	x0, 0x1000 <word+0x1c>
		00000000000011fc:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1200: 91000000     	add	x0, x0, #0x0
		0000000000001200:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    1204: f9400129     	ldr	x9, [x9]
		0000000000001204:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
    1208: eb09011f     	cmp	x8, x9
    120c: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		000000000000120c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1
    1210: 91000108     	add	x8, x8, #0x0
		0000000000001210:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1
    1214: 9a800108     	csel	x8, x8, x0, eq
    1218: b4000221     	cbz	x1, 0x125c <menu_name+0x68>
    121c: 71000449     	subs	w9, w2, #0x1
    1220: 540001eb     	b.lt	0x125c <menu_name+0x68>
    1224: 7100085f     	cmp	w2, #0x2
    1228: 54000143     	b.lo	0x1250 <menu_name+0x5c>
    122c: aa1f03ea     	mov	x10, xzr
    1230: 386a690b     	ldrb	w11, [x8, x10]
    1234: 3400010b     	cbz	w11, 0x1254 <menu_name+0x60>
    1238: 382a682b     	strb	w11, [x1, x10]
    123c: 9100054a     	add	x10, x10, #0x1
    1240: eb0a013f     	cmp	x9, x10
    1244: 54ffff61     	b.ne	0x1230 <menu_name+0x3c>
    1248: aa0903ea     	mov	x10, x9
    124c: 14000002     	b	0x1254 <menu_name+0x60>
    1250: aa1f03ea     	mov	x10, xzr
    1254: aa0103e0     	mov	x0, x1
    1258: 382a683f     	strb	wzr, [x1, x10]
    125c: d65f03c0     	ret

0000000000001260 <menu_value>:
    1260: d100c3ff     	sub	sp, sp, #0x30
    1264: a9017bfd     	stp	x29, x30, [sp, #0x10]
    1268: a9024ff4     	stp	x20, x19, [sp, #0x20]
    126c: 910043fd     	add	x29, sp, #0x10
    1270: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001270:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x50
    1274: 2a0203f4     	mov	w20, w2
    1278: aa0103f3     	mov	x19, x1
    127c: f9400108     	ldr	x8, [x8]
		000000000000127c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x50
    1280: eb08001f     	cmp	x0, x8
    1284: 54000260     	b.eq	0x12d0 <menu_value+0x70>
    1288: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001288:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xb
    128c: 91000108     	add	x8, x8, #0x0
		000000000000128c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xb
    1290: 90000000     	adrp	x0, 0x1000 <word+0x1c>
		0000000000001290:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1294: 91000000     	add	x0, x0, #0x0
		0000000000001294:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    1298: b40003d3     	cbz	x19, 0x1310 <menu_value+0xb0>
    129c: 71000689     	subs	w9, w20, #0x1
    12a0: 5400038b     	b.lt	0x1310 <menu_value+0xb0>
    12a4: 71000a9f     	cmp	w20, #0x2
    12a8: 540002e3     	b.lo	0x1304 <menu_value+0xa4>
    12ac: aa1f03ea     	mov	x10, xzr
    12b0: 386a690b     	ldrb	w11, [x8, x10]
    12b4: 340002ab     	cbz	w11, 0x1308 <menu_value+0xa8>
    12b8: 382a6a6b     	strb	w11, [x19, x10]
    12bc: 9100054a     	add	x10, x10, #0x1
    12c0: eb0a013f     	cmp	x9, x10
    12c4: 54ffff61     	b.ne	0x12b0 <menu_value+0x50>
    12c8: aa0903ea     	mov	x10, x9
    12cc: 1400000f     	b	0x1308 <menu_value+0xa8>
    12d0: 910003e0     	mov	x0, sp
    12d4: 94000000     	bl	0x12d4 <menu_value+0x74>
		00000000000012d4:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
    12d8: 34fffd80     	cbz	w0, 0x1288 <menu_value+0x28>
    12dc: b94003e8     	ldr	w8, [sp]
    12e0: 7100091f     	cmp	w8, #0x2
    12e4: 54fffd28     	b.hi	0x1288 <menu_value+0x28>
    12e8: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		00000000000012e8:  R_AARCH64_ADR_PREL_PG_HI21	.rodata+0x718
    12ec: 91000129     	add	x9, x9, #0x0
		00000000000012ec:  R_AARCH64_ADD_ABS_LO12_NC	.rodata+0x718
    12f0: f8687928     	ldr	x8, [x9, x8, lsl #3]
    12f4: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		00000000000012f4:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0x258
    12f8: 91000129     	add	x9, x9, #0x0
		00000000000012f8:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0x258
    12fc: f8687928     	ldr	x8, [x9, x8, lsl #3]
    1300: 17ffffe4     	b	0x1290 <menu_value+0x30>
    1304: aa1f03ea     	mov	x10, xzr
    1308: aa1303e0     	mov	x0, x19
    130c: 382a6a7f     	strb	wzr, [x19, x10]
    1310: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    1314: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    1318: 9100c3ff     	add	sp, sp, #0x30
    131c: d65f03c0     	ret

0000000000001320 <leaf_name>:
    1320: b40001a0     	cbz	x0, 0x1354 <leaf_name+0x34>
    1324: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001324:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
    1328: f9400108     	ldr	x8, [x8]
		0000000000001328:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
    132c: eb08001f     	cmp	x0, x8
    1330: 54000180     	b.eq	0x1360 <leaf_name+0x40>
    1334: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001334:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d0
    1338: f9400108     	ldr	x8, [x8]
		0000000000001338:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d0
    133c: eb08001f     	cmp	x0, x8
    1340: 54000140     	b.eq	0x1368 <leaf_name+0x48>
    1344: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001344:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d8
    1348: f9400108     	ldr	x8, [x8]
		0000000000001348:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d8
    134c: eb08001f     	cmp	x0, x8
    1350: 54000100     	b.eq	0x1370 <leaf_name+0x50>
    1354: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001354:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1358: 91000108     	add	x8, x8, #0x0
		0000000000001358:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    135c: 14000009     	b	0x1380 <leaf_name+0x60>
    1360: aa1f03e8     	mov	x8, xzr
    1364: 14000004     	b	0x1374 <leaf_name+0x54>
    1368: 52800028     	mov	w8, #0x1                // =1
    136c: 14000002     	b	0x1374 <leaf_name+0x54>
    1370: 52800048     	mov	w8, #0x2                // =2
    1374: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		0000000000001374:  R_AARCH64_ADR_PREL_PG_HI21	.data.rel.ro+0x258
    1378: 91000129     	add	x9, x9, #0x0
		0000000000001378:  R_AARCH64_ADD_ABS_LO12_NC	.data.rel.ro+0x258
    137c: f8687928     	ldr	x8, [x9, x8, lsl #3]
    1380: 90000000     	adrp	x0, 0x1000 <word+0x1c>
		0000000000001380:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1384: 91000000     	add	x0, x0, #0x0
		0000000000001384:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    1388: b4000221     	cbz	x1, 0x13cc <leaf_name+0xac>
    138c: 71000449     	subs	w9, w2, #0x1
    1390: 540001eb     	b.lt	0x13cc <leaf_name+0xac>
    1394: 7100085f     	cmp	w2, #0x2
    1398: 54000143     	b.lo	0x13c0 <leaf_name+0xa0>
    139c: aa1f03ea     	mov	x10, xzr
    13a0: 386a690b     	ldrb	w11, [x8, x10]
    13a4: 3400010b     	cbz	w11, 0x13c4 <leaf_name+0xa4>
    13a8: 382a682b     	strb	w11, [x1, x10]
    13ac: 9100054a     	add	x10, x10, #0x1
    13b0: eb0a013f     	cmp	x9, x10
    13b4: 54ffff61     	b.ne	0x13a0 <leaf_name+0x80>
    13b8: aa0903ea     	mov	x10, x9
    13bc: 14000002     	b	0x13c4 <leaf_name+0xa4>
    13c0: aa1f03ea     	mov	x10, xzr
    13c4: aa0103e0     	mov	x0, x1
    13c8: 382a683f     	strb	wzr, [x1, x10]
    13cc: d65f03c0     	ret

00000000000013d0 <leaf_value>:
    13d0: d10103ff     	sub	sp, sp, #0x40
    13d4: a9017bfd     	stp	x29, x30, [sp, #0x10]
    13d8: f90013f5     	str	x21, [sp, #0x20]
    13dc: a9034ff4     	stp	x20, x19, [sp, #0x30]
    13e0: 910043fd     	add	x29, sp, #0x10
    13e4: 2a0203f4     	mov	w20, w2
    13e8: aa0103f3     	mov	x19, x1
    13ec: b40001a0     	cbz	x0, 0x1420 <leaf_value+0x50>
    13f0: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		00000000000013f0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
    13f4: f9400108     	ldr	x8, [x8]
		00000000000013f4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
    13f8: eb08001f     	cmp	x0, x8
    13fc: 54000180     	b.eq	0x142c <leaf_value+0x5c>
    1400: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001400:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d0
    1404: f9400108     	ldr	x8, [x8]
		0000000000001404:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d0
    1408: eb08001f     	cmp	x0, x8
    140c: 54000140     	b.eq	0x1434 <leaf_value+0x64>
    1410: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001410:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d8
    1414: f9400108     	ldr	x8, [x8]
		0000000000001414:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d8
    1418: eb08001f     	cmp	x0, x8
    141c: 54000100     	b.eq	0x143c <leaf_value+0x6c>
    1420: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001420:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1424: 91000108     	add	x8, x8, #0x0
		0000000000001424:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    1428: 14000013     	b	0x1474 <leaf_value+0xa4>
    142c: aa1f03f5     	mov	x21, xzr
    1430: 14000004     	b	0x1440 <leaf_value+0x70>
    1434: 52800035     	mov	w21, #0x1               // =1
    1438: 14000002     	b	0x1440 <leaf_value+0x70>
    143c: 52800055     	mov	w21, #0x2               // =2
    1440: 910003e0     	mov	x0, sp
    1444: 94000000     	bl	0x1444 <leaf_value+0x74>
		0000000000001444:  R_AARCH64_CALL26	iq4_f3_settings_snapshot_06
    1448: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		0000000000001448:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    144c: 91000108     	add	x8, x8, #0x0
		000000000000144c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    1450: 34000120     	cbz	w0, 0x1474 <leaf_value+0xa4>
    1454: 9000000a     	adrp	x10, 0x1000 <word+0x1c>
		0000000000001454:  R_AARCH64_ADR_PREL_PG_HI21	.rodata+0x708
    1458: 9100014a     	add	x10, x10, #0x0
		0000000000001458:  R_AARCH64_ADD_ABS_LO12_NC	.rodata+0x708
    145c: b94003e9     	ldr	w9, [sp]
    1460: b875794a     	ldr	w10, [x10, x21, lsl #2]
    1464: 6b0a013f     	cmp	w9, w10
    1468: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		0000000000001468:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0x2b
    146c: 91000129     	add	x9, x9, #0x0
		000000000000146c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0x2b
    1470: 9a880128     	csel	x8, x9, x8, eq
    1474: 90000000     	adrp	x0, 0x1000 <word+0x1c>
		0000000000001474:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.str1.1+0xa
    1478: 91000000     	add	x0, x0, #0x0
		0000000000001478:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.str1.1+0xa
    147c: b4000233     	cbz	x19, 0x14c0 <leaf_value+0xf0>
    1480: 71000689     	subs	w9, w20, #0x1
    1484: 540001eb     	b.lt	0x14c0 <leaf_value+0xf0>
    1488: 71000a9f     	cmp	w20, #0x2
    148c: 54000143     	b.lo	0x14b4 <leaf_value+0xe4>
    1490: aa1f03ea     	mov	x10, xzr
    1494: 386a690b     	ldrb	w11, [x8, x10]
    1498: 3400010b     	cbz	w11, 0x14b8 <leaf_value+0xe8>
    149c: 382a6a6b     	strb	w11, [x19, x10]
    14a0: 9100054a     	add	x10, x10, #0x1
    14a4: eb0a013f     	cmp	x9, x10
    14a8: 54ffff61     	b.ne	0x1494 <leaf_value+0xc4>
    14ac: aa0903ea     	mov	x10, x9
    14b0: 14000002     	b	0x14b8 <leaf_value+0xe8>
    14b4: aa1f03ea     	mov	x10, xzr
    14b8: aa1303e0     	mov	x0, x19
    14bc: 382a6a7f     	strb	wzr, [x19, x10]
    14c0: a9434ff4     	ldp	x20, x19, [sp, #0x30]
    14c4: f94013f5     	ldr	x21, [sp, #0x20]
    14c8: a9417bfd     	ldp	x29, x30, [sp, #0x10]
    14cc: 910103ff     	add	sp, sp, #0x40
    14d0: d65f03c0     	ret

00000000000014d4 <activate>:
    14d4: b40001a0     	cbz	x0, 0x1508 <activate+0x34>
    14d8: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		00000000000014d8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1c8
    14dc: f9400108     	ldr	x8, [x8]
		00000000000014dc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1c8
    14e0: eb08001f     	cmp	x0, x8
    14e4: 54000160     	b.eq	0x1510 <activate+0x3c>
    14e8: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		00000000000014e8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d0
    14ec: f9400108     	ldr	x8, [x8]
		00000000000014ec:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d0
    14f0: eb08001f     	cmp	x0, x8
    14f4: 54000120     	b.eq	0x1518 <activate+0x44>
    14f8: 90000008     	adrp	x8, 0x1000 <word+0x1c>
		00000000000014f8:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x1d8
    14fc: f9400108     	ldr	x8, [x8]
		00000000000014fc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss+0x1d8
    1500: eb08001f     	cmp	x0, x8
    1504: 540000e0     	b.eq	0x1520 <activate+0x4c>
    1508: 2a1f03e0     	mov	w0, wzr
    150c: d65f03c0     	ret
    1510: aa1f03e8     	mov	x8, xzr
    1514: 14000004     	b	0x1524 <activate+0x50>
    1518: 52800028     	mov	w8, #0x1                // =1
    151c: 14000002     	b	0x1524 <activate+0x50>
    1520: 52800048     	mov	w8, #0x2                // =2
    1524: 90000009     	adrp	x9, 0x1000 <word+0x1c>
		0000000000001524:  R_AARCH64_ADR_PREL_PG_HI21	.rodata+0x708
    1528: 91000129     	add	x9, x9, #0x0
		0000000000001528:  R_AARCH64_ADD_ABS_LO12_NC	.rodata+0x708
    152c: 52800140     	mov	w0, #0xa                // =10
    1530: b8687921     	ldr	w1, [x9, x8, lsl #2]
    1534: 14000000     	b	0x1534 <activate+0x60>
		0000000000001534:  R_AARCH64_JUMP26	iq4_f3_native_mode_set_on_ui_01

0000000000001538 <construct>:
    1538: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
    153c: f9000bf5     	str	x21, [sp, #0x10]
    1540: a9024ff4     	stp	x20, x19, [sp, #0x20]
    1544: 910003fd     	mov	x29, sp
    1548: aa0003f4     	mov	x20, x0
    154c: aa0103e0     	mov	x0, x1
    1550: aa0303f3     	mov	x19, x3
    1554: aa1403e1     	mov	x1, x20
    1558: aa0203f5     	mov	x21, x2
    155c: 94000000     	bl	0x155c <construct+0x24>
		000000000000155c:  R_AARCH64_CALL26	iq4_f4_menu_new_03
    1560: 340001e0     	cbz	w0, 0x159c <construct+0x64>
    1564: f9400281     	ldr	x1, [x20]
    1568: b4000181     	cbz	x1, 0x1598 <construct+0x60>
    156c: aa1503e0     	mov	x0, x21
    1570: 94000000     	bl	0x1570 <construct+0x38>
		0000000000001570:  R_AARCH64_CALL26	iq4_f4_menu_ctor_03
    1574: 34000140     	cbz	w0, 0x159c <construct+0x64>
    1578: f9400280     	ldr	x0, [x20]
    157c: 91004268     	add	x8, x19, #0x10
    1580: 910063a1     	add	x1, x29, #0x18
    1584: 52800102     	mov	w2, #0x8                // =8
    1588: f9000fa8     	str	x8, [x29, #0x18]
    158c: 94000000     	bl	0x158c <construct+0x54>
		000000000000158c:  R_AARCH64_CALL26	memcpy
    1590: 52800020     	mov	w0, #0x1                // =1
    1594: 14000002     	b	0x159c <construct+0x64>
    1598: 2a1f03e0     	mov	w0, wzr
    159c: a9424ff4     	ldp	x20, x19, [sp, #0x20]
    15a0: f9400bf5     	ldr	x21, [sp, #0x10]
    15a4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
    15a8: d65f03c0     	ret
