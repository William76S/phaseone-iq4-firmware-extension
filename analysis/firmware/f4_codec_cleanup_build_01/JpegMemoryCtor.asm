
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a5250: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  9a5254: 910003fd     	mov	x29, sp
  9a5258: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a525c: aa0003f4     	mov	x20, x0
  9a5260: f900041f     	str	xzr, [x0, #0x8]
  9a5264: 94000b39     	bl	0x9a7f48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30ea8>
  9a5268: f90017e0     	str	x0, [sp, #0x28]
  9a526c: d2801501     	mov	x1, #0xa8               // =168
  9a5270: aa1403e0     	mov	x0, x20
  9a5274: 94000b1f     	bl	0x9a7ef0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30e50>
  9a5278: aa0003f3     	mov	x19, x0
  9a527c: b4000880     	cbz	x0, 0x9a538c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e2ec>
  9a5280: d299400c     	mov	x12, #0xca00            // =51712
  9a5284: d0ffffea     	adrp	x10, 0x9a3000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf60>
  9a5288: f94017ed     	ldr	x13, [sp, #0x28]
  9a528c: f0ffffe0     	adrp	x0, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a5290: 9136c14a     	add	x10, x10, #0xdb0
  9a5294: 9109e000     	add	x0, x0, #0x278
  9a5298: f0ffffe9     	adrp	x9, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a529c: f0ffffe8     	adrp	x8, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52a0: 9135c129     	add	x9, x9, #0xd70
  9a52a4: 912d4108     	add	x8, x8, #0xb50
  9a52a8: f0ffffe7     	adrp	x7, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52ac: d0ffffe6     	adrp	x6, 0x9a3000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2bf60>
  9a52b0: 910100e7     	add	x7, x7, #0x40
  9a52b4: 913ea0c6     	add	x6, x6, #0xfa8
  9a52b8: f0ffffe5     	adrp	x5, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52bc: f0ffffe4     	adrp	x4, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52c0: 913ee0a5     	add	x5, x5, #0xfb8
  9a52c4: 910f4084     	add	x4, x4, #0x3d0
  9a52c8: f0ffffe3     	adrp	x3, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52cc: f0ffffe2     	adrp	x2, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52d0: 911e2063     	add	x3, x3, #0x788
  9a52d4: 91036042     	add	x2, x2, #0xd8
  9a52d8: f0ffffe1     	adrp	x1, 0x9a4000 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cf60>
  9a52dc: f2a7734c     	movk	x12, #0x3b9a, lsl #16
  9a52e0: 9108c021     	add	x1, x1, #0x230
  9a52e4: d280150b     	mov	x11, #0xa8              // =168
  9a52e8: a900026a     	stp	x10, x0, [x19]
  9a52ec: b0002160     	adrp	x0, 0xdd2000
  9a52f0: 9118e000     	add	x0, x0, #0x638
  9a52f4: a9012269     	stp	x9, x8, [x19, #0x10]
  9a52f8: a9021a67     	stp	x7, x6, [x19, #0x20]
  9a52fc: a9031265     	stp	x5, x4, [x19, #0x30]
  9a5300: a9040a63     	stp	x3, x2, [x19, #0x40]
  9a5304: a9053661     	stp	x1, x13, [x19, #0x50]
  9a5308: a9067e6c     	stp	x12, xzr, [x19, #0x60]
  9a530c: a9077e7f     	stp	xzr, xzr, [x19, #0x70]
  9a5310: a9087e7f     	stp	xzr, xzr, [x19, #0x80]
  9a5314: a9092e7f     	stp	xzr, x11, [x19, #0x90]
  9a5318: f9000693     	str	x19, [x20, #0x8]
  9a531c: 97e99665     	bl	0x40acb0 <getenv@plt>
  9a5320: b4000300     	cbz	x0, 0x9a5380 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e2e0>
  9a5324: 52800f04     	mov	w4, #0x78               // =120
  9a5328: b0002161     	adrp	x1, 0xdd2000
  9a532c: 91009fe3     	add	x3, sp, #0x27
  9a5330: 91190021     	add	x1, x1, #0x640
  9a5334: 9100a3e2     	add	x2, sp, #0x28
  9a5338: 39009fe4     	strb	w4, [sp, #0x27]
  9a533c: 97e99595     	bl	0x40a990 <__isoc99_sscanf@plt>
  9a5340: 7100001f     	cmp	w0, #0x0
  9a5344: 540001ed     	b.le	0x9a5380 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e2e0>
  9a5348: f94017e2     	ldr	x2, [sp, #0x28]
  9a534c: 39409fe1     	ldrb	w1, [sp, #0x27]
  9a5350: d37be840     	lsl	x0, x2, #5
  9a5354: 121a7821     	and	w1, w1, #0xffffffdf
  9a5358: cb020000     	sub	x0, x0, x2
  9a535c: 12001c21     	and	w1, w1, #0xff
  9a5360: 7101343f     	cmp	w1, #0x4d
  9a5364: 8b000840     	add	x0, x2, x0, lsl #2
  9a5368: d37df000     	lsl	x0, x0, #3
  9a536c: 54000081     	b.ne	0x9a537c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e2dc>
  9a5370: d2884800     	mov	x0, #0x4240             // =16960
  9a5374: f2a001e0     	movk	x0, #0xf, lsl #16
  9a5378: 9b007c40     	mul	x0, x2, x0
  9a537c: f9002e60     	str	x0, [x19, #0x58]
  9a5380: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a5384: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  9a5388: d65f03c0     	ret
  9a538c: aa1403e0     	mov	x0, x20
  9a5390: 94000af0     	bl	0x9a7f50 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30eb0>
  9a5394: f9400281     	ldr	x1, [x20]
  9a5398: b0002162     	adrp	x2, 0xdd2000
  9a539c: aa1403e0     	mov	x0, x20
  9a53a0: fd431840     	ldr	d0, [x2, #0x630]
  9a53a4: f9400022     	ldr	x2, [x1]
  9a53a8: fd001420     	str	d0, [x1, #0x28]
  9a53ac: d63f0040     	blr	x2
  9a53b0: 17ffffb4     	b	0x9a5280 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2e1e0>
