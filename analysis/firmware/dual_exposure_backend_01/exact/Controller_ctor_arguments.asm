
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7988e0: d109c3ff     	sub	sp, sp, #0x270
  7988e4: a9007bfd     	stp	x29, x30, [sp]
  7988e8: 910003fd     	mov	x29, sp
  7988ec: a90153f3     	stp	x19, x20, [sp, #0x10]
  7988f0: aa0003f3     	mov	x19, x0
  7988f4: 9106a014     	add	x20, x0, #0x1a8
  7988f8: 6d0627e8     	stp	d8, d9, [sp, #0x60]
  7988fc: 9e6700a8     	fmov	d8, x5
  798900: 9e6700c9     	fmov	d9, x6
  798904: 6d072fea     	stp	d10, d11, [sp, #0x70]
  798908: 9e67004b     	fmov	d11, x2
  79890c: 9e67008a     	fmov	d10, x4
  798910: fd0043ec     	str	d12, [sp, #0x80]
  798914: 9e67002c     	fmov	d12, x1
  798918: 52800082     	mov	w2, #0x4                // =4
  79891c: d2800004     	mov	x4, #0x0                // =0
  798920: f0002ec1     	adrp	x1, 0xd73000
  798924: 912ac021     	add	x1, x1, #0xab0
  798928: a90363f7     	stp	x23, x24, [sp, #0x30]
  79892c: a9046bf9     	stp	x25, x26, [sp, #0x40]
  798930: a90573fb     	stp	x27, x28, [sp, #0x50]
  798934: aa0303fb     	mov	x27, x3
  798938: 52820003     	mov	w3, #0x1000             // =4096
  79893c: f90067f4     	str	x20, [sp, #0xc8]
  798940: f9413ff9     	ldr	x25, [sp, #0x278]
  798944: f9414ffa     	ldr	x26, [sp, #0x298]
  798948: f94153f8     	ldr	x24, [sp, #0x2a0]
