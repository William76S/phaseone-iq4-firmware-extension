
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000431748 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv>:
  432314: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  432318: 910003fd     	mov	x29, sp
  43231c: f9000fe0     	str	x0, [sp, #0x18]
  432320: 910083e0     	add	x0, sp, #0x20
  432324: 97ff67fb     	bl	0x40c310 <.text+0x10e0>
  432328: f9400fe0     	ldr	x0, [sp, #0x18]
  43232c: b940c000     	ldr	w0, [x0, #0xc0]
  432330: b9002fe0     	str	w0, [sp, #0x2c]
  432334: 910083e0     	add	x0, sp, #0x20
  432338: 97ff6802     	bl	0x40c340 <.text+0x1110>
  43233c: b9402fe0     	ldr	w0, [sp, #0x2c]
  432340: 1e270000     	fmov	s0, w0
  432344: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  432348: d65f03c0     	ret
