
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a7ef0: aa0103e0     	mov	x0, x1
  9a7ef4: 17e989bb     	b	0x40a5e0 <malloc@plt>
  9a7ef8: aa0103e0     	mov	x0, x1
  9a7efc: 17e98c89     	b	0x40b120 <free@plt>
  9a7f00: aa0103e0     	mov	x0, x1
  9a7f04: 17e989b7     	b	0x40a5e0 <malloc@plt>
  9a7f08: aa0103e0     	mov	x0, x1
  9a7f0c: 17e98c85     	b	0x40b120 <free@plt>
  9a7f10: f9400400     	ldr	x0, [x0, #0x8]
  9a7f14: f9402c01     	ldr	x1, [x0, #0x58]
  9a7f18: aa0203e0     	mov	x0, x2
  9a7f1c: b4000061     	cbz	x1, 0x9a7f28 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30e88>
  9a7f20: eb030022     	subs	x2, x1, x3
  9a7f24: 9a9f8040     	csel	x0, x2, xzr, hi
  9a7f28: d65f03c0     	ret
  9a7f2c: d503201f     	nop
  9a7f30: f9400001     	ldr	x1, [x0]
  9a7f34: 52800663     	mov	w3, #0x33               // =51
  9a7f38: f9400022     	ldr	x2, [x1]
  9a7f3c: b9002823     	str	w3, [x1, #0x28]
  9a7f40: d61f0040     	br	x2
  9a7f44: d503201f     	nop
  9a7f48: d2800000     	mov	x0, #0x0                // =0
  9a7f4c: d65f03c0     	ret
  9a7f50: d65f03c0     	ret
  9a7f54: d503201f     	nop
