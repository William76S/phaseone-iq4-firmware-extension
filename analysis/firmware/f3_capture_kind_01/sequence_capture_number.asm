
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7a0edc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a0ee0: 910003fd     	mov	x29, sp
  7a0ee4: f9000fe0     	str	x0, [sp, #0x18]
  7a0ee8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a0eec: f9400802     	ldr	x2, [x0, #0x10]
  7a0ef0: f9400fe0     	ldr	x0, [sp, #0x18]
  7a0ef4: f9400800     	ldr	x0, [x0, #0x10]
  7a0ef8: f9400000     	ldr	x0, [x0]
  7a0efc: 91010000     	add	x0, x0, #0x40
  7a0f00: f9400001     	ldr	x1, [x0]
  7a0f04: aa0203e0     	mov	x0, x2
  7a0f08: d63f0020     	blr	x1
  7a0f0c: 12001c00     	and	w0, w0, #0xff
  7a0f10: 52000000     	eor	w0, w0, #0x1
  7a0f14: 12001c00     	and	w0, w0, #0xff
  7a0f18: 7100001f     	cmp	w0, #0x0
  7a0f1c: 540001c0     	b.eq	0x7a0f54 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87228>
  7a0f20: f9400fe0     	ldr	x0, [sp, #0x18]
  7a0f24: f9400400     	ldr	x0, [x0, #0x8]
  7a0f28: f100001f     	cmp	x0, #0x0
  7a0f2c: 54000140     	b.eq	0x7a0f54 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87228>
  7a0f30: f9400fe0     	ldr	x0, [sp, #0x18]
  7a0f34: f9400402     	ldr	x2, [x0, #0x8]
  7a0f38: f9400fe0     	ldr	x0, [sp, #0x18]
  7a0f3c: f9400400     	ldr	x0, [x0, #0x8]
  7a0f40: f9400000     	ldr	x0, [x0]
  7a0f44: 91010000     	add	x0, x0, #0x40
  7a0f48: f9400001     	ldr	x1, [x0]
  7a0f4c: aa0203e0     	mov	x0, x2
  7a0f50: d63f0020     	blr	x1
  7a0f54: d503201f     	nop
  7a0f58: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a0f5c: d65f03c0     	ret
  7a0f60: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7a0f64: 910003fd     	mov	x29, sp
  7a0f68: a90153f3     	stp	x19, x20, [sp, #0x10]
  7a0f6c: f90017e0     	str	x0, [sp, #0x28]
  7a0f70: f94017e0     	ldr	x0, [sp, #0x28]
  7a0f74: f9400802     	ldr	x2, [x0, #0x10]
  7a0f78: f94017e0     	ldr	x0, [sp, #0x28]
  7a0f7c: f9400800     	ldr	x0, [x0, #0x10]
  7a0f80: f9400000     	ldr	x0, [x0]
  7a0f84: 91010000     	add	x0, x0, #0x40
  7a0f88: f9400001     	ldr	x1, [x0]
  7a0f8c: aa0203e0     	mov	x0, x2
  7a0f90: d63f0020     	blr	x1
  7a0f94: 12001c00     	and	w0, w0, #0xff
  7a0f98: 52000000     	eor	w0, w0, #0x1
  7a0f9c: 12001c00     	and	w0, w0, #0xff
  7a0fa0: 7100001f     	cmp	w0, #0x0
  7a0fa4: 540001c0     	b.eq	0x7a0fdc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x872b0>
  7a0fa8: f94017e0     	ldr	x0, [sp, #0x28]
  7a0fac: f9400400     	ldr	x0, [x0, #0x8]
  7a0fb0: f100001f     	cmp	x0, #0x0
  7a0fb4: 54000140     	b.eq	0x7a0fdc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x872b0>
  7a0fb8: f94017e0     	ldr	x0, [sp, #0x28]
  7a0fbc: f9400402     	ldr	x2, [x0, #0x8]
  7a0fc0: f94017e0     	ldr	x0, [sp, #0x28]
  7a0fc4: f9400400     	ldr	x0, [x0, #0x8]
  7a0fc8: f9400000     	ldr	x0, [x0]
  7a0fcc: 91012000     	add	x0, x0, #0x48
  7a0fd0: f9400001     	ldr	x1, [x0]
  7a0fd4: aa0203e0     	mov	x0, x2
  7a0fd8: d63f0020     	blr	x1
  7a0fdc: f94017e0     	ldr	x0, [sp, #0x28]
  7a0fe0: f9402414     	ldr	x20, [x0, #0x48]
  7a0fe4: f94017e0     	ldr	x0, [sp, #0x28]
  7a0fe8: f9402400     	ldr	x0, [x0, #0x48]
  7a0fec: f9400000     	ldr	x0, [x0]
  7a0ff0: 91012000     	add	x0, x0, #0x48
  7a0ff4: f9400013     	ldr	x19, [x0]
  7a0ff8: f94017e0     	ldr	x0, [sp, #0x28]
  7a0ffc: f9402402     	ldr	x2, [x0, #0x48]
  7a1000: f94017e0     	ldr	x0, [sp, #0x28]
  7a1004: f9402400     	ldr	x0, [x0, #0x48]
  7a1008: f9400000     	ldr	x0, [x0]
  7a100c: 91010000     	add	x0, x0, #0x40
  7a1010: f9400001     	ldr	x1, [x0]
  7a1014: aa0203e0     	mov	x0, x2
  7a1018: d63f0020     	blr	x1
  7a101c: 11000400     	add	w0, w0, #0x1
  7a1020: 2a0003e1     	mov	w1, w0
  7a1024: aa1403e0     	mov	x0, x20
  7a1028: d63f0260     	blr	x19
  7a102c: d503201f     	nop
  7a1030: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7a1034: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7a1038: d65f03c0     	ret
  7a103c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a1040: 910003fd     	mov	x29, sp
  7a1044: f9000fe0     	str	x0, [sp, #0x18]
  7a1048: f9400fe0     	ldr	x0, [sp, #0x18]
  7a104c: f9400802     	ldr	x2, [x0, #0x10]
  7a1050: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1054: f9400800     	ldr	x0, [x0, #0x10]
  7a1058: f9400000     	ldr	x0, [x0]
  7a105c: 91010000     	add	x0, x0, #0x40
  7a1060: f9400001     	ldr	x1, [x0]
  7a1064: aa0203e0     	mov	x0, x2
  7a1068: d63f0020     	blr	x1
  7a106c: 12001c00     	and	w0, w0, #0xff
  7a1070: 52000000     	eor	w0, w0, #0x1
  7a1074: 12001c00     	and	w0, w0, #0xff
  7a1078: 7100001f     	cmp	w0, #0x0
  7a107c: 540001e0     	b.eq	0x7a10b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8738c>
  7a1080: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1084: f9400400     	ldr	x0, [x0, #0x8]
  7a1088: f100001f     	cmp	x0, #0x0
  7a108c: 54000160     	b.eq	0x7a10b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8738c>
  7a1090: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1094: f9400402     	ldr	x2, [x0, #0x8]
  7a1098: f9400fe0     	ldr	x0, [sp, #0x18]
  7a109c: f9400400     	ldr	x0, [x0, #0x8]
  7a10a0: f9400000     	ldr	x0, [x0]
  7a10a4: 91014000     	add	x0, x0, #0x50
  7a10a8: f9400001     	ldr	x1, [x0]
  7a10ac: aa0203e0     	mov	x0, x2
  7a10b0: d63f0020     	blr	x1
  7a10b4: 14000002     	b	0x7a10bc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87390>
  7a10b8: 52800000     	mov	w0, #0x0                // =0
  7a10bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a10c0: d65f03c0     	ret
  7a10c4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a10c8: 910003fd     	mov	x29, sp
  7a10cc: b9001fe0     	str	w0, [sp, #0x1c]
  7a10d0: b9001be1     	str	w1, [sp, #0x18]
  7a10d4: b9401fe0     	ldr	w0, [sp, #0x1c]
  7a10d8: 7100041f     	cmp	w0, #0x1
  7a10dc: 540013e1     	b.ne	0x7a1358 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8762c>
  7a10e0: b9401be1     	ldr	w1, [sp, #0x18]
  7a10e4: 529fffe0     	mov	w0, #0xffff             // =65535
  7a10e8: 6b00003f     	cmp	w1, w0
  7a10ec: 54001361     	b.ne	0x7a1358 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8762c>
  7a10f0: 52800004     	mov	w4, #0x0                // =0
  7a10f4: 52800003     	mov	w3, #0x0                // =0
  7a10f8: 52800002     	mov	w2, #0x0                // =0
  7a10fc: 12800001     	mov	w1, #-0x1               // =-1
  7a1100: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1104: 91302000     	add	x0, x0, #0xc08
  7a1108: 97f1c4b1     	bl	0x4123cc <.text+0x719c>
  7a110c: 12800004     	mov	w4, #-0x1               // =-1
  7a1110: 12800003     	mov	w3, #-0x1               // =-1
  7a1114: 12800002     	mov	w2, #-0x1               // =-1
  7a1118: 12800001     	mov	w1, #-0x1               // =-1
  7a111c: d001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a1120: 91304000     	add	x0, x0, #0xc10
  7a1124: 97f1c4aa     	bl	0x4123cc <.text+0x719c>
  7a1128: 52800004     	mov	w4, #0x0                // =0
  7a112c: 52800003     	mov	w3, #0x0                // =0
