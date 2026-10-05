  492a38: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  492a3c: 910003fd     	mov	x29, sp
  492a40: f9000fe0     	str	x0, [sp, #0x18]
  492a44: f9000be1     	str	x1, [sp, #0x10]
  492a48: f9400fe0     	ldr	x0, [sp, #0x18]
  492a4c: f943c000     	ldr	x0, [x0, #0x780]
  492a50: 91076000     	add	x0, x0, #0x1d8
  492a54: 94000a7d     	bl	0x495448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f49c>
  492a58: b90033e0     	str	w0, [sp, #0x30]
  492a5c: 3900bfff     	strb	wzr, [sp, #0x2f]
  492a60: 52800020     	mov	w0, #0x1                // =1
  492a64: 3900bbe0     	strb	w0, [sp, #0x2e]
  492a68: f9001fff     	str	xzr, [sp, #0x38]
  492a6c: b90037ff     	str	wzr, [sp, #0x34]
  492a70: b98037e0     	ldrsw	x0, [sp, #0x34]
  492a74: f100141f     	cmp	x0, #0x5
  492a78: 540002a8     	b.hi	0x492acc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb20>
  492a7c: 90003760     	adrp	x0, 0xb7e000
  492a80: 91234001     	add	x1, x0, #0x8d0
  492a84: b98037e0     	ldrsw	x0, [sp, #0x34]
  492a88: d37df000     	lsl	x0, x0, #3
  492a8c: 8b000020     	add	x0, x1, x0
  492a90: b9400000     	ldr	w0, [x0]
  492a94: b94033e1     	ldr	w1, [sp, #0x30]
  492a98: 6b00003f     	cmp	w1, w0
  492a9c: 54000101     	b.ne	0x492abc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb10>
  492aa0: b98037e0     	ldrsw	x0, [sp, #0x34]
  492aa4: d37df001     	lsl	x1, x0, #3
  492aa8: 90003760     	adrp	x0, 0xb7e000
  492aac: 91234000     	add	x0, x0, #0x8d0
  492ab0: 8b000020     	add	x0, x1, x0
  492ab4: f9001fe0     	str	x0, [sp, #0x38]
  492ab8: 14000005     	b	0x492acc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb20>
  492abc: b94037e0     	ldr	w0, [sp, #0x34]
  492ac0: 11000400     	add	w0, w0, #0x1
  492ac4: b90037e0     	str	w0, [sp, #0x34]
  492ac8: 17ffffea     	b	0x492a70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cac4>
  492acc: f9401fe0     	ldr	x0, [sp, #0x38]
  492ad0: f100001f     	cmp	x0, #0x0
  492ad4: 540001a1     	b.ne	0x492b08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cb5c>
  492ad8: b94033e0     	ldr	w0, [sp, #0x30]
  492adc: 2a0003e4     	mov	w4, w0
  492ae0: 90003760     	adrp	x0, 0xb7e000
  492ae4: 91240003     	add	x3, x0, #0x900
  492ae8: 52802482     	mov	w2, #0x124              // =292
  492aec: 90003760     	adrp	x0, 0xb7e000
  492af0: 911e0001     	add	x1, x0, #0x780
  492af4: 52800040     	mov	w0, #0x2                // =2
  492af8: 940ace95     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  492afc: 90003760     	adrp	x0, 0xb7e000
  492b00: 91234000     	add	x0, x0, #0x8d0
  492b04: f9001fe0     	str	x0, [sp, #0x38]
  492b08: f9400fe0     	ldr	x0, [sp, #0x18]
  492b0c: f943c000     	ldr	x0, [x0, #0x780]
  492b10: 91076000     	add	x0, x0, #0x1d8
  492b14: 94000a5a     	bl	0x49547c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f4d0>
  492b18: aa0003e1     	mov	x1, x0
  492b1c: f9400be0     	ldr	x0, [sp, #0x10]
  492b20: eb01001f     	cmp	x0, x1
  492b24: 1a9f17e0     	cset	w0, eq
  492b28: 12001c00     	and	w0, w0, #0xff
  492b2c: 7100001f     	cmp	w0, #0x0
  492b30: 540003e0     	b.eq	0x492bac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc00>
  492b34: f9400fe0     	ldr	x0, [sp, #0x18]
  492b38: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492b3c: 7100001f     	cmp	w0, #0x0
  492b40: 540012c0     	b.eq	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492b44: f9401fe0     	ldr	x0, [sp, #0x38]
  492b48: 39401400     	ldrb	w0, [x0, #0x5]
  492b4c: 7100001f     	cmp	w0, #0x0
  492b50: 540000a0     	b.eq	0x492b64 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbb8>
  492b54: 52800081     	mov	w1, #0x4                // =4
  492b58: f9400fe0     	ldr	x0, [sp, #0x18]
  492b5c: 9400011e     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492b60: 14000004     	b	0x492b70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbc4>
  492b64: f9400fe0     	ldr	x0, [sp, #0x18]
  492b68: 52800081     	mov	w1, #0x4                // =4
  492b6c: 97ffe29b     	bl	0x48b5d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5562c>
  492b70: f9401fe0     	ldr	x0, [sp, #0x38]
  492b74: 39401800     	ldrb	w0, [x0, #0x6]
  492b78: 7100001f     	cmp	w0, #0x0
  492b7c: 54000100     	b.eq	0x492b9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cbf0>
  492b80: 52800203     	mov	w3, #0x10               // =16
  492b84: 52808002     	mov	w2, #0x400              // =1024
  492b88: 90003760     	adrp	x0, 0xb7e000
  492b8c: 91248001     	add	x1, x0, #0x920
  492b90: f9400fe0     	ldr	x0, [sp, #0x18]
  492b94: 94000281     	bl	0x493598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ec>
  492b98: 14000080     	b	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492b9c: 52800201     	mov	w1, #0x10               // =16
  492ba0: f9400fe0     	ldr	x0, [sp, #0x18]
  492ba4: 9400037c     	bl	0x493994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9e8>
  492ba8: 1400007c     	b	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492bac: f9400fe0     	ldr	x0, [sp, #0x18]
  492bb0: f943e402     	ldr	x2, [x0, #0x7c8]
  492bb4: f9400fe0     	ldr	x0, [sp, #0x18]
  492bb8: f943e400     	ldr	x0, [x0, #0x7c8]
  492bbc: f9400000     	ldr	x0, [x0]
  492bc0: 91010000     	add	x0, x0, #0x40
  492bc4: f9400001     	ldr	x1, [x0]
  492bc8: aa0203e0     	mov	x0, x2
  492bcc: d63f0020     	blr	x1
  492bd0: 12001c00     	and	w0, w0, #0xff
  492bd4: 7100001f     	cmp	w0, #0x0
  492bd8: 54000520     	b.eq	0x492c7c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccd0>
  492bdc: f9400fe0     	ldr	x0, [sp, #0x18]
  492be0: 395f6000     	ldrb	w0, [x0, #0x7d8]
  492be4: 52000000     	eor	w0, w0, #0x1
  492be8: 12001c00     	and	w0, w0, #0xff
  492bec: 7100001f     	cmp	w0, #0x0
  492bf0: 540005e0     	b.eq	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492bf4: f9400fe0     	ldr	x0, [sp, #0x18]
  492bf8: 97ffe0bf     	bl	0x48aef4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x54f48>
  492bfc: f9401fe0     	ldr	x0, [sp, #0x38]
  492c00: 39401000     	ldrb	w0, [x0, #0x4]
  492c04: 7100001f     	cmp	w0, #0x0
  492c08: 54000080     	b.eq	0x492c18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc6c>
  492c0c: 52800041     	mov	w1, #0x2                // =2
  492c10: f9400fe0     	ldr	x0, [sp, #0x18]
  492c14: 940000c4     	bl	0x492f24 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cf78>
  492c18: f9400fe0     	ldr	x0, [sp, #0x18]
  492c1c: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492c20: 7100001f     	cmp	w0, #0x0
  492c24: 54000240     	b.eq	0x492c6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccc0>
  492c28: f9401fe0     	ldr	x0, [sp, #0x38]
  492c2c: 39401400     	ldrb	w0, [x0, #0x5]
  492c30: 7100001f     	cmp	w0, #0x0
  492c34: 54000080     	b.eq	0x492c44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cc98>
  492c38: 52800081     	mov	w1, #0x4                // =4
  492c3c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c40: 940000e5     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492c44: f9401fe0     	ldr	x0, [sp, #0x38]
  492c48: 39401800     	ldrb	w0, [x0, #0x6]
  492c4c: 7100001f     	cmp	w0, #0x0
  492c50: 540000e0     	b.eq	0x492c6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ccc0>
  492c54: 52800203     	mov	w3, #0x10               // =16
  492c58: 52808002     	mov	w2, #0x400              // =1024
  492c5c: 90003760     	adrp	x0, 0xb7e000
  492c60: 91248001     	add	x1, x0, #0x920
  492c64: f9400fe0     	ldr	x0, [sp, #0x18]
  492c68: 9400024c     	bl	0x493598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ec>
  492c6c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c70: 52800021     	mov	w1, #0x1                // =1
  492c74: 391f6001     	strb	w1, [x0, #0x7d8]
  492c78: 1400000d     	b	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492c7c: f9400fe0     	ldr	x0, [sp, #0x18]
  492c80: 395f6000     	ldrb	w0, [x0, #0x7d8]
  492c84: 7100001f     	cmp	w0, #0x0
  492c88: 54000120     	b.eq	0x492cac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd00>
  492c8c: 52800201     	mov	w1, #0x10               // =16
  492c90: f9400fe0     	ldr	x0, [sp, #0x18]
  492c94: 94000340     	bl	0x493994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9e8>
  492c98: f9400fe0     	ldr	x0, [sp, #0x18]
  492c9c: 52800041     	mov	w1, #0x2                // =2
  492ca0: 97ffe24e     	bl	0x48b5d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5562c>
  492ca4: f9400fe0     	ldr	x0, [sp, #0x18]
  492ca8: 391f601f     	strb	wzr, [x0, #0x7d8]
  492cac: f9400fe0     	ldr	x0, [sp, #0x18]
  492cb0: f943cc02     	ldr	x2, [x0, #0x798]
  492cb4: f9400fe0     	ldr	x0, [sp, #0x18]
  492cb8: f943cc00     	ldr	x0, [x0, #0x798]
  492cbc: f9400000     	ldr	x0, [x0]
  492cc0: 91010000     	add	x0, x0, #0x40
  492cc4: f9400001     	ldr	x1, [x0]
  492cc8: aa0203e0     	mov	x0, x2
  492ccc: d63f0020     	blr	x1
  492cd0: 12001c00     	and	w0, w0, #0xff
  492cd4: 7100001f     	cmp	w0, #0x0
  492cd8: 54000480     	b.eq	0x492d68 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdbc>
  492cdc: f9400fe0     	ldr	x0, [sp, #0x18]
  492ce0: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492ce4: 52000000     	eor	w0, w0, #0x1
  492ce8: 12001c00     	and	w0, w0, #0xff
  492cec: 7100001f     	cmp	w0, #0x0
  492cf0: 54000540     	b.eq	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492cf4: f9401fe0     	ldr	x0, [sp, #0x38]
  492cf8: 39401400     	ldrb	w0, [x0, #0x5]
  492cfc: 7100001f     	cmp	w0, #0x0
  492d00: 54000180     	b.eq	0x492d30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd84>
  492d04: f9401fe0     	ldr	x0, [sp, #0x38]
  492d08: 39401000     	ldrb	w0, [x0, #0x4]
  492d0c: 7100001f     	cmp	w0, #0x0
  492d10: 540000a0     	b.eq	0x492d24 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd78>
  492d14: 52800081     	mov	w1, #0x4                // =4
  492d18: f9400fe0     	ldr	x0, [sp, #0x18]
  492d1c: 940000ae     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492d20: 14000004     	b	0x492d30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cd84>
  492d24: 52800081     	mov	w1, #0x4                // =4
  492d28: f9400fe0     	ldr	x0, [sp, #0x18]
  492d2c: 940000aa     	bl	0x492fd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d028>
  492d30: f9401fe0     	ldr	x0, [sp, #0x38]
  492d34: 39401800     	ldrb	w0, [x0, #0x6]
  492d38: 7100001f     	cmp	w0, #0x0
  492d3c: 540000e0     	b.eq	0x492d58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdac>
  492d40: 52800203     	mov	w3, #0x10               // =16
  492d44: 52808002     	mov	w2, #0x400              // =1024
  492d48: 90003760     	adrp	x0, 0xb7e000
  492d4c: 91248001     	add	x1, x0, #0x920
  492d50: f9400fe0     	ldr	x0, [sp, #0x18]
  492d54: 94000211     	bl	0x493598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d5ec>
  492d58: f9400fe0     	ldr	x0, [sp, #0x18]
  492d5c: 52800021     	mov	w1, #0x1                // =1
  492d60: 391ea001     	strb	w1, [x0, #0x7a8]
  492d64: 1400000d     	b	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492d68: f9400fe0     	ldr	x0, [sp, #0x18]
  492d6c: 395ea000     	ldrb	w0, [x0, #0x7a8]
  492d70: 7100001f     	cmp	w0, #0x0
  492d74: 54000120     	b.eq	0x492d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5cdec>
  492d78: 52800201     	mov	w1, #0x10               // =16
  492d7c: f9400fe0     	ldr	x0, [sp, #0x18]
  492d80: 94000305     	bl	0x493994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9e8>
  492d84: f9400fe0     	ldr	x0, [sp, #0x18]
  492d88: 52800081     	mov	w1, #0x4                // =4
  492d8c: 97ffe213     	bl	0x48b5d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5562c>
  492d90: f9400fe0     	ldr	x0, [sp, #0x18]
  492d94: 391ea01f     	strb	wzr, [x0, #0x7a8]
  492d98: f9400fe0     	ldr	x0, [sp, #0x18]
  492d9c: 97ffd347     	bl	0x487ab8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x51b0c>
  492da0: d503201f     	nop
  492da4: a8c47bfd     	ldp	x29, x30, [sp], #0x40
