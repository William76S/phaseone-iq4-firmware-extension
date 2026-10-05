
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  799388: 8b04027b     	add	x27, x19, x4
  79938c: d288ec05     	mov	x5, #0x4760             // =18272
  799390: 4f000400     	movi	v0.4s, #0x0
  799394: 8b050260     	add	x0, x19, x5
  799398: fd413be1     	ldr	d1, [sp, #0x270]
  79939c: f816437f     	stur	xzr, [x27, #-0x9c]
  7993a0: f923ba78     	str	x24, [x19, #0x4770]
  7993a4: 52801fe2     	mov	w2, #0xff               // =255
  7993a8: f94147e3     	ldr	x3, [sp, #0x288]
  7993ac: 3c978360     	stur	q0, [x27, #-0x88]
  7993b0: 52800041     	mov	w1, #0x2                // =2
  7993b4: 4e080422     	dup	v2.2d, v1.d[0]
  7993b8: f923c678     	str	x24, [x19, #0x4788]
  7993bc: fd4143e1     	ldr	d1, [sp, #0x280]
  7993c0: f923d278     	str	x24, [x19, #0x47a0]
  7993c4: 3d91e660     	str	q0, [x19, #0x4790]
  7993c8: 91402274     	add	x20, x19, #0x8, lsl #12 // =0x8000
  7993cc: 4e181f22     	mov	v2.d[1], x25
  7993d0: 3c9a8360     	stur	q0, [x27, #-0x58]
  7993d4: 91401279     	add	x25, x19, #0x4, lsl #12 // =0x4000
  7993d8: d2904006     	mov	x6, #0x8200             // =33280
  7993dc: 4e080421     	dup	v1.2d, v1.d[0]
  7993e0: f923de7f     	str	xzr, [x19, #0x47b8]
  7993e4: b81d6362     	stur	w2, [x27, #-0x2a]
  7993e8: f923f67f     	str	xzr, [x19, #0x47e8]
  7993ec: b9009001     	str	w1, [x0, #0x90]
  7993f0: d2800021     	mov	x1, #0x1                // =1
  7993f4: 4e181c61     	mov	v1.d[1], x3
  7993f8: 52800023     	mov	w3, #0x1                // =1
  7993fc: 790feb23     	strh	w3, [x25, #0x7f4]
  799400: f923fe7f     	str	xzr, [x19, #0x47f8]
  799404: b900a01f     	str	wzr, [x0, #0xa0]
  799408: 8b060260     	add	x0, x19, x6
  79940c: f94183e2     	ldr	x2, [sp, #0x300]
  799410: 3c8e8282     	stur	q2, [x20, #0xe8]
  799414: 3c8f8281     	stur	q1, [x20, #0xf8]
