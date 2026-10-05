INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  98cf08: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  98cf0c: 910003fd     	mov	x29, sp
  98cf10: f9000fe0     	str	x0, [sp, #0x18]
  98cf14: f9400fe0     	ldr	x0, [sp, #0x18]
  98cf18: f9400000     	ldr	x0, [x0]
  98cf1c: f9400801     	ldr	x1, [x0, #0x10]
  98cf20: f9400fe0     	ldr	x0, [sp, #0x18]
  98cf24: d63f0020     	blr	x1
  98cf28: f9400fe0     	ldr	x0, [sp, #0x18]
  98cf2c: f9400000     	ldr	x0, [x0]
  98cf30: f90017e0     	str	x0, [sp, #0x28]
  98cf34: f94017e0     	ldr	x0, [sp, #0x28]
  98cf38: f9405400     	ldr	x0, [x0, #0xa8]
  98cf3c: 91002000     	add	x0, x0, #0x8
  98cf40: 52800021     	mov	w1, #0x1                // =1
  98cf44: 97e9f847     	bl	0x40b060 <longjmp@plt>
