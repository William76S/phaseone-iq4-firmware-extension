
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7992e0: d2800043     	mov	x3, #0x2                // =2
  7992e4: fd10566c     	str	d12, [x19, #0x20a8]
  7992e8: 52800085     	mov	w5, #0x4                // =4
  7992ec: fd105a6b     	str	d11, [x19, #0x20b0]
  7992f0: d2c00024     	mov	x4, #0x100000000        // =4294967296
  7992f4: fd105e6a     	str	d10, [x19, #0x20b8]
  7992f8: d2844f08     	mov	x8, #0x2278             // =8824
  7992fc: fd106268     	str	d8, [x19, #0x20c0]
  799300: f2c00063     	movk	x3, #0x3, lsl #32
  799304: f910667b     	str	x27, [x19, #0x20c8]
  799308: 8b080260     	add	x0, x19, x8
