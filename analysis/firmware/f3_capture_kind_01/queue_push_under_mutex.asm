
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c709c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c70a0: 910003fd     	mov	x29, sp
  8c70a4: f9000bf3     	str	x19, [sp, #0x10]
  8c70a8: f90017e0     	str	x0, [sp, #0x28]
  8c70ac: f90013e1     	str	x1, [sp, #0x20]
  8c70b0: f94013e0     	ldr	x0, [sp, #0x20]
  8c70b4: f100001f     	cmp	x0, #0x0
  8c70b8: 54000061     	b.ne	0x8c70c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20898>
  8c70bc: 52800013     	mov	w19, #0x0               // =0
  8c70c0: 14000032     	b	0x8c7188 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x2095c>
  8c70c4: f94017e0     	ldr	x0, [sp, #0x28]
  8c70c8: 91008001     	add	x1, x0, #0x20
  8c70cc: 9100c3e0     	add	x0, sp, #0x30
  8c70d0: 97ed2abc     	bl	0x411bc0 <.text+0x6990>
  8c70d4: f94017e0     	ldr	x0, [sp, #0x28]
  8c70d8: f94013e1     	ldr	x1, [sp, #0x20]
  8c70dc: 940001ca     	bl	0x8c7804 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20fd8>
  8c70e0: 12001c00     	and	w0, w0, #0xff
  8c70e4: 3900ffe0     	strb	w0, [sp, #0x3f]
  8c70e8: 3940ffe0     	ldrb	w0, [sp, #0x3f]
  8c70ec: 7100001f     	cmp	w0, #0x0
  8c70f0: 54000460     	b.eq	0x8c717c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20950>
  8c70f4: f94017e0     	ldr	x0, [sp, #0x28]
  8c70f8: f9404000     	ldr	x0, [x0, #0x80]
  8c70fc: f100001f     	cmp	x0, #0x0
  8c7100: 54000380     	b.eq	0x8c7170 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20944>
  8c7104: f94017e0     	ldr	x0, [sp, #0x28]
  8c7108: b9408800     	ldr	w0, [x0, #0x88]
  8c710c: 12000000     	and	w0, w0, #0x1
  8c7110: 7100001f     	cmp	w0, #0x0
  8c7114: 540002e0     	b.eq	0x8c7170 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20944>
  8c7118: f94013e0     	ldr	x0, [sp, #0x20]
  8c711c: f100001f     	cmp	x0, #0x0
  8c7120: 54000141     	b.ne	0x8c7148 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x2091c>
  8c7124: 52801983     	mov	w3, #0xcc               // =204
  8c7128: b0002760     	adrp	x0, 0xdb4000
  8c712c: 91224002     	add	x2, x0, #0x890
  8c7130: b0002760     	adrp	x0, 0xdb4000
  8c7134: 9122c001     	add	x1, x0, #0x8b0
  8c7138: b0002760     	adrp	x0, 0xdb4000
  8c713c: 91152000     	add	x0, x0, #0x548
  8c7140: 97ed0d10     	bl	0x40a580 <printf@plt>
  8c7144: 97fa9571     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c7148: f94017e0     	ldr	x0, [sp, #0x28]
  8c714c: f9404003     	ldr	x3, [x0, #0x80]
  8c7150: f94017e0     	ldr	x0, [sp, #0x28]
  8c7154: f9404000     	ldr	x0, [x0, #0x80]
  8c7158: f9400000     	ldr	x0, [x0]
  8c715c: f9400002     	ldr	x2, [x0]
  8c7160: f94013e0     	ldr	x0, [sp, #0x20]
  8c7164: aa0003e1     	mov	x1, x0
  8c7168: aa0303e0     	mov	x0, x3
  8c716c: d63f0040     	blr	x2
  8c7170: f94017e0     	ldr	x0, [sp, #0x28]
  8c7174: f9400c00     	ldr	x0, [x0, #0x18]
  8c7178: 97f92060     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  8c717c: 3940fff3     	ldrb	w19, [sp, #0x3f]
  8c7180: 9100c3e0     	add	x0, sp, #0x30
  8c7184: 97ed2a9c     	bl	0x411bf4 <.text+0x69c4>
  8c7188: 2a1303e0     	mov	w0, w19
  8c718c: 14000006     	b	0x8c71a4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20978>
  8c7190: aa0003f3     	mov	x19, x0
  8c7194: 9100c3e0     	add	x0, sp, #0x30
  8c7198: 97ed2a97     	bl	0x411bf4 <.text+0x69c4>
  8c719c: aa1303e0     	mov	x0, x19
  8c71a0: 97ed0d6c     	bl	0x40a750 <_Unwind_Resume@plt>
  8c71a4: f9400bf3     	ldr	x19, [sp, #0x10]
  8c71a8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c71ac: d65f03c0     	ret
