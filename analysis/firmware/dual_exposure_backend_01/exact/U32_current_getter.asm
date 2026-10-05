
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  40c880: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  40c884: 910003fd     	mov	x29, sp
  40c888: f9000fe0     	str	x0, [sp, #0x18]
  40c88c: 910083e0     	add	x0, sp, #0x20
  40c890: 97fffea0     	bl	0x40c310 <.text+0x10e0>
  40c894: f9400fe0     	ldr	x0, [sp, #0x18]
  40c898: b940c000     	ldr	w0, [x0, #0xc0]
  40c89c: b9002fe0     	str	w0, [sp, #0x2c]
  40c8a0: 910083e0     	add	x0, sp, #0x20
  40c8a4: 97fffea7     	bl	0x40c340 <.text+0x1110>
  40c8a8: b9402fe0     	ldr	w0, [sp, #0x2c]
  40c8ac: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  40c8b0: d65f03c0     	ret
