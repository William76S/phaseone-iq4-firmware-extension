  9227b0: d10503ff     	sub	sp, sp, #0x140
  9227b4: a9057bfd     	stp	x29, x30, [sp, #0x50]
  9227b8: 910143fd     	add	x29, sp, #0x50
  9227bc: 6d0b27e8     	stp	d8, d9, [sp, #0xb0]
  9227c0: 9e670108     	fmov	d8, x8
  9227c4: 9e670029     	fmov	d9, x1
  9227c8: 6d0c2fea     	stp	d10, d11, [sp, #0xc0]
  9227cc: 9e67000a     	fmov	d10, x0
  9227d0: 6d0d37ec     	stp	d12, d13, [sp, #0xd0]
  9227d4: 9e67006c     	fmov	d12, x3
  9227d8: 9e67008d     	fmov	d13, x4
  9227dc: a90653f3     	stp	x19, x20, [sp, #0x60]
  9227e0: b94173f4     	ldr	w20, [sp, #0x170]
  9227e4: b9417bf3     	ldr	w19, [sp, #0x178]
  9227e8: a9075bf5     	stp	x21, x22, [sp, #0x70]
  9227ec: b9416bf5     	ldr	w21, [sp, #0x168]
  9227f0: a90863f7     	stp	x23, x24, [sp, #0x80]
  9227f4: 2a0603f7     	mov	w23, w6
  9227f8: 2a0703f8     	mov	w24, w7
  9227fc: a9096bf9     	stp	x25, x26, [sp, #0x90]
  922800: b94163f9     	ldr	w25, [sp, #0x160]
  922804: a90a73fb     	stp	x27, x28, [sp, #0xa0]
  922808: 2a0503fc     	mov	w28, w5
  92280c: f9007be2     	str	x2, [sp, #0xf0]
  922810: f940c7f6     	ldr	x22, [sp, #0x188]
  922814: 97eba037     	bl	0x40a8f0
  922818: b94143e6     	ldr	w6, [sp, #0x140]
  92281c: 9e660100     	fmov	x0, d8
  922820: b9414be7     	ldr	w7, [sp, #0x148]
  922824: 52800208     	mov	w8, #0x10               // =16
  922828: b94153e4     	ldr	w4, [sp, #0x150]
  92282c: 52800029     	mov	w9, #0x1                // =1
  922830: b9415be5     	ldr	w5, [sp, #0x158]
  922834: 2a1803e3     	mov	w3, w24
  922838: f9407be1     	ldr	x1, [sp, #0xf0]
  92283c: b90003f9     	str	w25, [sp]
  922840: b9000bf5     	str	w21, [sp, #0x8]
  922844: 2a1703e2     	mov	w2, w23
  922848: b90013f4     	str	w20, [sp, #0x10]
  92284c: b9001bf3     	str	w19, [sp, #0x18]
  922850: b90023e8     	str	w8, [sp, #0x20]
  922854: b9002be9     	str	w9, [sp, #0x28]
  922858: 3900c3ff     	strb	wzr, [sp, #0x30]
  92285c: 3900e3ff     	strb	wzr, [sp, #0x38]
  922860: b90043ff     	str	wzr, [sp, #0x40]
  922864: b9004be8     	str	w8, [sp, #0x48]
  922868: 97fffe42     	bl	0x922170
  92286c: 9e660101     	fmov	x1, d8
  922870: 9e660120     	fmov	x0, d9
  922874: 940067db     	bl	0x93c7e0
  922878: 9e660100     	fmov	x0, d8
  92287c: 97ffff0d     	bl	0x9224b0
  922880: 9e67000b     	fmov	d11, x0
  922884: 9e660100     	fmov	x0, d8
  922888: 97ffff12     	bl	0x9224d0
  92288c: b900f3e0     	str	w0, [sp, #0xf0]
  922890: 9e660100     	fmov	x0, d8
  922894: 97ffff0d     	bl	0x9224c8
  922898: 2a0003fa     	mov	w26, w0
  92289c: 9e660100     	fmov	x0, d8
  9228a0: 97ffff28     	bl	0x922540
  9228a4: 2a0003fb     	mov	w27, w0
  9228a8: 97eba012     	bl	0x40a8f0
  9228ac: a9404ec0     	ldp	x0, x19, [x22]
  9228b0: cb000273     	sub	x19, x19, x0
  9228b4: 9342fe73     	asr	x19, x19, #2
  9228b8: b9010bf3     	str	w19, [sp, #0x108]
  9228bc: 34000c13     	cbz	w19, 0x922a3c
  9228c0: 9e660140     	fmov	x0, d10
  9228c4: 97f7d0d6     	bl	0x716c1c
  9228c8: 2a0003f4     	mov	w20, w0
  9228cc: aa1403f9     	mov	x25, x20
  9228d0: b4000b34     	cbz	x20, 0x922a34
  9228d4: 52800b00     	mov	w0, #0x58               // =88
  9228d8: 9ba07e80     	umull	x0, w20, w0
  9228dc: 97eb9d61     	bl	0x409e60
  9228e0: 4f000400     	movi	v0.4s, #0x0
  9228e4: aa1403e1     	mov	x1, x20
  9228e8: fd0073ee     	str	d14, [sp, #0xe0]
  9228ec: 9e67000e     	fmov	d14, x0
  9228f0: a9007c1f     	stp	xzr, xzr, [x0]
  9228f4: f1000421     	subs	x1, x1, #0x1
  9228f8: a9017c1f     	stp	xzr, xzr, [x0, #0x10]
  9228fc: 91016000     	add	x0, x0, #0x58
  922900: f81c801f     	stur	xzr, [x0, #-0x38]
  922904: b81f001f     	stur	wzr, [x0, #-0x10]
  922908: f81f801f     	stur	xzr, [x0, #-0x8]
  92290c: 3c9d0000     	stur	q0, [x0, #-0x30]
  922910: 3c9e0000     	stur	q0, [x0, #-0x20]
  922914: 54fffee1     	b.ne	0x9228f0
  922918: 92407e60     	and	x0, x19, #0xffffffff
  92291c: d1000400     	sub	x0, x0, #0x1
  922920: 8b140000     	add	x0, x0, x20
  922924: 9ad40814     	udiv	x20, x0, x20
  922928: b9010ff4     	str	w20, [sp, #0x10c]
  92292c: 34000779     	cbz	w25, 0x922a18
  922930: 92407e82     	and	x2, x20, #0xffffffff
  922934: 9e6601d3     	fmov	x19, d14
  922938: 90000001     	adrp	x1, 0x922000
  92293c: 911ea021     	add	x1, x1, #0x7a8
  922940: 90000000     	adrp	x0, 0x922000
  922944: 52800015     	mov	w21, #0x0               // =0
  922948: 91170000     	add	x0, x0, #0x5c0
  92294c: 52800014     	mov	w20, #0x0               // =0
  922950: a90f87e0     	stp	x0, x1, [sp, #0xf8]
  922954: d37ef441     	lsl	x1, x2, #2
  922958: f9008be2     	str	x2, [sp, #0x110]
  92295c: f9008fe1     	str	x1, [sp, #0x118]
  922960: b9410be0     	ldr	w0, [sp, #0x108]
  922964: f94006c3     	ldr	x3, [x22, #0x8]
  922968: 6b15001f     	cmp	w0, w21
  92296c: 54000829     	b.ls	0x922a70
  922970: f94002c0     	ldr	x0, [x22]
  922974: f9408be2     	ldr	x2, [sp, #0x110]
  922978: 8b354800     	add	x0, x0, w21, uxtw #2
  92297c: f9000260     	str	x0, [x19]
  922980: cb000061     	sub	x1, x3, x0
  922984: eb81085f     	cmp	x2, x1, asr #2
  922988: 5400006a     	b.ge	0x922994
  92298c: f9408fe1     	ldr	x1, [sp, #0x118]
  922990: 8b010003     	add	x3, x0, x1
  922994: f9000663     	str	x3, [x19, #0x8]
  922998: 9e660140     	fmov	x0, d10
  92299c: b940f3e3     	ldr	w3, [sp, #0xf0]
  9229a0: 910483e2     	add	x2, sp, #0x120
  9229a4: f9407fe4     	ldr	x4, [sp, #0xf8]
  9229a8: b9002e63     	str	w3, [x19, #0x2c]
  9229ac: b94183e3     	ldr	w3, [sp, #0x180]
  9229b0: 2a1403e1     	mov	w1, w20
  9229b4: f9009be4     	str	x4, [sp, #0x130]
  9229b8: f94083e4     	ldr	x4, [sp, #0x100]
  9229bc: fd00126b     	str	d11, [x19, #0x20]
  9229c0: b9002a7c     	str	w28, [x19, #0x28]
  9229c4: 29066e7a     	stp	w26, w27, [x19, #0x30]
  9229c8: b9003a63     	str	w3, [x19, #0x38]
  9229cc: 2907de78     	stp	w24, w23, [x19, #0x3c]
  9229d0: 2908fe7f     	stp	wzr, wzr, [x19, #0x44]
  9229d4: fd002a69     	str	d9, [x19, #0x50]
  9229d8: 6d01366c     	stp	d12, d13, [x19, #0x10]
  9229dc: f90093f3     	str	x19, [sp, #0x120]
  9229e0: f9009fe4     	str	x4, [sp, #0x138]
  9229e4: 97f7d0b4     	bl	0x716cb4
  9229e8: f9409be3     	ldr	x3, [sp, #0x130]
  9229ec: 11000694     	add	w20, w20, #0x1
  9229f0: b4000443     	cbz	x3, 0x922a78
  9229f4: 910483e1     	add	x1, sp, #0x120
  9229f8: 52800062     	mov	w2, #0x3                // =3
  9229fc: aa0103e0     	mov	x0, x1
  922a00: d63f0060     	blr	x3
  922a04: b9410fe0     	ldr	w0, [sp, #0x10c]
  922a08: 91016273     	add	x19, x19, #0x58
  922a0c: 6b14033f     	cmp	w25, w20
  922a10: 0b0002b5     	add	w21, w21, w0
  922a14: 54fffa61     	b.ne	0x922960
  922a18: 9e660140     	fmov	x0, d10
  922a1c: 97f7d111     	bl	0x716e60
  922a20: 97eb9fb4     	bl	0x40a8f0
  922a24: 9e6601c0     	fmov	x0, d14
  922a28: 97eb9ee2     	bl	0x40a5b0
  922a2c: fd4073ee     	ldr	d14, [sp, #0xe0]
  922a30: 14000004     	b	0x922a40
  922a34: 9e660140     	fmov	x0, d10
  922a38: 97f7d10a     	bl	0x716e60
  922a3c: 97eb9fad     	bl	0x40a8f0
  922a40: 9e660100     	fmov	x0, d8
  922a44: a9457bfd     	ldp	x29, x30, [sp, #0x50]
  922a48: a94653f3     	ldp	x19, x20, [sp, #0x60]
  922a4c: a9475bf5     	ldp	x21, x22, [sp, #0x70]
  922a50: a94863f7     	ldp	x23, x24, [sp, #0x80]
  922a54: a9496bf9     	ldp	x25, x26, [sp, #0x90]
  922a58: a94a73fb     	ldp	x27, x28, [sp, #0xa0]
  922a5c: 6d4b27e8     	ldp	d8, d9, [sp, #0xb0]
  922a60: 6d4c2fea     	ldp	d10, d11, [sp, #0xc0]
  922a64: 6d4d37ec     	ldp	d12, d13, [sp, #0xd0]
  922a68: 910503ff     	add	sp, sp, #0x140
  922a6c: d65f03c0     	ret
  922a70: f9000263     	str	x3, [x19]
  922a74: 17ffffc8     	b	0x922994
  922a78: b9410fe0     	ldr	w0, [sp, #0x10c]
  922a7c: 6b14033f     	cmp	w25, w20
  922a80: 91016273     	add	x19, x19, #0x58
  922a84: 0b0002b5     	add	w21, w21, w0
  922a88: 54fff6c1     	b.ne	0x922960
  922a8c: 17ffffe3     	b	0x922a18
  922a90: aa0003f3     	mov	x19, x0
  922a94: fd0073ee     	str	d14, [sp, #0xe0]
  922a98: 9e660100     	fmov	x0, d8
  922a9c: 97fffdb1     	bl	0x922160
  922aa0: aa1303e0     	mov	x0, x19
  922aa4: 97eb9f2b     	bl	0x40a750
  922aa8: 17fffffa     	b	0x922a90
  922aac: f9409be3     	ldr	x3, [sp, #0x130]
  922ab0: aa0003f3     	mov	x19, x0
  922ab4: b40000a3     	cbz	x3, 0x922ac8
  922ab8: 910483e1     	add	x1, sp, #0x120
  922abc: 52800062     	mov	w2, #0x3                // =3
  922ac0: aa0103e0     	mov	x0, x1
  922ac4: d63f0060     	blr	x3
  922ac8: 9e6601c0     	fmov	x0, d14
  922acc: 97eb9eb9     	bl	0x40a5b0
  922ad0: 17fffff2     	b	0x922a98
  922ad4: aa0003f3     	mov	x19, x0
  922ad8: 17fffffc     	b	0x922ac8
  922adc: d503201f     	nop
