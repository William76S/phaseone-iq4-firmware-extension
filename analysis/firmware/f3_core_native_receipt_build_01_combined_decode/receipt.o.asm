
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_core_native_receipt_build_01_combined_decode/receipt.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_f3_core_begin_01:

0000000000000000 <iq4_f3_core_begin_01>:
       0: d10183ff     	sub	sp, sp, #0x60
       4: a9027bfd     	stp	x29, x30, [sp, #0x20]
       8: f9001bf7     	str	x23, [sp, #0x30]
       c: a90457f6     	stp	x22, x21, [sp, #0x40]
      10: a9054ff4     	stp	x20, x19, [sp, #0x50]
      14: 910083fd     	add	x29, sp, #0x20
      18: aa0003f3     	mov	x19, x0
      1c: 52800020     	mov	w0, #0x1                // =1
      20: b40017f3     	cbz	x19, 0x31c <iq4_f3_core_begin_01+0x31c>
      24: b40017c2     	cbz	x2, 0x31c <iq4_f3_core_begin_01+0x31c>
      28: b40017a3     	cbz	x3, 0x31c <iq4_f3_core_begin_01+0x31c>
      2c: f9400048     	ldr	x8, [x2]
      30: b4001768     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      34: f9400448     	ldr	x8, [x2, #0x8]
      38: b4001728     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      3c: f9400848     	ldr	x8, [x2, #0x10]
      40: b40016e8     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      44: f9400c48     	ldr	x8, [x2, #0x18]
      48: b40016a8     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      4c: f9401048     	ldr	x8, [x2, #0x20]
      50: b4001668     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      54: f9401449     	ldr	x9, [x2, #0x28]
      58: cb0903e9     	neg	x9, x9
      5c: eb09011f     	cmp	x8, x9
      60: 540015e2     	b.hs	0x31c <iq4_f3_core_begin_01+0x31c>
      64: 90000008     	adrp	x8, 0x0 <iq4_f3_core_begin_01>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
      68: b9400108     	ldr	w8, [x8]
		0000000000000068:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x70
      6c: 34000068     	cbz	w8, 0x78 <iq4_f3_core_begin_01+0x78>
      70: 52800080     	mov	w0, #0x4                // =4
      74: 140000aa     	b	0x31c <iq4_f3_core_begin_01+0x31c>
      78: 90000008     	adrp	x8, 0x0 <iq4_f3_core_begin_01>
		0000000000000078:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x88
      7c: b9400108     	ldr	w8, [x8]
		000000000000007c:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x88
      80: 34000068     	cbz	w8, 0x8c <iq4_f3_core_begin_01+0x8c>
      84: 52800040     	mov	w0, #0x2                // =2
      88: 140000a5     	b	0x31c <iq4_f3_core_begin_01+0x31c>
      8c: 90000014     	adrp	x20, 0x0 <iq4_f3_core_begin_01>
		000000000000008c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      90: 91000294     	add	x20, x20, #0x0
		0000000000000090:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state
      94: aa0103f6     	mov	x22, x1
      98: aa1403e0     	mov	x0, x20
      9c: 2a1f03e1     	mov	w1, wzr
      a0: aa0203f7     	mov	x23, x2
      a4: 52801402     	mov	w2, #0xa0               // =160
      a8: aa0303f5     	mov	x21, x3
      ac: 94000000     	bl	0xac <iq4_f3_core_begin_01+0xac>
		00000000000000ac:  R_AARCH64_CALL26	memset
      b0: a9005a93     	stp	x19, x22, [x20]
      b4: aa1703f3     	mov	x19, x23
      b8: ad4006e0     	ldp	q0, q1, [x23]
      bc: 3dc00ae2     	ldr	q2, [x23, #0x20]
      c0: 3d800e82     	str	q2, [x20, #0x30]
      c4: ad008680     	stp	q0, q1, [x20, #0x10]
      c8: 94000000     	bl	0xc8 <iq4_f3_core_begin_01+0xc8>
		00000000000000c8:  R_AARCH64_CALL26	.text.admit
      cc: 34001260     	cbz	w0, 0x318 <iq4_f3_core_begin_01+0x318>
      d0: f9400261     	ldr	x1, [x19]
      d4: 528000a0     	mov	w0, #0x5                // =5
      d8: 91001028     	add	x8, x1, #0x4
      dc: d342fd08     	lsr	x8, x8, #2
      e0: f110051f     	cmp	x8, #0x401
      e4: 540011c3     	b.lo	0x31c <iq4_f3_core_begin_01+0x31c>
      e8: 90000014     	adrp	x20, 0x0 <iq4_f3_core_begin_01>
		00000000000000e8:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      ec: f9400288     	ldr	x8, [x20]
		00000000000000ec:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      f0: b4001168     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
      f4: 90000016     	adrp	x22, 0x0 <iq4_f3_core_begin_01>
		00000000000000f4:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      f8: 910073a2     	add	x2, x29, #0x1c
      fc: 52800083     	mov	w3, #0x4                // =4
     100: f94002c0     	ldr	x0, [x22]
		0000000000000100:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     104: d63f0100     	blr	x8
     108: 7100041f     	cmp	w0, #0x1
     10c: 54001061     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     110: f9400268     	ldr	x8, [x19]
     114: 528000a0     	mov	w0, #0x5                // =5
     118: 91004109     	add	x9, x8, #0x10
     11c: d342fd29     	lsr	x9, x9, #2
     120: f110053f     	cmp	x9, #0x401
     124: 54000fc3     	b.lo	0x31c <iq4_f3_core_begin_01+0x31c>
     128: f9400289     	ldr	x9, [x20]
		0000000000000128:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     12c: b4000f89     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     130: f94002c0     	ldr	x0, [x22]
		0000000000000130:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     134: 91003101     	add	x1, x8, #0xc
     138: 910063a2     	add	x2, x29, #0x18
     13c: 52800083     	mov	w3, #0x4                // =4
     140: d63f0120     	blr	x9
     144: 7100041f     	cmp	w0, #0x1
     148: 54000e81     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     14c: f9400268     	ldr	x8, [x19]
     150: 528000a0     	mov	w0, #0x5                // =5
     154: 910a4909     	add	x9, x8, #0x292
     158: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
     15c: 54000e09     	b.ls	0x31c <iq4_f3_core_begin_01+0x31c>
     160: f9400289     	ldr	x9, [x20]
		0000000000000160:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     164: b4000dc9     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     168: f94002c0     	ldr	x0, [x22]
		0000000000000168:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     16c: 910a4501     	add	x1, x8, #0x291
     170: 910023e2     	add	x2, sp, #0x8
     174: 52800023     	mov	w3, #0x1                // =1
     178: d63f0120     	blr	x9
     17c: 7100041f     	cmp	w0, #0x1
     180: 54000cc1     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     184: f9400661     	ldr	x1, [x19, #0x8]
     188: 528000a0     	mov	w0, #0x5                // =5
     18c: 91000428     	add	x8, x1, #0x1
     190: f140051f     	cmp	x8, #0x1, lsl #12       // =0x1000
     194: 54000c49     	b.ls	0x31c <iq4_f3_core_begin_01+0x31c>
     198: f9400288     	ldr	x8, [x20]
		0000000000000198:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     19c: b4000c08     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
     1a0: f94002c0     	ldr	x0, [x22]
		00000000000001a0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     1a4: 910013e2     	add	x2, sp, #0x4
     1a8: 52800023     	mov	w3, #0x1                // =1
     1ac: d63f0100     	blr	x8
     1b0: 7100041f     	cmp	w0, #0x1
     1b4: 54000b21     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     1b8: f9400268     	ldr	x8, [x19]
     1bc: 528000a0     	mov	w0, #0x5                // =5
     1c0: 910b0109     	add	x9, x8, #0x2c0
     1c4: d343fd29     	lsr	x9, x9, #3
     1c8: f108053f     	cmp	x9, #0x201
     1cc: 54000a83     	b.lo	0x31c <iq4_f3_core_begin_01+0x31c>
     1d0: f9400289     	ldr	x9, [x20]
		00000000000001d0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     1d4: b4000a49     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     1d8: f94002c0     	ldr	x0, [x22]
		00000000000001d8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     1dc: 910ae101     	add	x1, x8, #0x2b8
     1e0: 910043e2     	add	x2, sp, #0x10
     1e4: 52800103     	mov	w3, #0x8                // =8
     1e8: 910043f7     	add	x23, sp, #0x10
     1ec: d63f0120     	blr	x9
     1f0: 7100041f     	cmp	w0, #0x1
     1f4: 54000921     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     1f8: f9400268     	ldr	x8, [x19]
     1fc: 528000a0     	mov	w0, #0x5                // =5
     200: 910b2109     	add	x9, x8, #0x2c8
     204: d343fd29     	lsr	x9, x9, #3
     208: f108053f     	cmp	x9, #0x201
     20c: 54000883     	b.lo	0x31c <iq4_f3_core_begin_01+0x31c>
     210: f9400289     	ldr	x9, [x20]
		0000000000000210:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     214: b4000849     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     218: f94002c0     	ldr	x0, [x22]
		0000000000000218:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     21c: 910b0101     	add	x1, x8, #0x2c0
     220: 910022e2     	add	x2, x23, #0x8
     224: 52800103     	mov	w3, #0x8                // =8
     228: d63f0120     	blr	x9
     22c: 7100041f     	cmp	w0, #0x1
     230: 54000741     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     234: f9400268     	ldr	x8, [x19]
     238: 528000a0     	mov	w0, #0x5                // =5
     23c: 9100d109     	add	x9, x8, #0x34
     240: d342fd29     	lsr	x9, x9, #2
     244: f110053f     	cmp	x9, #0x401
     248: 540006a3     	b.lo	0x31c <iq4_f3_core_begin_01+0x31c>
     24c: f9400289     	ldr	x9, [x20]
		000000000000024c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     250: b4000669     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     254: f94002c0     	ldr	x0, [x22]
		0000000000000254:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     258: 9100c101     	add	x1, x8, #0x30
     25c: 910033e2     	add	x2, sp, #0xc
     260: 52800083     	mov	w3, #0x4                // =4
     264: d63f0120     	blr	x9
     268: 7100041f     	cmp	w0, #0x1
     26c: 54000561     	b.ne	0x318 <iq4_f3_core_begin_01+0x318>
     270: b9401fa8     	ldr	w8, [x29, #0x1c]
     274: 52a7f009     	mov	w9, #0x3f800000         // =1065353216
     278: 6b09011f     	cmp	w8, w9
     27c: 54000501     	b.ne	0x31c <iq4_f3_core_begin_01+0x31c>
     280: b9401ba8     	ldr	w8, [x29, #0x18]
     284: 350004c8     	cbnz	w8, 0x31c <iq4_f3_core_begin_01+0x31c>
     288: 394023e8     	ldrb	w8, [sp, #0x8]
     28c: 7100051f     	cmp	w8, #0x1
     290: 54000461     	b.ne	0x31c <iq4_f3_core_begin_01+0x31c>
     294: 394013e8     	ldrb	w8, [sp, #0x4]
     298: 35000428     	cbnz	w8, 0x31c <iq4_f3_core_begin_01+0x31c>
     29c: b9400fe8     	ldr	w8, [sp, #0xc]
     2a0: 350003e8     	cbnz	w8, 0x31c <iq4_f3_core_begin_01+0x31c>
     2a4: f9400be8     	ldr	x8, [sp, #0x10]
     2a8: b50003a8     	cbnz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
     2ac: f9400fe8     	ldr	x8, [sp, #0x18]
     2b0: d360fd09     	lsr	x9, x8, #32
     2b4: b4000349     	cbz	x9, 0x31c <iq4_f3_core_begin_01+0x31c>
     2b8: 2a0803e8     	mov	w8, w8
     2bc: b4000308     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
     2c0: 94000000     	bl	0x2c0 <iq4_f3_core_begin_01+0x2c0>
		00000000000002c0:  R_AARCH64_CALL26	iq4_native_current_tid_01
     2c4: aa0003e8     	mov	x8, x0
     2c8: 528000a0     	mov	w0, #0x5                // =5
     2cc: b4000288     	cbz	x8, 0x31c <iq4_f3_core_begin_01+0x31c>
     2d0: 90000009     	adrp	x9, 0x0 <iq4_f3_core_begin_01>
		00000000000002d0:  R_AARCH64_ADR_PREL_PG_HI21	.bss.sequence
     2d4: f940012a     	ldr	x10, [x9]
		00000000000002d4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.sequence
     2d8: b100055f     	cmn	x10, #0x1
     2dc: 54000200     	b.eq	0x31c <iq4_f3_core_begin_01+0x31c>
     2e0: 9100054a     	add	x10, x10, #0x1
     2e4: 2a1f03e0     	mov	w0, wzr
     2e8: 5280002b     	mov	w11, #0x1               // =1
     2ec: 9000000c     	adrp	x12, 0x0 <iq4_f3_core_begin_01>
		00000000000002ec:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x40
     2f0: 9100018c     	add	x12, x12, #0x0
		00000000000002f0:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x40
     2f4: f900012a     	str	x10, [x9]
		00000000000002f4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.sequence
     2f8: 90000009     	adrp	x9, 0x0 <iq4_f3_core_begin_01>
		00000000000002f8:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
     2fc: 91000129     	add	x9, x9, #0x0
		00000000000002fc:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
     300: b900558b     	str	w11, [x12, #0x54]
     304: b900498b     	str	w11, [x12, #0x48]
     308: a900218a     	stp	x10, x8, [x12]
     30c: f90002aa     	str	x10, [x21]
     310: c89ffd28     	stlr	x8, [x9]
     314: 14000002     	b	0x31c <iq4_f3_core_begin_01+0x31c>
     318: 528000a0     	mov	w0, #0x5                // =5
     31c: a9454ff4     	ldp	x20, x19, [sp, #0x50]
     320: f9401bf7     	ldr	x23, [sp, #0x30]
     324: a94457f6     	ldp	x22, x21, [sp, #0x40]
     328: a9427bfd     	ldp	x29, x30, [sp, #0x20]
     32c: 910183ff     	add	sp, sp, #0x60
     330: d65f03c0     	ret

Disassembly of section .text.admit:

0000000000000000 <admit>:
       0: d10243ff     	sub	sp, sp, #0x90
       4: a9047bfd     	stp	x29, x30, [sp, #0x40]
       8: f9002bf9     	str	x25, [sp, #0x50]
       c: a9065ff8     	stp	x24, x23, [sp, #0x60]
      10: a90757f6     	stp	x22, x21, [sp, #0x70]
      14: a9084ff4     	stp	x20, x19, [sp, #0x80]
      18: 910103fd     	add	x29, sp, #0x40
      1c: 5293ab15     	mov	w21, #0x9d58            // =40280
      20: aa1f03f6     	mov	x22, xzr
      24: 90000014     	adrp	x20, 0x0 <admit>
		0000000000000024:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      28: 72a01235     	movk	w21, #0x91, lsl #16
      2c: 90000013     	adrp	x19, 0x0 <admit>
		000000000000002c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      30: 90000017     	adrp	x23, 0x0 <admit>
		0000000000000030:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_0
      34: 910002f7     	add	x23, x23, #0x0
		0000000000000034:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_0
      38: 14000005     	b	0x4c <admit+0x4c>
      3c: d342fec8     	lsr	x8, x22, #2
      40: 910012d6     	add	x22, x22, #0x4
      44: f1151d1f     	cmp	x8, #0x547
      48: 54000282     	b.hs	0x98 <admit+0x98>
      4c: f128d2df     	cmp	x22, #0xa34
      50: 54ffff60     	b.eq	0x3c <admit+0x3c>
      54: f13032df     	cmp	x22, #0xc0c
      58: 54ffff20     	b.eq	0x3c <admit+0x3c>
      5c: f9400288     	ldr	x8, [x20]
		000000000000005c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      60: b4000a68     	cbz	x8, 0x1ac <admit+0x1ac>
      64: f9400260     	ldr	x0, [x19]
		0000000000000064:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      68: 8b1502c1     	add	x1, x22, x21
      6c: 910003e2     	mov	x2, sp
      70: 52800083     	mov	w3, #0x4                // =4
      74: d63f0100     	blr	x8
      78: 7100041f     	cmp	w0, #0x1
      7c: 54000981     	b.ne	0x1ac <admit+0x1ac>
      80: 910003e0     	mov	x0, sp
      84: 8b1602e1     	add	x1, x23, x22
      88: 52800082     	mov	w2, #0x4                // =4
      8c: 94000000     	bl	0x8c <admit+0x8c>
		000000000000008c:  R_AARCH64_CALL26	memcmp
      90: 34fffd60     	cbz	w0, 0x3c <admit+0x3c>
      94: 14000046     	b	0x1ac <admit+0x1ac>
      98: 52874516     	mov	w22, #0x3a28            // =14888
      9c: aa1f03f7     	mov	x23, xzr
      a0: 90000018     	adrp	x24, 0x0 <admit>
		00000000000000a0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_1
      a4: 91000318     	add	x24, x24, #0x0
		00000000000000a4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_1
      a8: 72a012d6     	movk	w22, #0x96, lsl #16
      ac: 14000005     	b	0xc0 <admit+0xc0>
      b0: d342fee8     	lsr	x8, x23, #2
      b4: 910012f7     	add	x23, x23, #0x4
      b8: f110e51f     	cmp	x8, #0x439
      bc: 54000282     	b.hs	0x10c <admit+0x10c>
      c0: f10c02ff     	cmp	x23, #0x300
      c4: 54ffff60     	b.eq	0xb0 <admit+0xb0>
      c8: f138e2ff     	cmp	x23, #0xe38
      cc: 54ffff20     	b.eq	0xb0 <admit+0xb0>
      d0: f9400288     	ldr	x8, [x20]
		00000000000000d0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      d4: b40006c8     	cbz	x8, 0x1ac <admit+0x1ac>
      d8: f9400260     	ldr	x0, [x19]
		00000000000000d8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      dc: 8b1602e1     	add	x1, x23, x22
      e0: 910003e2     	mov	x2, sp
      e4: 52800083     	mov	w3, #0x4                // =4
      e8: d63f0100     	blr	x8
      ec: 7100041f     	cmp	w0, #0x1
      f0: 540005e1     	b.ne	0x1ac <admit+0x1ac>
      f4: 910003e0     	mov	x0, sp
      f8: 8b170301     	add	x1, x24, x23
      fc: 52800082     	mov	w2, #0x4                // =4
     100: 94000000     	bl	0x100 <admit+0x100>
		0000000000000100:  R_AARCH64_CALL26	memcmp
     104: 34fffd60     	cbz	w0, 0xb0 <admit+0xb0>
     108: 14000029     	b	0x1ac <admit+0x1ac>
     10c: 528dcc18     	mov	w24, #0x6e60            // =28256
     110: aa1f03f7     	mov	x23, xzr
     114: 90000019     	adrp	x25, 0x0 <admit>
		0000000000000114:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_2
     118: 91000339     	add	x25, x25, #0x0
		0000000000000118:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_2
     11c: 72a00e38     	movk	w24, #0x71, lsl #16
     120: f9400288     	ldr	x8, [x20]
		0000000000000120:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     124: b4000448     	cbz	x8, 0x1ac <admit+0x1ac>
     128: f9400260     	ldr	x0, [x19]
		0000000000000128:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     12c: 8b1802e1     	add	x1, x23, x24
     130: 910003e2     	mov	x2, sp
     134: 52800083     	mov	w3, #0x4                // =4
     138: d63f0100     	blr	x8
     13c: 7100041f     	cmp	w0, #0x1
     140: 54000361     	b.ne	0x1ac <admit+0x1ac>
     144: 910003e0     	mov	x0, sp
     148: 8b170321     	add	x1, x25, x23
     14c: 52800082     	mov	w2, #0x4                // =4
     150: 94000000     	bl	0x150 <admit+0x150>
		0000000000000150:  R_AARCH64_CALL26	memcmp
     154: 350002c0     	cbnz	w0, 0x1ac <admit+0x1ac>
     158: f10702ff     	cmp	x23, #0x1c0
     15c: 910012f7     	add	x23, x23, #0x4
     160: 54fffe03     	b.lo	0x120 <admit+0x120>
     164: f9400288     	ldr	x8, [x20]
		0000000000000164:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     168: b4000228     	cbz	x8, 0x1ac <admit+0x1ac>
     16c: f9400260     	ldr	x0, [x19]
		000000000000016c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     170: 52951e01     	mov	w1, #0xa8f0             // =43248
     174: 52951e17     	mov	w23, #0xa8f0            // =43248
     178: 910003e2     	mov	x2, sp
     17c: 72a00801     	movk	w1, #0x40, lsl #16
     180: 52800083     	mov	w3, #0x4                // =4
     184: 72a00817     	movk	w23, #0x40, lsl #16
     188: d63f0100     	blr	x8
     18c: 7100041f     	cmp	w0, #0x1
     190: 540000e1     	b.ne	0x1ac <admit+0x1ac>
     194: 90000001     	adrp	x1, 0x0 <admit>
		0000000000000194:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_3
     198: 91000021     	add	x1, x1, #0x0
		0000000000000198:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_3
     19c: 910003e0     	mov	x0, sp
     1a0: 52800082     	mov	w2, #0x4                // =4
     1a4: 94000000     	bl	0x1a4 <admit+0x1a4>
		00000000000001a4:  R_AARCH64_CALL26	memcmp
     1a8: 34000120     	cbz	w0, 0x1cc <admit+0x1cc>
     1ac: 2a1f03e0     	mov	w0, wzr
     1b0: a9484ff4     	ldp	x20, x19, [sp, #0x80]
     1b4: f9402bf9     	ldr	x25, [sp, #0x50]
     1b8: a94757f6     	ldp	x22, x21, [sp, #0x70]
     1bc: a9465ff8     	ldp	x24, x23, [sp, #0x60]
     1c0: a9447bfd     	ldp	x29, x30, [sp, #0x40]
     1c4: 910243ff     	add	sp, sp, #0x90
     1c8: d65f03c0     	ret
     1cc: f9400288     	ldr	x8, [x20]
		00000000000001cc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     1d0: b4fffee8     	cbz	x8, 0x1ac <admit+0x1ac>
     1d4: f9400260     	ldr	x0, [x19]
		00000000000001d4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     1d8: 910012e1     	add	x1, x23, #0x4
     1dc: 910003e2     	mov	x2, sp
     1e0: 52800083     	mov	w3, #0x4                // =4
     1e4: d63f0100     	blr	x8
     1e8: 7100041f     	cmp	w0, #0x1
     1ec: 54fffe01     	b.ne	0x1ac <admit+0x1ac>
     1f0: 90000001     	adrp	x1, 0x0 <admit>
		00000000000001f0:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_3+0x4
     1f4: 91000021     	add	x1, x1, #0x0
		00000000000001f4:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_3+0x4
     1f8: 910003e0     	mov	x0, sp
     1fc: 52800082     	mov	w2, #0x4                // =4
     200: 94000000     	bl	0x200 <admit+0x200>
		0000000000000200:  R_AARCH64_CALL26	memcmp
     204: 35fffd40     	cbnz	w0, 0x1ac <admit+0x1ac>
     208: f9400288     	ldr	x8, [x20]
		0000000000000208:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     20c: b4fffd08     	cbz	x8, 0x1ac <admit+0x1ac>
     210: f9400260     	ldr	x0, [x19]
		0000000000000210:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     214: 910022e1     	add	x1, x23, #0x8
     218: 910003e2     	mov	x2, sp
     21c: 52800083     	mov	w3, #0x4                // =4
     220: d63f0100     	blr	x8
     224: 7100041f     	cmp	w0, #0x1
     228: 54fffc21     	b.ne	0x1ac <admit+0x1ac>
     22c: 90000001     	adrp	x1, 0x0 <admit>
		000000000000022c:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_3+0x8
     230: 91000021     	add	x1, x1, #0x0
		0000000000000230:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_3+0x8
     234: 910003e0     	mov	x0, sp
     238: 52800082     	mov	w2, #0x4                // =4
     23c: 94000000     	bl	0x23c <admit+0x23c>
		000000000000023c:  R_AARCH64_CALL26	memcmp
     240: 35fffb60     	cbnz	w0, 0x1ac <admit+0x1ac>
     244: f9400288     	ldr	x8, [x20]
		0000000000000244:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     248: b4fffb28     	cbz	x8, 0x1ac <admit+0x1ac>
     24c: f9400260     	ldr	x0, [x19]
		000000000000024c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     250: 910032e1     	add	x1, x23, #0xc
     254: 910003e2     	mov	x2, sp
     258: 52800083     	mov	w3, #0x4                // =4
     25c: d63f0100     	blr	x8
     260: 7100041f     	cmp	w0, #0x1
     264: 54fffa41     	b.ne	0x1ac <admit+0x1ac>
     268: 90000001     	adrp	x1, 0x0 <admit>
		0000000000000268:  R_AARCH64_ADR_PREL_PG_HI21	.rodata.iq4_core_pin_bytes_3+0xc
     26c: 91000021     	add	x1, x1, #0x0
		000000000000026c:  R_AARCH64_ADD_ABS_LO12_NC	.rodata.iq4_core_pin_bytes_3+0xc
     270: 910003e0     	mov	x0, sp
     274: 52800082     	mov	w2, #0x4                // =4
     278: 94000000     	bl	0x278 <admit+0x278>
		0000000000000278:  R_AARCH64_CALL26	memcmp
     27c: 35fff980     	cbnz	w0, 0x1ac <admit+0x1ac>
     280: 90000008     	adrp	x8, 0x0 <admit>
		0000000000000280:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_wrapper_01
     284: 92890be9     	mov	x9, #-0x4860            // =-18528
     288: f9400108     	ldr	x8, [x8]
		0000000000000288:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_wrapper_01
     28c: f2beed29     	movk	x9, #0xf769, lsl #16
     290: 8b090108     	add	x8, x8, x9
     294: b2648fe9     	mov	x9, #-0x10000000        // =-268435456
     298: eb09011f     	cmp	x8, x9
     29c: 54fff883     	b.lo	0x1ac <admit+0x1ac>
     2a0: f9400288     	ldr	x8, [x20]
		00000000000002a0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     2a4: b4fff848     	cbz	x8, 0x1ac <admit+0x1ac>
     2a8: f9400260     	ldr	x0, [x19]
		00000000000002a8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     2ac: 9138e2c1     	add	x1, x22, #0xe38
     2b0: 910073a2     	add	x2, x29, #0x1c
     2b4: 52800083     	mov	w3, #0x4                // =4
     2b8: d63f0100     	blr	x8
     2bc: 7100041f     	cmp	w0, #0x1
     2c0: 54fff761     	b.ne	0x1ac <admit+0x1ac>
     2c4: 90000008     	adrp	x8, 0x0 <admit>
		00000000000002c4:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_wrapper_01
     2c8: 52b28009     	mov	w9, #-0x6c000000        // =-1811939328
     2cc: 52b28017     	mov	w23, #-0x6c000000       // =-1811939328
     2d0: f9400108     	ldr	x8, [x8]
		00000000000002d0:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_wrapper_01
     2d4: b9401faa     	ldr	w10, [x29, #0x1c]
     2d8: 51659108     	sub	w8, w8, #0x964, lsl #12 // =0x964000
     2dc: 51218108     	sub	w8, w8, #0x860
     2e0: 33026d09     	bfxil	w9, w8, #2, #26
     2e4: 6b09015f     	cmp	w10, w9
     2e8: 54fff621     	b.ne	0x1ac <admit+0x1ac>
     2ec: 90000008     	adrp	x8, 0x0 <admit>
		00000000000002ec:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_join_wrapper_01
     2f0: 9294f169     	mov	x9, #-0xa78c            // =-42892
     2f4: f9400108     	ldr	x8, [x8]
		00000000000002f4:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_join_wrapper_01
     2f8: f2beedc9     	movk	x9, #0xf76e, lsl #16
     2fc: 8b090108     	add	x8, x8, x9
     300: b2648fe9     	mov	x9, #-0x10000000        // =-268435456
     304: eb09011f     	cmp	x8, x9
     308: 54fff523     	b.lo	0x1ac <admit+0x1ac>
     30c: f9400288     	ldr	x8, [x20]
		000000000000030c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     310: b4fff4e8     	cbz	x8, 0x1ac <admit+0x1ac>
     314: f9400260     	ldr	x0, [x19]
		0000000000000314:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     318: 9128d2a1     	add	x1, x21, #0xa34
     31c: 910073a2     	add	x2, x29, #0x1c
     320: 52800083     	mov	w3, #0x4                // =4
     324: d63f0100     	blr	x8
     328: 7100041f     	cmp	w0, #0x1
     32c: 54fff401     	b.ne	0x1ac <admit+0x1ac>
     330: 90000008     	adrp	x8, 0x0 <admit>
		0000000000000330:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_join_wrapper_01
     334: f9400108     	ldr	x8, [x8]
		0000000000000334:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_join_wrapper_01
     338: b9401fa9     	ldr	w9, [x29, #0x1c]
     33c: 51646908     	sub	w8, w8, #0x91a, lsl #12 // =0x91a000
     340: 511e3108     	sub	w8, w8, #0x78c
     344: 53026d08     	ubfx	w8, w8, #2, #26
     348: 2a170108     	orr	w8, w8, w23
     34c: 6b08013f     	cmp	w9, w8
     350: 54fff2e1     	b.ne	0x1ac <admit+0x1ac>
     354: 90000008     	adrp	x8, 0x0 <admit>
		0000000000000354:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_terminal_wrapper_01
     358: 92952c69     	mov	x9, #-0xa964            // =-43364
     35c: f9400108     	ldr	x8, [x8]
		000000000000035c:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_terminal_wrapper_01
     360: f2beedc9     	movk	x9, #0xf76e, lsl #16
     364: 8b090108     	add	x8, x8, x9
     368: b2648fe9     	mov	x9, #-0x10000000        // =-268435456
     36c: eb09011f     	cmp	x8, x9
     370: 54fff1e3     	b.lo	0x1ac <admit+0x1ac>
     374: f9400288     	ldr	x8, [x20]
		0000000000000374:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     378: b4fff1a8     	cbz	x8, 0x1ac <admit+0x1ac>
     37c: f9400260     	ldr	x0, [x19]
		000000000000037c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     380: 913032a1     	add	x1, x21, #0xc0c
     384: 910073a2     	add	x2, x29, #0x1c
     388: 52800083     	mov	w3, #0x4                // =4
     38c: d63f0100     	blr	x8
     390: 7100041f     	cmp	w0, #0x1
     394: 54fff0c1     	b.ne	0x1ac <admit+0x1ac>
     398: 90000008     	adrp	x8, 0x0 <admit>
		0000000000000398:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_core_native_terminal_wrapper_01
     39c: f9400108     	ldr	x8, [x8]
		000000000000039c:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_core_native_terminal_wrapper_01
     3a0: b9401fa9     	ldr	w9, [x29, #0x1c]
     3a4: 51646908     	sub	w8, w8, #0x91a, lsl #12 // =0x91a000
     3a8: 51259108     	sub	w8, w8, #0x964
     3ac: 53026d08     	ubfx	w8, w8, #2, #26
     3b0: 2a170108     	orr	w8, w8, w23
     3b4: 6b08013f     	cmp	w9, w8
     3b8: 54ffefa1     	b.ne	0x1ac <admit+0x1ac>
     3bc: 90000008     	adrp	x8, 0x0 <admit>
		00000000000003bc:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_decode_native_reader_wrapper_02
     3c0: 9287a4e9     	mov	x9, #-0x3d28            // =-15656
     3c4: f9400108     	ldr	x8, [x8]
		00000000000003c4:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_decode_native_reader_wrapper_02
     3c8: f2beed29     	movk	x9, #0xf769, lsl #16
     3cc: 8b090108     	add	x8, x8, x9
     3d0: b2648fe9     	mov	x9, #-0x10000000        // =-268435456
     3d4: eb09011f     	cmp	x8, x9
     3d8: 54ffeea3     	b.lo	0x1ac <admit+0x1ac>
     3dc: f9400288     	ldr	x8, [x20]
		00000000000003dc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     3e0: b4ffee68     	cbz	x8, 0x1ac <admit+0x1ac>
     3e4: f9400260     	ldr	x0, [x19]
		00000000000003e4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     3e8: 910c02c1     	add	x1, x22, #0x300
     3ec: 910073a2     	add	x2, x29, #0x1c
     3f0: 52800083     	mov	w3, #0x4                // =4
     3f4: d63f0100     	blr	x8
     3f8: 7100041f     	cmp	w0, #0x1
     3fc: 54ffed81     	b.ne	0x1ac <admit+0x1ac>
     400: 90000008     	adrp	x8, 0x0 <admit>
		0000000000000400:  R_AARCH64_ADR_GOT_PAGE	iq4_f3_decode_native_reader_wrapper_02
     404: f9400108     	ldr	x8, [x8]
		0000000000000404:  R_AARCH64_LD64_GOT_LO12_NC	iq4_f3_decode_native_reader_wrapper_02
     408: b9401fa9     	ldr	w9, [x29, #0x1c]
     40c: 51658d08     	sub	w8, w8, #0x963, lsl #12 // =0x963000
     410: 5134a108     	sub	w8, w8, #0xd28
     414: 53026d08     	ubfx	w8, w8, #2, #26
     418: 2a170108     	orr	w8, w8, w23
     41c: 6b08013f     	cmp	w9, w8
     420: 1a9f17e0     	cset	w0, eq
     424: 17ffff63     	b	0x1b0 <admit+0x1b0>

Disassembly of section .text.iq4_f3_core_before_01:

0000000000000000 <iq4_f3_core_before_01>:
       0: d10103ff     	sub	sp, sp, #0x40
       4: a9017bfd     	stp	x29, x30, [sp, #0x10]
       8: f90013f5     	str	x21, [sp, #0x20]
       c: a9034ff4     	stp	x20, x19, [sp, #0x30]
      10: 910043fd     	add	x29, sp, #0x10
      14: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		0000000000000014:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
      18: 91000108     	add	x8, x8, #0x0
		0000000000000018:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
      1c: c8dffd15     	ldar	x21, [x8]
      20: b4000a75     	cbz	x21, 0x16c <iq4_f3_core_before_01+0x16c>
      24: aa0203f4     	mov	x20, x2
      28: aa0003f3     	mov	x19, x0
      2c: 94000000     	bl	0x2c <iq4_f3_core_before_01+0x2c>
		000000000000002c:  R_AARCH64_CALL26	iq4_native_current_tid_01
      30: eb15001f     	cmp	x0, x21
      34: 540009c1     	b.ne	0x16c <iq4_f3_core_before_01+0x16c>
      38: 52890c88     	mov	w8, #0x4864             // =18532
      3c: 72a012c8     	movk	w8, #0x96, lsl #16
      40: eb08029f     	cmp	x20, x8
      44: 540008a1     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      48: b4000893     	cbz	x19, 0x158 <iq4_f3_core_before_01+0x158>
      4c: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		000000000000004c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8c
      50: 91000108     	add	x8, x8, #0x0
		0000000000000050:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x8c
      54: b9400109     	ldr	w9, [x8]
      58: 35000809     	cbnz	w9, 0x158 <iq4_f3_core_before_01+0x158>
      5c: b9400d08     	ldr	w8, [x8, #0xc]
      60: 350007c8     	cbnz	w8, 0x158 <iq4_f3_core_before_01+0x158>
      64: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x28
      68: f9400a69     	ldr	x9, [x19, #0x10]
      6c: f9400108     	ldr	x8, [x8]
		000000000000006c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x28
      70: eb08013f     	cmp	x9, x8
      74: 54000721     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      78: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		0000000000000078:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x10
      7c: f9401669     	ldr	x9, [x19, #0x28]
      80: f9400108     	ldr	x8, [x8]
		0000000000000080:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x10
      84: eb08013f     	cmp	x9, x8
      88: 54000681     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      8c: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		000000000000008c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x20
      90: f9401a69     	ldr	x9, [x19, #0x30]
      94: f9400108     	ldr	x8, [x8]
		0000000000000094:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x20
      98: eb08013f     	cmp	x9, x8
      9c: 540005e1     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      a0: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		00000000000000a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x18
      a4: f9401e69     	ldr	x9, [x19, #0x38]
      a8: f9400108     	ldr	x8, [x8]
		00000000000000a8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x18
      ac: eb08013f     	cmp	x9, x8
      b0: 54000541     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      b4: f9400268     	ldr	x8, [x19]
      b8: 91004109     	add	x9, x8, #0x10
      bc: d343fd29     	lsr	x9, x9, #3
      c0: f108053f     	cmp	x9, #0x201
      c4: 540004a3     	b.lo	0x158 <iq4_f3_core_before_01+0x158>
      c8: 90000014     	adrp	x20, 0x0 <iq4_f3_core_before_01>
		00000000000000c8:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      cc: f9400289     	ldr	x9, [x20]
		00000000000000cc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      d0: b4000449     	cbz	x9, 0x158 <iq4_f3_core_before_01+0x158>
      d4: 90000015     	adrp	x21, 0x0 <iq4_f3_core_before_01>
		00000000000000d4:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      d8: 91002101     	add	x1, x8, #0x8
      dc: 910063a2     	add	x2, x29, #0x18
      e0: f94002a0     	ldr	x0, [x21]
		00000000000000e0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      e4: 52800103     	mov	w3, #0x8                // =8
      e8: d63f0120     	blr	x9
      ec: 7100041f     	cmp	w0, #0x1
      f0: 54000341     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
      f4: f9400268     	ldr	x8, [x19]
      f8: 91006109     	add	x9, x8, #0x18
      fc: d343fd29     	lsr	x9, x9, #3
     100: f108053f     	cmp	x9, #0x201
     104: 540002a3     	b.lo	0x158 <iq4_f3_core_before_01+0x158>
     108: f9400289     	ldr	x9, [x20]
		0000000000000108:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
     10c: b4000269     	cbz	x9, 0x158 <iq4_f3_core_before_01+0x158>
     110: f94002a0     	ldr	x0, [x21]
		0000000000000110:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     114: 91004101     	add	x1, x8, #0x10
     118: 910023e2     	add	x2, sp, #0x8
     11c: 52800103     	mov	w3, #0x8                // =8
     120: d63f0120     	blr	x9
     124: 7100041f     	cmp	w0, #0x1
     128: 54000181     	b.ne	0x158 <iq4_f3_core_before_01+0x158>
     12c: f94007e8     	ldr	x8, [sp, #0x8]
     130: b40000c8     	cbz	x8, 0x148 <iq4_f3_core_before_01+0x148>
     134: 9000000a     	adrp	x10, 0x0 <iq4_f3_core_before_01>
		0000000000000134:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x30
     138: f9400fa9     	ldr	x9, [x29, #0x18]
     13c: f940014a     	ldr	x10, [x10]
		000000000000013c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x30
     140: eb0a013f     	cmp	x9, x10
     144: 540001e2     	b.hs	0x180 <iq4_f3_core_before_01+0x180>
     148: 90000008     	adrp	x8, 0x0 <iq4_f3_core_before_01>
		0000000000000148:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x98
     14c: 52800029     	mov	w9, #0x1                // =1
     150: b9000109     	str	w9, [x8]
		0000000000000150:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x98
     154: 14000006     	b	0x16c <iq4_f3_core_before_01+0x16c>
     158: 52800028     	mov	w8, #0x1                // =1
     15c: 90000009     	adrp	x9, 0x0 <iq4_f3_core_before_01>
		000000000000015c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
     160: 91000129     	add	x9, x9, #0x0
		0000000000000160:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x70
     164: b9000128     	str	w8, [x9]
     168: b9002928     	str	w8, [x9, #0x28]
     16c: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     170: f94013f5     	ldr	x21, [sp, #0x20]
     174: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     178: 910103ff     	add	sp, sp, #0x40
     17c: d65f03c0     	ret
     180: 9000000b     	adrp	x11, 0x0 <iq4_f3_core_before_01>
		0000000000000180:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x38
     184: f940016b     	ldr	x11, [x11]
		0000000000000184:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x38
     188: 8b0a016a     	add	x10, x11, x10
     18c: eb090149     	subs	x9, x10, x9
     190: 54fffdc3     	b.lo	0x148 <iq4_f3_core_before_01+0x148>
     194: eb09011f     	cmp	x8, x9
     198: 54fffd88     	b.hi	0x148 <iq4_f3_core_before_01+0x148>
     19c: f9400268     	ldr	x8, [x19]
     1a0: 90000009     	adrp	x9, 0x0 <iq4_f3_core_before_01>
		00000000000001a0:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x58
     1a4: 91000129     	add	x9, x9, #0x0
		00000000000001a4:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x58
     1a8: f9001128     	str	x8, [x9, #0x20]
     1ac: f9400a68     	ldr	x8, [x19, #0x10]
     1b0: f9001528     	str	x8, [x9, #0x28]
     1b4: 52800028     	mov	w8, #0x1                // =1
     1b8: f940026a     	ldr	x10, [x19]
     1bc: b9003528     	str	w8, [x9, #0x34]
     1c0: f900012a     	str	x10, [x9]
     1c4: 17ffffea     	b	0x16c <iq4_f3_core_before_01+0x16c>

Disassembly of section .text.iq4_f3_core_join_returned_01:

0000000000000000 <iq4_f3_core_join_returned_01>:
       0: d10103ff     	sub	sp, sp, #0x40
       4: a9017bfd     	stp	x29, x30, [sp, #0x10]
       8: a90257f6     	stp	x22, x21, [sp, #0x20]
       c: a9034ff4     	stp	x20, x19, [sp, #0x30]
      10: 910043fd     	add	x29, sp, #0x10
      14: 90000008     	adrp	x8, 0x0 <iq4_f3_core_join_returned_01>
		0000000000000014:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
      18: 91000108     	add	x8, x8, #0x0
		0000000000000018:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
      1c: c8dffd16     	ldar	x22, [x8]
      20: b40007b6     	cbz	x22, 0x114 <iq4_f3_core_join_returned_01+0x114>
      24: aa0203f5     	mov	x21, x2
      28: aa0103f4     	mov	x20, x1
      2c: aa0003f3     	mov	x19, x0
      30: 94000000     	bl	0x30 <iq4_f3_core_join_returned_01+0x30>
		0000000000000030:  R_AARCH64_CALL26	iq4_native_current_tid_01
      34: eb16001f     	cmp	x0, x22
      38: 540006e1     	b.ne	0x114 <iq4_f3_core_join_returned_01+0x114>
      3c: 90000016     	adrp	x22, 0x0 <iq4_f3_core_join_returned_01>
		000000000000003c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
      40: 910002d6     	add	x22, x22, #0x0
		0000000000000040:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x70
      44: b94002c8     	ldr	w8, [x22]
      48: b9402ac9     	ldr	w9, [x22, #0x28]
      4c: 2a090108     	orr	w8, w8, w9
      50: 35000628     	cbnz	w8, 0x114 <iq4_f3_core_join_returned_01+0x114>
      54: 5294f208     	mov	w8, #0xa790             // =42896
      58: 72a01228     	movk	w8, #0x91, lsl #16
      5c: eb0802bf     	cmp	x21, x8
      60: 54000541     	b.ne	0x108 <iq4_f3_core_join_returned_01+0x108>
      64: 90000008     	adrp	x8, 0x0 <iq4_f3_core_join_returned_01>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x20
      68: f9400108     	ldr	x8, [x8]
		0000000000000068:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x20
      6c: eb08029f     	cmp	x20, x8
      70: 540004c1     	b.ne	0x108 <iq4_f3_core_join_returned_01+0x108>
      74: aa1303e0     	mov	x0, x19
      78: 94000000     	bl	0x78 <iq4_f3_core_join_returned_01+0x78>
		0000000000000078:  R_AARCH64_CALL26	.text.frame_matches
      7c: 34000460     	cbz	w0, 0x108 <iq4_f3_core_join_returned_01+0x108>
      80: 9103d268     	add	x8, x19, #0xf4
      84: d342fd08     	lsr	x8, x8, #2
      88: f110051f     	cmp	x8, #0x401
      8c: 540003e3     	b.lo	0x108 <iq4_f3_core_join_returned_01+0x108>
      90: 90000014     	adrp	x20, 0x0 <iq4_f3_core_join_returned_01>
		0000000000000090:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      94: f9400288     	ldr	x8, [x20]
		0000000000000094:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      98: b4000388     	cbz	x8, 0x108 <iq4_f3_core_join_returned_01+0x108>
      9c: 90000015     	adrp	x21, 0x0 <iq4_f3_core_join_returned_01>
		000000000000009c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      a0: 9103c261     	add	x1, x19, #0xf0
      a4: d10013a2     	sub	x2, x29, #0x4
      a8: f94002a0     	ldr	x0, [x21]
		00000000000000a8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      ac: 52800083     	mov	w3, #0x4                // =4
      b0: d63f0100     	blr	x8
      b4: 7100041f     	cmp	w0, #0x1
      b8: 54000281     	b.ne	0x108 <iq4_f3_core_join_returned_01+0x108>
      bc: f13d327f     	cmp	x19, #0xf4c
      c0: 54000243     	b.lo	0x108 <iq4_f3_core_join_returned_01+0x108>
      c4: f9400288     	ldr	x8, [x20]
		00000000000000c4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      c8: b4000208     	cbz	x8, 0x108 <iq4_f3_core_join_returned_01+0x108>
      cc: f94002a0     	ldr	x0, [x21]
		00000000000000cc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      d0: 9102d261     	add	x1, x19, #0xb4
      d4: 910023e2     	add	x2, sp, #0x8
      d8: 52800083     	mov	w3, #0x4                // =4
      dc: d63f0100     	blr	x8
      e0: 7100041f     	cmp	w0, #0x1
      e4: 54000121     	b.ne	0x108 <iq4_f3_core_join_returned_01+0x108>
      e8: b9400be8     	ldr	w8, [sp, #0x8]
      ec: 51100508     	sub	w8, w8, #0x401
      f0: 3110011f     	cmn	w8, #0x400
      f4: 540001a2     	b.hs	0x128 <iq4_f3_core_join_returned_01+0x128>
      f8: 90000008     	adrp	x8, 0x0 <iq4_f3_core_join_returned_01>
		00000000000000f8:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x98
      fc: 52800029     	mov	w9, #0x1                // =1
     100: b9000109     	str	w9, [x8]
		0000000000000100:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x98
     104: 14000004     	b	0x114 <iq4_f3_core_join_returned_01+0x114>
     108: 52800028     	mov	w8, #0x1                // =1
     10c: b90002c8     	str	w8, [x22]
     110: b9002ac8     	str	w8, [x22, #0x28]
     114: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     118: a94257f6     	ldp	x22, x21, [sp, #0x20]
     11c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     120: 910103ff     	add	sp, sp, #0x40
     124: d65f03c0     	ret
     128: 90000008     	adrp	x8, 0x0 <iq4_f3_core_join_returned_01>
		0000000000000128:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x60
     12c: b85fc3a9     	ldur	w9, [x29, #-0x4]
     130: b940010a     	ldr	w10, [x8]
		0000000000000130:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x60
     134: 6b0a013f     	cmp	w9, w10
     138: 54fffe01     	b.ne	0xf8 <iq4_f3_core_join_returned_01+0xf8>
     13c: 7140055f     	cmp	w10, #0x1, lsl #12      // =0x1000
     140: 54fffdc2     	b.hs	0xf8 <iq4_f3_core_join_returned_01+0xf8>
     144: 11000529     	add	w9, w9, #0x1
     148: b9000109     	str	w9, [x8]
		0000000000000148:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x60
     14c: 17fffff2     	b	0x114 <iq4_f3_core_join_returned_01+0x114>

Disassembly of section .text.frame_matches:

0000000000000000 <frame_matches>:
       0: d10143ff     	sub	sp, sp, #0x50
       4: a9027bfd     	stp	x29, x30, [sp, #0x20]
       8: f9001bf5     	str	x21, [sp, #0x30]
       c: a9044ff4     	stp	x20, x19, [sp, #0x40]
      10: 910083fd     	add	x29, sp, #0x20
      14: b4000a80     	cbz	x0, 0x164 <frame_matches+0x164>
      18: 90000008     	adrp	x8, 0x0 <frame_matches>
		0000000000000018:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8c
      1c: 91000108     	add	x8, x8, #0x0
		000000000000001c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x8c
      20: b9400109     	ldr	w9, [x8]
      24: 34000a09     	cbz	w9, 0x164 <frame_matches+0x164>
      28: b9400d08     	ldr	w8, [x8, #0xc]
      2c: 350009c8     	cbnz	w8, 0x164 <frame_matches+0x164>
      30: 9103c008     	add	x8, x0, #0xf0
      34: d343fd08     	lsr	x8, x8, #3
      38: f108051f     	cmp	x8, #0x201
      3c: 54000943     	b.lo	0x164 <frame_matches+0x164>
      40: 90000014     	adrp	x20, 0x0 <frame_matches>
		0000000000000040:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      44: f9400289     	ldr	x9, [x20]
		0000000000000044:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      48: b40008e9     	cbz	x9, 0x164 <frame_matches+0x164>
      4c: 90000015     	adrp	x21, 0x0 <frame_matches>
		000000000000004c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      50: 9103a001     	add	x1, x0, #0xe8
      54: 910063a2     	add	x2, x29, #0x18
      58: f94002a8     	ldr	x8, [x21]
		0000000000000058:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      5c: aa0003f3     	mov	x19, x0
      60: 52800103     	mov	w3, #0x8                // =8
      64: aa0803e0     	mov	x0, x8
      68: d63f0120     	blr	x9
      6c: 7100041f     	cmp	w0, #0x1
      70: 540007a1     	b.ne	0x164 <frame_matches+0x164>
      74: 91048269     	add	x9, x19, #0x120
      78: aa1303e8     	mov	x8, x19
      7c: d343fd29     	lsr	x9, x9, #3
      80: f108053f     	cmp	x9, #0x201
      84: 54000703     	b.lo	0x164 <frame_matches+0x164>
      88: f9400289     	ldr	x9, [x20]
		0000000000000088:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      8c: b40006c9     	cbz	x9, 0x164 <frame_matches+0x164>
      90: f94002a0     	ldr	x0, [x21]
		0000000000000090:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      94: 91046101     	add	x1, x8, #0x118
      98: d10023a2     	sub	x2, x29, #0x8
      9c: 52800103     	mov	w3, #0x8                // =8
      a0: d63f0120     	blr	x9
      a4: 7100041f     	cmp	w0, #0x1
      a8: 540005e1     	b.ne	0x164 <frame_matches+0x164>
      ac: aa1303e8     	mov	x8, x19
      b0: f13de27f     	cmp	x19, #0xf78
      b4: 54000583     	b.lo	0x164 <frame_matches+0x164>
      b8: f9400289     	ldr	x9, [x20]
		00000000000000b8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      bc: b4000549     	cbz	x9, 0x164 <frame_matches+0x164>
      c0: f94002a0     	ldr	x0, [x21]
		00000000000000c0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      c4: 91022101     	add	x1, x8, #0x88
      c8: 910043e2     	add	x2, sp, #0x10
      cc: 52800103     	mov	w3, #0x8                // =8
      d0: d63f0120     	blr	x9
      d4: 7100041f     	cmp	w0, #0x1
      d8: 54000461     	b.ne	0x164 <frame_matches+0x164>
      dc: f9400289     	ldr	x9, [x20]
		00000000000000dc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      e0: b4000429     	cbz	x9, 0x164 <frame_matches+0x164>
      e4: f94002a0     	ldr	x0, [x21]
		00000000000000e4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      e8: 9102e261     	add	x1, x19, #0xb8
      ec: 910023e2     	add	x2, sp, #0x8
      f0: 52800103     	mov	w3, #0x8                // =8
      f4: d63f0120     	blr	x9
      f8: 7100041f     	cmp	w0, #0x1
      fc: 54000341     	b.ne	0x164 <frame_matches+0x164>
     100: 90000008     	adrp	x8, 0x0 <frame_matches>
		0000000000000100:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x78
     104: f9400fa9     	ldr	x9, [x29, #0x18]
     108: f9400108     	ldr	x8, [x8]
		0000000000000108:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x78
     10c: eb08013f     	cmp	x9, x8
     110: 540002a1     	b.ne	0x164 <frame_matches+0x164>
     114: 90000008     	adrp	x8, 0x0 <frame_matches>
		0000000000000114:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x80
     118: f85f83a9     	ldur	x9, [x29, #-0x8]
     11c: f9400108     	ldr	x8, [x8]
		000000000000011c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x80
     120: eb08013f     	cmp	x9, x8
     124: 54000201     	b.ne	0x164 <frame_matches+0x164>
     128: 90000008     	adrp	x8, 0x0 <frame_matches>
		0000000000000128:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x10
     12c: f9400be9     	ldr	x9, [sp, #0x10]
     130: f9400108     	ldr	x8, [x8]
		0000000000000130:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x10
     134: eb08013f     	cmp	x9, x8
     138: 54000161     	b.ne	0x164 <frame_matches+0x164>
     13c: 90000008     	adrp	x8, 0x0 <frame_matches>
		000000000000013c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x18
     140: f94007e9     	ldr	x9, [sp, #0x8]
     144: f9400108     	ldr	x8, [x8]
		0000000000000144:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x18
     148: eb08013f     	cmp	x9, x8
     14c: 540000c1     	b.ne	0x164 <frame_matches+0x164>
     150: 90000008     	adrp	x8, 0x0 <frame_matches>
		0000000000000150:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x50
     154: f9400109     	ldr	x9, [x8]
		0000000000000154:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x50
     158: b40001c9     	cbz	x9, 0x190 <frame_matches+0x190>
     15c: eb13013f     	cmp	x9, x19
     160: 54000180     	b.eq	0x190 <frame_matches+0x190>
     164: 52800028     	mov	w8, #0x1                // =1
     168: 90000009     	adrp	x9, 0x0 <frame_matches>
		0000000000000168:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
     16c: 91000129     	add	x9, x9, #0x0
		000000000000016c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x70
     170: 2a1f03e0     	mov	w0, wzr
     174: b9000128     	str	w8, [x9]
     178: b9002928     	str	w8, [x9, #0x28]
     17c: a9444ff4     	ldp	x20, x19, [sp, #0x40]
     180: f9401bf5     	ldr	x21, [sp, #0x30]
     184: a9427bfd     	ldp	x29, x30, [sp, #0x20]
     188: 910143ff     	add	sp, sp, #0x50
     18c: d65f03c0     	ret
     190: 52800020     	mov	w0, #0x1                // =1
     194: f9000113     	str	x19, [x8]
		0000000000000194:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x50
     198: 17fffff9     	b	0x17c <frame_matches+0x17c>

Disassembly of section .text.iq4_f3_core_terminal_01:

0000000000000000 <iq4_f3_core_terminal_01>:
       0: d10103ff     	sub	sp, sp, #0x40
       4: a9017bfd     	stp	x29, x30, [sp, #0x10]
       8: a90257f6     	stp	x22, x21, [sp, #0x20]
       c: a9034ff4     	stp	x20, x19, [sp, #0x30]
      10: 910043fd     	add	x29, sp, #0x10
      14: 90000008     	adrp	x8, 0x0 <iq4_f3_core_terminal_01>
		0000000000000014:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
      18: 91000108     	add	x8, x8, #0x0
		0000000000000018:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
      1c: c8dffd15     	ldar	x21, [x8]
      20: b4000c75     	cbz	x21, 0x1ac <iq4_f3_core_terminal_01+0x1ac>
      24: aa0103f4     	mov	x20, x1
      28: aa0003f3     	mov	x19, x0
      2c: 94000000     	bl	0x2c <iq4_f3_core_terminal_01+0x2c>
		000000000000002c:  R_AARCH64_CALL26	iq4_native_current_tid_01
      30: eb15001f     	cmp	x0, x21
      34: 54000bc1     	b.ne	0x1ac <iq4_f3_core_terminal_01+0x1ac>
      38: 90000015     	adrp	x21, 0x0 <iq4_f3_core_terminal_01>
		0000000000000038:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
      3c: 910002b5     	add	x21, x21, #0x0
		000000000000003c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x70
      40: b94002a8     	ldr	w8, [x21]
      44: b9402aa9     	ldr	w9, [x21, #0x28]
      48: 2a090108     	orr	w8, w8, w9
      4c: 35000b08     	cbnz	w8, 0x1ac <iq4_f3_core_terminal_01+0x1ac>
      50: 52952d08     	mov	w8, #0xa968             // =43368
      54: 72a01228     	movk	w8, #0x91, lsl #16
      58: eb08029f     	cmp	x20, x8
      5c: 54000a21     	b.ne	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      60: 90000008     	adrp	x8, 0x0 <iq4_f3_core_terminal_01>
		0000000000000060:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x90
      64: b9400108     	ldr	w8, [x8]
		0000000000000064:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x90
      68: 350009c8     	cbnz	w8, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      6c: aa1303e0     	mov	x0, x19
      70: 94000000     	bl	0x70 <iq4_f3_core_terminal_01+0x70>
		0000000000000070:  R_AARCH64_CALL26	.text.frame_matches
      74: 34000960     	cbz	w0, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      78: 9103d268     	add	x8, x19, #0xf4
      7c: d342fd08     	lsr	x8, x8, #2
      80: f110051f     	cmp	x8, #0x401
      84: 540008e3     	b.lo	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      88: 90000016     	adrp	x22, 0x0 <iq4_f3_core_terminal_01>
		0000000000000088:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
      8c: f94002c8     	ldr	x8, [x22]
		000000000000008c:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      90: b4000888     	cbz	x8, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      94: 90000014     	adrp	x20, 0x0 <iq4_f3_core_terminal_01>
		0000000000000094:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x8
      98: 9103c261     	add	x1, x19, #0xf0
      9c: d10013a2     	sub	x2, x29, #0x4
      a0: f9400280     	ldr	x0, [x20]
		00000000000000a0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      a4: 52800083     	mov	w3, #0x4                // =4
      a8: d63f0100     	blr	x8
      ac: 7100041f     	cmp	w0, #0x1
      b0: 54000781     	b.ne	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      b4: 9104d268     	add	x8, x19, #0x134
      b8: d342fd08     	lsr	x8, x8, #2
      bc: f110051f     	cmp	x8, #0x401
      c0: 54000703     	b.lo	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      c4: f94002c8     	ldr	x8, [x22]
		00000000000000c4:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      c8: b40006c8     	cbz	x8, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      cc: f9400280     	ldr	x0, [x20]
		00000000000000cc:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      d0: 9104c261     	add	x1, x19, #0x130
      d4: 910023e2     	add	x2, sp, #0x8
      d8: 52800083     	mov	w3, #0x4                // =4
      dc: d63f0100     	blr	x8
      e0: 7100041f     	cmp	w0, #0x1
      e4: 540005e1     	b.ne	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      e8: f13d327f     	cmp	x19, #0xf4c
      ec: 540005a3     	b.lo	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      f0: f94002c8     	ldr	x8, [x22]
		00000000000000f0:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state
      f4: b4000568     	cbz	x8, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
      f8: f9400280     	ldr	x0, [x20]
		00000000000000f8:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
      fc: 9102d261     	add	x1, x19, #0xb4
     100: 910013e2     	add	x2, sp, #0x4
     104: 52800083     	mov	w3, #0x4                // =4
     108: d63f0100     	blr	x8
     10c: 7100041f     	cmp	w0, #0x1
     110: 54000481     	b.ne	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
     114: 90000008     	adrp	x8, 0x0 <iq4_f3_core_terminal_01>
		0000000000000114:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state
     118: 91000108     	add	x8, x8, #0x0
		0000000000000118:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state
     11c: f9400d01     	ldr	x1, [x8, #0x18]
     120: 91000429     	add	x9, x1, #0x1
     124: f140053f     	cmp	x9, #0x1, lsl #12       // =0x1000
     128: 540003c9     	b.ls	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
     12c: f9400108     	ldr	x8, [x8]
     130: b4000388     	cbz	x8, 0x1a0 <iq4_f3_core_terminal_01+0x1a0>
     134: f9400280     	ldr	x0, [x20]
		0000000000000134:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x8
     138: 910003e2     	mov	x2, sp
     13c: 52800023     	mov	w3, #0x1                // =1
     140: d63f0100     	blr	x8
     144: 7100041f     	cmp	w0, #0x1
     148: 540002c1     	b.ne	0x1a0 <iq4_f3_core_terminal_01+0x1a0>
     14c: b9400be8     	ldr	w8, [sp, #0x8]
     150: 51000509     	sub	w9, w8, #0x1
     154: 713ffd3f     	cmp	w9, #0xfff
     158: 54000348     	b.hi	0x1c0 <iq4_f3_core_terminal_01+0x1c0>
     15c: b85fc3a9     	ldur	w9, [x29, #-0x4]
     160: 6b08013f     	cmp	w9, w8
     164: 540002e1     	b.ne	0x1c0 <iq4_f3_core_terminal_01+0x1c0>
     168: 90000009     	adrp	x9, 0x0 <iq4_f3_core_terminal_01>
		0000000000000168:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x60
     16c: b9400129     	ldr	w9, [x9]
		000000000000016c:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x60
     170: 6b09011f     	cmp	w8, w9
     174: 54000261     	b.ne	0x1c0 <iq4_f3_core_terminal_01+0x1c0>
     178: b94007e9     	ldr	w9, [sp, #0x4]
     17c: 34000229     	cbz	w9, 0x1c0 <iq4_f3_core_terminal_01+0x1c0>
     180: 394003e9     	ldrb	w9, [sp]
     184: 350001e9     	cbnz	w9, 0x1c0 <iq4_f3_core_terminal_01+0x1c0>
     188: 90000009     	adrp	x9, 0x0 <iq4_f3_core_terminal_01>
		0000000000000188:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x64
     18c: 91000129     	add	x9, x9, #0x0
		000000000000018c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x64
     190: b9000128     	str	w8, [x9]
     194: 52800028     	mov	w8, #0x1                // =1
     198: b9002d28     	str	w8, [x9, #0x2c]
     19c: 14000004     	b	0x1ac <iq4_f3_core_terminal_01+0x1ac>
     1a0: 52800028     	mov	w8, #0x1                // =1
     1a4: b90002a8     	str	w8, [x21]
     1a8: b9002aa8     	str	w8, [x21, #0x28]
     1ac: a9434ff4     	ldp	x20, x19, [sp, #0x30]
     1b0: a94257f6     	ldp	x22, x21, [sp, #0x20]
     1b4: a9417bfd     	ldp	x29, x30, [sp, #0x10]
     1b8: 910103ff     	add	sp, sp, #0x40
     1bc: d65f03c0     	ret
     1c0: 90000008     	adrp	x8, 0x0 <iq4_f3_core_terminal_01>
		00000000000001c0:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x98
     1c4: 52800029     	mov	w9, #0x1                // =1
     1c8: b9000109     	str	w9, [x8]
		00000000000001c8:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x98
     1cc: 17fffff8     	b	0x1ac <iq4_f3_core_terminal_01+0x1ac>

Disassembly of section .text.iq4_f3_core_after_01:

0000000000000000 <iq4_f3_core_after_01>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: 90000008     	adrp	x8, 0x0 <iq4_f3_core_after_01>
		000000000000000c:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
      10: 91000108     	add	x8, x8, #0x0
		0000000000000010:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
      14: c8dffd13     	ldar	x19, [x8]
      18: b40004d3     	cbz	x19, 0xb0 <iq4_f3_core_after_01+0xb0>
      1c: 94000000     	bl	0x1c <iq4_f3_core_after_01+0x1c>
		000000000000001c:  R_AARCH64_CALL26	iq4_native_current_tid_01
      20: eb13001f     	cmp	x0, x19
      24: 54000461     	b.ne	0xb0 <iq4_f3_core_after_01+0xb0>
      28: 90000008     	adrp	x8, 0x0 <iq4_f3_core_after_01>
		0000000000000028:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x68
      2c: 91000108     	add	x8, x8, #0x0
		000000000000002c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x68
      30: b9400109     	ldr	w9, [x8]
      34: 35000209     	cbnz	w9, 0x74 <iq4_f3_core_after_01+0x74>
      38: b9402508     	ldr	w8, [x8, #0x24]
      3c: 340001c8     	cbz	w8, 0x74 <iq4_f3_core_after_01+0x74>
      40: 90000008     	adrp	x8, 0x0 <iq4_f3_core_after_01>
		0000000000000040:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x60
      44: 91000108     	add	x8, x8, #0x0
		0000000000000044:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x60
      48: 52800029     	mov	w9, #0x1                // =1
      4c: b940310a     	ldr	w10, [x8, #0x30]
      50: b9000909     	str	w9, [x8, #0x8]
      54: 340001ca     	cbz	w10, 0x8c <iq4_f3_core_after_01+0x8c>
      58: b9400108     	ldr	w8, [x8]
      5c: 34000188     	cbz	w8, 0x8c <iq4_f3_core_after_01+0x8c>
      60: 90000008     	adrp	x8, 0x0 <iq4_f3_core_after_01>
		0000000000000060:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x98
      64: b9400108     	ldr	w8, [x8]
		0000000000000064:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x98
      68: 7100011f     	cmp	w8, #0x0
      6c: 1a9f17e8     	cset	w8, eq
      70: 1400000a     	b	0x98 <iq4_f3_core_after_01+0x98>
      74: 52800028     	mov	w8, #0x1                // =1
      78: 90000009     	adrp	x9, 0x0 <iq4_f3_core_after_01>
		0000000000000078:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x70
      7c: 91000129     	add	x9, x9, #0x0
		000000000000007c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x70
      80: b9000128     	str	w8, [x9]
      84: b9002928     	str	w8, [x9, #0x28]
      88: 1400000a     	b	0xb0 <iq4_f3_core_after_01+0xb0>
      8c: 2a1f03e8     	mov	w8, wzr
      90: 9000000a     	adrp	x10, 0x0 <iq4_f3_core_after_01>
		0000000000000090:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x98
      94: b9000149     	str	w9, [x10]
		0000000000000094:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x98
      98: 90000009     	adrp	x9, 0x0 <iq4_f3_core_after_01>
		0000000000000098:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x6c
      9c: 91000129     	add	x9, x9, #0x0
		000000000000009c:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x6c
      a0: b940052a     	ldr	w10, [x9, #0x4]
      a4: 7100015f     	cmp	w10, #0x0
      a8: 1a8813e8     	csel	w8, wzr, w8, ne
      ac: b9000128     	str	w8, [x9]
      b0: f9400bf3     	ldr	x19, [sp, #0x10]
      b4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      b8: d65f03c0     	ret

Disassembly of section .text.iq4_f3_core_end_01:

0000000000000000 <iq4_f3_core_end_01>:
       0: aa0003e8     	mov	x8, x0
       4: 52800020     	mov	w0, #0x1                // =1
       8: b4000448     	cbz	x8, 0x90 <iq4_f3_core_end_01+0x90>
       c: b4000421     	cbz	x1, 0x90 <iq4_f3_core_end_01+0x90>
      10: 90000009     	adrp	x9, 0x0 <iq4_f3_core_end_01>
		0000000000000010:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x40
      14: f9400129     	ldr	x9, [x9]
		0000000000000014:  R_AARCH64_LDST64_ABS_LO12_NC	.bss.state+0x40
      18: eb09011f     	cmp	x8, x9
      1c: 540003a1     	b.ne	0x90 <iq4_f3_core_end_01+0x90>
      20: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
      24: f9000bf5     	str	x21, [sp, #0x10]
      28: a9024ff4     	stp	x20, x19, [sp, #0x20]
      2c: 910003fd     	mov	x29, sp
      30: 90000013     	adrp	x19, 0x0 <iq4_f3_core_end_01>
		0000000000000030:  R_AARCH64_ADR_PREL_PG_HI21	.bss.published_thread
      34: 91000273     	add	x19, x19, #0x0
		0000000000000034:  R_AARCH64_ADD_ABS_LO12_NC	.bss.published_thread
      38: c8dffe75     	ldar	x21, [x19]
      3c: b4000235     	cbz	x21, 0x80 <iq4_f3_core_end_01+0x80>
      40: aa0103f4     	mov	x20, x1
      44: 94000000     	bl	0x44 <iq4_f3_core_end_01+0x44>
		0000000000000044:  R_AARCH64_CALL26	iq4_native_current_tid_01
      48: eb15001f     	cmp	x0, x21
      4c: 540001a1     	b.ne	0x80 <iq4_f3_core_end_01+0x80>
      50: 90000008     	adrp	x8, 0x0 <iq4_f3_core_end_01>
		0000000000000050:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x40
      54: 91000108     	add	x8, x8, #0x0
		0000000000000054:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x40
      58: ad408102     	ldp	q2, q0, [x8, #0x10]
      5c: f940190a     	ldr	x10, [x8, #0x30]
      60: 3dc00101     	ldr	q1, [x8]
      64: f9001a8a     	str	x10, [x20, #0x30]
      68: ad008282     	stp	q2, q0, [x20, #0x10]
      6c: 3d800281     	str	q1, [x20]
      70: b940310a     	ldr	w10, [x8, #0x30]
      74: 3400010a     	cbz	w10, 0x94 <iq4_f3_core_end_01+0x94>
      78: 52800080     	mov	w0, #0x4                // =4
      7c: 14000002     	b	0x84 <iq4_f3_core_end_01+0x84>
      80: 52800020     	mov	w0, #0x1                // =1
      84: a9424ff4     	ldp	x20, x19, [sp, #0x20]
      88: f9400bf5     	ldr	x21, [sp, #0x10]
      8c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
      90: d65f03c0     	ret
      94: 9000000a     	adrp	x10, 0x0 <iq4_f3_core_end_01>
		0000000000000094:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x68
      98: b940014a     	ldr	w10, [x10]
		0000000000000098:  R_AARCH64_LDST32_ABS_LO12_NC	.bss.state+0x68
      9c: 3400014a     	cbz	w10, 0xc4 <iq4_f3_core_end_01+0xc4>
      a0: c89ffe7f     	stlr	xzr, [x19]
      a4: 90000008     	adrp	x8, 0x0 <iq4_f3_core_end_01>
		00000000000000a4:  R_AARCH64_ADR_PREL_PG_HI21	.bss.state+0x6c
      a8: 91000108     	add	x8, x8, #0x0
		00000000000000a8:  R_AARCH64_ADD_ABS_LO12_NC	.bss.state+0x6c
      ac: b9400109     	ldr	w9, [x8]
      b0: b9001d1f     	str	wzr, [x8, #0x1c]
      b4: 7100013f     	cmp	w9, #0x0
      b8: 52800069     	mov	w9, #0x3                // =3
      bc: 1a9f0120     	csel	w0, w9, wzr, eq
      c0: 17fffff1     	b	0x84 <iq4_f3_core_end_01+0x84>
      c4: 5280002a     	mov	w10, #0x1               // =1
      c8: ad408102     	ldp	q2, q0, [x8, #0x10]
      cc: b900310a     	str	w10, [x8, #0x30]
      d0: 3dc00101     	ldr	q1, [x8]
      d4: 52800080     	mov	w0, #0x4                // =4
      d8: b900590a     	str	w10, [x8, #0x58]
      dc: f940190a     	ldr	x10, [x8, #0x30]
      e0: ad008282     	stp	q2, q0, [x20, #0x10]
      e4: f9001a8a     	str	x10, [x20, #0x30]
      e8: 3d800281     	str	q1, [x20]
      ec: 17ffffe6     	b	0x84 <iq4_f3_core_end_01+0x84>
