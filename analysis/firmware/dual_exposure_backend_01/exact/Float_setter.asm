
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  44136c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  441370: 910003fd     	mov	x29, sp
  441374: f9000bf3     	str	x19, [sp, #0x10]
  441378: f90017e0     	str	x0, [sp, #0x28]
  44137c: bd0027e0     	str	s0, [sp, #0x24]
  441380: 9100e3e0     	add	x0, sp, #0x38
  441384: 97ff2be3     	bl	0x40c310 <.text+0x10e0>
  441388: f94017e0     	ldr	x0, [sp, #0x28]
  44138c: b940c800     	ldr	w0, [x0, #0xc8]
  441390: 7100041f     	cmp	w0, #0x1
  441394: 54000101     	b.ne	0x4413b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb408>
  441398: f94017e0     	ldr	x0, [sp, #0x28]
  44139c: bd40c000     	ldr	s0, [x0, #0xc0]
  4413a0: bd4027e1     	ldr	s1, [sp, #0x24]
  4413a4: 1e202020     	fcmp	s1, s0
  4413a8: 54000061     	b.ne	0x4413b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb408>
  4413ac: 52800013     	mov	w19, #0x0               // =0
  4413b0: 14000005     	b	0x4413c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb418>
  4413b4: f94017e0     	ldr	x0, [sp, #0x28]
  4413b8: b94027e1     	ldr	w1, [sp, #0x24]
  4413bc: b900c001     	str	w1, [x0, #0xc0]
  4413c0: 52800033     	mov	w19, #0x1               // =1
  4413c4: 9100e3e0     	add	x0, sp, #0x38
  4413c8: 97ff2bde     	bl	0x40c340 <.text+0x1110>
  4413cc: 7100067f     	cmp	w19, #0x1
  4413d0: 54000081     	b.ne	0x4413e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb434>
  4413d4: f94017e0     	ldr	x0, [sp, #0x28]
  4413d8: 91002000     	add	x0, x0, #0x8
  4413dc: 940b37c7     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  4413e0: f9400bf3     	ldr	x19, [sp, #0x10]
  4413e4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4413e8: d65f03c0     	ret
