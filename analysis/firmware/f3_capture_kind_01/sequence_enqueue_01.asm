
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7979d8: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  7979dc: 910003fd     	mov	x29, sp
  7979e0: a90153f3     	stp	x19, x20, [sp, #0x10]
  7979e4: 2a0203f4     	mov	w20, w2
  7979e8: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7979ec: 2a0403f6     	mov	w22, w4
  7979f0: 2a0303f5     	mov	w21, w3
  7979f4: a90363f7     	stp	x23, x24, [sp, #0x30]
  7979f8: aa0003f7     	mov	x23, x0
  7979fc: a9046bf9     	stp	x25, x26, [sp, #0x40]
  797a00: b962d406     	ldr	w6, [x0, #0x22d4]
  797a04: f9400024     	ldr	x4, [x1]
  797a08: f9505400     	ldr	x0, [x0, #0x20a8]
  797a0c: 34001a26     	cbz	w6, 0x797d50 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7e024>
  797a10: b962d2e7     	ldr	w7, [x23, #0x22d0]
  797a14: 52800013     	mov	w19, #0x0               // =0
  797a18: 52800005     	mov	w5, #0x0                // =0
  797a1c: d37ff8e8     	lsl	x8, x7, #1
  797a20: f10010ff     	cmp	x7, #0x4
  797a24: 91002081     	add	x1, x4, #0x8
  797a28: 79401083     	ldrh	w3, [x4, #0x8]
  797a2c: 54000120     	b.eq	0x797a50 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd24>
  797a30: 8b080084     	add	x4, x4, x8
  797a34: d503201f     	nop
  797a38: 78402422     	ldrh	w2, [x1], #0x2
  797a3c: 6b03005f     	cmp	w2, w3
  797a40: 2a0203e3     	mov	w3, w2
  797a44: 1a930673     	cinc	w19, w19, ne
  797a48: eb04003f     	cmp	x1, x4
  797a4c: 54ffff61     	b.ne	0x797a38 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd0c>
  797a50: 110004a5     	add	w5, w5, #0x1
  797a54: aa0103e4     	mov	x4, x1
  797a58: 6b0600bf     	cmp	w5, w6
  797a5c: 54fffe21     	b.ne	0x797a20 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dcf4>
  797a60: 914022f8     	add	x24, x23, #0x8, lsl #12 // =0x8000
  797a64: 52800002     	mov	w2, #0x0                // =0
  797a68: 2a1303e1     	mov	w1, w19
  797a6c: 97ffc259     	bl	0x7883d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6e6a4>
  797a70: 2a0003fa     	mov	w26, w0
  797a74: d282b208     	mov	x8, #0x1590             // =5520
  797a78: f9407f00     	ldr	x0, [x24, #0xf8]
  797a7c: 8b080000     	add	x0, x0, x8
  797a80: 39430000     	ldrb	w0, [x0, #0xc0]
  797a84: 34000400     	cbz	w0, 0x797b04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7ddd8>
  797a88: 34000133     	cbz	w19, 0x797aac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd80>
  797a8c: 71000adf     	cmp	w22, #0x2
  797a90: 54000920     	b.eq	0x797bb4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7de88>
  797a94: f9407f01     	ldr	x1, [x24, #0xf8]
  797a98: d2828004     	mov	x4, #0x1400             // =5120
  797a9c: b9013315     	str	w21, [x24, #0x130]
  797aa0: 8b040020     	add	x0, x1, x4
  797aa4: b9013714     	str	w20, [x24, #0x134]
  797aa8: 14000007     	b	0x797ac4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd98>
  797aac: f9407f01     	ldr	x1, [x24, #0xf8]
  797ab0: d2828003     	mov	x3, #0x1400             // =5120
  797ab4: 8b030020     	add	x0, x1, x3
  797ab8: 52800013     	mov	w19, #0x0               // =0
  797abc: b9013315     	str	w21, [x24, #0x130]
  797ac0: b9013714     	str	w20, [x24, #0x134]
  797ac4: b9417800     	ldr	w0, [x0, #0x178]
  797ac8: 7100041f     	cmp	w0, #0x1
  797acc: 54000081     	b.ne	0x797adc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7ddb0>
  797ad0: b9556820     	ldr	w0, [x1, #0x1568]
  797ad4: 6b1a001f     	cmp	w0, w26
  797ad8: 540012a0     	b.eq	0x797d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7e000>
  797adc: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  797ae0: d2829602     	mov	x2, #0x14b0             // =5296
  797ae4: a94363f7     	ldp	x23, x24, [sp, #0x30]
  797ae8: b915683a     	str	w26, [x1, #0x1568]
  797aec: b9156c33     	str	w19, [x1, #0x156c]
  797af0: 8b020020     	add	x0, x1, x2
  797af4: a94153f3     	ldp	x19, x20, [sp, #0x10]
  797af8: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  797afc: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  797b00: 17fdddfe     	b	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  797b04: a90573fb     	stp	x27, x28, [sp, #0x50]
  797b08: 90002efb     	adrp	x27, 0xd73000
  797b0c: 90002ef9     	adrp	x25, 0xd73000
  797b10: 9123837b     	add	x27, x27, #0x8e0
  797b14: 9110a339     	add	x25, x25, #0x428
  797b18: aa1b03e2     	mov	x2, x27
  797b1c: aa1903e0     	mov	x0, x25
  797b20: 52821a41     	mov	w1, #0x10d2             // =4306
  797b24: 97feba5e     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797b28: aa1903e0     	mov	x0, x25
  797b2c: 52821a61     	mov	w1, #0x10d3             // =4307
  797b30: 90002ee2     	adrp	x2, 0xd73000
  797b34: 91240042     	add	x2, x2, #0x900
  797b38: 97feba59     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797b3c: aa1b03e2     	mov	x2, x27
  797b40: aa1903e0     	mov	x0, x25
  797b44: 52821a81     	mov	w1, #0x10d4             // =4308
  797b48: 97feba55     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797b4c: 52800001     	mov	w1, #0x0                // =0
  797b50: 52800020     	mov	w0, #0x1                // =1
  797b54: 97ffc28d     	bl	0x788588 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6e85c>
  797b58: aa1b03e2     	mov	x2, x27
  797b5c: aa1903e0     	mov	x0, x25
  797b60: 52821ac1     	mov	w1, #0x10d6             // =4310
  797b64: 97feba4e     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797b68: aa1b03e2     	mov	x2, x27
  797b6c: aa1903e0     	mov	x0, x25
  797b70: 52821ae1     	mov	w1, #0x10d7             // =4311
  797b74: 97feba4a     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797b78: 71000adf     	cmp	w22, #0x2
  797b7c: 90002ee0     	adrp	x0, 0xd73000
  797b80: 90002ee4     	adrp	x4, 0xd73000
  797b84: 91232000     	add	x0, x0, #0x8c8
  797b88: 9122a084     	add	x4, x4, #0x8a8
  797b8c: aa1903e1     	mov	x1, x25
  797b90: 9a800084     	csel	x4, x4, x0, eq
  797b94: 90002ee3     	adrp	x3, 0xd73000
  797b98: 52821b22     	mov	w2, #0x10d9             // =4313
  797b9c: 91246063     	add	x3, x3, #0x918
  797ba0: 52800080     	mov	w0, #0x4                // =4
  797ba4: 97feba6a     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  797ba8: a94573fb     	ldp	x27, x28, [sp, #0x50]
  797bac: 35fff713     	cbnz	w19, 0x797a8c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd60>
  797bb0: 17ffffbf     	b	0x797aac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd80>
  797bb4: b96316e1     	ldr	w1, [x23, #0x2314]
  797bb8: 52800024     	mov	w4, #0x1                // =1
  797bbc: b9631ae2     	ldr	w2, [x23, #0x2318]
  797bc0: 2a0403e3     	mov	w3, w4
  797bc4: aa1703e0     	mov	x0, x23
  797bc8: 97ffede2     	bl	0x793350 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79624>
  797bcc: 914042e2     	add	x2, x23, #0x10, lsl #12 // =0x10000
  797bd0: d2848007     	mov	x7, #0x2400             // =9216
  797bd4: 8b0702e1     	add	x1, x23, x7
  797bd8: f9504ee4     	ldr	x4, [x23, #0x2098]
  797bdc: b9496840     	ldr	w0, [x2, #0x968]
  797be0: f8514025     	ldur	x5, [x1, #-0xec]
  797be4: 11000403     	add	w3, w0, #0x1
  797be8: 7101dc1f     	cmp	w0, #0x77
  797bec: 54000069     	b.ls	0x797bf8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7decc>
  797bf0: 52800023     	mov	w3, #0x1                // =1
  797bf4: 52800000     	mov	w0, #0x0                // =0
  797bf8: d37c7c00     	ubfiz	x0, x0, #4, #32
  797bfc: aa0403e1     	mov	x1, x4
  797c00: 8b0002e0     	add	x0, x23, x0
  797c04: 91404000     	add	x0, x0, #0x10, lsl #12  // =0x10000
  797c08: a91e9404     	stp	x4, x5, [x0, #0x1e8]
  797c0c: b9096843     	str	w3, [x2, #0x968]
  797c10: f9504ae0     	ldr	x0, [x23, #0x2090]
  797c14: 9404b735     	bl	0x8c58e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f0bc>
  797c18: f9104eff     	str	xzr, [x23, #0x2098]
  797c1c: d2828006     	mov	x6, #0x1400             // =5120
  797c20: f9407f01     	ldr	x1, [x24, #0xf8]
  797c24: 8b060020     	add	x0, x1, x6
  797c28: 39494002     	ldrb	w2, [x0, #0x250]
  797c2c: 35fff4c2     	cbnz	w2, 0x797ac4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dd98>
  797c30: 90002ef4     	adrp	x20, 0xd73000
  797c34: 90002ef9     	adrp	x25, 0xd73000
  797c38: 91238294     	add	x20, x20, #0x8e0
  797c3c: 9110a339     	add	x25, x25, #0x428
  797c40: aa1403e3     	mov	x3, x20
  797c44: aa1903e1     	mov	x1, x25
  797c48: 52821d62     	mov	w2, #0x10eb             // =4331
  797c4c: 52800080     	mov	w0, #0x4                // =4
  797c50: a90573fb     	stp	x27, x28, [sp, #0x50]
  797c54: 97feba3e     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  797c58: aa1903e1     	mov	x1, x25
  797c5c: 52821d82     	mov	w2, #0x10ec             // =4332
  797c60: 52800080     	mov	w0, #0x4                // =4
  797c64: 90002ee3     	adrp	x3, 0xd73000
  797c68: 9124e063     	add	x3, x3, #0x938
  797c6c: 97feba38     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  797c70: 52816016     	mov	w22, #0xb00             // =2816
  797c74: aa1403e3     	mov	x3, x20
  797c78: aa1903e1     	mov	x1, x25
  797c7c: 52800080     	mov	w0, #0x4                // =4
  797c80: 52821da2     	mov	w2, #0x10ed             // =4333
  797c84: 97feba32     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  797c88: 90002efb     	adrp	x27, 0xd73000
  797c8c: f95062e0     	ldr	x0, [x23, #0x20c0]
  797c90: 52804001     	mov	w1, #0x200              // =512
  797c94: 90002efc     	adrp	x28, 0xd73000
  797c98: 9125a37b     	add	x27, x27, #0x968
  797c9c: 9125439c     	add	x28, x28, #0x950
  797ca0: 52800014     	mov	w20, #0x0               // =0
  797ca4: b9403400     	ldr	w0, [x0, #0x34]
  797ca8: 51007800     	sub	w0, w0, #0x1e
  797cac: 71000c1f     	cmp	w0, #0x3
  797cb0: 1a8192d6     	csel	w22, w22, w1, ls
  797cb4: 1400000a     	b	0x797cdc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dfb0>
  797cb8: 2a1503e5     	mov	w5, w21
  797cbc: 2a1403e3     	mov	w3, w20
  797cc0: aa1b03e2     	mov	x2, x27
  797cc4: 52821f81     	mov	w1, #0x10fc             // =4348
  797cc8: aa1903e0     	mov	x0, x25
  797ccc: 97feb9f4     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797cd0: 11000694     	add	w20, w20, #0x1
  797cd4: 6b1402df     	cmp	w22, w20
  797cd8: 54000560     	b.eq	0x797d84 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7e058>
  797cdc: f95066e2     	ldr	x2, [x23, #0x20c8]
  797ce0: 2a1403e1     	mov	w1, w20
  797ce4: aa0203e0     	mov	x0, x2
  797ce8: f9400042     	ldr	x2, [x2]
  797cec: f9406c42     	ldr	x2, [x2, #0xd8]
  797cf0: d63f0040     	blr	x2
  797cf4: 12001c15     	and	w21, w0, #0xff
  797cf8: f95066e0     	ldr	x0, [x23, #0x20c8]
  797cfc: 2a1403e1     	mov	w1, w20
  797d00: 9401d9e7     	bl	0x80e49c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x524d4>
  797d04: 12001c04     	and	w4, w0, #0xff
  797d08: 6b0402bf     	cmp	w21, w4
  797d0c: 54fffd61     	b.ne	0x797cb8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7df8c>
  797d10: 2a1503e4     	mov	w4, w21
  797d14: 2a1403e3     	mov	w3, w20
  797d18: aa1c03e2     	mov	x2, x28
  797d1c: 52821f01     	mov	w1, #0x10f8             // =4344
  797d20: aa1903e0     	mov	x0, x25
  797d24: 97feb9de     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  797d28: 17ffffea     	b	0x797cd0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dfa4>
  797d2c: b9556c20     	ldr	w0, [x1, #0x156c]
