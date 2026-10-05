
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000007bbfc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_>:
  829af4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  829af8: 910003fd     	mov	x29, sp
  829afc: f9000bf3     	str	x19, [sp, #0x10]
  829b00: f90017e0     	str	x0, [sp, #0x28]
  829b04: f90013e1     	str	x1, [sp, #0x20]
  829b08: f94013e0     	ldr	x0, [sp, #0x20]
  829b0c: f100001f     	cmp	x0, #0x0
  829b10: 54000121     	b.ne	0x829b34 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6db6c>
  829b14: 90002b40     	adrp	x0, 0xd91000
  829b18: 913aa003     	add	x3, x0, #0xea8
  829b1c: 52800c22     	mov	w2, #0x61               // =97
  829b20: 90002b40     	adrp	x0, 0xd91000
  829b24: 913b6001     	add	x1, x0, #0xed8
  829b28: 52800040     	mov	w0, #0x2                // =2
  829b2c: 97fc7288     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  829b30: 14000014     	b	0x829b80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6dbb8>
  829b34: f94017e1     	ldr	x1, [sp, #0x28]
  829b38: d284a000     	mov	x0, #0x2500             // =9472
  829b3c: 8b000021     	add	x1, x1, x0
  829b40: 9100e3e0     	add	x0, sp, #0x38
  829b44: 97efa01f     	bl	0x411bc0 <.text+0x6990>
  829b48: f94017e0     	ldr	x0, [sp, #0x28]
  829b4c: 91006000     	add	x0, x0, #0x18
  829b50: d2849d02     	mov	x2, #0x24e8             // =9448
  829b54: aa0003e1     	mov	x1, x0
  829b58: f94013e0     	ldr	x0, [sp, #0x20]
  829b5c: 97fb9c15     	bl	0x710bb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22b30>
  829b60: 9100e3e0     	add	x0, sp, #0x38
  829b64: 97efa024     	bl	0x411bf4 <.text+0x69c4>
  829b68: 14000006     	b	0x829b80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6dbb8>
  829b6c: aa0003f3     	mov	x19, x0
  829b70: 9100e3e0     	add	x0, sp, #0x38
  829b74: 97efa020     	bl	0x411bf4 <.text+0x69c4>
  829b78: aa1303e0     	mov	x0, x19
  829b7c: 97ef82f5     	bl	0x40a750 <_Unwind_Resume@plt>
  829b80: f9400bf3     	ldr	x19, [sp, #0x10]
  829b84: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  829b88: d65f03c0     	ret
