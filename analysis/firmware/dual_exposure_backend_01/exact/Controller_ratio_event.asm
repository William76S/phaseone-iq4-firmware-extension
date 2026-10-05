
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  79cb08: a9b67bfd     	stp	x29, x30, [sp, #-0xa0]!
  79cb0c: d283fa0b     	mov	x11, #0x1fd0            // =8144
  79cb10: 910003fd     	mov	x29, sp
  79cb14: a90153f3     	stp	x19, x20, [sp, #0x10]
  79cb18: aa0003f3     	mov	x19, x0
  79cb1c: a9025bf5     	stp	x21, x22, [sp, #0x20]
  79cb20: aa0103f6     	mov	x22, x1
  79cb24: 8b0b0001     	add	x1, x0, x11
  79cb28: eb0102df     	cmp	x22, x1
  79cb2c: 54002100     	b.eq	0x79cf4c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83220>
  79cb30: d283280a     	mov	x10, #0x1940            // =6464
  79cb34: 8b0a0275     	add	x21, x19, x10
  79cb38: 91402274     	add	x20, x19, #0x8, lsl #12 // =0x8000
  79cb3c: eb1602bf     	cmp	x21, x22
  79cb40: 54001ee0     	b.eq	0x79cf1c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x831f0>
  79cb44: f9407680     	ldr	x0, [x20, #0xe8]
  79cb48: d2821109     	mov	x9, #0x1088             // =4232
  79cb4c: 8b090001     	add	x1, x0, x9
  79cb50: eb0102df     	cmp	x22, x1
  79cb54: 54000220     	b.eq	0x79cb98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e6c>
  79cb58: 394b0260     	ldrb	w0, [x19, #0x2c0]
  79cb5c: 340002e0     	cbz	w0, 0x79cbb8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e8c>
  79cb60: f9504e60     	ldr	x0, [x19, #0x2098]
  79cb64: b4000400     	cbz	x0, 0x79cbe4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82eb8>
  79cb68: 91230276     	add	x22, x19, #0x8c0
  79cb6c: 394302c0     	ldrb	w0, [x22, #0xc0]
  79cb70: 340000c0     	cbz	w0, 0x79cb88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e5c>
  79cb74: a90363f7     	stp	x23, x24, [sp, #0x30]
  79cb78: 911fa277     	add	x23, x19, #0x7e8
  79cb7c: 394302e0     	ldrb	w0, [x23, #0xc0]
  79cb80: 350006c0     	cbnz	w0, 0x79cc58 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f2c>
  79cb84: a94363f7     	ldp	x23, x24, [sp, #0x30]
  79cb88: a94153f3     	ldp	x19, x20, [sp, #0x10]
  79cb8c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  79cb90: a8ca7bfd     	ldp	x29, x30, [sp], #0xa0
  79cb94: d65f03c0     	ret
  79cb98: f9506661     	ldr	x1, [x19, #0x20c8]
  79cb9c: bd514000     	ldr	s0, [x0, #0x1140]
  79cba0: aa0103e0     	mov	x0, x1
  79cba4: f9400021     	ldr	x1, [x1]
  79cba8: f9404021     	ldr	x1, [x1, #0x80]
  79cbac: d63f0020     	blr	x1
  79cbb0: 394b0260     	ldrb	w0, [x19, #0x2c0]
  79cbb4: 35fffd60     	cbnz	w0, 0x79cb60 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e34>
