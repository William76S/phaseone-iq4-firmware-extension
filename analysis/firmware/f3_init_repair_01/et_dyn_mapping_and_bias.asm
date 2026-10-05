
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_ram_loader_static/ld-2.28.analysis.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000001040 <.text>:
    5738: b940d7a0     	ldr	w0, [x29, #0xd4]
    573c: 71000c1f     	cmp	w0, #0x3
    5740: 54004581     	b.ne	0x5ff0 <.text+0x4fb0>
    5744: d10004e0     	sub	x0, x7, #0x1
    5748: 911c82a2     	add	x2, x21, #0x720
    574c: b9402b2e     	ldr	w14, [x25, #0x28]
    5750: 1e260104     	fmov	w4, s8
    5754: 8b000400     	add	x0, x0, x0, lsl #1
    5758: 52810043     	mov	w3, #0x802              // =2050
    575c: f940032d     	ldr	x13, [x25]
    5760: 8b001321     	add	x1, x25, x0, lsl #4
    5764: aa0203e0     	mov	x0, x2
    5768: 2a0e03e2     	mov	w2, w14
    576c: f9401325     	ldr	x5, [x25, #0x20]
    5770: f90057ab     	str	x11, [x29, #0xa8]
    5774: f9400c3c     	ldr	x28, [x1, #0x18]
    5778: b900b3ac     	str	w12, [x29, #0xb0]
    577c: f940d000     	ldr	x0, [x0, #0x1a0]
    5780: cb0d039c     	sub	x28, x28, x13
    5784: aa1c03e1     	mov	x1, x28
    5788: a90bb7a7     	stp	x7, x13, [x29, #0xb8]
    578c: 8a0001a0     	and	x0, x13, x0
    5790: b900cbae     	str	w14, [x29, #0xc8]
    5794: 940043cd     	bl	0x166c8 <_dl_catch_error+0x12c8>
    5798: f901a760     	str	x0, [x27, #0x348]
    579c: b100041f     	cmn	x0, #0x1
    57a0: b940b3ac     	ldr	w12, [x29, #0xb0]
    57a4: b940cbae     	ldr	w14, [x29, #0xc8]
    57a8: f94057ab     	ldr	x11, [x29, #0xa8]
    57ac: a94bb7a7     	ldp	x7, x13, [x29, #0xb8]
    57b0: 54000b00     	b.eq	0x5910 <.text+0x48d0>
    57b4: cb0d000d     	sub	x13, x0, x13
    57b8: 8b1c0000     	add	x0, x0, x28
    57bc: f900036d     	str	x13, [x27]
    57c0: f901ab60     	str	x0, [x27, #0x350]
