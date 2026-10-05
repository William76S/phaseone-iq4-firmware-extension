
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_ram_loader_static/ld-2.28.analysis.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000001040 <.text>:
    5944: 911c82a3     	add	x3, x21, #0x720
    5948: f9401b88     	ldr	x8, [x28, #0x30]
    594c: f9400c66     	ldr	x6, [x3, #0x18]
    5950: d10004c3     	sub	x3, x6, #0x1
    5954: ea03011f     	tst	x8, x3
    5958: 54000c81     	b.ne	0x5ae8 <.text+0x4aa8>
    595c: a940b78b     	ldp	x11, x13, [x28, #0x8]
    5960: d1000508     	sub	x8, x8, #0x1
    5964: cb0b01a9     	sub	x9, x13, x11
    5968: ea08013f     	tst	x9, x8
    596c: 54000e81     	b.ne	0x5b3c <.text+0x4afc>
    5970: d37ffac9     	lsl	x9, x22, #1
    5974: cb0603e6     	neg	x6, x6
    5978: 8b160128     	add	x8, x9, x22
    597c: 8a0601b0     	and	x16, x13, x6
    5980: 8a06016b     	and	x11, x11, x6
    5984: 910006d1     	add	x17, x22, #0x1
    5988: d37ced08     	lsl	x8, x8, #4
    598c: f100063f     	cmp	x17, #0x1
    5990: 8b08032a     	add	x10, x25, x8
    5994: f8286b30     	str	x16, [x25, x8]
    5998: a942238e     	ldp	x14, x8, [x28, #0x20]
    599c: f900114b     	str	x11, [x10, #0x20]
    59a0: 8b0e01ae     	add	x14, x13, x14
    59a4: 8b0e0063     	add	x3, x3, x14
    59a8: 8a060066     	and	x6, x3, x6
    59ac: a900b946     	stp	x6, x14, [x10, #0x8]
    59b0: 8b0d0106     	add	x6, x8, x13
    59b4: f9000d46     	str	x6, [x10, #0x18]
    59b8: 54000089     	b.ls	0x59c8 <.text+0x4988>
    59bc: f85d8143     	ldur	x3, [x10, #-0x28]
    59c0: eb10007f     	cmp	x3, x16
    59c4: 1a800318     	csel	w24, w24, w0, eq
    59c8: 8b160123     	add	x3, x9, x22
    59cc: b9400780     	ldr	w0, [x28, #0x4]
    59d0: aa1103f6     	mov	x22, x17
    59d4: 8b031323     	add	x3, x25, x3, lsl #4
    59d8: 531e0800     	ubfiz	w0, w0, #2, #3
    59dc: 1ac029e0     	asr	w0, w15, w0
    59e0: 12000c00     	and	w0, w0, #0xf
    59e4: b9002860     	str	w0, [x3, #0x28]
    59e8: 17ffff33     	b	0x56b4 <.text+0x4674>
