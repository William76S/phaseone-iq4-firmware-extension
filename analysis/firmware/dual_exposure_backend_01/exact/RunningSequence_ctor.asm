
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5f9d3c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5f9d40: 910003fd     	mov	x29, sp
  5f9d44: f9000bf3     	str	x19, [sp, #0x10]
  5f9d48: f90017e0     	str	x0, [sp, #0x28]
  5f9d4c: f0002ea0     	adrp	x0, 0xbd0000
  5f9d50: 9128e001     	add	x1, x0, #0xa38
  5f9d54: f94017e0     	ldr	x0, [sp, #0x28]
  5f9d58: f9000001     	str	x1, [x0]
  5f9d5c: f94017e0     	ldr	x0, [sp, #0x28]
  5f9d60: 91002004     	add	x4, x0, #0x8
  5f9d64: 52800023     	mov	w3, #0x1                // =1
  5f9d68: 12800002     	mov	w2, #-0x1               // =-1
  5f9d6c: f0002ea0     	adrp	x0, 0xbd0000
  5f9d70: 911d4001     	add	x1, x0, #0x750
  5f9d74: aa0403e0     	mov	x0, x4
  5f9d78: 94000171     	bl	0x5fa33c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x10128c>
  5f9d7c: f94017e0     	ldr	x0, [sp, #0x28]
  5f9d80: 9103a004     	add	x4, x0, #0xe8
  5f9d84: 52800023     	mov	w3, #0x1                // =1
  5f9d88: 52800002     	mov	w2, #0x0                // =0
  5f9d8c: f0002ea0     	adrp	x0, 0xbd0000
  5f9d90: 911da001     	add	x1, x0, #0x768
  5f9d94: aa0403e0     	mov	x0, x4
  5f9d98: 97f86d6f     	bl	0x415354 <.text+0xa124>
  5f9d9c: f94017e0     	ldr	x0, [sp, #0x28]
  5f9da0: 91070004     	add	x4, x0, #0x1c0
  5f9da4: 52800023     	mov	w3, #0x1                // =1
  5f9da8: 52800022     	mov	w2, #0x1                // =1
  5f9dac: f0002ea0     	adrp	x0, 0xbd0000
  5f9db0: 911de001     	add	x1, x0, #0x778
  5f9db4: aa0403e0     	mov	x0, x4
  5f9db8: 97f86d67     	bl	0x415354 <.text+0xa124>
  5f9dbc: f94017e0     	ldr	x0, [sp, #0x28]
  5f9dc0: 910a6004     	add	x4, x0, #0x298
  5f9dc4: 52800023     	mov	w3, #0x1                // =1
  5f9dc8: 52800002     	mov	w2, #0x0                // =0
  5f9dcc: f0002ea0     	adrp	x0, 0xbd0000
  5f9dd0: 911e4001     	add	x1, x0, #0x790
  5f9dd4: aa0403e0     	mov	x0, x4
  5f9dd8: 97f86d5f     	bl	0x415354 <.text+0xa124>
