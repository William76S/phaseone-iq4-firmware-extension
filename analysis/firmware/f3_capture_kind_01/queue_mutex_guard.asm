
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

000000000040b230 <.text>:
  411bc0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  411bc4: 910003fd     	mov	x29, sp
  411bc8: f9000fe0     	str	x0, [sp, #0x18]
  411bcc: f9000be1     	str	x1, [sp, #0x10]
  411bd0: f9400fe0     	ldr	x0, [sp, #0x18]
  411bd4: f9400be1     	ldr	x1, [sp, #0x10]
  411bd8: f9000001     	str	x1, [x0]
  411bdc: f9400fe0     	ldr	x0, [sp, #0x18]
  411be0: f9400000     	ldr	x0, [x0]
  411be4: 940c0153     	bl	0x712130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x240b0>
  411be8: d503201f     	nop
  411bec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  411bf0: d65f03c0     	ret
  411bf4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  411bf8: 910003fd     	mov	x29, sp
  411bfc: f9000fe0     	str	x0, [sp, #0x18]
  411c00: f9400fe0     	ldr	x0, [sp, #0x18]
  411c04: f9400000     	ldr	x0, [x0]
  411c08: 940c017f     	bl	0x712204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24184>
  411c0c: d503201f     	nop
  411c10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  411c14: d65f03c0     	ret
