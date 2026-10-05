
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000007bbfc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_>:
  822adc: b94017e0     	ldr	w0, [sp, #0x14]
  822ae0: 1e230001     	ucvtf	s1, w0
  822ae4: f9400fe0     	ldr	x0, [sp, #0x18]
  822ae8: bd413800     	ldr	s0, [x0, #0x138]
  822aec: 1e200820     	fmul	s0, s1, s0
  822af0: 1e390000     	fcvtzu	w0, s0
  822af4: b90057e0     	str	w0, [sp, #0x54]
  822af8: f9400fe0     	ldr	x0, [sp, #0x18]
  822afc: f940a800     	ldr	x0, [x0, #0x150]
  822b00: 39400800     	ldrb	w0, [x0, #0x2]
