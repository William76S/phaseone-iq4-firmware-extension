
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000007bbfc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_>:
  8338a4: a9a47bfd     	stp	x29, x30, [sp, #-0x1c0]!
  8338a8: 910003fd     	mov	x29, sp
  8338ac: a90153f3     	stp	x19, x20, [sp, #0x10]
  8338b0: f90017e0     	str	x0, [sp, #0x28]
  8338b4: f90013e1     	str	x1, [sp, #0x20]
  8338b8: f94013e4     	ldr	x4, [sp, #0x20]
  8338bc: 52800003     	mov	w3, #0x0                // =0
  8338c0: d0002b00     	adrp	x0, 0xd95000
  8338c4: 9122c002     	add	x2, x0, #0x8b0
  8338c8: 52800041     	mov	w1, #0x2                // =2
  8338cc: aa0403e0     	mov	x0, x4
  8338d0: 97fc3401     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8338d4: 12001c00     	and	w0, w0, #0xff
  8338d8: 7100001f     	cmp	w0, #0x0
  8338dc: 54000420     	b.eq	0x833960 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77998>
  8338e0: f94013e0     	ldr	x0, [sp, #0x20]
  8338e4: 52800002     	mov	w2, #0x0                // =0
  8338e8: 52800061     	mov	w1, #0x3                // =3
  8338ec: 97fc356f     	bl	0x740ea8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2717c>
  8338f0: b901a3e0     	str	w0, [sp, #0x1a0]
  8338f4: f94013e0     	ldr	x0, [sp, #0x20]
  8338f8: f9400000     	ldr	x0, [x0]
  8338fc: 91008000     	add	x0, x0, #0x20
  833900: f9400003     	ldr	x3, [x0]
  833904: b941a3e0     	ldr	w0, [sp, #0x1a0]
  833908: 7100001f     	cmp	w0, #0x0
  83390c: 54000080     	b.eq	0x83391c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77954>
  833910: d0002b00     	adrp	x0, 0xd95000
  833914: 91304000     	add	x0, x0, #0xc10
  833918: 14000003     	b	0x833924 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7795c>
  83391c: d0002b00     	adrp	x0, 0xd95000
  833920: 91306000     	add	x0, x0, #0xc18
  833924: aa0003e2     	mov	x2, x0
  833928: d0002b00     	adrp	x0, 0xd95000
  83392c: 91308001     	add	x1, x0, #0xc20
  833930: f94013e0     	ldr	x0, [sp, #0x20]
  833934: d63f0060     	blr	x3
  833938: f94017e0     	ldr	x0, [sp, #0x28]
  83393c: f9401802     	ldr	x2, [x0, #0x30]
  833940: b941a3e0     	ldr	w0, [sp, #0x1a0]
  833944: 7100001f     	cmp	w0, #0x0
  833948: 1a9f07e0     	cset	w0, ne
  83394c: 12001c00     	and	w0, w0, #0xff
  833950: 2a0003e1     	mov	w1, w0
  833954: aa0203e0     	mov	x0, x2
  833958: 97fda37c     	bl	0x79c748 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82a1c>
  83395c: 140017b3     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833960: f94013e4     	ldr	x4, [sp, #0x20]
  833964: 52800003     	mov	w3, #0x0                // =0
  833968: d0002b00     	adrp	x0, 0xd95000
  83396c: 9122e002     	add	x2, x0, #0x8b8
  833970: 52800041     	mov	w1, #0x2                // =2
  833974: aa0403e0     	mov	x0, x4
  833978: 97fc33d7     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  83397c: 12001c00     	and	w0, w0, #0xff
  833980: 7100001f     	cmp	w0, #0x0
  833984: 54000960     	b.eq	0x833ab0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77ae8>
  833988: f94013e0     	ldr	x0, [sp, #0x20]
  83398c: 12800002     	mov	w2, #-0x1               // =-1
  833990: 52800061     	mov	w1, #0x3                // =3
  833994: 97fc351c     	bl	0x740e04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x270d8>
  833998: b9019fe0     	str	w0, [sp, #0x19c]
  83399c: f94013e4     	ldr	x4, [sp, #0x20]
  8339a0: 52800003     	mov	w3, #0x0                // =0
  8339a4: d0002b00     	adrp	x0, 0xd95000
  8339a8: 9130e002     	add	x2, x0, #0xc38
  8339ac: 52800081     	mov	w1, #0x4                // =4
  8339b0: aa0403e0     	mov	x0, x4
  8339b4: 97fc33c8     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8339b8: 12001c00     	and	w0, w0, #0xff
  8339bc: 7100001f     	cmp	w0, #0x0
  8339c0: 54000161     	b.ne	0x8339ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77a24>
  8339c4: f94013e4     	ldr	x4, [sp, #0x20]
  8339c8: 52800023     	mov	w3, #0x1                // =1
  8339cc: d0002b00     	adrp	x0, 0xd95000
  8339d0: 91310002     	add	x2, x0, #0xc40
  8339d4: 52800081     	mov	w1, #0x4                // =4
  8339d8: aa0403e0     	mov	x0, x4
  8339dc: 97fc33be     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8339e0: 12001c00     	and	w0, w0, #0xff
  8339e4: 7100001f     	cmp	w0, #0x0
  8339e8: 54000060     	b.eq	0x8339f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77a2c>
  8339ec: 52800020     	mov	w0, #0x1                // =1
  8339f0: 14000002     	b	0x8339f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77a30>
  8339f4: 52800000     	mov	w0, #0x0                // =0
  8339f8: 39066fe0     	strb	w0, [sp, #0x19b]
  8339fc: b9419fe0     	ldr	w0, [sp, #0x19c]
  833a00: 3100041f     	cmn	w0, #0x1
  833a04: 54000440     	b.eq	0x833a8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77ac4>
  833a08: 39466fe0     	ldrb	w0, [sp, #0x19b]
  833a0c: 7100001f     	cmp	w0, #0x0
  833a10: 540001a0     	b.eq	0x833a44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77a7c>
  833a14: f94017e0     	ldr	x0, [sp, #0x28]
  833a18: f9401c03     	ldr	x3, [x0, #0x38]
  833a1c: f94017e0     	ldr	x0, [sp, #0x28]
  833a20: f9401c00     	ldr	x0, [x0, #0x38]
  833a24: f9400000     	ldr	x0, [x0]
  833a28: 91036000     	add	x0, x0, #0xd8
  833a2c: f9400002     	ldr	x2, [x0]
  833a30: b9419fe1     	ldr	w1, [sp, #0x19c]
  833a34: aa0303e0     	mov	x0, x3
  833a38: d63f0040     	blr	x2
  833a3c: 12001c00     	and	w0, w0, #0xff
  833a40: 14000006     	b	0x833a58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77a90>
  833a44: f94017e0     	ldr	x0, [sp, #0x28]
  833a48: f9401c00     	ldr	x0, [x0, #0x38]
  833a4c: b9419fe1     	ldr	w1, [sp, #0x19c]
  833a50: 97ff6a93     	bl	0x80e49c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x524d4>
  833a54: 12001c00     	and	w0, w0, #0xff
  833a58: 39066be0     	strb	w0, [sp, #0x19a]
  833a5c: f94013e0     	ldr	x0, [sp, #0x20]
  833a60: f9400000     	ldr	x0, [x0]
  833a64: 91008000     	add	x0, x0, #0x20
  833a68: f9400004     	ldr	x4, [x0]
  833a6c: 39466be0     	ldrb	w0, [sp, #0x19a]
  833a70: 2a0003e3     	mov	w3, w0
  833a74: b9419fe2     	ldr	w2, [sp, #0x19c]
  833a78: d0002b00     	adrp	x0, 0xd95000
  833a7c: 91312001     	add	x1, x0, #0xc48
  833a80: f94013e0     	ldr	x0, [sp, #0x20]
  833a84: d63f0080     	blr	x4
  833a88: 14001768     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833a8c: f94013e0     	ldr	x0, [sp, #0x20]
  833a90: f9400000     	ldr	x0, [x0]
  833a94: 91008000     	add	x0, x0, #0x20
  833a98: f9400002     	ldr	x2, [x0]
  833a9c: d0002b00     	adrp	x0, 0xd95000
  833aa0: 91318001     	add	x1, x0, #0xc60
  833aa4: f94013e0     	ldr	x0, [sp, #0x20]
  833aa8: d63f0040     	blr	x2
  833aac: 1400175f     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833ab0: f94013e4     	ldr	x4, [sp, #0x20]
  833ab4: 52800003     	mov	w3, #0x0                // =0
  833ab8: d0002b00     	adrp	x0, 0xd95000
  833abc: 91230002     	add	x2, x0, #0x8c0
  833ac0: 52800041     	mov	w1, #0x2                // =2
  833ac4: aa0403e0     	mov	x0, x4
  833ac8: 97fc3383     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833acc: 12001c00     	and	w0, w0, #0xff
  833ad0: 7100001f     	cmp	w0, #0x0
  833ad4: 54000260     	b.eq	0x833b20 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77b58>
  833ad8: f94017e0     	ldr	x0, [sp, #0x28]
  833adc: f9401c02     	ldr	x2, [x0, #0x38]
  833ae0: f94017e0     	ldr	x0, [sp, #0x28]
  833ae4: f9401c00     	ldr	x0, [x0, #0x38]
  833ae8: f9400000     	ldr	x0, [x0]
  833aec: 9102e000     	add	x0, x0, #0xb8
  833af0: f9400001     	ldr	x1, [x0]
  833af4: aa0203e0     	mov	x0, x2
  833af8: d63f0020     	blr	x1
  833afc: f94013e0     	ldr	x0, [sp, #0x20]
  833b00: f9400000     	ldr	x0, [x0]
  833b04: 91008000     	add	x0, x0, #0x20
  833b08: f9400002     	ldr	x2, [x0]
  833b0c: d0002b00     	adrp	x0, 0xd95000
  833b10: 9131e001     	add	x1, x0, #0xc78
  833b14: f94013e0     	ldr	x0, [sp, #0x20]
  833b18: d63f0040     	blr	x2
  833b1c: 14001743     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833b20: f94013e4     	ldr	x4, [sp, #0x20]
  833b24: 52800003     	mov	w3, #0x0                // =0
  833b28: d0002b00     	adrp	x0, 0xd95000
  833b2c: 91232002     	add	x2, x0, #0x8c8
  833b30: 52800041     	mov	w1, #0x2                // =2
  833b34: aa0403e0     	mov	x0, x4
  833b38: 97fc3367     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833b3c: 12001c00     	and	w0, w0, #0xff
  833b40: 7100001f     	cmp	w0, #0x0
  833b44: 54000a40     	b.eq	0x833c8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77cc4>
  833b48: 9100c3e0     	add	x0, sp, #0x30
  833b4c: d2802001     	mov	x1, #0x100              // =256
  833b50: aa0103e2     	mov	x2, x1
  833b54: 52800001     	mov	w1, #0x0                // =0
  833b58: 97ef5992     	bl	0x40a1a0 <memset@plt>
  833b5c: f94017e0     	ldr	x0, [sp, #0x28]
  833b60: f9401800     	ldr	x0, [x0, #0x30]
  833b64: 94001d56     	bl	0x83b0bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f0f4>
  833b68: aa0003e4     	mov	x4, x0
  833b6c: f100009f     	cmp	x4, #0x0
  833b70: 54000120     	b.eq	0x833b94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77bcc>
  833b74: d2800003     	mov	x3, #0x0                // =0
  833b78: d0002ac0     	adrp	x0, 0xd8d000
  833b7c: 9119a002     	add	x2, x0, #0x668
  833b80: b0002ac0     	adrp	x0, 0xd8c000
  833b84: 91330001     	add	x1, x0, #0xcc0
  833b88: aa0403e0     	mov	x0, x4
  833b8c: 97ef5c91     	bl	0x40add0 <__dynamic_cast@plt>
  833b90: 14000002     	b	0x833b98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77bd0>
  833b94: d2800000     	mov	x0, #0x0                // =0
  833b98: f900cbe0     	str	x0, [sp, #0x190]
  833b9c: f940cbe0     	ldr	x0, [sp, #0x190]
  833ba0: f100001f     	cmp	x0, #0x0
  833ba4: 54000141     	b.ne	0x833bcc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77c04>
  833ba8: 528015c3     	mov	w3, #0xae               // =174
  833bac: d0002b00     	adrp	x0, 0xd95000
  833bb0: 91324002     	add	x2, x0, #0xc90
  833bb4: d0002b00     	adrp	x0, 0xd95000
  833bb8: 9132e001     	add	x1, x0, #0xcb8
  833bbc: d0002b00     	adrp	x0, 0xd95000
  833bc0: 91334000     	add	x0, x0, #0xcd0
  833bc4: 97ef5a6f     	bl	0x40a580 <printf@plt>
  833bc8: 97fce2d0     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  833bcc: 9100c3e0     	add	x0, sp, #0x30
  833bd0: d2802003     	mov	x3, #0x100              // =256
  833bd4: aa0003e2     	mov	x2, x0
  833bd8: 52800001     	mov	w1, #0x0                // =0
  833bdc: f940cbe0     	ldr	x0, [sp, #0x190]
  833be0: 97ff6cc0     	bl	0x80eee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x52f18>
  833be4: b901bfff     	str	wzr, [sp, #0x1bc]
  833be8: b981bfe0     	ldrsw	x0, [sp, #0x1bc]
  833bec: f103fc1f     	cmp	x0, #0xff
  833bf0: 540003c8     	b.hi	0x833c68 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77ca0>
  833bf4: b941bfe0     	ldr	w0, [sp, #0x1bc]
  833bf8: 12000c00     	and	w0, w0, #0xf
  833bfc: 7100001f     	cmp	w0, #0x0
  833c00: 54000141     	b.ne	0x833c28 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77c60>
  833c04: f94013e0     	ldr	x0, [sp, #0x20]
  833c08: f9400000     	ldr	x0, [x0]
  833c0c: 91008000     	add	x0, x0, #0x20
  833c10: f9400003     	ldr	x3, [x0]
  833c14: b941bfe2     	ldr	w2, [sp, #0x1bc]
  833c18: d0002b00     	adrp	x0, 0xd95000
  833c1c: 9133e001     	add	x1, x0, #0xcf8
  833c20: f94013e0     	ldr	x0, [sp, #0x20]
  833c24: d63f0060     	blr	x3
  833c28: f94013e0     	ldr	x0, [sp, #0x20]
  833c2c: f9400000     	ldr	x0, [x0]
  833c30: 91008000     	add	x0, x0, #0x20
  833c34: f9400003     	ldr	x3, [x0]
  833c38: b981bfe0     	ldrsw	x0, [sp, #0x1bc]
  833c3c: 9100c3e1     	add	x1, sp, #0x30
  833c40: 38606820     	ldrb	w0, [x1, x0]
  833c44: 2a0003e2     	mov	w2, w0
  833c48: d0002b00     	adrp	x0, 0xd95000
  833c4c: 91340001     	add	x1, x0, #0xd00
  833c50: f94013e0     	ldr	x0, [sp, #0x20]
  833c54: d63f0060     	blr	x3
  833c58: b941bfe0     	ldr	w0, [sp, #0x1bc]
  833c5c: 11000400     	add	w0, w0, #0x1
  833c60: b901bfe0     	str	w0, [sp, #0x1bc]
  833c64: 17ffffe1     	b	0x833be8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77c20>
  833c68: f94013e0     	ldr	x0, [sp, #0x20]
  833c6c: f9400000     	ldr	x0, [x0]
  833c70: 91008000     	add	x0, x0, #0x20
  833c74: f9400002     	ldr	x2, [x0]
  833c78: d0002b00     	adrp	x0, 0xd95000
  833c7c: 91342001     	add	x1, x0, #0xd08
  833c80: f94013e0     	ldr	x0, [sp, #0x20]
  833c84: d63f0040     	blr	x2
  833c88: 140016e8     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833c8c: f94013e4     	ldr	x4, [sp, #0x20]
  833c90: 52800003     	mov	w3, #0x0                // =0
  833c94: d0002b00     	adrp	x0, 0xd95000
  833c98: 91236002     	add	x2, x0, #0x8d8
  833c9c: 52800041     	mov	w1, #0x2                // =2
  833ca0: aa0403e0     	mov	x0, x4
  833ca4: 97fc330c     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833ca8: 12001c00     	and	w0, w0, #0xff
  833cac: 7100001f     	cmp	w0, #0x0
  833cb0: 54000b40     	b.eq	0x833e18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77e50>
  833cb4: 9100c3e0     	add	x0, sp, #0x30
  833cb8: d2802001     	mov	x1, #0x100              // =256
  833cbc: aa0103e2     	mov	x2, x1
  833cc0: 52800001     	mov	w1, #0x0                // =0
  833cc4: 97ef5937     	bl	0x40a1a0 <memset@plt>
  833cc8: f94017e0     	ldr	x0, [sp, #0x28]
  833ccc: f9401800     	ldr	x0, [x0, #0x30]
  833cd0: 94001cfb     	bl	0x83b0bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f0f4>
  833cd4: aa0003e4     	mov	x4, x0
  833cd8: f100009f     	cmp	x4, #0x0
  833cdc: 54000120     	b.eq	0x833d00 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77d38>
  833ce0: d2800003     	mov	x3, #0x0                // =0
  833ce4: d0002ac0     	adrp	x0, 0xd8d000
  833ce8: 9119a002     	add	x2, x0, #0x668
  833cec: b0002ac0     	adrp	x0, 0xd8c000
  833cf0: 91330001     	add	x1, x0, #0xcc0
  833cf4: aa0403e0     	mov	x0, x4
  833cf8: 97ef5c36     	bl	0x40add0 <__dynamic_cast@plt>
  833cfc: 14000002     	b	0x833d04 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77d3c>
  833d00: d2800000     	mov	x0, #0x0                // =0
  833d04: f900c7e0     	str	x0, [sp, #0x188]
  833d08: f940c7e0     	ldr	x0, [sp, #0x188]
  833d0c: f100001f     	cmp	x0, #0x0
  833d10: 54000141     	b.ne	0x833d38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77d70>
  833d14: 52801843     	mov	w3, #0xc2               // =194
  833d18: d0002b00     	adrp	x0, 0xd95000
  833d1c: 91324002     	add	x2, x0, #0xc90
  833d20: d0002b00     	adrp	x0, 0xd95000
  833d24: 9132e001     	add	x1, x0, #0xcb8
  833d28: d0002b00     	adrp	x0, 0xd95000
  833d2c: 91334000     	add	x0, x0, #0xcd0
  833d30: 97ef5a14     	bl	0x40a580 <printf@plt>
  833d34: 97fce275     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  833d38: 9100c3e0     	add	x0, sp, #0x30
  833d3c: d2802003     	mov	x3, #0x100              // =256
  833d40: aa0003e2     	mov	x2, x0
  833d44: 52800001     	mov	w1, #0x0                // =0
  833d48: f940c7e0     	ldr	x0, [sp, #0x188]
  833d4c: 97ff6c65     	bl	0x80eee0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x52f18>
  833d50: b901bbff     	str	wzr, [sp, #0x1b8]
  833d54: b981bbe0     	ldrsw	x0, [sp, #0x1b8]
  833d58: f103fc1f     	cmp	x0, #0xff
  833d5c: 5402d668     	b.hi	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833d60: b981bbe0     	ldrsw	x0, [sp, #0x1b8]
  833d64: 9100c3e1     	add	x1, sp, #0x30
  833d68: 38606833     	ldrb	w19, [x1, x0]
  833d6c: f940c7e0     	ldr	x0, [sp, #0x188]
  833d70: f9400000     	ldr	x0, [x0]
  833d74: 91036000     	add	x0, x0, #0xd8
  833d78: f9400002     	ldr	x2, [x0]
  833d7c: b941bbe0     	ldr	w0, [sp, #0x1b8]
  833d80: 2a0003e1     	mov	w1, w0
  833d84: f940c7e0     	ldr	x0, [sp, #0x188]
  833d88: d63f0040     	blr	x2
  833d8c: 12001c00     	and	w0, w0, #0xff
  833d90: 6b00027f     	cmp	w19, w0
  833d94: 1a9f07e0     	cset	w0, ne
  833d98: 39061fe0     	strb	w0, [sp, #0x187]
  833d9c: 39461fe0     	ldrb	w0, [sp, #0x187]
  833da0: 7100001f     	cmp	w0, #0x0
  833da4: 54000320     	b.eq	0x833e08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77e40>
  833da8: f94013e0     	ldr	x0, [sp, #0x20]
  833dac: f9400000     	ldr	x0, [x0]
  833db0: 91008000     	add	x0, x0, #0x20
  833db4: f9400013     	ldr	x19, [x0]
  833db8: b981bbe0     	ldrsw	x0, [sp, #0x1b8]
  833dbc: 9100c3e1     	add	x1, sp, #0x30
  833dc0: 38606820     	ldrb	w0, [x1, x0]
  833dc4: 2a0003f4     	mov	w20, w0
  833dc8: f940c7e0     	ldr	x0, [sp, #0x188]
  833dcc: f9400000     	ldr	x0, [x0]
  833dd0: 91036000     	add	x0, x0, #0xd8
  833dd4: f9400002     	ldr	x2, [x0]
  833dd8: b941bbe0     	ldr	w0, [sp, #0x1b8]
  833ddc: 2a0003e1     	mov	w1, w0
  833de0: f940c7e0     	ldr	x0, [sp, #0x188]
  833de4: d63f0040     	blr	x2
  833de8: 12001c00     	and	w0, w0, #0xff
  833dec: 2a0003e4     	mov	w4, w0
  833df0: 2a1403e3     	mov	w3, w20
  833df4: b941bbe2     	ldr	w2, [sp, #0x1b8]
  833df8: d0002b00     	adrp	x0, 0xd95000
  833dfc: 91344001     	add	x1, x0, #0xd10
  833e00: f94013e0     	ldr	x0, [sp, #0x20]
  833e04: d63f0260     	blr	x19
  833e08: b941bbe0     	ldr	w0, [sp, #0x1b8]
  833e0c: 11000400     	add	w0, w0, #0x1
  833e10: b901bbe0     	str	w0, [sp, #0x1b8]
  833e14: 17ffffd0     	b	0x833d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77d8c>
  833e18: f94013e4     	ldr	x4, [sp, #0x20]
  833e1c: 52800003     	mov	w3, #0x0                // =0
  833e20: d0002b00     	adrp	x0, 0xd95000
  833e24: 9123a002     	add	x2, x0, #0x8e8
  833e28: 52800041     	mov	w1, #0x2                // =2
  833e2c: aa0403e0     	mov	x0, x4
  833e30: 97fc32a9     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833e34: 12001c00     	and	w0, w0, #0xff
  833e38: 7100001f     	cmp	w0, #0x0
  833e3c: 54000460     	b.eq	0x833ec8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77f00>
  833e40: f94017e0     	ldr	x0, [sp, #0x28]
  833e44: f9401800     	ldr	x0, [x0, #0x30]
  833e48: 94001c9d     	bl	0x83b0bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f0f4>
  833e4c: aa0003e4     	mov	x4, x0
  833e50: f100009f     	cmp	x4, #0x0
  833e54: 54000120     	b.eq	0x833e78 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77eb0>
  833e58: d2800003     	mov	x3, #0x0                // =0
  833e5c: d0002ac0     	adrp	x0, 0xd8d000
  833e60: 91280002     	add	x2, x0, #0xa00
  833e64: b0002ac0     	adrp	x0, 0xd8c000
  833e68: 91330001     	add	x1, x0, #0xcc0
  833e6c: aa0403e0     	mov	x0, x4
  833e70: 97ef5bd8     	bl	0x40add0 <__dynamic_cast@plt>
  833e74: 14000002     	b	0x833e7c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77eb4>
  833e78: d2800000     	mov	x0, #0x0                // =0
  833e7c: f900bfe0     	str	x0, [sp, #0x178]
  833e80: f940bfe0     	ldr	x0, [sp, #0x178]
  833e84: f100001f     	cmp	x0, #0x0
  833e88: 54000141     	b.ne	0x833eb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77ee8>
  833e8c: 52801a43     	mov	w3, #0xd2               // =210
  833e90: d0002b00     	adrp	x0, 0xd95000
  833e94: 91324002     	add	x2, x0, #0xc90
  833e98: d0002b00     	adrp	x0, 0xd95000
  833e9c: 91350001     	add	x1, x0, #0xd40
  833ea0: d0002b00     	adrp	x0, 0xd95000
  833ea4: 91334000     	add	x0, x0, #0xcd0
  833ea8: 97ef59b6     	bl	0x40a580 <printf@plt>
  833eac: 97fce217     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  833eb0: f940bfe0     	ldr	x0, [sp, #0x178]
  833eb4: f9400000     	ldr	x0, [x0]
  833eb8: f9400001     	ldr	x1, [x0]
  833ebc: f940bfe0     	ldr	x0, [sp, #0x178]
  833ec0: d63f0020     	blr	x1
  833ec4: 14001659     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833ec8: f94013e4     	ldr	x4, [sp, #0x20]
  833ecc: 52800003     	mov	w3, #0x0                // =0
  833ed0: d0002b00     	adrp	x0, 0xd95000
  833ed4: 9123e002     	add	x2, x0, #0x8f8
  833ed8: 52800041     	mov	w1, #0x2                // =2
  833edc: aa0403e0     	mov	x0, x4
  833ee0: 97fc327d     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833ee4: 12001c00     	and	w0, w0, #0xff
  833ee8: 7100001f     	cmp	w0, #0x0
  833eec: 54000780     	b.eq	0x833fdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78014>
  833ef0: f94013e0     	ldr	x0, [sp, #0x20]
  833ef4: 12800002     	mov	w2, #-0x1               // =-1
  833ef8: 52800061     	mov	w1, #0x3                // =3
  833efc: 97fc33c2     	bl	0x740e04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x270d8>
  833f00: b90177e0     	str	w0, [sp, #0x174]
  833f04: b94177e0     	ldr	w0, [sp, #0x174]
  833f08: 3100041f     	cmn	w0, #0x1
  833f0c: 54000560     	b.eq	0x833fb8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77ff0>
  833f10: f94013e0     	ldr	x0, [sp, #0x20]
  833f14: 12800002     	mov	w2, #-0x1               // =-1
  833f18: 52800081     	mov	w1, #0x4                // =4
  833f1c: 97fc33ba     	bl	0x740e04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x270d8>
  833f20: b90173e0     	str	w0, [sp, #0x170]
  833f24: b94173e0     	ldr	w0, [sp, #0x170]
  833f28: 12185c00     	and	w0, w0, #0xffffff00
  833f2c: 7100001f     	cmp	w0, #0x0
  833f30: 54000321     	b.ne	0x833f94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x77fcc>
  833f34: f94017e0     	ldr	x0, [sp, #0x28]
  833f38: f9401c04     	ldr	x4, [x0, #0x38]
  833f3c: f94017e0     	ldr	x0, [sp, #0x28]
  833f40: f9401c00     	ldr	x0, [x0, #0x38]
  833f44: f9400000     	ldr	x0, [x0]
  833f48: 91038000     	add	x0, x0, #0xe0
  833f4c: f9400003     	ldr	x3, [x0]
  833f50: b94173e0     	ldr	w0, [sp, #0x170]
  833f54: 12001c00     	and	w0, w0, #0xff
  833f58: 2a0003e2     	mov	w2, w0
  833f5c: b94177e1     	ldr	w1, [sp, #0x174]
  833f60: aa0403e0     	mov	x0, x4
  833f64: d63f0060     	blr	x3
  833f68: f94013e0     	ldr	x0, [sp, #0x20]
  833f6c: f9400000     	ldr	x0, [x0]
  833f70: 91008000     	add	x0, x0, #0x20
  833f74: f9400004     	ldr	x4, [x0]
  833f78: b94173e3     	ldr	w3, [sp, #0x170]
  833f7c: b94177e2     	ldr	w2, [sp, #0x174]
  833f80: d0002b00     	adrp	x0, 0xd95000
  833f84: 91358001     	add	x1, x0, #0xd60
  833f88: f94013e0     	ldr	x0, [sp, #0x20]
  833f8c: d63f0080     	blr	x4
  833f90: 14001626     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833f94: f94013e0     	ldr	x0, [sp, #0x20]
  833f98: f9400000     	ldr	x0, [x0]
  833f9c: 91008000     	add	x0, x0, #0x20
  833fa0: f9400002     	ldr	x2, [x0]
  833fa4: d0002b00     	adrp	x0, 0xd95000
  833fa8: 9135e001     	add	x1, x0, #0xd78
  833fac: f94013e0     	ldr	x0, [sp, #0x20]
  833fb0: d63f0040     	blr	x2
  833fb4: 1400161d     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833fb8: f94013e0     	ldr	x0, [sp, #0x20]
  833fbc: f9400000     	ldr	x0, [x0]
  833fc0: 91008000     	add	x0, x0, #0x20
  833fc4: f9400002     	ldr	x2, [x0]
  833fc8: d0002b00     	adrp	x0, 0xd95000
  833fcc: 91318001     	add	x1, x0, #0xc60
  833fd0: f94013e0     	ldr	x0, [sp, #0x20]
  833fd4: d63f0040     	blr	x2
  833fd8: 14001614     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  833fdc: f94013e4     	ldr	x4, [sp, #0x20]
  833fe0: 52800003     	mov	w3, #0x0                // =0
  833fe4: d0002b00     	adrp	x0, 0xd95000
  833fe8: 91240002     	add	x2, x0, #0x900
  833fec: 52800041     	mov	w1, #0x2                // =2
  833ff0: aa0403e0     	mov	x0, x4
  833ff4: 97fc3238     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  833ff8: 12001c00     	and	w0, w0, #0xff
  833ffc: 7100001f     	cmp	w0, #0x0
  834000: 54000420     	b.eq	0x834084 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x780bc>
  834004: f94013e0     	ldr	x0, [sp, #0x20]
  834008: 12800002     	mov	w2, #-0x1               // =-1
  83400c: 52800061     	mov	w1, #0x3                // =3
  834010: 97fc337d     	bl	0x740e04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x270d8>
  834014: b9016fe0     	str	w0, [sp, #0x16c]
  834018: b9416fe0     	ldr	w0, [sp, #0x16c]
  83401c: 3100041f     	cmn	w0, #0x1
  834020: 54000200     	b.eq	0x834060 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78098>
  834024: f94017e0     	ldr	x0, [sp, #0x28]
  834028: f9401c00     	ldr	x0, [x0, #0x38]
  83402c: b9416fe1     	ldr	w1, [sp, #0x16c]
  834030: 12001c21     	and	w1, w1, #0xff
  834034: 94001c28     	bl	0x83b0d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f10c>
  834038: f94013e0     	ldr	x0, [sp, #0x20]
  83403c: f9400000     	ldr	x0, [x0]
  834040: 91008000     	add	x0, x0, #0x20
  834044: f9400003     	ldr	x3, [x0]
  834048: b9416fe2     	ldr	w2, [sp, #0x16c]
  83404c: b0002b00     	adrp	x0, 0xd95000
  834050: 91368001     	add	x1, x0, #0xda0
  834054: f94013e0     	ldr	x0, [sp, #0x20]
  834058: d63f0060     	blr	x3
  83405c: 140015f3     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834060: f94013e0     	ldr	x0, [sp, #0x20]
  834064: f9400000     	ldr	x0, [x0]
  834068: 91008000     	add	x0, x0, #0x20
  83406c: f9400002     	ldr	x2, [x0]
  834070: b0002b00     	adrp	x0, 0xd95000
  834074: 91370001     	add	x1, x0, #0xdc0
  834078: f94013e0     	ldr	x0, [sp, #0x20]
  83407c: d63f0040     	blr	x2
  834080: 140015ea     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834084: f94013e4     	ldr	x4, [sp, #0x20]
  834088: 52800003     	mov	w3, #0x0                // =0
  83408c: b0002b00     	adrp	x0, 0xd95000
  834090: 91242002     	add	x2, x0, #0x908
  834094: 52800041     	mov	w1, #0x2                // =2
  834098: aa0403e0     	mov	x0, x4
  83409c: 97fc320e     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8340a0: 12001c00     	and	w0, w0, #0xff
  8340a4: 7100001f     	cmp	w0, #0x0
  8340a8: 54000d80     	b.eq	0x834258 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78290>
  8340ac: f94013e4     	ldr	x4, [sp, #0x20]
  8340b0: 52800003     	mov	w3, #0x0                // =0
  8340b4: b0002b00     	adrp	x0, 0xd95000
  8340b8: 9130e002     	add	x2, x0, #0xc38
  8340bc: 52800061     	mov	w1, #0x3                // =3
  8340c0: aa0403e0     	mov	x0, x4
  8340c4: 97fc3204     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8340c8: 12001c00     	and	w0, w0, #0xff
  8340cc: 3905afe0     	strb	w0, [sp, #0x16b]
  8340d0: f94013e0     	ldr	x0, [sp, #0x20]
  8340d4: f9400000     	ldr	x0, [x0]
  8340d8: 91008000     	add	x0, x0, #0x20
  8340dc: f9400002     	ldr	x2, [x0]
  8340e0: b0002b00     	adrp	x0, 0xd95000
  8340e4: 91376001     	add	x1, x0, #0xdd8
  8340e8: f94013e0     	ldr	x0, [sp, #0x20]
  8340ec: d63f0040     	blr	x2
  8340f0: f94017e0     	ldr	x0, [sp, #0x28]
  8340f4: f9402000     	ldr	x0, [x0, #0x40]
  8340f8: b9403400     	ldr	w0, [x0, #0x34]
  8340fc: 7100781f     	cmp	w0, #0x1e
  834100: 54000200     	b.eq	0x834140 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78178>
  834104: f94017e0     	ldr	x0, [sp, #0x28]
  834108: f9402000     	ldr	x0, [x0, #0x40]
  83410c: b9403400     	ldr	w0, [x0, #0x34]
  834110: 7100841f     	cmp	w0, #0x21
  834114: 54000160     	b.eq	0x834140 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78178>
  834118: f94017e0     	ldr	x0, [sp, #0x28]
  83411c: f9402000     	ldr	x0, [x0, #0x40]
  834120: b9403400     	ldr	w0, [x0, #0x34]
  834124: 71007c1f     	cmp	w0, #0x1f
  834128: 540000c0     	b.eq	0x834140 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78178>
  83412c: f94017e0     	ldr	x0, [sp, #0x28]
  834130: f9402000     	ldr	x0, [x0, #0x40]
  834134: b9403400     	ldr	w0, [x0, #0x34]
  834138: 7100801f     	cmp	w0, #0x20
  83413c: 54000061     	b.ne	0x834148 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78180>
  834140: 52800020     	mov	w0, #0x1                // =1
  834144: 14000002     	b	0x83414c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78184>
  834148: 52800000     	mov	w0, #0x0                // =0
  83414c: 3905abe0     	strb	w0, [sp, #0x16a]
  834150: b901b7ff     	str	wzr, [sp, #0x1b4]
  834154: 3945abe0     	ldrb	w0, [sp, #0x16a]
  834158: 7100001f     	cmp	w0, #0x0
  83415c: 54000060     	b.eq	0x834168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x781a0>
  834160: 52816000     	mov	w0, #0xb00              // =2816
  834164: 14000002     	b	0x83416c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x781a4>
  834168: 52804000     	mov	w0, #0x200              // =512
  83416c: b941b7e1     	ldr	w1, [sp, #0x1b4]
  834170: 6b01001f     	cmp	w0, w1
  834174: 5402b5a9     	b.ls	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834178: f94017e0     	ldr	x0, [sp, #0x28]
  83417c: f9401c03     	ldr	x3, [x0, #0x38]
  834180: f94017e0     	ldr	x0, [sp, #0x28]
  834184: f9401c00     	ldr	x0, [x0, #0x38]
  834188: f9400000     	ldr	x0, [x0]
  83418c: 91036000     	add	x0, x0, #0xd8
  834190: f9400002     	ldr	x2, [x0]
  834194: b941b7e1     	ldr	w1, [sp, #0x1b4]
  834198: aa0303e0     	mov	x0, x3
  83419c: d63f0040     	blr	x2
  8341a0: 12001c00     	and	w0, w0, #0xff
  8341a4: 3905a7e0     	strb	w0, [sp, #0x169]
  8341a8: f94017e0     	ldr	x0, [sp, #0x28]
  8341ac: f9401c00     	ldr	x0, [x0, #0x38]
  8341b0: b941b7e1     	ldr	w1, [sp, #0x1b4]
  8341b4: 97ff68ba     	bl	0x80e49c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x524d4>
  8341b8: 12001c00     	and	w0, w0, #0xff
  8341bc: 3906cfe0     	strb	w0, [sp, #0x1b3]
  8341c0: 3945afe0     	ldrb	w0, [sp, #0x16b]
  8341c4: 7100001f     	cmp	w0, #0x0
  8341c8: 54000060     	b.eq	0x8341d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7820c>
  8341cc: 3945a7e0     	ldrb	w0, [sp, #0x169]
  8341d0: 3906cfe0     	strb	w0, [sp, #0x1b3]
  8341d4: 3946cfe1     	ldrb	w1, [sp, #0x1b3]
  8341d8: 3945a7e0     	ldrb	w0, [sp, #0x169]
  8341dc: 6b00003f     	cmp	w1, w0
  8341e0: 540001a1     	b.ne	0x834214 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7824c>
  8341e4: f94013e0     	ldr	x0, [sp, #0x20]
  8341e8: f9400000     	ldr	x0, [x0]
  8341ec: 91008000     	add	x0, x0, #0x20
  8341f0: f9400004     	ldr	x4, [x0]
  8341f4: 3946cfe0     	ldrb	w0, [sp, #0x1b3]
  8341f8: 2a0003e3     	mov	w3, w0
  8341fc: b941b7e2     	ldr	w2, [sp, #0x1b4]
  834200: b0002b00     	adrp	x0, 0xd95000
  834204: 9137c001     	add	x1, x0, #0xdf0
  834208: f94013e0     	ldr	x0, [sp, #0x20]
  83420c: d63f0080     	blr	x4
  834210: 1400000e     	b	0x834248 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78280>
  834214: f94013e0     	ldr	x0, [sp, #0x20]
  834218: f9400000     	ldr	x0, [x0]
  83421c: 91008000     	add	x0, x0, #0x20
  834220: f9400005     	ldr	x5, [x0]
  834224: 3946cfe0     	ldrb	w0, [sp, #0x1b3]
  834228: 3945a7e1     	ldrb	w1, [sp, #0x169]
  83422c: 2a0103e4     	mov	w4, w1
  834230: 2a0003e3     	mov	w3, w0
  834234: b941b7e2     	ldr	w2, [sp, #0x1b4]
  834238: b0002b00     	adrp	x0, 0xd95000
  83423c: 91382001     	add	x1, x0, #0xe08
  834240: f94013e0     	ldr	x0, [sp, #0x20]
  834244: d63f00a0     	blr	x5
  834248: b941b7e0     	ldr	w0, [sp, #0x1b4]
  83424c: 11000400     	add	w0, w0, #0x1
  834250: b901b7e0     	str	w0, [sp, #0x1b4]
  834254: 17ffffc0     	b	0x834154 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7818c>
  834258: f94013e4     	ldr	x4, [sp, #0x20]
  83425c: 52800003     	mov	w3, #0x0                // =0
  834260: b0002b00     	adrp	x0, 0xd95000
  834264: 91244002     	add	x2, x0, #0x910
  834268: 52800041     	mov	w1, #0x2                // =2
  83426c: aa0403e0     	mov	x0, x4
  834270: 97fc3199     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  834274: 12001c00     	and	w0, w0, #0xff
  834278: 7100001f     	cmp	w0, #0x0
  83427c: 540003a0     	b.eq	0x8342f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78328>
  834280: f94013e0     	ldr	x0, [sp, #0x20]
  834284: 1e3e1000     	fmov	s0, #-1.00000000
  834288: 52800061     	mov	w1, #0x3                // =3
  83428c: 97fc3329     	bl	0x740f30 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x27204>
  834290: bd0167e0     	str	s0, [sp, #0x164]
  834294: bd4167e0     	ldr	s0, [sp, #0x164]
  834298: 1e202018     	fcmpe	s0, #0.0
  83429c: 54000145     	b.pl	0x8342c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x782fc>
  8342a0: f94013e0     	ldr	x0, [sp, #0x20]
  8342a4: f9400000     	ldr	x0, [x0]
  8342a8: 91008000     	add	x0, x0, #0x20
  8342ac: f9400002     	ldr	x2, [x0]
  8342b0: b0002b00     	adrp	x0, 0xd95000
  8342b4: 9138c001     	add	x1, x0, #0xe30
  8342b8: f94013e0     	ldr	x0, [sp, #0x20]
  8342bc: d63f0040     	blr	x2
  8342c0: 1400155a     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  8342c4: f94017e0     	ldr	x0, [sp, #0x28]
  8342c8: f9401c02     	ldr	x2, [x0, #0x38]
  8342cc: f94017e0     	ldr	x0, [sp, #0x28]
  8342d0: f9401c00     	ldr	x0, [x0, #0x38]
  8342d4: f9400000     	ldr	x0, [x0]
  8342d8: 91020000     	add	x0, x0, #0x80
  8342dc: f9400001     	ldr	x1, [x0]
  8342e0: bd4167e0     	ldr	s0, [sp, #0x164]
  8342e4: aa0203e0     	mov	x0, x2
  8342e8: d63f0020     	blr	x1
  8342ec: 1400154f     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  8342f0: f94013e4     	ldr	x4, [sp, #0x20]
  8342f4: 52800003     	mov	w3, #0x0                // =0
  8342f8: b0002b00     	adrp	x0, 0xd95000
  8342fc: 91246002     	add	x2, x0, #0x918
  834300: 52800041     	mov	w1, #0x2                // =2
  834304: aa0403e0     	mov	x0, x4
  834308: 97fc3173     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  83430c: 12001c00     	and	w0, w0, #0xff
  834310: 7100001f     	cmp	w0, #0x0
  834314: 54001220     	b.eq	0x834558 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78590>
  834318: f94013e0     	ldr	x0, [sp, #0x20]
  83431c: 12800002     	mov	w2, #-0x1               // =-1
  834320: 52800061     	mov	w1, #0x3                // =3
  834324: 97fc32e1     	bl	0x740ea8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2717c>
  834328: b901afe0     	str	w0, [sp, #0x1ac]
  83432c: f94013e0     	ldr	x0, [sp, #0x20]
  834330: 52800002     	mov	w2, #0x0                // =0
  834334: 52800081     	mov	w1, #0x4                // =4
  834338: 97fc32dc     	bl	0x740ea8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2717c>
  83433c: b901abe0     	str	w0, [sp, #0x1a8]
  834340: b941afe0     	ldr	w0, [sp, #0x1ac]
  834344: 3100041f     	cmn	w0, #0x1
  834348: 54000160     	b.eq	0x834374 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x783ac>
  83434c: b941afe0     	ldr	w0, [sp, #0x1ac]
  834350: 7100001f     	cmp	w0, #0x0
  834354: 54000100     	b.eq	0x834374 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x783ac>
  834358: b941abe0     	ldr	w0, [sp, #0x1a8]
  83435c: 7100001f     	cmp	w0, #0x0
  834360: 540000a1     	b.ne	0x834374 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x783ac>
  834364: b941afe0     	ldr	w0, [sp, #0x1ac]
  834368: b901abe0     	str	w0, [sp, #0x1a8]
  83436c: 52800020     	mov	w0, #0x1                // =1
  834370: b901afe0     	str	w0, [sp, #0x1ac]
  834374: f94013e4     	ldr	x4, [sp, #0x20]
  834378: 52800003     	mov	w3, #0x0                // =0
  83437c: b0002b00     	adrp	x0, 0xd95000
  834380: 91398002     	add	x2, x0, #0xe60
  834384: 52800061     	mov	w1, #0x3                // =3
  834388: aa0403e0     	mov	x0, x4
  83438c: 97fc3152     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  834390: 12001c00     	and	w0, w0, #0xff
  834394: 7100001f     	cmp	w0, #0x0
  834398: 540001c0     	b.eq	0x8343d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78408>
  83439c: f94017e0     	ldr	x0, [sp, #0x28]
  8343a0: f9401c00     	ldr	x0, [x0, #0x38]
  8343a4: 52800001     	mov	w1, #0x0                // =0
  8343a8: 94001b2c     	bl	0x83b058 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f090>
  8343ac: f94013e0     	ldr	x0, [sp, #0x20]
  8343b0: f9400000     	ldr	x0, [x0]
  8343b4: 91008000     	add	x0, x0, #0x20
  8343b8: f9400002     	ldr	x2, [x0]
  8343bc: b0002b00     	adrp	x0, 0xd95000
  8343c0: 9139a001     	add	x1, x0, #0xe68
  8343c4: f94013e0     	ldr	x0, [sp, #0x20]
  8343c8: d63f0040     	blr	x2
  8343cc: 14001517     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  8343d0: f94017e0     	ldr	x0, [sp, #0x28]
  8343d4: f9401c00     	ldr	x0, [x0, #0x38]
  8343d8: 52800021     	mov	w1, #0x1                // =1
  8343dc: 94001b1f     	bl	0x83b058 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7f090>
  8343e0: f94013e4     	ldr	x4, [sp, #0x20]
  8343e4: 52800003     	mov	w3, #0x0                // =0
  8343e8: b0002b00     	adrp	x0, 0xd95000
  8343ec: 913a6002     	add	x2, x0, #0xe98
  8343f0: 52800061     	mov	w1, #0x3                // =3
  8343f4: aa0403e0     	mov	x0, x4
  8343f8: 97fc3137     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8343fc: 12001c00     	and	w0, w0, #0xff
  834400: 7100001f     	cmp	w0, #0x0
  834404: 54000060     	b.eq	0x834410 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78448>
  834408: 52800020     	mov	w0, #0x1                // =1
  83440c: b901afe0     	str	w0, [sp, #0x1ac]
  834410: b941afe0     	ldr	w0, [sp, #0x1ac]
  834414: 7100001f     	cmp	w0, #0x0
  834418: 54000400     	b.eq	0x834498 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x784d0>
  83441c: b941afe0     	ldr	w0, [sp, #0x1ac]
  834420: 7100101f     	cmp	w0, #0x4
  834424: 540003a8     	b.hi	0x834498 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x784d0>
  834428: b9013bff     	str	wzr, [sp, #0x138]
  83442c: f94017e0     	ldr	x0, [sp, #0x28]
  834430: f9401c05     	ldr	x5, [x0, #0x38]
  834434: f94017e0     	ldr	x0, [sp, #0x28]
  834438: f9401c00     	ldr	x0, [x0, #0x38]
  83443c: f9400000     	ldr	x0, [x0]
  834440: 9103c000     	add	x0, x0, #0xf0
  834444: f9400004     	ldr	x4, [x0]
  834448: 9104e3e0     	add	x0, sp, #0x138
  83444c: aa0003e3     	mov	x3, x0
  834450: b941abe2     	ldr	w2, [sp, #0x1a8]
  834454: b941afe1     	ldr	w1, [sp, #0x1ac]
  834458: aa0503e0     	mov	x0, x5
  83445c: d63f0080     	blr	x4
  834460: b901abe0     	str	w0, [sp, #0x1a8]
  834464: f94013e0     	ldr	x0, [sp, #0x20]
  834468: f9400000     	ldr	x0, [x0]
  83446c: 91008000     	add	x0, x0, #0x20
  834470: f9400005     	ldr	x5, [x0]
  834474: b9413be0     	ldr	w0, [sp, #0x138]
  834478: 2a0003e4     	mov	w4, w0
  83447c: b941abe3     	ldr	w3, [sp, #0x1a8]
  834480: b941afe2     	ldr	w2, [sp, #0x1ac]
  834484: b0002b00     	adrp	x0, 0xd95000
  834488: 913a8001     	add	x1, x0, #0xea0
  83448c: f94013e0     	ldr	x0, [sp, #0x20]
  834490: d63f00a0     	blr	x5
  834494: 140014e5     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834498: f94013e4     	ldr	x4, [sp, #0x20]
  83449c: 52800003     	mov	w3, #0x0                // =0
  8344a0: b0002b00     	adrp	x0, 0xd95000
  8344a4: 913b8002     	add	x2, x0, #0xee0
  8344a8: 52800061     	mov	w1, #0x3                // =3
  8344ac: aa0403e0     	mov	x0, x4
  8344b0: 97fc3109     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8344b4: 12001c00     	and	w0, w0, #0xff
  8344b8: 7100001f     	cmp	w0, #0x0
  8344bc: 54000081     	b.ne	0x8344cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78504>
  8344c0: b941afe0     	ldr	w0, [sp, #0x1ac]
  8344c4: 7100001f     	cmp	w0, #0x0
  8344c8: 54000061     	b.ne	0x8344d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7850c>
  8344cc: 52800020     	mov	w0, #0x1                // =1
  8344d0: 14000002     	b	0x8344d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78510>
  8344d4: 52800000     	mov	w0, #0x0                // =0
  8344d8: 7100001f     	cmp	w0, #0x0
  8344dc: 540002c0     	b.eq	0x834534 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7856c>
  8344e0: f94017e0     	ldr	x0, [sp, #0x28]
  8344e4: f9401c05     	ldr	x5, [x0, #0x38]
  8344e8: f94017e0     	ldr	x0, [sp, #0x28]
  8344ec: f9401c00     	ldr	x0, [x0, #0x38]
  8344f0: f9400000     	ldr	x0, [x0]
  8344f4: 9103c000     	add	x0, x0, #0xf0
  8344f8: f9400004     	ldr	x4, [x0]
  8344fc: d2800003     	mov	x3, #0x0                // =0
  834500: 52800002     	mov	w2, #0x0                // =0
  834504: 52800001     	mov	w1, #0x0                // =0
  834508: aa0503e0     	mov	x0, x5
  83450c: d63f0080     	blr	x4
  834510: f94013e0     	ldr	x0, [sp, #0x20]
  834514: f9400000     	ldr	x0, [x0]
  834518: 91008000     	add	x0, x0, #0x20
  83451c: f9400002     	ldr	x2, [x0]
  834520: b0002b00     	adrp	x0, 0xd95000
  834524: 913ba001     	add	x1, x0, #0xee8
  834528: f94013e0     	ldr	x0, [sp, #0x20]
  83452c: d63f0040     	blr	x2
  834530: 140014be     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834534: f94013e0     	ldr	x0, [sp, #0x20]
  834538: f9400000     	ldr	x0, [x0]
  83453c: 91008000     	add	x0, x0, #0x20
  834540: f9400002     	ldr	x2, [x0]
  834544: b0002b00     	adrp	x0, 0xd95000
  834548: 913c2001     	add	x1, x0, #0xf08
  83454c: f94013e0     	ldr	x0, [sp, #0x20]
  834550: d63f0040     	blr	x2
  834554: 140014b5     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834558: f94013e4     	ldr	x4, [sp, #0x20]
  83455c: 52800003     	mov	w3, #0x0                // =0
  834560: b0002b00     	adrp	x0, 0xd95000
  834564: 9124a002     	add	x2, x0, #0x928
  834568: 52800041     	mov	w1, #0x2                // =2
  83456c: aa0403e0     	mov	x0, x4
  834570: 97fc30d9     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  834574: 12001c00     	and	w0, w0, #0xff
  834578: 7100001f     	cmp	w0, #0x0
  83457c: 540002e0     	b.eq	0x8345d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78610>
  834580: f94013e0     	ldr	x0, [sp, #0x20]
  834584: 12800002     	mov	w2, #-0x1               // =-1
  834588: 52800061     	mov	w1, #0x3                // =3
  83458c: 97fc3247     	bl	0x740ea8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2717c>
  834590: b90163e0     	str	w0, [sp, #0x160]
  834594: b94163e0     	ldr	w0, [sp, #0x160]
  834598: 3100041f     	cmn	w0, #0x1
  83459c: 54000141     	b.ne	0x8345c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x785fc>
  8345a0: f94013e0     	ldr	x0, [sp, #0x20]
  8345a4: f9400000     	ldr	x0, [x0]
  8345a8: 91008000     	add	x0, x0, #0x20
  8345ac: f9400002     	ldr	x2, [x0]
  8345b0: b0002b00     	adrp	x0, 0xd95000
  8345b4: 913c8001     	add	x1, x0, #0xf20
  8345b8: f94013e0     	ldr	x0, [sp, #0x20]
  8345bc: d63f0040     	blr	x2
  8345c0: 1400149a     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  8345c4: f94017e0     	ldr	x0, [sp, #0x28]
  8345c8: f9401c00     	ldr	x0, [x0, #0x38]
  8345cc: b94163e1     	ldr	w1, [sp, #0x160]
  8345d0: 97ff672e     	bl	0x80e288 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x522c0>
  8345d4: 14001495     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  8345d8: f94013e4     	ldr	x4, [sp, #0x20]
  8345dc: 52800003     	mov	w3, #0x0                // =0
  8345e0: b0002b00     	adrp	x0, 0xd95000
  8345e4: 9124c002     	add	x2, x0, #0x930
  8345e8: 52800041     	mov	w1, #0x2                // =2
  8345ec: aa0403e0     	mov	x0, x4
  8345f0: 97fc30b9     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  8345f4: 12001c00     	and	w0, w0, #0xff
  8345f8: 7100001f     	cmp	w0, #0x0
  8345fc: 540000c0     	b.eq	0x834614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7864c>
  834600: f94017e0     	ldr	x0, [sp, #0x28]
  834604: f9401c00     	ldr	x0, [x0, #0x38]
  834608: f94013e1     	ldr	x1, [sp, #0x20]
  83460c: 97ff6adc     	bl	0x80f17c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x531b4>
  834610: 14001486     	b	0x839828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x7d860>
  834614: f94013e4     	ldr	x4, [sp, #0x20]
  834618: 52800003     	mov	w3, #0x0                // =0
  83461c: b0002b00     	adrp	x0, 0xd95000
  834620: 9124e002     	add	x2, x0, #0x938
  834624: 52800041     	mov	w1, #0x2                // =2
  834628: aa0403e0     	mov	x0, x4
  83462c: 97fc30aa     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  834630: 12001c00     	and	w0, w0, #0xff
  834634: 7100001f     	cmp	w0, #0x0
  834638: 54000940     	b.eq	0x834760 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x78798>
  83463c: f94013e0     	ldr	x0, [sp, #0x20]
