
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_ram_loader_static/ld-2.28.analysis.elf:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000015400 <_dl_catch_error>:
   166c8: f2402cbf     	tst	x5, #0xfff
   166cc: 54000121     	b.ne	0x166f0 <_dl_catch_error+0x12f0>
   166d0: 93407c42     	sxtw	x2, w2
   166d4: 93407c63     	sxtw	x3, w3
   166d8: 93407c84     	sxtw	x4, w4
   166dc: d2801bc8     	mov	x8, #0xde               // =222
   166e0: d4000001     	svc	#0
   166e4: b140041f     	cmn	x0, #0x1, lsl #12       // =0x1000
   166e8: 540000e8     	b.hi	0x16704 <_dl_catch_error+0x1304>
   166ec: d65f03c0     	ret
   166f0: f00000c1     	adrp	x1, 0x31000 <_dl_argv>
   166f4: 528002c2     	mov	w2, #0x16               // =22
   166f8: 92800000     	mov	x0, #-0x1               // =-1
   166fc: b9013422     	str	w2, [x1, #0x134]
   16700: d65f03c0     	ret
   16704: f00000c1     	adrp	x1, 0x31000 <_dl_argv>
   16708: 4b0003e2     	neg	w2, w0
   1670c: 92800000     	mov	x0, #-0x1               // =-1
   16710: b9013422     	str	w2, [x1, #0x134]
   16714: d65f03c0     	ret
