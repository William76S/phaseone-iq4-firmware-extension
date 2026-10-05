
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .plt:

000000000040a730 <pthread_mutex_unlock@plt>:
  40a730: b00059d0     	adrp	x16, 0xf43000
  40a734: f942da11     	ldr	x17, [x16, #0x5b0]
  40a738: 9116c210     	add	x16, x16, #0x5b0
  40a73c: d61f0220     	br	x17
