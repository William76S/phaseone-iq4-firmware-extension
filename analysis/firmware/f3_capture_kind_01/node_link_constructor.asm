
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c35c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c35c4: 910003fd     	mov	x29, sp
  8c35c8: f9000fe0     	str	x0, [sp, #0x18]
  8c35cc: f9000be1     	str	x1, [sp, #0x10]
  8c35d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c35d4: 94000007     	bl	0x8c35f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cdc4>
  8c35d8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c35dc: f9400be1     	ldr	x1, [sp, #0x10]
  8c35e0: f9000401     	str	x1, [x0, #0x8]
  8c35e4: d503201f     	nop
  8c35e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c35ec: d65f03c0     	ret
  8c35f0: d10043ff     	sub	sp, sp, #0x10
  8c35f4: f90007e0     	str	x0, [sp, #0x8]
  8c35f8: f94007e0     	ldr	x0, [sp, #0x8]
  8c35fc: f900001f     	str	xzr, [x0]
  8c3600: d503201f     	nop
  8c3604: 910043ff     	add	sp, sp, #0x10
  8c3608: d65f03c0     	ret
  8c360c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
