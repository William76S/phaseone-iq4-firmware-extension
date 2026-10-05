
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5c1e14: 91064001     	add	x1, x0, #0x190
  5c1e18: aa0403e0     	mov	x0, x4
  5c1e1c: 97f929c0     	bl	0x40c51c <.text+0x12ec>
  5c1e20: f94017e1     	ldr	x1, [sp, #0x28]
  5c1e24: d2821000     	mov	x0, #0x1080             // =4224
  5c1e28: 8b000023     	add	x3, x1, x0
  5c1e2c: 52800022     	mov	w2, #0x1                // =1
  5c1e30: 1e241000     	fmov	s0, #8.00000000
  5c1e34: f0002fe0     	adrp	x0, 0xbc0000
  5c1e38: 91068001     	add	x1, x0, #0x1a0
  5c1e3c: aa0303e0     	mov	x0, x3
  5c1e40: 97f9c1e3     	bl	0x4325cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0xe84>
  5c1e44: f94017e1     	ldr	x1, [sp, #0x28]
  5c1e48: d2822c00     	mov	x0, #0x1160             // =4448
  5c1e4c: 8b000024     	add	x4, x1, x0
  5c1e50: 52800023     	mov	w3, #0x1                // =1
  5c1e54: 52800a02     	mov	w2, #0x50               // =80
  5c1e58: f0002fe0     	adrp	x0, 0xbc0000
  5c1e5c: 9106e001     	add	x1, x0, #0x1b8
  5c1e60: aa0403e0     	mov	x0, x4
  5c1e64: 97f929ae     	bl	0x40c51c <.text+0x12ec>
  5c1e68: 14000067     	b	0x5c2004 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f54>
  5c1e6c: aa0003f3     	mov	x19, x0
  5c1e70: f94017e1     	ldr	x1, [sp, #0x28]
