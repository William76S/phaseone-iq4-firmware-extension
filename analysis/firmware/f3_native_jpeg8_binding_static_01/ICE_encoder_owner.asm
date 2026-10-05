INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7b5598: f9402fe1     	ldr	x1, [sp, #0x58]
  7b559c: d28f2000     	mov	x0, #0x7900             // =30976
  7b55a0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b55a4: 8b000020     	add	x0, x1, x0
  7b55a8: 910203e1     	add	x1, sp, #0x80
  7b55ac: 94001bc6     	bl	0x7bc4c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x4fc>
  7b55b0: 910203e0     	add	x0, sp, #0x80
  7b55b4: 97f1f1c8     	bl	0x431cd4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x58c>
  7b55b8: 94075e64     	bl	0x98cf48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x15ea8>
  7b55bc: aa0003e2     	mov	x2, x0
  7b55c0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b55c4: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b55c8: 8b000020     	add	x0, x1, x0
  7b55cc: f93c9402     	str	x2, [x0, #0x7928]
