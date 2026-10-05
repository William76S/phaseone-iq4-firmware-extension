
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  712790: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  712794: 910003fd     	mov	x29, sp
  712798: f9000fe0     	str	x0, [sp, #0x18]
  71279c: d0002880     	adrp	x0, 0xc24000
  7127a0: 9116e001     	add	x1, x0, #0x5b8
  7127a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7127a8: f9000001     	str	x1, [x0]
  7127ac: f0004200     	adrp	x0, 0xf55000
  7127b0: 910f0000     	add	x0, x0, #0x3c0
  7127b4: 97ffff1e     	bl	0x71242c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x243ac>
  7127b8: d503201f     	nop
  7127bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7127c0: d65f03c0     	ret
