  7dadb0: aa0003e3     	mov	x3, x0
  7dadb4: b94d3400     	ldr	w0, [x0, #0xd34]
  7dadb8: 34000280     	cbz	w0, 0x7dae08
  7dadbc: 51000405     	sub	w5, w0, #0x1
  7dadc0: 9102d063     	add	x3, x3, #0xb4
  7dadc4: d37c7ca4     	ubfiz	x4, x5, #4, #32
  7dadc8: 8b040062     	add	x2, x3, x4
  7dadcc: b8646864     	ldr	w4, [x3, x4]
  7dadd0: 6b04003f     	cmp	w1, w4
  7dadd4: 54000180     	b.eq	0x7dae04
  7dadd8: 340001a5     	cbz	w5, 0x7dae0c
  7daddc: 51000802     	sub	w2, w0, #0x2
  7dade0: 14000003     	b	0x7dadec
  7dade4: 34000122     	cbz	w2, 0x7dae08
  7dade8: 51000402     	sub	w2, w0, #0x1
  7dadec: d37cec44     	lsl	x4, x2, #4
  7dadf0: aa0203e0     	mov	x0, x2
  7dadf4: b8646864     	ldr	w4, [x3, x4]
  7dadf8: 6b04003f     	cmp	w1, w4
  7dadfc: 54ffff41     	b.ne	0x7dade4
  7dae00: 8b021062     	add	x2, x3, x2, lsl #4
  7dae04: b9400c40     	ldr	w0, [x2, #0xc]
  7dae08: d65f03c0     	ret
  7dae0c: 52800000     	mov	w0, #0x0                // =0
  7dae10: d65f03c0     	ret
  7dae14: d503201f     	nop
  7dae18: b94d3403     	ldr	w3, [x0, #0xd34]
  7dae1c: 340002e3     	cbz	w3, 0x7dae78
  7dae20: 51000466     	sub	w6, w3, #0x1
  7dae24: 9102d000     	add	x0, x0, #0xb4
  7dae28: d37c7cc5     	ubfiz	x5, x6, #4, #32
  7dae2c: 8b050004     	add	x4, x0, x5
  7dae30: b8656805     	ldr	w5, [x0, x5]
  7dae34: 6b05003f     	cmp	w1, w5
  7dae38: 54000180     	b.eq	0x7dae68
  7dae3c: 340001e6     	cbz	w6, 0x7dae78
  7dae40: 51000864     	sub	w4, w3, #0x2
  7dae44: 14000003     	b	0x7dae50
  7dae48: 34000184     	cbz	w4, 0x7dae78
  7dae4c: 51000464     	sub	w4, w3, #0x1
  7dae50: d37cec85     	lsl	x5, x4, #4
  7dae54: aa0403e3     	mov	x3, x4
  7dae58: b8656805     	ldr	w5, [x0, x5]
  7dae5c: 6b05003f     	cmp	w1, w5
  7dae60: 54ffff41     	b.ne	0x7dae48
  7dae64: 8b041004     	add	x4, x0, x4, lsl #4
  7dae68: b9400c81     	ldr	w1, [x4, #0xc]
  7dae6c: 52800020     	mov	w0, #0x1                // =1
  7dae70: b9000041     	str	w1, [x2]
  7dae74: d65f03c0     	ret
  7dae78: 52800000     	mov	w0, #0x0                // =0
  7dae7c: d65f03c0     	ret
  7dae80: b94d3403     	ldr	w3, [x0, #0xd34]
  7dae84: 340002e3     	cbz	w3, 0x7daee0
  7dae88: 51000466     	sub	w6, w3, #0x1
  7dae8c: 9102d000     	add	x0, x0, #0xb4
  7dae90: d37c7cc5     	ubfiz	x5, x6, #4, #32
  7dae94: 8b050004     	add	x4, x0, x5
  7dae98: b8656805     	ldr	w5, [x0, x5]
  7dae9c: 6b05003f     	cmp	w1, w5
  7daea0: 54000180     	b.eq	0x7daed0
  7daea4: 340001e6     	cbz	w6, 0x7daee0
  7daea8: 51000864     	sub	w4, w3, #0x2
  7daeac: 14000003     	b	0x7daeb8
  7daeb0: 34000184     	cbz	w4, 0x7daee0
  7daeb4: 51000464     	sub	w4, w3, #0x1
  7daeb8: d37cec85     	lsl	x5, x4, #4
  7daebc: aa0403e3     	mov	x3, x4
  7daec0: b8656805     	ldr	w5, [x0, x5]
  7daec4: 6b05003f     	cmp	w1, w5
  7daec8: 54ffff41     	b.ne	0x7daeb0
  7daecc: 8b041004     	add	x4, x0, x4, lsl #4
  7daed0: b9400c81     	ldr	w1, [x4, #0xc]
  7daed4: 52800020     	mov	w0, #0x1                // =1
  7daed8: b9000041     	str	w1, [x2]
  7daedc: d65f03c0     	ret
  7daee0: 52800000     	mov	w0, #0x0                // =0
  7daee4: d65f03c0     	ret
  7daee8: aa0003e3     	mov	x3, x0
  7daeec: b94d3400     	ldr	w0, [x0, #0xd34]
  7daef0: 34000280     	cbz	w0, 0x7daf40
  7daef4: 51000405     	sub	w5, w0, #0x1
  7daef8: 9102d063     	add	x3, x3, #0xb4
  7daefc: d37c7ca4     	ubfiz	x4, x5, #4, #32
  7daf00: 8b040062     	add	x2, x3, x4
  7daf04: b8646864     	ldr	w4, [x3, x4]
  7daf08: 6b04003f     	cmp	w1, w4
  7daf0c: 54000180     	b.eq	0x7daf3c
  7daf10: 340001a5     	cbz	w5, 0x7daf44
  7daf14: 51000802     	sub	w2, w0, #0x2
  7daf18: 14000003     	b	0x7daf24
  7daf1c: 34000122     	cbz	w2, 0x7daf40
  7daf20: 51000402     	sub	w2, w0, #0x1
  7daf24: d37cec44     	lsl	x4, x2, #4
  7daf28: aa0203e0     	mov	x0, x2
  7daf2c: b8646864     	ldr	w4, [x3, x4]
  7daf30: 6b04003f     	cmp	w1, w4
  7daf34: 54ffff41     	b.ne	0x7daf1c
  7daf38: 8b021062     	add	x2, x3, x2, lsl #4
  7daf3c: b9400840     	ldr	w0, [x2, #0x8]
  7daf40: d65f03c0     	ret
  7daf44: 52800000     	mov	w0, #0x0                // =0
  7daf48: d65f03c0     	ret
  7daf4c: d503201f     	nop
  7daf50: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  7daf54: f240047f     	tst	x3, #0x3
  7daf58: 910003fd     	mov	x29, sp
  7daf5c: a90153f3     	stp	x19, x20, [sp, #0x10]
  7daf60: aa0303f4     	mov	x20, x3
  7daf64: 2a0203f3     	mov	w19, w2
  7daf68: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7daf6c: aa0003f5     	mov	x21, x0
  7daf70: aa0103f6     	mov	x22, x1
  7daf74: a90363f7     	stp	x23, x24, [sp, #0x30]
  7daf78: 2a0503f7     	mov	w23, w5
  7daf7c: aa0303f8     	mov	x24, x3
  7daf80: 540007c1     	b.ne	0x7db078
  7daf84: b94d36a0     	ldr	w0, [x21, #0xd34]
  7daf88: 340006c0     	cbz	w0, 0x7db060
  7daf8c: 51000405     	sub	w5, w0, #0x1
  7daf90: 9102d2a3     	add	x3, x21, #0xb4
  7daf94: d37c7ca2     	ubfiz	x2, x5, #4, #32
  7daf98: 8b020061     	add	x1, x3, x2
  7daf9c: b8626862     	ldr	w2, [x3, x2]
  7dafa0: 6b02027f     	cmp	w19, w2
  7dafa4: 54001500     	b.eq	0x7db244
  7dafa8: 340005c5     	cbz	w5, 0x7db060
  7dafac: 51000801     	sub	w1, w0, #0x2
  7dafb0: 14000003     	b	0x7dafbc
  7dafb4: 34000561     	cbz	w1, 0x7db060
  7dafb8: 51000401     	sub	w1, w0, #0x1
  7dafbc: d37cec22     	lsl	x2, x1, #4
  7dafc0: aa0103e0     	mov	x0, x1
  7dafc4: b8626862     	ldr	w2, [x3, x2]
  7dafc8: 6b02027f     	cmp	w19, w2
  7dafcc: 54ffff41     	b.ne	0x7dafb4
  7dafd0: 8b011073     	add	x19, x3, x1, lsl #4
  7dafd4: f94002c3     	ldr	x3, [x22]
  7dafd8: b9004fe4     	str	w4, [sp, #0x4c]
  7dafdc: b94d3aa5     	ldr	w5, [x21, #0xd38]
  7dafe0: 52800002     	mov	w2, #0x0                // =0
  7dafe4: b9400e61     	ldr	w1, [x19, #0xc]
  7dafe8: aa1603e0     	mov	x0, x22
  7dafec: f9402463     	ldr	x3, [x3, #0x48]
  7daff0: 0b0502f7     	add	w23, w23, w5
  7daff4: 0b0102e1     	add	w1, w23, w1
  7daff8: d63f0060     	blr	x3
  7daffc: f94002c3     	ldr	x3, [x22]
  7db000: aa1603e0     	mov	x0, x22
  7db004: b9404fe4     	ldr	w4, [sp, #0x4c]
  7db008: aa1403e1     	mov	x1, x20
  7db00c: f9400c63     	ldr	x3, [x3, #0x18]
  7db010: 2a0403e2     	mov	w2, w4
  7db014: d63f0060     	blr	x3
  7db018: b9400660     	ldr	w0, [x19, #0x4]
  7db01c: 7100041f     	cmp	w0, #0x1
  7db020: 54000149     	b.ls	0x7db048
  7db024: 7100101f     	cmp	w0, #0x4
  7db028: 3942c2a3     	ldrb	w3, [x21, #0xb0]
  7db02c: 1a9f17e1     	cset	w1, eq
  7db030: 6a010061     	ands	w1, w3, w1
  7db034: 54000ba1     	b.ne	0x7db1a8
  7db038: 34000083     	cbz	w3, 0x7db048
  7db03c: 7100081f     	cmp	w0, #0x2
  7db040: 54000300     	b.eq	0x7db0a0
  7db044: d503201f     	nop
  7db048: 52800020     	mov	w0, #0x1                // =1
  7db04c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7db050: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7db054: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7db058: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  7db05c: d65f03c0     	ret
  7db060: 52800000     	mov	w0, #0x0                // =0
  7db064: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7db068: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7db06c: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7db070: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  7db074: d65f03c0     	ret
  7db078: f0002d43     	adrp	x3, 0xd86000
  7db07c: f0002d41     	adrp	x1, 0xd86000
  7db080: 91262063     	add	x3, x3, #0x988
  7db084: 91252021     	add	x1, x1, #0x948
  7db088: 52803402     	mov	w2, #0x1a0              // =416
  7db08c: 52800080     	mov	w0, #0x4                // =4
  7db090: b9004fe4     	str	w4, [sp, #0x4c]
  7db094: 97fdad2e     	bl	0x74654c
  7db098: b9404fe4     	ldr	w4, [sp, #0x4c]
  7db09c: 17ffffba     	b	0x7daf84
  7db0a0: b9400a60     	ldr	w0, [x19, #0x8]
  7db0a4: 53017c01     	lsr	w1, w0, #1
  7db0a8: 34fffd01     	cbz	w1, 0x7db048
  7db0ac: 51000422     	sub	w2, w1, #0x1
  7db0b0: 7100185f     	cmp	w2, #0x6
  7db0b4: 54000cc9     	b.ls	0x7db24c
  7db0b8: 53047c00     	lsr	w0, w0, #4
  7db0bc: 8b205282     	add	x2, x20, w0, uxtw #4
  7db0c0: 3dc00300     	ldr	q0, [x24]
  7db0c4: 4f185401     	shl	v1.8h, v0.8h, #0x8
  7db0c8: 6f180400     	ushr	v0.8h, v0.8h, #0x8
  7db0cc: 4ea01c20     	orr	v0.16b, v1.16b, v0.16b
  7db0d0: 3c810700     	str	q0, [x24], #0x10
  7db0d4: eb02031f     	cmp	x24, x2
  7db0d8: 54ffff41     	b.ne	0x7db0c0
  7db0dc: 531d7000     	lsl	w0, w0, #3
  7db0e0: 6b00003f     	cmp	w1, w0
  7db0e4: 54fffb20     	b.eq	0x7db048
  7db0e8: 937f7c02     	sbfiz	x2, x0, #1, #32
  7db0ec: 11000403     	add	w3, w0, #0x1
  7db0f0: 6b03003f     	cmp	w1, w3
  7db0f4: 78626a83     	ldrh	w3, [x20, x2]
  7db0f8: 5ac00463     	rev16	w3, w3
  7db0fc: 78226a83     	strh	w3, [x20, x2]
  7db100: 54fffa4d     	b.le	0x7db048
  7db104: 91000844     	add	x4, x2, #0x2
  7db108: 11000803     	add	w3, w0, #0x2
  7db10c: 6b03003f     	cmp	w1, w3
  7db110: 78646a83     	ldrh	w3, [x20, x4]
  7db114: 5ac00463     	rev16	w3, w3
  7db118: 78246a83     	strh	w3, [x20, x4]
  7db11c: 54fff96d     	b.le	0x7db048
  7db120: 91001044     	add	x4, x2, #0x4
  7db124: 11000c03     	add	w3, w0, #0x3
  7db128: 6b03003f     	cmp	w1, w3
  7db12c: 78646a83     	ldrh	w3, [x20, x4]
  7db130: 5ac00463     	rev16	w3, w3
  7db134: 78246a83     	strh	w3, [x20, x4]
  7db138: 54fff88d     	b.le	0x7db048
  7db13c: 91001844     	add	x4, x2, #0x6
  7db140: 11001003     	add	w3, w0, #0x4
  7db144: 6b03003f     	cmp	w1, w3
  7db148: 78646a83     	ldrh	w3, [x20, x4]
  7db14c: 5ac00463     	rev16	w3, w3
  7db150: 78246a83     	strh	w3, [x20, x4]
  7db154: 54fff7ad     	b.le	0x7db048
  7db158: 91002044     	add	x4, x2, #0x8
  7db15c: 11001403     	add	w3, w0, #0x5
  7db160: 6b03003f     	cmp	w1, w3
  7db164: 78646a83     	ldrh	w3, [x20, x4]
  7db168: 5ac00463     	rev16	w3, w3
  7db16c: 78246a83     	strh	w3, [x20, x4]
  7db170: 54fff6cd     	b.le	0x7db048
  7db174: 91002843     	add	x3, x2, #0xa
  7db178: 11001800     	add	w0, w0, #0x6
  7db17c: 6b00003f     	cmp	w1, w0
  7db180: 78636a80     	ldrh	w0, [x20, x3]
  7db184: 5ac00400     	rev16	w0, w0
  7db188: 78236a80     	strh	w0, [x20, x3]
  7db18c: 54fff5ed     	b.le	0x7db048
  7db190: 91003042     	add	x2, x2, #0xc
  7db194: 78626a80     	ldrh	w0, [x20, x2]
  7db198: 5ac00400     	rev16	w0, w0
  7db19c: 78226a80     	strh	w0, [x20, x2]
  7db1a0: 52800020     	mov	w0, #0x1                // =1
  7db1a4: 17ffffaa     	b	0x7db04c
  7db1a8: b9400a65     	ldr	w5, [x19, #0x8]
  7db1ac: 6b450bff     	cmp	wzr, w5, lsr #2
  7db1b0: 54fff4c0     	b.eq	0x7db048
  7db1b4: d2800002     	mov	x2, #0x0                // =0
  7db1b8: b8627a84     	ldr	w4, [x20, x2, lsl #2]
  7db1bc: b9005be4     	str	w4, [sp, #0x58]
  7db1c0: 34000361     	cbz	w1, 0x7db22c
  7db1c4: d503201f     	nop
  7db1c8: b9005fe4     	str	w4, [sp, #0x5c]
  7db1cc: 39417fe0     	ldrb	w0, [sp, #0x5f]
  7db1d0: 12001c00     	and	w0, w0, #0xff
  7db1d4: 390163e0     	strb	w0, [sp, #0x58]
  7db1d8: 39417be0     	ldrb	w0, [sp, #0x5e]
  7db1dc: 12001c00     	and	w0, w0, #0xff
  7db1e0: 390167e0     	strb	w0, [sp, #0x59]
  7db1e4: 394177e0     	ldrb	w0, [sp, #0x5d]
  7db1e8: 12001c00     	and	w0, w0, #0xff
  7db1ec: 39016be0     	strb	w0, [sp, #0x5a]
  7db1f0: 394173e0     	ldrb	w0, [sp, #0x5c]
  7db1f4: 12001c00     	and	w0, w0, #0xff
  7db1f8: 39016fe0     	strb	w0, [sp, #0x5b]
  7db1fc: b9405be0     	ldr	w0, [sp, #0x58]
  7db200: b8227a80     	str	w0, [x20, x2, lsl #2]
  7db204: 91000442     	add	x2, x2, #0x1
  7db208: 29409660     	ldp	w0, w5, [x19, #0x4]
  7db20c: 3942c2a3     	ldrb	w3, [x21, #0xb0]
  7db210: 1ac008a1     	udiv	w1, w5, w0
  7db214: 6b02003f     	cmp	w1, w2
  7db218: 54fff10d     	b.le	0x7db038
  7db21c: 2a0303e1     	mov	w1, w3
  7db220: b8627a84     	ldr	w4, [x20, x2, lsl #2]
  7db224: b9005be4     	str	w4, [sp, #0x58]
  7db228: 35fffd01     	cbnz	w1, 0x7db1c8
  7db22c: 1ac008a1     	udiv	w1, w5, w0
  7db230: 91000442     	add	x2, x2, #0x1
  7db234: 6b02003f     	cmp	w1, w2
  7db238: 54fff00d     	b.le	0x7db038
  7db23c: 2a0303e1     	mov	w1, w3
  7db240: 17fffff8     	b	0x7db220
  7db244: aa0103f3     	mov	x19, x1
  7db248: 17ffff63     	b	0x7dafd4
  7db24c: 52800000     	mov	w0, #0x0                // =0
  7db250: 17ffffa6     	b	0x7db0e8
  7db254: d503201f     	nop
  7db258: b94d3408     	ldr	w8, [x0, #0xd34]
  7db25c: 9102d007     	add	x7, x0, #0xb4
  7db260: 34000468     	cbz	w8, 0x7db2ec
  7db264: 51000506     	sub	w6, w8, #0x1
  7db268: d37c7cc0     	ubfiz	x0, x6, #4, #32
  7db26c: 8b0000e5     	add	x5, x7, x0
  7db270: b86068e0     	ldr	w0, [x7, x0]
  7db274: 6b00003f     	cmp	w1, w0
  7db278: 54000180     	b.eq	0x7db2a8
  7db27c: 34000386     	cbz	w6, 0x7db2ec
  7db280: 51000905     	sub	w5, w8, #0x2
  7db284: 14000003     	b	0x7db290
  7db288: 34000185     	cbz	w5, 0x7db2b8
  7db28c: 51000405     	sub	w5, w0, #0x1
  7db290: d37ceca6     	lsl	x6, x5, #4
  7db294: aa0503e0     	mov	x0, x5
  7db298: b86668e6     	ldr	w6, [x7, x6]
