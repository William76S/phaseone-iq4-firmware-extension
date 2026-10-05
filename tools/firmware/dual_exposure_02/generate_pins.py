#!/usr/bin/env python3
from pathlib import Path
import hashlib,importlib.util,sys,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('dual_pin_elf',ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py');m=importlib.util.module_from_spec(s);sys.modules[s.name]=m;s.loader.exec_module(m)
b=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();assert hashlib.sha256(b).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb';e=m.Elf(b,2)
ranges=[(0x536e7c,0x536ed8),(0x5378e0,0x537958),(0x53795c,0x537b08),(0x537b48,0x537e68),(0x537e6c,0x538540),(0x538544,0x538854),(0x4ac590,0x4ac740),(0xb846e0,0xb84840),(0xba25f8,0xba28c0),(0x44136c,0x4413ec),(0x432314,0x43234c),(0x4e1a2c,0x4e1a44),(0x9f8508,0x9f85b0),(0x5c3454,0x5c34a4)]
out=['#ifndef IQ4_DUAL_PINS_01_H','#define IQ4_DUAL_PINS_01_H','#include <stdint.h>','#include <stddef.h>','struct DualPin01 {uintptr_t va;size_t bytes;const unsigned char *data;};'];rows=[]
for i,(a,z) in enumerate(ranges):
 d=b[e.va_offset(a,z-a):][:z-a];out.append('static const unsigned char dual_pin_%d[]={%s};'%(i,','.join('0x%02x'%v for v in d)));rows.append(dict(va=a,bytes=len(d),sha256=hashlib.sha256(d).hexdigest()))
out.append('static const DualPin01 dual_pins_01[]={'+','.join('{0x%x,%d,dual_pin_%d}'%(a,z-a,i)for i,(a,z)in enumerate(ranges))+'};');out.append('#endif');
for filename, text in [('pins.h','\n'.join(out)+'\n'),('PINS.json',json.dumps(rows,indent=2)+'\n')]:
 p=HERE/filename
 if p.exists():assert p.read_text()==text, filename+' frozen output mismatch'
 else:p.write_text(text)
