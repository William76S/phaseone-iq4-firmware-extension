
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .plt:

000000000040aae0 <pthread_mutex_lock@plt>:
  40aae0: b00059d0     	adrp	x16, 0xf43000
  40aae4: f943c611     	ldr	x17, [x16, #0x788]
  40aae8: 911e2210     	add	x16, x16, #0x788
  40aaec: d61f0220     	br	x17
