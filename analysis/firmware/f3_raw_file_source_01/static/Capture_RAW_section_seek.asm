  7cc180: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7cc184: 910003fd     	mov	x29, sp
  7cc188: f9000fe0     	str	x0, [sp, #0x18]
  7cc18c: f9400fe0     	ldr	x0, [sp, #0x18]
  7cc190: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7cc194: b9503000     	ldr	w0, [x0, #0x1030]
  7cc198: 7100101f     	cmp	w0, #0x4
  7cc19c: 5400010c     	b.gt	0x7cc1bc
  7cc1a0: 71000c1f     	cmp	w0, #0x3
  7cc1a4: 540001ea     	b.ge	0x7cc1e0
  7cc1a8: 7100041f     	cmp	w0, #0x1
  7cc1ac: 54000540     	b.eq	0x7cc254
  7cc1b0: 7100081f     	cmp	w0, #0x2
  7cc1b4: 540000c0     	b.eq	0x7cc1cc
  7cc1b8: 1400003e     	b	0x7cc2b0
  7cc1bc: 7100141f     	cmp	w0, #0x5
  7cc1c0: 54000660     	b.eq	0x7cc28c
  7cc1c4: 7100181f     	cmp	w0, #0x6
  7cc1c8: 54000741     	b.ne	0x7cc2b0
  7cc1cc: f9400fe1     	ldr	x1, [sp, #0x18]
  7cc1d0: d2849f00     	mov	x0, #0x24f8             // =9464
  7cc1d4: 8b000020     	add	x0, x1, x0
  7cc1d8: 97ffd229     	bl	0x7c0a7c
  7cc1dc: 14000036     	b	0x7cc2b4
  7cc1e0: f9400fe1     	ldr	x1, [sp, #0x18]
  7cc1e4: d29a0b00     	mov	x0, #0xd058             // =53336
  7cc1e8: 8b000020     	add	x0, x1, x0
  7cc1ec: 528021e1     	mov	w1, #0x10f              // =271
  7cc1f0: 94003af0     	bl	0x7dadb0
  7cc1f4: b9002fe0     	str	w0, [sp, #0x2c]
  7cc1f8: f9400fe1     	ldr	x1, [sp, #0x18]
  7cc1fc: d29a0b00     	mov	x0, #0xd058             // =53336
  7cc200: 8b000020     	add	x0, x1, x0
  7cc204: 94003098     	bl	0x7d8464
  7cc208: 2a0003e1     	mov	w1, w0
  7cc20c: b9402fe0     	ldr	w0, [sp, #0x2c]
  7cc210: 0b010000     	add	w0, w0, w1
  7cc214: b9002fe0     	str	w0, [sp, #0x2c]
  7cc218: f9400fe0     	ldr	x0, [sp, #0x18]
  7cc21c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7cc220: f9681404     	ldr	x4, [x0, #0x5028]
  7cc224: f9400fe0     	ldr	x0, [sp, #0x18]
  7cc228: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7cc22c: f9681400     	ldr	x0, [x0, #0x5028]
  7cc230: f9400000     	ldr	x0, [x0]
  7cc234: 91012000     	add	x0, x0, #0x48
  7cc238: f9400003     	ldr	x3, [x0]
  7cc23c: b9402fe0     	ldr	w0, [sp, #0x2c]
  7cc240: 52800002     	mov	w2, #0x0                // =0
  7cc244: 2a0003e1     	mov	w1, w0
  7cc248: aa0403e0     	mov	x0, x4
  7cc24c: d63f0060     	blr	x3
  7cc250: 14000019     	b	0x7cc2b4
  7cc254: f9400fe0     	ldr	x0, [sp, #0x18]
  7cc258: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7cc25c: f9681404     	ldr	x4, [x0, #0x5028]
  7cc260: f9400fe0     	ldr	x0, [sp, #0x18]
  7cc264: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7cc268: f9681400     	ldr	x0, [x0, #0x5028]
  7cc26c: f9400000     	ldr	x0, [x0]
  7cc270: 91012000     	add	x0, x0, #0x48
  7cc274: f9400003     	ldr	x3, [x0]
  7cc278: 52800002     	mov	w2, #0x0                // =0
  7cc27c: 52800081     	mov	w1, #0x4                // =4
  7cc280: aa0403e0     	mov	x0, x4
  7cc284: d63f0060     	blr	x3
  7cc288: 1400000b     	b	0x7cc2b4
  7cc28c: 5280dbc3     	mov	w3, #0x6de              // =1758
  7cc290: b0002dc0     	adrp	x0, 0xd85000
  7cc294: 912c0002     	add	x2, x0, #0xb00
  7cc298: b0002dc0     	adrp	x0, 0xd85000
  7cc29c: 9137e001     	add	x1, x0, #0xdf8
  7cc2a0: b0002dc0     	adrp	x0, 0xd85000
  7cc2a4: 912ce000     	add	x0, x0, #0xb38
  7cc2a8: 97f0f8b6     	bl	0x40a580
  7cc2ac: 97fe8117     	bl	0x76c708
  7cc2b0: d503201f     	nop
  7cc2b4: d503201f     	nop
  7cc2b8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7cc2bc: d65f03c0     	ret
