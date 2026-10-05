INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a3d28: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  9a3d2c: 910003fd     	mov	x29, sp
  9a3d30: f9400401     	ldr	x1, [x0, #0x8]
  9a3d34: f9000bf3     	str	x19, [sp, #0x10]
  9a3d38: aa0003f3     	mov	x19, x0
  9a3d3c: b4000061     	cbz	x1, 0x9a3d48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cca8>
  9a3d40: f9402821     	ldr	x1, [x1, #0x50]
  9a3d44: d63f0020     	blr	x1
  9a3d48: f900067f     	str	xzr, [x19, #0x8]
  9a3d4c: b900267f     	str	wzr, [x19, #0x24]
  9a3d50: f9400bf3     	ldr	x19, [sp, #0x10]
  9a3d54: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a3d58: d65f03c0     	ret
