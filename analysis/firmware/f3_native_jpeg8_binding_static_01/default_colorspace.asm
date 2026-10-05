INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a33d0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  9a33d4: 910003fd     	mov	x29, sp
  9a33d8: b9403c01     	ldr	w1, [x0, #0x3c]
  9a33dc: f9000bf3     	str	x19, [sp, #0x10]
  9a33e0: aa0003f3     	mov	x19, x0
  9a33e4: 71000c3f     	cmp	w1, #0x3
  9a33e8: 540000e0     	b.eq	0x9a3404 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c364>
  9a33ec: 54000169     	b.ls	0x9a3418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c378>
  9a33f0: 7100143f     	cmp	w1, #0x5
  9a33f4: 540001a0     	b.eq	0x9a3428 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c388>
  9a33f8: 54000583     	b.lo	0x9a34a8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c408>
  9a33fc: 71003c3f     	cmp	w1, #0xf
  9a3400: 540001a8     	b.hi	0x9a3434 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c394>
  9a3404: aa1303e0     	mov	x0, x19
  9a3408: 52800061     	mov	w1, #0x3                // =3
  9a340c: f9400bf3     	ldr	x19, [sp, #0x10]
  9a3410: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a3414: 17ffff43     	b	0x9a3120 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c080>
  9a3418: 7100043f     	cmp	w1, #0x1
  9a341c: 540001a0     	b.eq	0x9a3450 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c3b0>
  9a3420: 52800001     	mov	w1, #0x0                // =0
  9a3424: 54ffff08     	b.hi	0x9a3404 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c364>
  9a3428: f9400bf3     	ldr	x19, [sp, #0x10]
  9a342c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a3430: 17ffff3c     	b	0x9a3120 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c080>
  9a3434: f9400001     	ldr	x1, [x0]
  9a3438: 52800143     	mov	w3, #0xa                // =10
  9a343c: f9400bf3     	ldr	x19, [sp, #0x10]
  9a3440: b9002823     	str	w3, [x1, #0x28]
  9a3444: f9400022     	ldr	x2, [x1]
  9a3448: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a344c: d61f0040     	br	x2
  9a3450: b9402401     	ldr	w1, [x0, #0x24]
  9a3454: 7101903f     	cmp	w1, #0x64
  9a3458: 540000c0     	b.eq	0x9a3470 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c3d0>
  9a345c: f9400002     	ldr	x2, [x0]
  9a3460: 528002a4     	mov	w4, #0x15               // =21
  9a3464: f9400043     	ldr	x3, [x2]
  9a3468: 29050444     	stp	w4, w1, [x2, #0x28]
  9a346c: d63f0060     	blr	x3
  9a3470: f0002160     	adrp	x0, 0xdd2000
  9a3474: b20003e2     	mov	x2, #0x100000001        // =4294967297
  9a3478: f805c262     	stur	x2, [x19, #0x5c]
  9a347c: 52800021     	mov	w1, #0x1                // =1
  9a3480: 3dc14c00     	ldr	q0, [x0, #0x530]
  9a3484: b9014661     	str	w1, [x19, #0x144]
  9a3488: f9403660     	ldr	x0, [x19, #0x68]
  9a348c: b901527f     	str	wzr, [x19, #0x150]
  9a3490: f9400bf3     	ldr	x19, [sp, #0x10]
  9a3494: b9000001     	str	w1, [x0]
  9a3498: b900181f     	str	wzr, [x0, #0x18]
  9a349c: 3c808000     	stur	q0, [x0, #0x8]
  9a34a0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a34a4: d65f03c0     	ret
  9a34a8: f9400bf3     	ldr	x19, [sp, #0x10]
  9a34ac: 52800081     	mov	w1, #0x4                // =4
  9a34b0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a34b4: 17ffff1b     	b	0x9a3120 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c080>
