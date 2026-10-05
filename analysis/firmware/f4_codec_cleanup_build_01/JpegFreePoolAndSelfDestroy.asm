
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a40d8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  9a40dc: 7100043f     	cmp	w1, #0x1
  9a40e0: 910003fd     	mov	x29, sp
  9a40e4: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a40e8: a9025bf5     	stp	x21, x22, [sp, #0x20]
  9a40ec: aa0003f5     	mov	x21, x0
  9a40f0: f9400416     	ldr	x22, [x0, #0x8]
  9a40f4: f9001bf7     	str	x23, [sp, #0x30]
  9a40f8: 2a0103f7     	mov	w23, w1
  9a40fc: 54000589     	b.ls	0x9a41ac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d10c>
  9a4100: f9400001     	ldr	x1, [x0]
  9a4104: 528001e3     	mov	w3, #0xf                // =15
  9a4108: f9400022     	ldr	x2, [x1]
  9a410c: 29055c23     	stp	w3, w23, [x1, #0x28]
  9a4110: d63f0040     	blr	x2
  9a4114: 8b37ced7     	add	x23, x22, w23, sxtw #3
  9a4118: f9403ef3     	ldr	x19, [x23, #0x78]
  9a411c: f9003eff     	str	xzr, [x23, #0x78]
  9a4120: b40001d3     	cbz	x19, 0x9a4158 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d0b8>
  9a4124: d503201f     	nop
  9a4128: a9408a74     	ldp	x20, x2, [x19, #0x8]
  9a412c: aa1303e1     	mov	x1, x19
  9a4130: aa1503e0     	mov	x0, x21
  9a4134: f9400273     	ldr	x19, [x19]
  9a4138: 8b020294     	add	x20, x20, x2
  9a413c: 91006294     	add	x20, x20, #0x18
  9a4140: aa1403e2     	mov	x2, x20
  9a4144: 94000f71     	bl	0x9a7f08 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30e68>
  9a4148: f9404ec0     	ldr	x0, [x22, #0x98]
  9a414c: cb140014     	sub	x20, x0, x20
  9a4150: f9004ed4     	str	x20, [x22, #0x98]
  9a4154: b5fffeb3     	cbnz	x19, 0x9a4128 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d088>
  9a4158: f94036f3     	ldr	x19, [x23, #0x68]
  9a415c: f90036ff     	str	xzr, [x23, #0x68]
  9a4160: b40001d3     	cbz	x19, 0x9a4198 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d0f8>
  9a4164: d503201f     	nop
  9a4168: a9408a74     	ldp	x20, x2, [x19, #0x8]
  9a416c: aa1303e1     	mov	x1, x19
  9a4170: aa1503e0     	mov	x0, x21
  9a4174: f9400273     	ldr	x19, [x19]
  9a4178: 8b020294     	add	x20, x20, x2
  9a417c: 91006294     	add	x20, x20, #0x18
  9a4180: aa1403e2     	mov	x2, x20
  9a4184: 94000f5d     	bl	0x9a7ef8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30e58>
  9a4188: f9404ec0     	ldr	x0, [x22, #0x98]
  9a418c: cb140014     	sub	x20, x0, x20
  9a4190: f9004ed4     	str	x20, [x22, #0x98]
  9a4194: b5fffeb3     	cbnz	x19, 0x9a4168 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d0c8>
  9a4198: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a419c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9a41a0: f9401bf7     	ldr	x23, [sp, #0x30]
  9a41a4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  9a41a8: d65f03c0     	ret
  9a41ac: 54fffb41     	b.ne	0x9a4114 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d074>
  9a41b0: f94046d3     	ldr	x19, [x22, #0x88]
  9a41b4: b4000153     	cbz	x19, 0x9a41dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d13c>
  9a41b8: b9402e62     	ldr	w2, [x19, #0x2c]
  9a41bc: 9100e261     	add	x1, x19, #0x38
  9a41c0: aa1503e0     	mov	x0, x21
  9a41c4: 34000282     	cbz	w2, 0x9a4214 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d174>
  9a41c8: f9402662     	ldr	x2, [x19, #0x48]
  9a41cc: b9002e7f     	str	wzr, [x19, #0x2c]
  9a41d0: d63f0040     	blr	x2
  9a41d4: f9401a73     	ldr	x19, [x19, #0x30]
  9a41d8: b5ffff13     	cbnz	x19, 0x9a41b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d118>
  9a41dc: f9404ad3     	ldr	x19, [x22, #0x90]
  9a41e0: f90046df     	str	xzr, [x22, #0x88]
  9a41e4: b4000153     	cbz	x19, 0x9a420c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d16c>
  9a41e8: b9402e62     	ldr	w2, [x19, #0x2c]
  9a41ec: 9100e261     	add	x1, x19, #0x38
  9a41f0: aa1503e0     	mov	x0, x21
  9a41f4: 34000162     	cbz	w2, 0x9a4220 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d180>
  9a41f8: f9402662     	ldr	x2, [x19, #0x48]
  9a41fc: b9002e7f     	str	wzr, [x19, #0x2c]
  9a4200: d63f0040     	blr	x2
  9a4204: f9401a73     	ldr	x19, [x19, #0x30]
  9a4208: b5ffff13     	cbnz	x19, 0x9a41e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d148>
  9a420c: f9004adf     	str	xzr, [x22, #0x90]
  9a4210: 17ffffc1     	b	0x9a4114 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d074>
  9a4214: f9401a73     	ldr	x19, [x19, #0x30]
  9a4218: b5fffd13     	cbnz	x19, 0x9a41b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d118>
  9a421c: 17fffff0     	b	0x9a41dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d13c>
  9a4220: f9401a73     	ldr	x19, [x19, #0x30]
  9a4224: b5fffe33     	cbnz	x19, 0x9a41e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d148>
  9a4228: f9004adf     	str	xzr, [x22, #0x90]
  9a422c: 17ffffba     	b	0x9a4114 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d074>
  9a4230: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  9a4234: 52800021     	mov	w1, #0x1                // =1
  9a4238: 910003fd     	mov	x29, sp
  9a423c: f9000bf3     	str	x19, [sp, #0x10]
  9a4240: aa0003f3     	mov	x19, x0
  9a4244: 97ffffa5     	bl	0x9a40d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d038>
  9a4248: aa1303e0     	mov	x0, x19
  9a424c: 52800001     	mov	w1, #0x0                // =0
  9a4250: 97ffffa2     	bl	0x9a40d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2d038>
  9a4254: f9400661     	ldr	x1, [x19, #0x8]
  9a4258: aa1303e0     	mov	x0, x19
  9a425c: d2801502     	mov	x2, #0xa8               // =168
  9a4260: 94000f26     	bl	0x9a7ef8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30e58>
  9a4264: f900067f     	str	xzr, [x19, #0x8]
  9a4268: aa1303e0     	mov	x0, x19
  9a426c: f9400bf3     	ldr	x19, [sp, #0x10]
  9a4270: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a4274: 14000f37     	b	0x9a7f50 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30eb0>
