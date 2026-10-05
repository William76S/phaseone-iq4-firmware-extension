
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000904660 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm>:
  963a28: d284e210     	mov	x16, #0x2710            // =10000
  963a2c: cb3063ff     	sub	sp, sp, x16
  963a30: a9057bfd     	stp	x29, x30, [sp, #0x50]
  963a34: 910143fd     	add	x29, sp, #0x50
  963a38: a90653f3     	stp	x19, x20, [sp, #0x60]
  963a3c: aa0403f3     	mov	x19, x4
  963a40: aa0003f4     	mov	x20, x0
  963a44: 6d0b27e8     	stp	d8, d9, [sp, #0xb0]
  963a48: 9e6700a9     	fmov	d9, x5
  963a4c: 6d0c2fea     	stp	d10, d11, [sp, #0xc0]
  963a50: 9e67006a     	fmov	d10, x3
  963a54: 9e6700cb     	fmov	d11, x6
  963a58: a9075bf5     	stp	x21, x22, [sp, #0x70]
  963a5c: a90863f7     	stp	x23, x24, [sp, #0x80]
  963a60: aa0103f7     	mov	x23, x1
  963a64: a9096bf9     	stp	x25, x26, [sp, #0x90]
  963a68: aa0203f9     	mov	x25, x2
  963a6c: a90a73fb     	stp	x27, x28, [sp, #0xa0]
  963a70: 6d0d37ec     	stp	d12, d13, [sp, #0xd0]
  963a74: 6d0e3fee     	stp	d14, d15, [sp, #0xe0]
  963a78: 97ffb780     	bl	0x951878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d218>
  963a7c: 394a4660     	ldrb	w0, [x19, #0x291]
  963a80: 34003e00     	cbz	w0, 0x964240 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fbe0>
  963a84: 9106a3e0     	add	x0, sp, #0x1a8
  963a88: 97fe82b2     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963a8c: 910803e0     	add	x0, sp, #0x200
  963a90: 97fe82b0     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963a94: bd400e60     	ldr	s0, [x19, #0xc]
  963a98: d0002320     	adrp	x0, 0xdc9000
  963a9c: fd423001     	ldr	d1, [x0, #0x460]
  963aa0: 1e20c000     	fabs	s0, s0
  963aa4: 1e22c000     	fcvt	d0, s0
  963aa8: 1e612010     	fcmpe	d0, d1
  963aac: 54003c4d     	b.le	0x964234 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fbd4>
  963ab0: 9106a3f8     	add	x24, sp, #0x1a8
  963ab4: 910803e0     	add	x0, sp, #0x200
  963ab8: 9e670008     	fmov	d8, x0
  963abc: bd400260     	ldr	s0, [x19]
  963ac0: 1e202018     	fcmpe	s0, #0.0
  963ac4: 54003929     	b.ls	0x9641e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb88>
  963ac8: b942c260     	ldr	w0, [x19, #0x2c0]
  963acc: 7100001f     	cmp	w0, #0x0
  963ad0: 540038cd     	b.le	0x9641e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb88>
  963ad4: b942c660     	ldr	w0, [x19, #0x2c4]
  963ad8: 7100001f     	cmp	w0, #0x0
  963adc: 5400386d     	b.le	0x9641e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb88>
  963ae0: f940d680     	ldr	x0, [x20, #0x1a8]
  963ae4: 97ff7e25     	bl	0x943378 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3ed18>
  963ae8: b900fbe0     	str	w0, [sp, #0xf8]
  963aec: f940d680     	ldr	x0, [x20, #0x1a8]
  963af0: 97ff7dc2     	bl	0x9431f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3eb98>
  963af4: 1e27000e     	fmov	s14, w0
  963af8: f940d680     	ldr	x0, [x20, #0x1a8]
  963afc: 97ff7f9f     	bl	0x943978 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3f318>
  963b00: 2a0003fa     	mov	w26, w0
  963b04: f940d680     	ldr	x0, [x20, #0x1a8]
  963b08: 97ff8060     	bl	0x943c88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3f628>
  963b0c: 2a0003fb     	mov	w27, w0
  963b10: f940d680     	ldr	x0, [x20, #0x1a8]
  963b14: 97ff7d59     	bl	0x943078 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3ea18>
  963b18: b900f3e0     	str	w0, [sp, #0xf0]
  963b1c: f940d680     	ldr	x0, [x20, #0x1a8]
  963b20: 97ff7f36     	bl	0x9437f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x3f198>
  963b24: bd419261     	ldr	s1, [x19, #0x190]
  963b28: b9010be0     	str	w0, [sp, #0x108]
  963b2c: 52824de0     	mov	w0, #0x126f             // =4719
  963b30: 72a75060     	movk	w0, #0x3a83, lsl #16
  963b34: 1e270000     	fmov	s0, w0
  963b38: 1e20c021     	fabs	s1, s1
  963b3c: 1e202030     	fcmpe	s1, s0
  963b40: 5400010c     	b.gt	0x963b60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f500>
  963b44: bd419661     	ldr	s1, [x19, #0x194]
  963b48: 1e202030     	fcmpe	s1, s0
  963b4c: 540000ac     	b.gt	0x963b60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f500>
  963b50: bd419a61     	ldr	s1, [x19, #0x198]
  963b54: 1e202030     	fcmpe	s1, s0
  963b58: 540068cd     	b.le	0x964870 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60210>
  963b5c: d503201f     	nop
  963b60: b942be60     	ldr	w0, [x19, #0x2bc]
  963b64: 52800016     	mov	w22, #0x0               // =0
  963b68: 34003940     	cbz	w0, 0x964290 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fc30>
  963b6c: b941ba81     	ldr	w1, [x20, #0x1b8]
  963b70: 91054295     	add	x21, x20, #0x150
  963b74: aa1503e0     	mov	x0, x21
  963b78: 940062da     	bl	0x97c6e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x5640>
  963b7c: b941ba81     	ldr	w1, [x20, #0x1b8]
  963b80: aa1503e0     	mov	x0, x21
  963b84: 94006267     	bl	0x97c520 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x5480>
  963b88: aa0003fc     	mov	x28, x0
  963b8c: bd40026d     	ldr	s13, [x19]
  963b90: f9400400     	ldr	x0, [x0, #0x8]
  963b94: b4003860     	cbz	x0, 0x9642a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fc40>
  963b98: 97fe822c     	bl	0x904448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc1c>
  963b9c: bd40026c     	ldr	s12, [x19]
  963ba0: 1e2c1001     	fmov	s1, #0.50000000
  963ba4: 1e230340     	ucvtf	s0, w26
  963ba8: 520002d6     	eor	w22, w22, #0x1
  963bac: 1e21798c     	fminnm	s12, s12, s1
  963bb0: 1e2121a0     	fcmp	s13, s1
  963bb4: 1e2c0800     	fmul	s0, s0, s12
  963bb8: 1e280001     	fcvtps	w1, s0
  963bbc: 0b417c22     	add	w2, w1, w1, lsr #31
  963bc0: 13017c42     	asr	w2, w2, #1
  963bc4: 1a828021     	csel	w1, w1, w2, hi
  963bc8: 6b00003f     	cmp	w1, w0
  963bcc: 1a9f07e0     	cset	w0, ne
  963bd0: 6a16001f     	tst	w0, w22
  963bd4: 540046a1     	b.ne	0x9644a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fe48>
  963bd8: 390a4260     	strb	w0, [x19, #0x290]
  963bdc: 2a1b03e1     	mov	w1, w27
  963be0: 910543e8     	add	x8, sp, #0x150
  963be4: aa1303e0     	mov	x0, x19
  963be8: 97fff83e     	bl	0x961ce0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5d680>
  963bec: 97ffb723     	bl	0x951878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d218>
  963bf0: 4f000400     	movi	v0.4s, #0x0
  963bf4: 52800021     	mov	w1, #0x1                // =1
  963bf8: f9400280     	ldr	x0, [x20]
  963bfc: f90093ff     	str	xzr, [sp, #0x120]
  963c00: 3904a3e1     	strb	w1, [sp, #0x128]
  963c04: f900a3ff     	str	xzr, [sp, #0x140]
  963c08: 390523e1     	strb	w1, [sp, #0x148]
  963c0c: 3d8047e0     	str	q0, [sp, #0x110]
  963c10: 3d804fe0     	str	q0, [sp, #0x130]
  963c14: b40043c0     	cbz	x0, 0x96448c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fe2c>
  963c18: b940fbe1     	ldr	w1, [sp, #0xf8]
  963c1c: 9104c3f6     	add	x22, sp, #0x130
  963c20: 910543e3     	add	x3, sp, #0x150
  963c24: aa1603e5     	mov	x5, x22
  963c28: 910443e4     	add	x4, sp, #0x110
  963c2c: 531f7822     	lsl	w2, w1, #1
  963c30: b941ba81     	ldr	w1, [x20, #0x1b8]
  963c34: 11007c42     	add	w2, w2, #0x1f
  963c38: d37ff842     	lsl	x2, x2, #1
  963c3c: 927a6442     	and	x2, x2, #0xffffffc0
  963c40: 940009c4     	bl	0x966350 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x61cf0>
  963c44: 97ffb70d     	bl	0x951878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d218>
  963c48: 911383e0     	add	x0, sp, #0x4e0
  963c4c: 9e6703e0     	fmov	d0, xzr
  963c50: fd40d28d     	ldr	d13, [x20, #0x1a0]
  963c54: a9007c1f     	stp	xzr, xzr, [x0]
  963c58: a94082e1     	ldp	x1, x0, [x23, #0x8]
  963c5c: f9027bff     	str	xzr, [sp, #0x4f0]
  963c60: fd40e28c     	ldr	d12, [x20, #0x1c0]
  963c64: cb010015     	sub	x21, x0, x1
  963c68: 9e6702af     	fmov	d15, x21
  963c6c: 9342fea2     	asr	x2, x21, #2
  963c70: b4000142     	cbz	x2, 0x963c98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f638>
  963c74: 92f80000     	mov	x0, #0x3fffffffffffffff // =4611686018427387903
  963c78: eb00005f     	cmp	x2, x0
  963c7c: 54005fe8     	b.hi	0x964878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60218>
  963c80: aa1503e0     	mov	x0, x21
  963c84: 97ea9877     	bl	0x409e60 <_Znwm@plt>
  963c88: 9e670000     	fmov	d0, x0
  963c8c: a94082e1     	ldp	x1, x0, [x23, #0x8]
  963c90: cb010002     	sub	x2, x0, x1
  963c94: 9e67004f     	fmov	d15, x2
  963c98: 9e6702a1     	fmov	d1, x21
  963c9c: eb00003f     	cmp	x1, x0
  963ca0: 4e080402     	dup	v2.2d, v0.d[0]
  963ca4: 5ee18401     	add	d1, d0, d1
  963ca8: 3d813be2     	str	q2, [sp, #0x4e0]
  963cac: fd027be1     	str	d1, [sp, #0x4f0]
  963cb0: 540000a0     	b.eq	0x963cc4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f664>
  963cb4: 9e660000     	fmov	x0, d0
  963cb8: 9e6601e2     	fmov	x2, d15
  963cbc: 97ea981d     	bl	0x409d30 <memmove@plt>
  963cc0: 9e670000     	fmov	d0, x0
  963cc4: f94012e4     	ldr	x4, [x23, #0x20]
  963cc8: b90003fa     	str	w26, [sp]
  963ccc: b9410be1     	ldr	w1, [sp, #0x108]
  963cd0: 5eef8400     	add	d0, d0, d15
  963cd4: b94002e0     	ldr	w0, [x23]
  963cd8: 1e2601c7     	fmov	w7, s14
  963cdc: b9402ae5     	ldr	w5, [x23, #0x28]
  963ce0: 9e6601a2     	fmov	x2, d13
  963ce4: b90013e1     	str	w1, [sp, #0x10]
  963ce8: 911383f5     	add	x21, sp, #0x4e0
  963cec: b940f3e1     	ldr	w1, [sp, #0xf0]
  963cf0: aa1503e3     	mov	x3, x21
  963cf4: b940fbe6     	ldr	w6, [sp, #0xf8]
  963cf8: 910d83e8     	add	x8, sp, #0x360
  963cfc: b9001be1     	str	w1, [sp, #0x18]
  963d00: 9e660181     	fmov	x1, d12
  963d04: b90043e0     	str	w0, [sp, #0x40]
  963d08: 9e660120     	fmov	x0, d9
  963d0c: b9000bfb     	str	w27, [sp, #0x8]
  963d10: b90023ff     	str	wzr, [sp, #0x20]
  963d14: b9002bff     	str	wzr, [sp, #0x28]
  963d18: b90033fa     	str	w26, [sp, #0x30]
  963d1c: b9003bfb     	str	w27, [sp, #0x38]
  963d20: f90027f6     	str	x22, [sp, #0x48]
  963d24: fd0277e0     	str	d0, [sp, #0x4e8]
  963d28: 97fefaa2     	bl	0x9227b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1e150>
  963d2c: f94273e0     	ldr	x0, [sp, #0x4e0]
  963d30: b4000040     	cbz	x0, 0x963d38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f6d8>
  963d34: 97ea9a1f     	bl	0x40a5b0 <_ZdlPv@plt>
  963d38: f9400280     	ldr	x0, [x20]
  963d3c: b40000c0     	cbz	x0, 0x963d54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f6f4>
  963d40: b941ba81     	ldr	w1, [x20, #0x1b8]
  963d44: aa1603e4     	mov	x4, x22
  963d48: 910443e3     	add	x3, sp, #0x110
  963d4c: 910d83e2     	add	x2, sp, #0x360
  963d50: 940008ac     	bl	0x966000 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x619a0>
  963d54: 97ffb6c9     	bl	0x951878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d218>
  963d58: 910d83e0     	add	x0, sp, #0x360
  963d5c: f940d296     	ldr	x22, [x20, #0x1a0]
  963d60: 97fef95c     	bl	0x9222d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1dc70>
  963d64: 8b2042c0     	add	x0, x22, w0, uxtw
  963d68: f9007fe0     	str	x0, [sp, #0xf8]
  963d6c: 910d83e0     	add	x0, sp, #0x360
  963d70: f940ce96     	ldr	x22, [x20, #0x198]
  963d74: 97fef957     	bl	0x9222d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1dc70>
  963d78: 3945a3e1     	ldrb	w1, [sp, #0x168]
  963d7c: cb2042c0     	sub	x0, x22, w0, uxtw
  963d80: f90083e0     	str	x0, [sp, #0x100]
  963d84: 34000081     	cbz	w1, 0x963d94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f734>
  963d88: f940e280     	ldr	x0, [x20, #0x1c0]
  963d8c: 39429000     	ldrb	w0, [x0, #0xa4]
  963d90: 350001c0     	cbnz	w0, 0x963dc8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f768>
  963d94: a9598e84     	ldp	x4, x3, [x20, #0x198]
  963d98: 9e660121     	fmov	x1, d9
  963d9c: f940d682     	ldr	x2, [x20, #0x1a8]
  963da0: aa1503e0     	mov	x0, x21
  963da4: 97ffb6c1     	bl	0x9518a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d248>
  963da8: f940e282     	ldr	x2, [x20, #0x1c0]
  963dac: 910d83e1     	add	x1, sp, #0x360
  963db0: aa1503e0     	mov	x0, x21
  963db4: 39429042     	ldrb	w2, [x2, #0xa4]
  963db8: 2a0203e3     	mov	w3, w2
  963dbc: 97ffc291     	bl	0x954800 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x501a0>
  963dc0: aa1503e0     	mov	x0, x21
  963dc4: 97ffb70d     	bl	0x9519f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d398>
  963dc8: 910d83e0     	add	x0, sp, #0x360
  963dcc: 97fef9dd     	bl	0x922540 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1dee0>
  963dd0: bd400260     	ldr	s0, [x19]
  963dd4: 1e2c1001     	fmov	s1, #0.50000000
  963dd8: 2a0003f7     	mov	w23, w0
  963ddc: 1e212010     	fcmpe	s0, s1
  963de0: 54002668     	b.hi	0x9642ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fc4c>
  963de4: 97fea9d7     	bl	0x90e540 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x9ee0>
  963de8: b942ba61     	ldr	w1, [x19, #0x2b8]
  963dec: 531f7800     	lsl	w0, w0, #1
  963df0: b942be76     	ldr	w22, [x19, #0x2bc]
  963df4: 121f7ac2     	and	w2, w22, #0xfffffffe
  963df8: b9010fe2     	str	w2, [sp, #0x10c]
  963dfc: 1ac00c21     	sdiv	w1, w1, w0
  963e00: 4b02035a     	sub	w26, w26, w2
  963e04: 1b007c36     	mul	w22, w1, w0
  963e08: 4b16037b     	sub	w27, w27, w22
  963e0c: 910d83e0     	add	x0, sp, #0x360
  963e10: 97fef9a8     	bl	0x9224b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1de50>
  963e14: b9410be1     	ldr	w1, [sp, #0x108]
  963e18: b940f3e2     	ldr	w2, [sp, #0xf0]
  963e1c: 0b160036     	add	w22, w1, w22
  963e20: b9410fe1     	ldr	w1, [sp, #0x10c]
  963e24: 0b020021     	add	w1, w1, w2
  963e28: 1b177ed6     	mul	w22, w22, w23
  963e2c: 8b0106d6     	add	x22, x22, x1, lsl #1
  963e30: 8b160016     	add	x22, x0, x22
  963e34: 910963e0     	add	x0, sp, #0x258
  963e38: 97fe81c6     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963e3c: aa1603e5     	mov	x5, x22
  963e40: 2a1703e4     	mov	w4, w23
  963e44: 2a1b03e2     	mov	w2, w27
  963e48: 2a1a03e1     	mov	w1, w26
  963e4c: 52800006     	mov	w6, #0x0                // =0
  963e50: 52800023     	mov	w3, #0x1                // =1
  963e54: 910963e0     	add	x0, sp, #0x258
  963e58: 97fe80e6     	bl	0x9041f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d9c4>
  963e5c: 910ac3f7     	add	x23, sp, #0x2b0
  963e60: aa1703e0     	mov	x0, x23
  963e64: 97fe81bb     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963e68: 5297cee0     	mov	w0, #0xbe77             // =48759
  963e6c: b9403261     	ldr	w1, [x19, #0x30]
  963e70: bd400261     	ldr	s1, [x19]
  963e74: 72a7efe0     	movk	w0, #0x3f7f, lsl #16
  963e78: 1e270000     	fmov	s0, w0
  963e7c: 7100003f     	cmp	w1, #0x0
  963e80: 9a9fc2e0     	csel	x0, x23, xzr, gt
  963e84: 1e2c1002     	fmov	s2, #0.50000000
  963e88: 1e202030     	fcmpe	s1, s0
  963e8c: f9007be0     	str	x0, [sp, #0xf0]
  963e90: 1e224434     	fccmpe	s1, s2, #0x4, mi
  963e94: 540000cc     	b.gt	0x963eac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f84c>
  963e98: 528418a0     	mov	w0, #0x20c5             // =8389
  963e9c: 72a7f000     	movk	w0, #0x3f80, lsl #16
  963ea0: 1e270000     	fmov	s0, w0
  963ea4: 1e202030     	fcmpe	s1, s0
  963ea8: 54004a2d     	b.le	0x9647ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6018c>
  963eac: 910f03f6     	add	x22, sp, #0x3c0
  963eb0: aa1603e0     	mov	x0, x22
  963eb4: 97fe81a7     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963eb8: aa1503e0     	mov	x0, x21
  963ebc: 97fe81a5     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  963ec0: 1e2e1000     	fmov	s0, #1.00000000
  963ec4: b940027b     	ldr	w27, [x19]
  963ec8: f900c3ff     	str	xzr, [sp, #0x180]
  963ecc: 9105c3fa     	add	x26, sp, #0x170
  963ed0: bd000260     	str	s0, [x19]
  963ed4: f940f283     	ldr	x3, [x20, #0x1e0]
  963ed8: b40000e3     	cbz	x3, 0x963ef4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f894>
  963edc: 52800042     	mov	w2, #0x2                // =2
  963ee0: aa1a03e0     	mov	x0, x26
  963ee4: 91074281     	add	x1, x20, #0x1d0
  963ee8: d63f0060     	blr	x3
  963eec: 3dc07a80     	ldr	q0, [x20, #0x1e0]
  963ef0: 3d8063e0     	str	q0, [sp, #0x180]
  963ef4: 910c23f4     	add	x20, sp, #0x308
  963ef8: a94f8be1     	ldp	x1, x2, [sp, #0xf8]
  963efc: aa1a03e3     	mov	x3, x26
  963f00: aa1403e0     	mov	x0, x20
  963f04: 97fed6a1     	bl	0x919988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15328>
  963f08: f940c3e3     	ldr	x3, [sp, #0x180]
  963f0c: b40000a3     	cbz	x3, 0x963f20 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f8c0>
  963f10: 52800062     	mov	w2, #0x3                // =3
  963f14: aa1a03e1     	mov	x1, x26
  963f18: aa1a03e0     	mov	x0, x26
  963f1c: d63f0060     	blr	x3
  963f20: 9e660167     	fmov	x7, d11
  963f24: 9e660126     	fmov	x6, d9
  963f28: f9407be4     	ldr	x4, [sp, #0xf0]
  963f2c: f90003fc     	str	x28, [sp]
  963f30: aa1303e5     	mov	x5, x19
  963f34: aa1503e3     	mov	x3, x21
  963f38: aa1603e2     	mov	x2, x22
  963f3c: 910963e1     	add	x1, sp, #0x258
  963f40: aa1403e0     	mov	x0, x20
  963f44: 97fed785     	bl	0x919d58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x156f8>
  963f48: aa1403e0     	mov	x0, x20
  963f4c: 97fed65d     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  963f50: b900027b     	str	w27, [x19]
  963f54: aa1503e0     	mov	x0, x21
  963f58: 97fe811a     	bl	0x9043c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db94>
  963f5c: aa0003fa     	mov	x26, x0
  963f60: aa1503e0     	mov	x0, x21
  963f64: 97fe8143     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  963f68: bd42c261     	ldr	s1, [x19, #0x2c0]
  963f6c: 8b20c35a     	add	x26, x26, w0, sxtw
  963f70: bd42c660     	ldr	s0, [x19, #0x2c4]
  963f74: aa1603e0     	mov	x0, x22
  963f78: bd400262     	ldr	s2, [x19]
  963f7c: 5e21d821     	scvtf	s1, s1
  963f80: 5e21d800     	scvtf	s0, s0
  963f84: 1e220821     	fmul	s1, s1, s2
  963f88: 1e220800     	fmul	s0, s0, s2
  963f8c: 1e28003b     	fcvtps	w27, s1
  963f90: 1e280014     	fcvtps	w20, s0
  963f94: 97fe8103     	bl	0x9043a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db74>
  963f98: 2a0003e4     	mov	w4, w0
  963f9c: aa1a03e6     	mov	x6, x26
  963fa0: 52800405     	mov	w5, #0x20               // =32
  963fa4: 52800003     	mov	w3, #0x0                // =0
  963fa8: 2a1403e2     	mov	w2, w20
  963fac: 2a1b03e1     	mov	w1, w27
  963fb0: aa1803e0     	mov	x0, x24
  963fb4: 97fe7fef     	bl	0x903f70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d744>
  963fb8: aa1803e0     	mov	x0, x24
  963fbc: 97fe812d     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  963fc0: 8b20c35a     	add	x26, x26, w0, sxtw
  963fc4: aa1503e0     	mov	x0, x21
  963fc8: 97fe80f6     	bl	0x9043a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db74>
  963fcc: 2a0003e4     	mov	w4, w0
  963fd0: 9e660100     	fmov	x0, d8
  963fd4: aa1a03e6     	mov	x6, x26
  963fd8: 2a1403e2     	mov	w2, w20
  963fdc: 2a1b03e1     	mov	w1, w27
  963fe0: 52800405     	mov	w5, #0x20               // =32
  963fe4: 52800003     	mov	w3, #0x0                // =0
  963fe8: 97fe7fe2     	bl	0x903f70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d744>
  963fec: bd400261     	ldr	s1, [x19]
  963ff0: 1e2e1000     	fmov	s0, #1.00000000
  963ff4: 1e202030     	fcmpe	s1, s0
  963ff8: 5400226d     	b.le	0x964444 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fde4>
  963ffc: aa1603e1     	mov	x1, x22
  964000: aa1803e0     	mov	x0, x24
  964004: 97fe80c7     	bl	0x904320 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5daf4>
  964008: bd400260     	ldr	s0, [x19]
  96400c: aa1803e0     	mov	x0, x24
  964010: 97ff1e0c     	bl	0x92b840 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x271e0>
  964014: 9e660100     	fmov	x0, d8
  964018: aa1503e1     	mov	x1, x21
  96401c: 97fe80c1     	bl	0x904320 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5daf4>
  964020: 9e660100     	fmov	x0, d8
  964024: bd400260     	ldr	s0, [x19]
  964028: 97ff1e06     	bl	0x92b840 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x271e0>
  96402c: aa1503e0     	mov	x0, x21
  964030: 97fe7f1e     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964034: aa1603e0     	mov	x0, x22
  964038: 97fe7f1c     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  96403c: b9403260     	ldr	w0, [x19, #0x30]
  964040: 7100001f     	cmp	w0, #0x0
  964044: 540013ac     	b.gt	0x9642b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fc58>
  964048: eb19031f     	cmp	x24, x25
  96404c: 54000aa0     	b.eq	0x9641a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb40>
  964050: aa1603e0     	mov	x0, x22
  964054: 94008187     	bl	0x984670 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd5d0>
  964058: 91001261     	add	x1, x19, #0x4
  96405c: aa1603e0     	mov	x0, x22
  964060: 94008198     	bl	0x9846c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd620>
  964064: bd400260     	ldr	s0, [x19]
  964068: aa1603e0     	mov	x0, x22
  96406c: 1e22c000     	fcvt	d0, s0
  964070: 940081da     	bl	0x9847d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd738>
  964074: bd400260     	ldr	s0, [x19]
  964078: aa1603e0     	mov	x0, x22
  96407c: 1e22c000     	fcvt	d0, s0
  964080: 940081da     	bl	0x9847e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd748>
  964084: aa1303e2     	mov	x2, x19
  964088: aa1603e1     	mov	x1, x22
  96408c: aa1503e0     	mov	x0, x21
  964090: 94007d16     	bl	0x9834e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc448>
  964094: 6d410a63     	ldp	d3, d2, [x19, #0x10]
  964098: 9e660100     	fmov	x0, d8
  96409c: fd415e61     	ldr	d1, [x19, #0x2b8]
  9640a0: fd416260     	ldr	d0, [x19, #0x2c0]
  9640a4: 0e21d863     	scvtf	v3.2s, v3.2s
  9640a8: 0e21d842     	scvtf	v2.2s, v2.2s
  9640ac: 0e21d821     	scvtf	v1.2s, v1.2s
  9640b0: 0d40ca64     	ld1r	{ v4.2s }, [x19]
  9640b4: 0e21d800     	scvtf	v0.2s, v0.2s
  9640b8: 2e24dc63     	fmul	v3.2s, v3.2s, v4.2s
  9640bc: 2e24dc42     	fmul	v2.2s, v2.2s, v4.2s
  9640c0: 2e24dc21     	fmul	v1.2s, v1.2s, v4.2s
  9640c4: 2e24dc00     	fmul	v0.2s, v0.2s, v4.2s
  9640c8: 0e21b863     	fcvtms	v3.2s, v3.2s
  9640cc: 0ea1a842     	fcvtps	v2.2s, v2.2s
  9640d0: 0e21b821     	fcvtms	v1.2s, v1.2s
  9640d4: 0ea1a800     	fcvtps	v0.2s, v0.2s
  9640d8: fd018fe3     	str	d3, [sp, #0x318]
  9640dc: fd0187e1     	str	d1, [sp, #0x308]
  9640e0: fd018be0     	str	d0, [sp, #0x310]
  9640e4: fd0193e2     	str	d2, [sp, #0x320]
  9640e8: 97fe80b6     	bl	0x9043c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db94>
  9640ec: aa0003f3     	mov	x19, x0
  9640f0: 9e660100     	fmov	x0, d8
  9640f4: 97fe80df     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  9640f8: 8b20c273     	add	x19, x19, w0, sxtw
  9640fc: b94323f4     	ldr	w20, [sp, #0x320]
  964100: aa1803e0     	mov	x0, x24
  964104: b94327fa     	ldr	w26, [sp, #0x324]
  964108: 97fe80a6     	bl	0x9043a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db74>
  96410c: 2a0003e4     	mov	w4, w0
  964110: aa1303e6     	mov	x6, x19
  964114: 2a1a03e2     	mov	w2, w26
  964118: 2a1403e1     	mov	w1, w20
  96411c: 52800005     	mov	w5, #0x0                // =0
  964120: 52800003     	mov	w3, #0x0                // =0
  964124: aa1903e0     	mov	x0, x25
  964128: 97fe7f92     	bl	0x903f70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d744>
  96412c: aa1903e0     	mov	x0, x25
  964130: 97fe80a4     	bl	0x9043c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db94>
  964134: aa0003f3     	mov	x19, x0
  964138: aa1903e0     	mov	x0, x25
  96413c: 97fe80cd     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  964140: 8b20c273     	add	x19, x19, w0, sxtw
  964144: 9e660100     	fmov	x0, d8
  964148: b94323f4     	ldr	w20, [sp, #0x320]
  96414c: b94327fa     	ldr	w26, [sp, #0x324]
  964150: 97fe8094     	bl	0x9043a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db74>
  964154: 2a0003e4     	mov	w4, w0
  964158: 9e660140     	fmov	x0, d10
  96415c: aa1303e6     	mov	x6, x19
  964160: 2a1a03e2     	mov	w2, w26
  964164: 2a1403e1     	mov	w1, w20
  964168: 52800005     	mov	w5, #0x0                // =0
  96416c: 52800003     	mov	w3, #0x0                // =0
  964170: 97fe7f80     	bl	0x903f70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d744>
  964174: aa1903e2     	mov	x2, x25
  964178: aa1803e1     	mov	x1, x24
  96417c: 910c23e3     	add	x3, sp, #0x308
  964180: aa1503e0     	mov	x0, x21
  964184: fd0197e8     	str	d8, [sp, #0x328]
  964188: fd019bea     	str	d10, [sp, #0x330]
  96418c: 9400791d     	bl	0x982600 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xb560>
  964190: aa1503e0     	mov	x0, x21
  964194: 94007ceb     	bl	0x983540 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc4a0>
  964198: aa1603e0     	mov	x0, x22
  96419c: 94008147     	bl	0x9846b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd618>
  9641a0: 97ffb5b6     	bl	0x951878 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d218>
  9641a4: aa1703e0     	mov	x0, x23
  9641a8: 97fe7ec0     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9641ac: 910963e0     	add	x0, sp, #0x258
  9641b0: 97fe7ebe     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9641b4: 910d83e0     	add	x0, sp, #0x360
  9641b8: 97fef7ea     	bl	0x922160 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1db00>
  9641bc: f9409be0     	ldr	x0, [sp, #0x130]
  9641c0: b4000040     	cbz	x0, 0x9641c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb68>
  9641c4: 97ea98fb     	bl	0x40a5b0 <_ZdlPv@plt>
  9641c8: f9408be0     	ldr	x0, [sp, #0x110]
  9641cc: b4000040     	cbz	x0, 0x9641d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb74>
  9641d0: 97ea98f8     	bl	0x40a5b0 <_ZdlPv@plt>
  9641d4: f940abe0     	ldr	x0, [sp, #0x150]
  9641d8: b4000040     	cbz	x0, 0x9641e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb80>
  9641dc: 97ea98f5     	bl	0x40a5b0 <_ZdlPv@plt>
  9641e0: 52800033     	mov	w19, #0x1               // =1
  9641e4: 14000002     	b	0x9641ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5fb8c>
  9641e8: 52800013     	mov	w19, #0x0               // =0
  9641ec: 910803e0     	add	x0, sp, #0x200
  9641f0: 97fe7eae     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9641f4: 9106a3e0     	add	x0, sp, #0x1a8
  9641f8: 97fe7eac     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9641fc: 2a1303e0     	mov	w0, w19
  964200: d284e210     	mov	x16, #0x2710            // =10000
  964204: a9457bfd     	ldp	x29, x30, [sp, #0x50]
  964208: a94653f3     	ldp	x19, x20, [sp, #0x60]
  96420c: a9475bf5     	ldp	x21, x22, [sp, #0x70]
  964210: a94863f7     	ldp	x23, x24, [sp, #0x80]
  964214: a9496bf9     	ldp	x25, x26, [sp, #0x90]
  964218: a94a73fb     	ldp	x27, x28, [sp, #0xa0]
  96421c: 6d4b27e8     	ldp	d8, d9, [sp, #0xb0]
  964220: 6d4c2fea     	ldp	d10, d11, [sp, #0xc0]
  964224: 6d4d37ec     	ldp	d12, d13, [sp, #0xd0]
  964228: 6d4e3fee     	ldp	d14, d15, [sp, #0xe0]
  96422c: 8b3063ff     	add	sp, sp, x16
  964230: d65f03c0     	ret
  964234: 1e604148     	fmov	d8, d10
  964238: aa1903f8     	mov	x24, x25
  96423c: 17fffe20     	b	0x963abc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f45c>
  964240: 910f03f6     	add	x22, sp, #0x3c0
  964244: aa1603e0     	mov	x0, x22
  964248: 9400810a     	bl	0x984670 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd5d0>
  96424c: aa1603e0     	mov	x0, x22
  964250: 91001261     	add	x1, x19, #0x4
  964254: 9400811b     	bl	0x9846c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd620>
  964258: 911383f5     	add	x21, sp, #0x4e0
  96425c: aa1303e2     	mov	x2, x19
  964260: aa1503e0     	mov	x0, x21
  964264: aa1603e1     	mov	x1, x22
  964268: 94007ca0     	bl	0x9834e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc448>
  96426c: 91004262     	add	x2, x19, #0x10
  964270: 910ae261     	add	x1, x19, #0x2b8
  964274: aa1503e0     	mov	x0, x21
  964278: 94007888     	bl	0x982498 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xb3f8>
  96427c: aa1503e0     	mov	x0, x21
  964280: 94007cb0     	bl	0x983540 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc4a0>
  964284: aa1603e0     	mov	x0, x22
  964288: 9400810c     	bl	0x9846b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd618>
  96428c: 17fffdfe     	b	0x963a84 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f424>
  964290: b942c260     	ldr	w0, [x19, #0x2c0]
  964294: 6b1a001f     	cmp	w0, w26
  964298: 1a9f17f6     	cset	w22, eq
  96429c: 17fffe34     	b	0x963b6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f50c>
  9642a0: 1e2041ac     	fmov	s12, s13
  9642a4: 52800000     	mov	w0, #0x0                // =0
  9642a8: 17fffe3e     	b	0x963ba0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f540>
  9642ac: 52800016     	mov	w22, #0x0               // =0
  9642b0: b9010fff     	str	wzr, [sp, #0x10c]
  9642b4: 17fffed6     	b	0x963e0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f7ac>
  9642b8: 910c23f4     	add	x20, sp, #0x308
  9642bc: aa1403e0     	mov	x0, x20
  9642c0: 97fe80a4     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  9642c4: aa1803e0     	mov	x0, x24
  9642c8: 97fe806a     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  9642cc: 2a0003fa     	mov	w26, w0
  9642d0: 9e660100     	fmov	x0, d8
  9642d4: 97fe8067     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  9642d8: 0b00035a     	add	w26, w26, w0
  9642dc: aa1703e0     	mov	x0, x23
  9642e0: 97fe8064     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  9642e4: a94f87e3     	ldp	x3, x1, [sp, #0xf8]
  9642e8: 0b00035a     	add	w26, w26, w0
  9642ec: aa1503e0     	mov	x0, x21
  9642f0: 93407f5a     	sxtw	x26, w26
  9642f4: cb1a0022     	sub	x2, x1, x26
  9642f8: 8b1a0061     	add	x1, x3, x26
  9642fc: 97fed597     	bl	0x919958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x152f8>
  964300: bd42ba6c     	ldr	s12, [x19, #0x2b8]
  964304: 1e2e1000     	fmov	s0, #1.00000000
  964308: bd42be6e     	ldr	s14, [x19, #0x2bc]
  96430c: 9108027b     	add	x27, x19, #0x200
  964310: bd42c26d     	ldr	s13, [x19, #0x2c0]
  964314: aa1703e0     	mov	x0, x23
  964318: bd40026f     	ldr	s15, [x19]
  96431c: b942c67c     	ldr	w28, [x19, #0x2c4]
  964320: bd000260     	str	s0, [x19]
  964324: 97fe8021     	bl	0x9043a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db7c>
  964328: a9400c02     	ldp	x2, x3, [x0]
  96432c: f90003ff     	str	xzr, [sp]
  964330: 9e660167     	fmov	x7, d11
  964334: 9e660126     	fmov	x6, d9
  964338: a90b8f62     	stp	x2, x3, [x27, #0xb8]
  96433c: 9e660103     	fmov	x3, d8
  964340: aa1303e5     	mov	x5, x19
  964344: f9407be1     	ldr	x1, [sp, #0xf0]
  964348: d2800004     	mov	x4, #0x0                // =0
  96434c: aa1503e0     	mov	x0, x21
  964350: aa1403e2     	mov	x2, x20
  964354: 97fed681     	bl	0x919d58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x156f8>
  964358: 4e04058c     	dup	v12.4s, v12.s[0]
  96435c: aa1503e0     	mov	x0, x21
  964360: 6e0c05cc     	mov	v12.s[1], v14.s[0]
  964364: 6e1405ac     	mov	v12.s[2], v13.s[0]
  964368: 4e1c1f8c     	mov	v12.s[3], w28
  96436c: 3c8b836c     	stur	q12, [x27, #0xb8]
  964370: bd00026f     	str	s15, [x19]
  964374: 97fed553     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  964378: aa1403e0     	mov	x0, x20
  96437c: 97fe803d     	bl	0x904470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc44>
  964380: a94f87e3     	ldp	x3, x1, [sp, #0xf8]
  964384: 8b20c340     	add	x0, x26, w0, sxtw
  964388: 9105c3fa     	add	x26, sp, #0x170
  96438c: cb000022     	sub	x2, x1, x0
  964390: 8b000061     	add	x1, x3, x0
  964394: aa1a03e0     	mov	x0, x26
  964398: 97fed570     	bl	0x919958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x152f8>
  96439c: aa1603e0     	mov	x0, x22
  9643a0: 97fe806c     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  9643a4: aa1403e0     	mov	x0, x20
  9643a8: 97fe8028     	bl	0x904448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc1c>
  9643ac: 2a0003fb     	mov	w27, w0
  9643b0: aa1403e0     	mov	x0, x20
  9643b4: 97fe8027     	bl	0x904450 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc24>
  9643b8: 2a0003fc     	mov	w28, w0
  9643bc: aa1403e0     	mov	x0, x20
  9643c0: 97fe802a     	bl	0x904468 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc3c>
  9643c4: 1e27000c     	fmov	s12, w0
  9643c8: aa1403e0     	mov	x0, x20
  9643cc: 97fe7fff     	bl	0x9043c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db9c>
  9643d0: 1e260184     	fmov	w4, s12
  9643d4: aa0003e5     	mov	x5, x0
  9643d8: 2a1c03e2     	mov	w2, w28
  9643dc: 2a1b03e1     	mov	w1, w27
  9643e0: 52800026     	mov	w6, #0x1                // =1
  9643e4: 528001a3     	mov	w3, #0xd                // =13
  9643e8: aa1603e0     	mov	x0, x22
  9643ec: 97fe7f81     	bl	0x9041f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d9c4>
  9643f0: aa1503e0     	mov	x0, x21
  9643f4: 97fe8057     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  9643f8: 9e660167     	fmov	x7, d11
  9643fc: 9e660126     	fmov	x6, d9
  964400: 9e660103     	fmov	x3, d8
  964404: f90003ff     	str	xzr, [sp]
  964408: aa1303e5     	mov	x5, x19
  96440c: d2800004     	mov	x4, #0x0                // =0
  964410: aa1503e2     	mov	x2, x21
  964414: aa1603e1     	mov	x1, x22
  964418: aa1a03e0     	mov	x0, x26
  96441c: 97fed64f     	bl	0x919d58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x156f8>
  964420: aa1503e0     	mov	x0, x21
  964424: 97fe7e21     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964428: aa1603e0     	mov	x0, x22
  96442c: 97fe7e1f     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964430: aa1a03e0     	mov	x0, x26
  964434: 97fed523     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  964438: aa1403e0     	mov	x0, x20
  96443c: 97fe7e1b     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964440: 17ffff02     	b	0x964048 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f9e8>
  964444: 1e22c021     	fcvt	d1, s1
  964448: 1e6e100c     	fmov	d12, #1.00000000
  96444c: 2f00e403     	movi	d3, #0000000000000000
  964450: aa1803e1     	mov	x1, x24
  964454: aa1603e0     	mov	x0, x22
  964458: 1e61198c     	fdiv	d12, d12, d1
  96445c: 1e604062     	fmov	d2, d3
  964460: 1e604181     	fmov	d1, d12
  964464: 1e604180     	fmov	d0, d12
  964468: 97ff1b70     	bl	0x92b228 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x26bc8>
  96446c: 2f00e403     	movi	d3, #0000000000000000
  964470: 1e604181     	fmov	d1, d12
  964474: 1e604180     	fmov	d0, d12
  964478: 9e660101     	fmov	x1, d8
  96447c: aa1503e0     	mov	x0, x21
  964480: 1e604062     	fmov	d2, d3
  964484: 97ff1b27     	bl	0x92b120 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x26ac0>
  964488: 17fffee9     	b	0x96402c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f9cc>
  96448c: 9104c3f6     	add	x22, sp, #0x130
  964490: 910543e1     	add	x1, sp, #0x150
  964494: aa1603e0     	mov	x0, x22
  964498: 97f960f5     	bl	0x7bc86c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x8a4>
  96449c: 3945a3e0     	ldrb	w0, [sp, #0x168]
  9644a0: 390523e0     	strb	w0, [sp, #0x148]
  9644a4: 17fffde8     	b	0x963c44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f5e4>
  9644a8: f0002320     	adrp	x0, 0xdcb000
  9644ac: f0002321     	adrp	x1, 0xdcb000
  9644b0: 911083e3     	add	x3, sp, #0x420
  9644b4: 1e2e1000     	fmov	s0, #1.00000000
  9644b8: 3dc13002     	ldr	q2, [x0, #0x4c0]
  9644bc: 528c0000     	mov	w0, #0x6000             // =24576
  9644c0: 3dc13421     	ldr	q1, [x1, #0x4d0]
  9644c4: d2820001     	mov	x1, #0x1000             // =4096
  9644c8: 72a8c6a0     	movk	w0, #0x4635, lsl #16
  9644cc: f2a8c101     	movk	x1, #0x4608, lsl #16
  9644d0: b904e7e0     	str	w0, [sp, #0x4e4]
  9644d4: d2a7f002     	mov	x2, #0x3f800000         // =1065353216
  9644d8: f90277e1     	str	x1, [sp, #0x4e8]
  9644dc: d2a81401     	mov	x1, #0x40a00000         // =1084227584
  9644e0: b90503ff     	str	wzr, [sp, #0x500]
  9644e4: b2091be0     	mov	x0, #0x3f8000003f800000 // =4575657222473777152
  9644e8: bd04e3e0     	str	s0, [sp, #0x4e0]
  9644ec: f2e7f001     	movk	x1, #0x3f80, lsl #48
  9644f0: 3d813fe2     	str	q2, [sp, #0x4f0]
  9644f4: 3c8e4061     	stur	q1, [x3, #0xe4]
  9644f8: f80f4060     	stur	x0, [x3, #0xf4]
  9644fc: d2800480     	mov	x0, #0x24               // =36
  964500: f80fc062     	stur	x2, [x3, #0xfc]
  964504: f90297e1     	str	x1, [sp, #0x528]
  964508: 911883e1     	add	x1, sp, #0x620
  96450c: 391493ff     	strb	wzr, [sp, #0x524]
  964510: bd0533e0     	str	s0, [sp, #0x530]
  964514: a931fc3f     	stp	xzr, xzr, [x1, #-0xe8]
  964518: f902a7ff     	str	xzr, [sp, #0x548]
  96451c: 97ea9651     	bl	0x409e60 <_Znwm@plt>
  964520: aa0003e1     	mov	x1, x0
  964524: f0002320     	adrp	x0, 0xdcb000
  964528: 91114000     	add	x0, x0, #0x450
  96452c: 91009023     	add	x3, x1, #0x24
  964530: 91010002     	add	x2, x0, #0x40
  964534: f902a3e3     	str	x3, [sp, #0x540]
  964538: f902a7e3     	str	x3, [sp, #0x548]
  96453c: 911543e3     	add	x3, sp, #0x550
  964540: a9441404     	ldp	x4, x5, [x0, #0x40]
  964544: a9001424     	stp	x4, x5, [x1]
  964548: 1e6e1000     	fmov	d0, #1.00000000
  96454c: a9411444     	ldp	x4, x5, [x2, #0x10]
  964550: f9029fe1     	str	x1, [sp, #0x538]
  964554: a9007c7f     	stp	xzr, xzr, [x3]
  964558: d2800400     	mov	x0, #0x20               // =32
  96455c: b9402043     	ldr	w3, [x2, #0x20]
  964560: a9011424     	stp	x4, x5, [x1, #0x10]
  964564: b9002023     	str	w3, [x1, #0x20]
  964568: f901e3ff     	str	xzr, [sp, #0x3c0]
  96456c: f901e7ff     	str	xzr, [sp, #0x3c8]
  964570: fd01ebe0     	str	d0, [sp, #0x3d0]
  964574: fd01efe0     	str	d0, [sp, #0x3d8]
  964578: f902b3ff     	str	xzr, [sp, #0x560]
  96457c: 97ea9639     	bl	0x409e60 <_Znwm@plt>
  964580: 3dc0f3e5     	ldr	q5, [sp, #0x3c0]
  964584: 911003e4     	add	x4, sp, #0x400
  964588: 911003e5     	add	x5, sp, #0x400
  96458c: 911003e6     	add	x6, sp, #0x400
  964590: 91008001     	add	x1, x0, #0x20
  964594: 911003e7     	add	x7, sp, #0x400
  964598: 3d800005     	str	q5, [x0]
  96459c: b2091be2     	mov	x2, #0x3f8000003f800000 // =4575657222473777152
  9645a0: 911003e8     	add	x8, sp, #0x400
  9645a4: 3dc0f7e4     	ldr	q4, [sp, #0x3d0]
  9645a8: a9150480     	stp	x0, x1, [x4, #0x150]
  9645ac: 911803e9     	add	x9, sp, #0x600
  9645b0: a9167c81     	stp	x1, xzr, [x4, #0x160]
  9645b4: 911803ea     	add	x10, sp, #0x600
  9645b8: 1e2e1002     	fmov	s2, #1.00000000
  9645bc: a9177cbf     	stp	xzr, xzr, [x5, #0x170]
  9645c0: f0002323     	adrp	x3, 0xdcb000
  9645c4: 911803eb     	add	x11, sp, #0x600
  9645c8: a91808bf     	stp	xzr, x2, [x5, #0x180]
  9645cc: 911383f5     	add	x21, sp, #0x4e0
  9645d0: aa1503e1     	mov	x1, x21
  9645d4: a9197cc2     	stp	x2, xzr, [x6, #0x190]
  9645d8: 4f000401     	movi	v1.4s, #0x0
  9645dc: a91a08df     	stp	xzr, x2, [x6, #0x1a0]
  9645e0: a91b7ce2     	stp	x2, xzr, [x7, #0x1b0]
  9645e4: a91c7cff     	stp	xzr, xzr, [x7, #0x1c0]
  9645e8: a91d7d1f     	stp	xzr, xzr, [x8, #0x1d0]
  9645ec: a91e7d1f     	stp	xzr, xzr, [x8, #0x1e0]
  9645f0: a93f7d3f     	stp	xzr, xzr, [x9, #-0x10]
  9645f4: a9007d3f     	stp	xzr, xzr, [x9]
  9645f8: a9017d5f     	stp	xzr, xzr, [x10, #0x10]
  9645fc: a9027d5f     	stp	xzr, xzr, [x10, #0x20]
  964600: 3dc13063     	ldr	q3, [x3, #0x4c0]
  964604: 3d800404     	str	q4, [x0, #0x10]
  964608: d2a7f003     	mov	x3, #0x3f800000         // =1065353216
  96460c: f9031bff     	str	xzr, [sp, #0x630]
  964610: aa1403e0     	mov	x0, x20
  964614: f9031fff     	str	xzr, [sp, #0x638]
  964618: f90323e2     	str	x2, [sp, #0x640]
  96461c: bd064be2     	str	s2, [sp, #0x648]
  964620: bd064fe2     	str	s2, [sp, #0x64c]
  964624: 3d819fe1     	str	q1, [sp, #0x670]
  964628: 4f000400     	movi	v0.4s, #0x0
  96462c: 3d81a3e1     	str	q1, [sp, #0x680]
  964630: a9050962     	stp	x2, x2, [x11, #0x50]
  964634: 911883e2     	add	x2, sp, #0x620
  964638: a9067d63     	stp	x3, xzr, [x11, #0x60]
  96463c: f9034bff     	str	xzr, [sp, #0x690]
  964640: a907fc5f     	stp	xzr, xzr, [x2, #0x78]
  964644: 912083e2     	add	x2, sp, #0x820
  964648: 391aa3ff     	strb	wzr, [sp, #0x6a8]
  96464c: 3d81afe0     	str	q0, [sp, #0x6b0]
  964650: f90363ff     	str	xzr, [sp, #0x6c0]
  964654: 391b23ff     	strb	wzr, [sp, #0x6c8]
  964658: b906cfff     	str	wzr, [sp, #0x6cc]
  96465c: 3d81b7e0     	str	q0, [sp, #0x6d0]
  964660: f90373ff     	str	xzr, [sp, #0x6e0]
  964664: 391ba3ff     	strb	wzr, [sp, #0x6e8]
  964668: b906efff     	str	wzr, [sp, #0x6ec]
  96466c: 3d81bfe0     	str	q0, [sp, #0x6f0]
  964670: f90383ff     	str	xzr, [sp, #0x700]
  964674: 391c23ff     	strb	wzr, [sp, #0x708]
  964678: b9070fff     	str	wzr, [sp, #0x70c]
  96467c: 3d81c7e0     	str	q0, [sp, #0x710]
  964680: f90393ff     	str	xzr, [sp, #0x720]
  964684: 391ca3ff     	strb	wzr, [sp, #0x728]
  964688: b9072fff     	str	wzr, [sp, #0x72c]
  96468c: 3d81cfe0     	str	q0, [sp, #0x730]
  964690: f903a3ff     	str	xzr, [sp, #0x740]
  964694: 391d23ff     	strb	wzr, [sp, #0x748]
  964698: b9074fff     	str	wzr, [sp, #0x74c]
  96469c: 3d81d7e0     	str	q0, [sp, #0x750]
  9646a0: f903b3ff     	str	xzr, [sp, #0x760]
  9646a4: 391da3ff     	strb	wzr, [sp, #0x768]
  9646a8: b9076fff     	str	wzr, [sp, #0x76c]
  9646ac: 790ee3ff     	strh	wzr, [sp, #0x770]
  9646b0: f903bfff     	str	xzr, [sp, #0x778]
  9646b4: a9367c5f     	stp	xzr, xzr, [x2, #-0xa0]
  9646b8: f903cbff     	str	xzr, [sp, #0x790]
  9646bc: 3c978043     	stur	q3, [x2, #-0x88]
  9646c0: 97fff036     	bl	0x960798 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5c138>
  9646c4: 911083e3     	add	x3, sp, #0x420
  9646c8: b9403e62     	ldr	w2, [x19, #0x3c]
  9646cc: 910f03f6     	add	x22, sp, #0x3c0
  9646d0: f8434261     	ldur	x1, [x19, #0x34]
  9646d4: f80f4061     	stur	x1, [x3, #0xf4]
  9646d8: 52800021     	mov	w1, #0x1                // =1
  9646dc: aa1603e0     	mov	x0, x22
  9646e0: bd04e3ec     	str	s12, [sp, #0x4e0]
  9646e4: b904efff     	str	wzr, [sp, #0x4ec]
  9646e8: b9051fe2     	str	w2, [sp, #0x51c]
  9646ec: 391dc7e1     	strb	w1, [sp, #0x771]
  9646f0: f903cfff     	str	xzr, [sp, #0x798]
  9646f4: b907a3fa     	str	w26, [sp, #0x7a0]
  9646f8: b907a7fb     	str	w27, [sp, #0x7a4]
  9646fc: 97fe7f95     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  964700: 9e660166     	fmov	x6, d11
  964704: 9e660125     	fmov	x5, d9
  964708: aa1503e4     	mov	x4, x21
  96470c: d2800003     	mov	x3, #0x0                // =0
  964710: aa1603e2     	mov	x2, x22
  964714: aa1703e1     	mov	x1, x23
  964718: aa1403e0     	mov	x0, x20
  96471c: 97fffcc3     	bl	0x963a28 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f3c8>
  964720: 1e2c1000     	fmov	s0, #0.50000000
  964724: d2a10004     	mov	x4, #0x8000000          // =134217728
  964728: f940d283     	ldr	x3, [x20, #0x1a0]
  96472c: 1e2021b0     	fcmpe	s13, s0
  964730: aa1603e1     	mov	x1, x22
  964734: aa1c03e0     	mov	x0, x28
  964738: 1a9fd7e2     	cset	w2, gt
  96473c: 94005e35     	bl	0x97c010 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x4f70>
  964740: 390a427f     	strb	wzr, [x19, #0x290]
  964744: aa1603e0     	mov	x0, x22
  964748: 97fe7d58     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  96474c: f943abe0     	ldr	x0, [sp, #0x750]
  964750: b4000040     	cbz	x0, 0x964758 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x600f8>
  964754: 97ea9797     	bl	0x40a5b0 <_ZdlPv@plt>
  964758: f9439be0     	ldr	x0, [sp, #0x730]
  96475c: b4000040     	cbz	x0, 0x964764 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60104>
  964760: 97ea9794     	bl	0x40a5b0 <_ZdlPv@plt>
  964764: f9438be0     	ldr	x0, [sp, #0x710]
  964768: b4000040     	cbz	x0, 0x964770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60110>
  96476c: 97ea9791     	bl	0x40a5b0 <_ZdlPv@plt>
  964770: f9437be0     	ldr	x0, [sp, #0x6f0]
  964774: b4000040     	cbz	x0, 0x96477c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6011c>
  964778: 97ea978e     	bl	0x40a5b0 <_ZdlPv@plt>
  96477c: f9436be0     	ldr	x0, [sp, #0x6d0]
  964780: b4000040     	cbz	x0, 0x964788 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60128>
  964784: 97ea978b     	bl	0x40a5b0 <_ZdlPv@plt>
  964788: f9435be0     	ldr	x0, [sp, #0x6b0]
  96478c: b4000040     	cbz	x0, 0x964794 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60134>
  964790: 97ea9788     	bl	0x40a5b0 <_ZdlPv@plt>
  964794: f9430fe0     	ldr	x0, [sp, #0x618]
  964798: b4000040     	cbz	x0, 0x9647a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60140>
  96479c: 97ea9785     	bl	0x40a5b0 <_ZdlPv@plt>
  9647a0: f94303e0     	ldr	x0, [sp, #0x600]
  9647a4: b4000040     	cbz	x0, 0x9647ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6014c>
  9647a8: 97ea9782     	bl	0x40a5b0 <_ZdlPv@plt>
  9647ac: f942f7e0     	ldr	x0, [sp, #0x5e8]
  9647b0: b4000040     	cbz	x0, 0x9647b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60158>
  9647b4: 97ea977f     	bl	0x40a5b0 <_ZdlPv@plt>
  9647b8: f942ebe0     	ldr	x0, [sp, #0x5d0]
  9647bc: b4000040     	cbz	x0, 0x9647c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60164>
  9647c0: 97ea977c     	bl	0x40a5b0 <_ZdlPv@plt>
  9647c4: f942dfe0     	ldr	x0, [sp, #0x5b8]
  9647c8: b4000040     	cbz	x0, 0x9647d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60170>
  9647cc: 97ea9779     	bl	0x40a5b0 <_ZdlPv@plt>
  9647d0: f942abe0     	ldr	x0, [sp, #0x550]
  9647d4: b4000040     	cbz	x0, 0x9647dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6017c>
  9647d8: 97ea9776     	bl	0x40a5b0 <_ZdlPv@plt>
  9647dc: f9429fe0     	ldr	x0, [sp, #0x538]
  9647e0: b4ff9fe0     	cbz	x0, 0x963bdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f57c>
  9647e4: 97ea9773     	bl	0x40a5b0 <_ZdlPv@plt>
  9647e8: 17fffcfd     	b	0x963bdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f57c>
  9647ec: f940f283     	ldr	x3, [x20, #0x1e0]
  9647f0: f901ebff     	str	xzr, [sp, #0x3d0]
  9647f4: 910f03f6     	add	x22, sp, #0x3c0
  9647f8: b40000e3     	cbz	x3, 0x964814 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x601b4>
  9647fc: 52800042     	mov	w2, #0x2                // =2
  964800: aa1603e0     	mov	x0, x22
  964804: 91074281     	add	x1, x20, #0x1d0
  964808: d63f0060     	blr	x3
  96480c: 3dc07a80     	ldr	q0, [x20, #0x1e0]
  964810: 3d80f7e0     	str	q0, [sp, #0x3d0]
  964814: aa1603e3     	mov	x3, x22
  964818: a94f8be1     	ldp	x1, x2, [sp, #0xf8]
  96481c: aa1503e0     	mov	x0, x21
  964820: 97fed45a     	bl	0x919988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15328>
  964824: f941ebe3     	ldr	x3, [sp, #0x3d0]
  964828: b40000a3     	cbz	x3, 0x96483c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x601dc>
  96482c: 52800062     	mov	w2, #0x3                // =3
  964830: aa1603e1     	mov	x1, x22
  964834: aa1603e0     	mov	x0, x22
  964838: d63f0060     	blr	x3
  96483c: 9e660167     	fmov	x7, d11
  964840: 9e660126     	fmov	x6, d9
  964844: 9e660103     	fmov	x3, d8
  964848: f90003fc     	str	x28, [sp]
  96484c: f9407be4     	ldr	x4, [sp, #0xf0]
  964850: aa1303e5     	mov	x5, x19
  964854: aa1803e2     	mov	x2, x24
  964858: 910963e1     	add	x1, sp, #0x258
  96485c: aa1503e0     	mov	x0, x21
  964860: 97fed53e     	bl	0x919d58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x156f8>
  964864: aa1503e0     	mov	x0, x21
  964868: 97fed416     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  96486c: 17fffdf4     	b	0x96403c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f9dc>
  964870: d280001c     	mov	x28, #0x0               // =0
  964874: 17fffcda     	b	0x963bdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f57c>
  964878: 97ea9536     	bl	0x409d50 <_ZSt17__throw_bad_allocv@plt>
  96487c: aa0003f3     	mov	x19, x0
  964880: 9106a3e0     	add	x0, sp, #0x1a8
  964884: 97fe7d09     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964888: aa1303e0     	mov	x0, x19
  96488c: 97ea97b1     	bl	0x40a750 <_Unwind_Resume@plt>
  964890: aa0003f3     	mov	x19, x0
  964894: aa1603e0     	mov	x0, x22
  964898: 94007f88     	bl	0x9846b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd618>
  96489c: aa1303e0     	mov	x0, x19
  9648a0: 97ea97ac     	bl	0x40a750 <_Unwind_Resume@plt>
  9648a4: aa0003f3     	mov	x19, x0
  9648a8: 910803e0     	add	x0, sp, #0x200
  9648ac: 97fe7cff     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9648b0: 17fffff4     	b	0x964880 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60220>
  9648b4: aa0003f3     	mov	x19, x0
  9648b8: aa1503e0     	mov	x0, x21
  9648bc: 97fed401     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  9648c0: aa1703e0     	mov	x0, x23
  9648c4: 97fe7cf9     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9648c8: 910963e0     	add	x0, sp, #0x258
  9648cc: 97fe7cf7     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9648d0: 910d83e0     	add	x0, sp, #0x360
  9648d4: 97fef623     	bl	0x922160 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x1db00>
  9648d8: f9409be0     	ldr	x0, [sp, #0x130]
  9648dc: b4000040     	cbz	x0, 0x9648e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60284>
  9648e0: 97ea9734     	bl	0x40a5b0 <_ZdlPv@plt>
  9648e4: f9408be0     	ldr	x0, [sp, #0x110]
  9648e8: b4000040     	cbz	x0, 0x9648f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60290>
  9648ec: 97ea9731     	bl	0x40a5b0 <_ZdlPv@plt>
  9648f0: f940abe0     	ldr	x0, [sp, #0x150]
  9648f4: b4fffda0     	cbz	x0, 0x9648a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60248>
  9648f8: 97ea972e     	bl	0x40a5b0 <_ZdlPv@plt>
  9648fc: 17ffffeb     	b	0x9648a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60248>
  964900: f941ebe3     	ldr	x3, [sp, #0x3d0]
  964904: aa0003f3     	mov	x19, x0
  964908: b4fffdc3     	cbz	x3, 0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  96490c: 52800062     	mov	w2, #0x3                // =3
  964910: aa1603e1     	mov	x1, x22
  964914: aa1603e0     	mov	x0, x22
  964918: d63f0060     	blr	x3
  96491c: 17ffffe9     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964920: f941ebe3     	ldr	x3, [sp, #0x3d0]
  964924: aa0003f3     	mov	x19, x0
  964928: b4fffcc3     	cbz	x3, 0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  96492c: 52800062     	mov	w2, #0x3                // =3
  964930: aa1603e1     	mov	x1, x22
  964934: aa1603e0     	mov	x0, x22
  964938: d63f0060     	blr	x3
  96493c: 17ffffe1     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964940: aa0003f3     	mov	x19, x0
  964944: aa1503e0     	mov	x0, x21
  964948: 94007afe     	bl	0x983540 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc4a0>
  96494c: 17ffffd2     	b	0x964894 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60234>
  964950: f94273e1     	ldr	x1, [sp, #0x4e0]
  964954: aa0003f3     	mov	x19, x0
  964958: b4fffc01     	cbz	x1, 0x9648d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60278>
  96495c: aa0103e0     	mov	x0, x1
  964960: 97ea9714     	bl	0x40a5b0 <_ZdlPv@plt>
  964964: 17ffffdd     	b	0x9648d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60278>
  964968: aa0003f3     	mov	x19, x0
  96496c: 17ffffdb     	b	0x9648d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60278>
  964970: aa0003f3     	mov	x19, x0
  964974: 17ffffdf     	b	0x9648f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60290>
  964978: aa0003f3     	mov	x19, x0
  96497c: 17ffffd1     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964980: aa0003f3     	mov	x19, x0
  964984: 17ffffd1     	b	0x9648c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60268>
  964988: aa0003f3     	mov	x19, x0
  96498c: aa1503e0     	mov	x0, x21
  964990: 97ffb41a     	bl	0x9519f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x4d398>
  964994: 17ffffcf     	b	0x9648d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60270>
  964998: aa0003f3     	mov	x19, x0
  96499c: 17ffffcd     	b	0x9648d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60270>
  9649a0: aa0003f3     	mov	x19, x0
  9649a4: aa1603e0     	mov	x0, x22
  9649a8: 97fe7cc0     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  9649ac: aa1503e0     	mov	x0, x21
  9649b0: 97f95d65     	bl	0x7bbf44 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa2218>
  9649b4: 17ffffbd     	b	0x9648a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60248>
  9649b8: aa0003f3     	mov	x19, x0
  9649bc: 17fffffc     	b	0x9649ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6034c>
  9649c0: f942abe1     	ldr	x1, [sp, #0x550]
  9649c4: aa0003f3     	mov	x19, x0
  9649c8: b4000061     	cbz	x1, 0x9649d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60374>
  9649cc: aa0103e0     	mov	x0, x1
  9649d0: 97ea96f8     	bl	0x40a5b0 <_ZdlPv@plt>
  9649d4: f9429fe0     	ldr	x0, [sp, #0x538]
  9649d8: b4fff580     	cbz	x0, 0x964888 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60228>
  9649dc: 97ea96f5     	bl	0x40a5b0 <_ZdlPv@plt>
  9649e0: 17ffffaa     	b	0x964888 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60228>
  9649e4: f9429fe1     	ldr	x1, [sp, #0x538]
  9649e8: aa0003f3     	mov	x19, x0
  9649ec: b4fff4e1     	cbz	x1, 0x964888 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60228>
  9649f0: aa0103e0     	mov	x0, x1
  9649f4: 97ea96ef     	bl	0x40a5b0 <_ZdlPv@plt>
  9649f8: 17ffffa4     	b	0x964888 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60228>
  9649fc: aa0003f3     	mov	x19, x0
  964a00: aa1503e0     	mov	x0, x21
  964a04: 97fe7ca9     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964a08: aa1603e0     	mov	x0, x22
  964a0c: 97fe7ca7     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964a10: aa1a03e0     	mov	x0, x26
  964a14: aa1303f6     	mov	x22, x19
  964a18: 97fed3aa     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  964a1c: aa1403e0     	mov	x0, x20
  964a20: aa1603f3     	mov	x19, x22
  964a24: 97fe7ca1     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964a28: 17ffffa6     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964a2c: aa0003f3     	mov	x19, x0
  964a30: 17fffff6     	b	0x964a08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x603a8>
  964a34: aa0003f3     	mov	x19, x0
  964a38: 17fffff6     	b	0x964a10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x603b0>
  964a3c: 4e04058c     	dup	v12.4s, v12.s[0]
  964a40: aa0003f6     	mov	x22, x0
  964a44: aa1503e0     	mov	x0, x21
  964a48: 6e0c05cc     	mov	v12.s[1], v14.s[0]
  964a4c: 6e1405ac     	mov	v12.s[2], v13.s[0]
  964a50: 4e1c1f8c     	mov	v12.s[3], w28
  964a54: 3c8b836c     	stur	q12, [x27, #0xb8]
  964a58: bd00026f     	str	s15, [x19]
  964a5c: 97fed399     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  964a60: 17ffffef     	b	0x964a1c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x603bc>
  964a64: aa0003f6     	mov	x22, x0
  964a68: 17ffffed     	b	0x964a1c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x603bc>
  964a6c: aa0003f3     	mov	x19, x0
  964a70: aa1503e0     	mov	x0, x21
  964a74: 94007ab3     	bl	0x983540 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xc4a0>
  964a78: aa1603e0     	mov	x0, x22
  964a7c: 94007f0f     	bl	0x9846b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0xd618>
  964a80: 17ffff90     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964a84: aa0003f3     	mov	x19, x0
  964a88: 17fffffc     	b	0x964a78 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60418>
  964a8c: aa0003f4     	mov	x20, x0
  964a90: aa1503e0     	mov	x0, x21
  964a94: aa1403f3     	mov	x19, x20
  964a98: 97fe7c84     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964a9c: aa1603e0     	mov	x0, x22
  964aa0: 97fe7c82     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  964aa4: 17ffff87     	b	0x9648c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60260>
  964aa8: aa0003e1     	mov	x1, x0
  964aac: aa1403e0     	mov	x0, x20
  964ab0: aa0103f4     	mov	x20, x1
  964ab4: 97fed383     	bl	0x9198c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x15260>
  964ab8: b900027b     	str	w27, [x19]
  964abc: 17fffff5     	b	0x964a90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60430>
  964ac0: f940c3e3     	ldr	x3, [sp, #0x180]
  964ac4: aa0003f4     	mov	x20, x0
  964ac8: b4ffff83     	cbz	x3, 0x964ab8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60458>
  964acc: 52800062     	mov	w2, #0x3                // =3
  964ad0: aa1a03e1     	mov	x1, x26
  964ad4: aa1a03e0     	mov	x0, x26
  964ad8: d63f0060     	blr	x3
  964adc: b900027b     	str	w27, [x19]
  964ae0: 17ffffec     	b	0x964a90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60430>
  964ae4: f940c3e3     	ldr	x3, [sp, #0x180]
  964ae8: aa0003f4     	mov	x20, x0
  964aec: b4fffe63     	cbz	x3, 0x964ab8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60458>
  964af0: 52800062     	mov	w2, #0x3                // =3
  964af4: aa1a03e1     	mov	x1, x26
  964af8: aa1a03e0     	mov	x0, x26
  964afc: d63f0060     	blr	x3
  964b00: b900027b     	str	w27, [x19]
  964b04: 17ffffe3     	b	0x964a90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x60430>
  964b08: aa0003f3     	mov	x19, x0
  964b0c: 17ffffe4     	b	0x964a9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x6043c>
