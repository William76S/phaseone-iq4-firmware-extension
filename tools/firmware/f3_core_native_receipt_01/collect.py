#!/usr/bin/env python3
"""Finite immutable-original windows, three core BLs and composed decoder BL."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 if out.exists() or not out.is_relative_to(ROOT):raise ValueError('fresh local output required')
 data=USER.read_bytes();assert len(data)==11874544 and hashlib.sha256(data).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 out.mkdir(parents=True);rows=[];commands=[];header=['/* Exact original windows. Three core BLs and the composed decoder BL checked separately. */','#ifndef IQ4_CORE_PINS_01_H','#define IQ4_CORE_PINS_01_H','#include <stdint.h>','#include <stddef.h>','struct Iq4CorePin01 {uintptr_t va;size_t n;const unsigned char*bytes;};']
 for i,(name,start,end) in enumerate([('Core',0x919d58,0x91b278),('Preview',0x963a28,0x964b10),('Join',0x716e60,0x717024),('ClockPLT',0x40a8f0,0x40a900)]):
  b=data[start-0x400000:end-0x400000];assert len(b)==end-start
  argv=['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={start}',f'--stop-address={end}',str(USER)]
  q=subprocess.run(argv,capture_output=True,text=True);assert q.returncode==0
  commands.append(dict(argv=argv,exit=q.returncode,stderr=q.stderr))
  asm=out/(name+'.asm');asm.write_text('\n'.join(s.rstrip() for s in q.stdout.splitlines())+'\n')
  header.append('static const unsigned char iq4_core_pin_bytes_%d[]={%s};'%(i,','.join('0x%02x'%x for x in b)))
  rows.append(dict(name=name,va=hex(start),end=hex(end),bytes=len(b),sha256=hashlib.sha256(b).hexdigest(),asm=str(asm.relative_to(ROOT)),asm_sha256=hashlib.sha256(asm.read_bytes()).hexdigest()))
 header.append('static const struct Iq4CorePin01 iq4_core_pins_01[]={'+','.join('{0x%x,%d,iq4_core_pin_bytes_%d}'%(int(r['va'],16),r['bytes'],i) for i,r in enumerate(rows))+'};\n#endif\n')
 (HERE/'pins.h').write_text('\n'.join(header));patch=[]
 for pc,target,name in [(0x964860,0x919d58,'iq4_f3_core_native_wrapper_01'),(0x91a78c,0x716e60,'iq4_f3_core_native_join_wrapper_01'),(0x91a964,0x40a8f0,'iq4_f3_core_native_terminal_wrapper_01'),(0x963d28,0x9227b0,'iq4_f3_decode_native_reader_wrapper_02')]:
  b=data[pc-0x400000:pc-0x400000+4];w=struct.unpack('<I',b)[0];imm=w&0x3ffffff;imm-=1<<26 if imm&(1<<25) else 0;assert w>>26==0x25 and pc+imm*4==target
  patch.append(dict(va=hex(pc),original_target=hex(target),old_bytes=b.hex(),wrapper=name))
 (out/'EXACT.json').write_text(json.dumps(dict(original_SHA256=hashlib.sha256(data).hexdigest(),windows=rows,patch_sites=patch,pins_header_SHA256=hashlib.sha256((HERE/'pins.h').read_bytes()).hexdigest(),target_executed=False),indent=2)+'\n')
 (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');print(json.dumps(dict(windows=len(rows),bytes=sum(r['bytes'] for r in rows),device_access=False)))
if __name__=='__main__':main()
