  7da788: a9b17bfd     	stp	x29, x30, [sp, #-0xf0]!
  7da78c: 910003fd     	mov	x29, sp
  7da790: a90153f3     	stp	x19, x20, [sp, #0x10]
  7da794: aa0003f3     	mov	x19, x0
  7da798: aa0103f4     	mov	x20, x1
  7da79c: aa0103e0     	mov	x0, x1
  7da7a0: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7da7a4: 2a0203f6     	mov	w22, w2
  7da7a8: f9400021     	ldr	x1, [x1]
  7da7ac: f9402c21     	ldr	x1, [x1, #0x58]
  7da7b0: d63f0020     	blr	x1
  7da7b4: b90d3e60     	str	w0, [x19, #0xd3c]
  7da7b8: b94d3a61     	ldr	w1, [x19, #0xd38]
  7da7bc: 52800002     	mov	w2, #0x0                // =0
  7da7c0: f9400283     	ldr	x3, [x20]
  7da7c4: aa1403e0     	mov	x0, x20
  7da7c8: f9402463     	ldr	x3, [x3, #0x48]
  7da7cc: d63f0060     	blr	x3
  7da7d0: b90d427f     	str	wzr, [x19, #0xd40]
  7da7d4: 91029261     	add	x1, x19, #0xa4
  7da7d8: 52800182     	mov	w2, #0xc                // =12
  7da7dc: f9400283     	ldr	x3, [x20]
  7da7e0: aa1403e0     	mov	x0, x20
  7da7e4: f9400c63     	ldr	x3, [x3, #0x18]
  7da7e8: d63f0060     	blr	x3
  7da7ec: b940a660     	ldr	w0, [x19, #0xa4]
  7da7f0: 5289a9a1     	mov	w1, #0x4d4d             // =19789
  7da7f4: 72a9a9a1     	movk	w1, #0x4d4d, lsl #16
  7da7f8: 52892922     	mov	w2, #0x4949             // =18761
  7da7fc: 6b01001f     	cmp	w0, w1
  7da800: 72a92922     	movk	w2, #0x4949, lsl #16
  7da804: 1a9f07f5     	cset	w21, ne
  7da808: 6b02001f     	cmp	w0, w2
  7da80c: 1a9f12b5     	csel	w21, w21, wzr, ne
  7da810: 350018d5     	cbnz	w21, 0x7dab28
  7da814: 6b01001f     	cmp	w0, w1
  7da818: b940aa62     	ldr	w2, [x19, #0xa8]
  7da81c: 1a9f17e3     	cset	w3, eq
  7da820: b9004fe2     	str	w2, [sp, #0x4c]
  7da824: 3902c263     	strb	w3, [x19, #0xb0]
  7da828: 540015e1     	b.ne	0x7daae4
  7da82c: b90053e2     	str	w2, [sp, #0x50]
  7da830: 528ee901     	mov	w1, #0x7748             // =30536
  7da834: 72aa4c21     	movk	w1, #0x5261, lsl #16
  7da838: 39414fe0     	ldrb	w0, [sp, #0x53]
  7da83c: 12001c00     	and	w0, w0, #0xff
  7da840: 390133e0     	strb	w0, [sp, #0x4c]
  7da844: 39414be0     	ldrb	w0, [sp, #0x52]
  7da848: 12001c00     	and	w0, w0, #0xff
  7da84c: 390137e0     	strb	w0, [sp, #0x4d]
  7da850: 394147e0     	ldrb	w0, [sp, #0x51]
  7da854: 12001c00     	and	w0, w0, #0xff
  7da858: 39013be0     	strb	w0, [sp, #0x4e]
  7da85c: 394143e0     	ldrb	w0, [sp, #0x50]
  7da860: 12001c00     	and	w0, w0, #0xff
  7da864: 39013fe0     	strb	w0, [sp, #0x4f]
  7da868: b9404fe0     	ldr	w0, [sp, #0x4c]
  7da86c: 6b01001f     	cmp	w0, w1
  7da870: 540017c0     	b.eq	0x7dab68
  7da874: 39414fe0     	ldrb	w0, [sp, #0x53]
  7da878: 528eea81     	mov	w1, #0x7754             // =30548
  7da87c: 72aa4c21     	movk	w1, #0x5261, lsl #16
  7da880: 12001c00     	and	w0, w0, #0xff
  7da884: 390133e0     	strb	w0, [sp, #0x4c]
  7da888: 39414be0     	ldrb	w0, [sp, #0x52]
  7da88c: 12001c00     	and	w0, w0, #0xff
  7da890: 390137e0     	strb	w0, [sp, #0x4d]
  7da894: 394147e0     	ldrb	w0, [sp, #0x51]
  7da898: 12001c00     	and	w0, w0, #0xff
  7da89c: 39013be0     	strb	w0, [sp, #0x4e]
  7da8a0: 394143e0     	ldrb	w0, [sp, #0x50]
  7da8a4: 12001c00     	and	w0, w0, #0xff
  7da8a8: 39013fe0     	strb	w0, [sp, #0x4f]
  7da8ac: b9404fe0     	ldr	w0, [sp, #0x4c]
  7da8b0: 6b01001f     	cmp	w0, w1
  7da8b4: 54000460     	b.eq	0x7da940
  7da8b8: 39414fe0     	ldrb	w0, [sp, #0x53]
  7da8bc: 528ee841     	mov	w1, #0x7742             // =30530
  7da8c0: 72aa4c21     	movk	w1, #0x5261, lsl #16
  7da8c4: 12001c00     	and	w0, w0, #0xff
  7da8c8: 390133e0     	strb	w0, [sp, #0x4c]
  7da8cc: 39414be0     	ldrb	w0, [sp, #0x52]
  7da8d0: 12001c00     	and	w0, w0, #0xff
  7da8d4: 390137e0     	strb	w0, [sp, #0x4d]
  7da8d8: 394147e0     	ldrb	w0, [sp, #0x51]
  7da8dc: 12001c00     	and	w0, w0, #0xff
  7da8e0: 39013be0     	strb	w0, [sp, #0x4e]
  7da8e4: 394143e0     	ldrb	w0, [sp, #0x50]
  7da8e8: 12001c00     	and	w0, w0, #0xff
  7da8ec: 39013fe0     	strb	w0, [sp, #0x4f]
  7da8f0: b9404fe0     	ldr	w0, [sp, #0x4c]
  7da8f4: 6b01001f     	cmp	w0, w1
  7da8f8: 54000240     	b.eq	0x7da940
  7da8fc: 39414fe0     	ldrb	w0, [sp, #0x53]
  7da900: 528ee861     	mov	w1, #0x7743             // =30531
  7da904: 72aa4c21     	movk	w1, #0x5261, lsl #16
  7da908: 12001c00     	and	w0, w0, #0xff
  7da90c: 390133e0     	strb	w0, [sp, #0x4c]
  7da910: 39414be0     	ldrb	w0, [sp, #0x52]
  7da914: 12001c00     	and	w0, w0, #0xff
  7da918: 390137e0     	strb	w0, [sp, #0x4d]
  7da91c: 394147e0     	ldrb	w0, [sp, #0x51]
  7da920: 12001c00     	and	w0, w0, #0xff
  7da924: 39013be0     	strb	w0, [sp, #0x4e]
  7da928: 394143e0     	ldrb	w0, [sp, #0x50]
  7da92c: 12001c00     	and	w0, w0, #0xff
  7da930: 39013fe0     	strb	w0, [sp, #0x4f]
  7da934: b9404fe0     	ldr	w0, [sp, #0x4c]
  7da938: 6b01001f     	cmp	w0, w1
  7da93c: 54000f61     	b.ne	0x7dab28
  7da940: b940ae60     	ldr	w0, [x19, #0xac]
  7da944: b90053e0     	str	w0, [sp, #0x50]
  7da948: 39414fe0     	ldrb	w0, [sp, #0x53]
  7da94c: 12001c00     	and	w0, w0, #0xff
  7da950: 390133e0     	strb	w0, [sp, #0x4c]
  7da954: 39414be0     	ldrb	w0, [sp, #0x52]
  7da958: 12001c00     	and	w0, w0, #0xff
  7da95c: 390137e0     	strb	w0, [sp, #0x4d]
  7da960: 394147e0     	ldrb	w0, [sp, #0x51]
  7da964: 12001c00     	and	w0, w0, #0xff
  7da968: 39013be0     	strb	w0, [sp, #0x4e]
  7da96c: 394143e0     	ldrb	w0, [sp, #0x50]
  7da970: 12001c00     	and	w0, w0, #0xff
  7da974: 39013fe0     	strb	w0, [sp, #0x4f]
  7da978: b9404fe1     	ldr	w1, [sp, #0x4c]
  7da97c: b94d3a60     	ldr	w0, [x19, #0xd38]
  7da980: 710002df     	cmp	w22, #0x0
  7da984: b94d3e62     	ldr	w2, [x19, #0xd3c]
  7da988: 0b010001     	add	w1, w0, w1
  7da98c: 0b160000     	add	w0, w0, w22
  7da990: 1a811001     	csel	w1, w0, w1, ne
  7da994: 6b02003f     	cmp	w1, w2
  7da998: 54000c88     	b.hi	0x7dab28
  7da99c: f9400283     	ldr	x3, [x20]
  7da9a0: 52800002     	mov	w2, #0x0                // =0
  7da9a4: aa1403e0     	mov	x0, x20
  7da9a8: f9402463     	ldr	x3, [x3, #0x48]
  7da9ac: f9001bf7     	str	x23, [sp, #0x30]
  7da9b0: d63f0060     	blr	x3
  7da9b4: f9400283     	ldr	x3, [x20]
  7da9b8: 52800102     	mov	w2, #0x8                // =8
  7da9bc: 910143e1     	add	x1, sp, #0x50
  7da9c0: aa1403e0     	mov	x0, x20
  7da9c4: f9400c63     	ldr	x3, [x3, #0x18]
  7da9c8: d63f0060     	blr	x3
  7da9cc: b94053f7     	ldr	w23, [sp, #0x50]
  7da9d0: 3942c260     	ldrb	w0, [x19, #0xb0]
  7da9d4: b9004bf7     	str	w23, [sp, #0x48]
  7da9d8: 340001e0     	cbz	w0, 0x7daa14
  7da9dc: b9004ff7     	str	w23, [sp, #0x4c]
  7da9e0: 39413fe0     	ldrb	w0, [sp, #0x4f]
  7da9e4: 12001c00     	and	w0, w0, #0xff
  7da9e8: 390123e0     	strb	w0, [sp, #0x48]
  7da9ec: 39413be0     	ldrb	w0, [sp, #0x4e]
  7da9f0: 12001c00     	and	w0, w0, #0xff
  7da9f4: 390127e0     	strb	w0, [sp, #0x49]
  7da9f8: 394137e0     	ldrb	w0, [sp, #0x4d]
  7da9fc: 12001c00     	and	w0, w0, #0xff
  7daa00: 39012be0     	strb	w0, [sp, #0x4a]
  7daa04: 394133e0     	ldrb	w0, [sp, #0x4c]
  7daa08: 12001c00     	and	w0, w0, #0xff
  7daa0c: 39012fe0     	strb	w0, [sp, #0x4b]
  7daa10: b9404bf7     	ldr	w23, [sp, #0x48]
  7daa14: 710322ff     	cmp	w23, #0xc8
  7daa18: 54000948     	b.hi	0x7dab40
  7daa1c: 34000d57     	cbz	w23, 0x7dabc4
  7daa20: 531c6ee2     	lsl	w2, w23, #4
  7daa24: b94d3e60     	ldr	w0, [x19, #0xd3c]
  7daa28: 6b02001f     	cmp	w0, w2
  7daa2c: 54000cc3     	b.lo	0x7dabc4
  7daa30: b90d427f     	str	wzr, [x19, #0xd40]
  7daa34: 9102d261     	add	x1, x19, #0xb4
  7daa38: b90d367f     	str	wzr, [x19, #0xd34]
  7daa3c: aa0103f6     	mov	x22, x1
  7daa40: f9400283     	ldr	x3, [x20]
  7daa44: 8b375037     	add	x23, x1, w23, uxtw #4
  7daa48: aa1403e0     	mov	x0, x20
  7daa4c: f9400c63     	ldr	x3, [x3, #0x18]
  7daa50: d63f0060     	blr	x3
  7daa54: d503201f     	nop
  7daa58: aa1603e1     	mov	x1, x22
  7daa5c: 52800022     	mov	w2, #0x1                // =1
  7daa60: aa1303e0     	mov	x0, x19
  7daa64: 910042d6     	add	x22, x22, #0x10
  7daa68: 97fffc52     	bl	0x7d9bb0
  7daa6c: 72001c00     	ands	w0, w0, #0xff
  7daa70: 54000aa0     	b.eq	0x7dabc4
  7daa74: eb1602ff     	cmp	x23, x22
  7daa78: 54ffff01     	b.ne	0x7daa58
  7daa7c: 3942c262     	ldrb	w2, [x19, #0xb0]
  7daa80: b94057e1     	ldr	w1, [sp, #0x54]
  7daa84: b9004be1     	str	w1, [sp, #0x48]
  7daa88: 340001e2     	cbz	w2, 0x7daac4
  7daa8c: b9004fe1     	str	w1, [sp, #0x4c]
  7daa90: 39413fe1     	ldrb	w1, [sp, #0x4f]
  7daa94: 12001c21     	and	w1, w1, #0xff
  7daa98: 390123e1     	strb	w1, [sp, #0x48]
  7daa9c: 39413be1     	ldrb	w1, [sp, #0x4e]
  7daaa0: 12001c21     	and	w1, w1, #0xff
  7daaa4: 390127e1     	strb	w1, [sp, #0x49]
  7daaa8: 394137e1     	ldrb	w1, [sp, #0x4d]
  7daaac: 12001c21     	and	w1, w1, #0xff
  7daab0: 39012be1     	strb	w1, [sp, #0x4a]
  7daab4: 394133e1     	ldrb	w1, [sp, #0x4c]
  7daab8: 12001c21     	and	w1, w1, #0xff
  7daabc: 39012fe1     	strb	w1, [sp, #0x4b]
  7daac0: b9404be1     	ldr	w1, [sp, #0x48]
  7daac4: b94d3a62     	ldr	w2, [x19, #0xd38]
  7daac8: b94d3e63     	ldr	w3, [x19, #0xd3c]
  7daacc: 0b020022     	add	w2, w1, w2
  7daad0: b90d4261     	str	w1, [x19, #0xd40]
  7daad4: 6b03005f     	cmp	w2, w3
  7daad8: 1a8083f5     	csel	w21, wzr, w0, hi
  7daadc: f9401bf7     	ldr	x23, [sp, #0x30]
  7daae0: 14000013     	b	0x7dab2c
  7daae4: 528ee900     	mov	w0, #0x7748             // =30536
  7daae8: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7daaec: 6b00005f     	cmp	w2, w0
  7daaf0: 540003c0     	b.eq	0x7dab68
  7daaf4: 528eea80     	mov	w0, #0x7754             // =30548
  7daaf8: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7daafc: 6b00005f     	cmp	w2, w0
  7dab00: 540005e0     	b.eq	0x7dabbc
  7dab04: 528ee840     	mov	w0, #0x7742             // =30530
  7dab08: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7dab0c: 6b00005f     	cmp	w2, w0
  7dab10: 54000560     	b.eq	0x7dabbc
  7dab14: 528ee860     	mov	w0, #0x7743             // =30531
  7dab18: 72aa4c20     	movk	w0, #0x5261, lsl #16
  7dab1c: 6b00005f     	cmp	w2, w0
  7dab20: 540004e0     	b.eq	0x7dabbc
  7dab24: d503201f     	nop
  7dab28: 52800015     	mov	w21, #0x0               // =0
  7dab2c: 2a1503e0     	mov	w0, w21
  7dab30: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7dab34: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7dab38: a8cf7bfd     	ldp	x29, x30, [sp], #0xf0
  7dab3c: d65f03c0     	ret
  7dab40: 52801482     	mov	w2, #0xa4               // =164
  7dab44: 90002d63     	adrp	x3, 0xd86000
  7dab48: 90002d61     	adrp	x1, 0xd86000
  7dab4c: 91248063     	add	x3, x3, #0x920
  7dab50: 91252021     	add	x1, x1, #0x948
  7dab54: 52800080     	mov	w0, #0x4                // =4
  7dab58: 97fdae7d     	bl	0x74654c
  7dab5c: 52801917     	mov	w23, #0xc8              // =200
  7dab60: 52819002     	mov	w2, #0xc80              // =3200
  7dab64: 17ffffb0     	b	0x7daa24
  7dab68: f9400283     	ldr	x3, [x20]
  7dab6c: 52800002     	mov	w2, #0x0                // =0
  7dab70: b94d3a61     	ldr	w1, [x19, #0xd38]
  7dab74: aa1403e0     	mov	x0, x20
  7dab78: 52800035     	mov	w21, #0x1               // =1
  7dab7c: f9402463     	ldr	x3, [x3, #0x48]
  7dab80: d63f0060     	blr	x3
  7dab84: f9400283     	ldr	x3, [x20]
  7dab88: 52801382     	mov	w2, #0x9c               // =156
  7dab8c: 910143e1     	add	x1, sp, #0x50
  7dab90: aa1403e0     	mov	x0, x20
  7dab94: f9400c63     	ldr	x3, [x3, #0x18]
  7dab98: d63f0060     	blr	x3
  7dab9c: 910143e1     	add	x1, sp, #0x50
  7daba0: aa1303e0     	mov	x0, x19
  7daba4: 97fffc7b     	bl	0x7d9d90
  7daba8: 2a1503e0     	mov	w0, w21
  7dabac: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7dabb0: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7dabb4: a8cf7bfd     	ldp	x29, x30, [sp], #0xf0
  7dabb8: d65f03c0     	ret
  7dabbc: b940ae61     	ldr	w1, [x19, #0xac]
  7dabc0: 17ffff6f     	b	0x7da97c
