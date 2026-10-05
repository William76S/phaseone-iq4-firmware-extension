INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a2148: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  9a214c: 7101483f     	cmp	w1, #0x52
  9a2150: 910003fd     	mov	x29, sp
  9a2154: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a2158: aa0003f3     	mov	x19, x0
  9a215c: f9400014     	ldr	x20, [x0]
  9a2160: f90013f5     	str	x21, [sp, #0x20]
  9a2164: f900041f     	str	xzr, [x0, #0x8]
  9a2168: aa0203f5     	mov	x21, x2
  9a216c: 54000100     	b.eq	0x9a218c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b0ec>
  9a2170: b9003281     	str	w1, [x20, #0x30]
  9a2174: 90002181     	adrp	x1, 0xdd2000
  9a2178: f9400282     	ldr	x2, [x20]
  9a217c: fd408c20     	ldr	d0, [x1, #0x118]
  9a2180: fd001680     	str	d0, [x20, #0x28]
  9a2184: d63f0040     	blr	x2
  9a2188: f9400274     	ldr	x20, [x19]
  9a218c: f10922bf     	cmp	x21, #0x248
  9a2190: 54000120     	b.eq	0x9a21b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b114>
  9a2194: 90002180     	adrp	x0, 0xdd2000
  9a2198: b9003295     	str	w21, [x20, #0x30]
  9a219c: f9400281     	ldr	x1, [x20]
  9a21a0: fd409000     	ldr	d0, [x0, #0x120]
  9a21a4: aa1303e0     	mov	x0, x19
  9a21a8: fd001680     	str	d0, [x20, #0x28]
  9a21ac: d63f0020     	blr	x1
  9a21b0: f9400274     	ldr	x20, [x19]
  9a21b4: d2804902     	mov	x2, #0x248              // =584
  9a21b8: f9400e75     	ldr	x21, [x19, #0x18]
  9a21bc: 52800001     	mov	w1, #0x0                // =0
  9a21c0: aa1303e0     	mov	x0, x19
  9a21c4: 97e99ff7     	bl	0x40a1a0 <memset@plt>
  9a21c8: f9000274     	str	x20, [x19]
  9a21cc: aa1303e0     	mov	x0, x19
  9a21d0: f9000e75     	str	x21, [x19, #0x18]
  9a21d4: 94000c1f     	bl	0x9a5250 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e1b0>
  9a21d8: 4f000400     	movi	v0.4s, #0x0
  9a21dc: 52800102     	mov	w2, #0x8                // =8
  9a21e0: 4f030481     	movi	v1.4s, #0x64
  9a21e4: 528007e1     	mov	w1, #0x3f               // =63
  9a21e8: 1e6e1002     	fmov	d2, #1.00000000
  9a21ec: 52800c83     	mov	w3, #0x64               // =100
  9a21f0: 90002180     	adrp	x0, 0xdd2000
  9a21f4: 91194000     	add	x0, x0, #0x650
  9a21f8: 3c868260     	stur	q0, [x19, #0x68]
  9a21fc: 3c878260     	stur	q0, [x19, #0x78]
  9a2200: f94013f5     	ldr	x21, [sp, #0x20]
  9a2204: f9000a7f     	str	xzr, [x19, #0x10]
  9a2208: b9002663     	str	w3, [x19, #0x24]
  9a220c: f900167f     	str	xzr, [x19, #0x28]
  9a2210: f900467f     	str	xzr, [x19, #0x88]
  9a2214: b901de62     	str	w2, [x19, #0x1dc]
  9a2218: f900f260     	str	x0, [x19, #0x1e0]
  9a221c: b901ea61     	str	w1, [x19, #0x1e8]
  9a2220: f9011e7f     	str	xzr, [x19, #0x238]
  9a2224: fd002262     	str	d2, [x19, #0x40]
  9a2228: 3d802661     	str	q1, [x19, #0x90]
  9a222c: 3d802a60     	str	q0, [x19, #0xa0]
  9a2230: 3d802e60     	str	q0, [x19, #0xb0]
  9a2234: 3d803260     	str	q0, [x19, #0xc0]
  9a2238: 3d803660     	str	q0, [x19, #0xd0]
  9a223c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a2240: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  9a2244: d65f03c0     	ret
