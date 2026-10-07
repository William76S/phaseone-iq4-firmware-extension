#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,importlib.util,subprocess
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_pair_delete_61';O.mkdir(exist_ok=True)
p=R/'analysis/firmware/half_request_owner_independent_59/verify_final.py';s=importlib.util.spec_from_file_location('jpeg_pair_elf',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
U=R/'analysis/firmware/extracted/P1Linux_6.03.21.bin';e=m.Elf(U);assert hashlib.sha256(U.read_bytes()).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
windows=[(0x493e60,128),(0x493f08,88),(0x493fc4,44),(0x4942b8,12),(0x4942c8,12),(0x494364,88),(0x494424,140),(0x4944b8,12),(0x494518,244),(0x494614,12),(0x494674,28),(0x4947d0,68),(0x494844,64),(0x825770,68),(0x82595c,76),(0x826a8c,144),(0x827348,1212),(0x9ef138,16),(0xd90410,32),(0xd91450,0x140),(0xb7eaa0,48),(0x8ca888,424),(0x8ca708,360),(0x495448,84),(0x492dac,32),(0x492e44,28),(0x492ef8,8),(0xb7ece0,40)]
rows=[]
for a,n in windows:
 for off in range(0,n,64):
  size=min(64,n-off);rows.append(dict(va=a+off,bytes=size,hex=e.va(a+off,size).hex()))
# Exclude the two new BL words, even if a parent window accidentally expands.
for q in rows:
 assert not any(q['va']<=h<q['va']+q['bytes'] for h in (0x4942c4,0x4944b4,0x494610)),q
lines=['#ifndef IQ4_JPEG_PAIR_PINS_61_H','#define IQ4_JPEG_PAIR_PINS_61_H','#include <stdint.h>','#include <stddef.h>','struct JpegPairPin61 {uintptr_t address;size_t bytes;const unsigned char*expected;};']
for i,q in enumerate(rows):lines.append('static const unsigned char JpegPairBytes61_'+str(i)+'[]={'+','.join('0x'+q['hex'][j:j+2]for j in range(0,len(q['hex']),2))+'};')
lines.append('static const struct JpegPairPin61 JpegPairPins61[]={'+','.join('{'+hex(q['va'])+',sizeof(JpegPairBytes61_'+str(i)+'),JpegPairBytes61_'+str(i)+'}'for i,q in enumerate(rows))+'};')
lines.append('#endif');(D/'pins.h').write_text('\n'.join(lines)+'\n')
hooks=[dict(va=a,old_hex=e.va(a,4).hex(),original_target=0x82595c,target_symbol=name)for a,name in [(0x4944b4,'iq4_jpeg_pair_sd_raw_wrapper_61'),(0x494610,'iq4_jpeg_pair_xqd_raw_wrapper_61')]]
hooks.append(dict(va=0x4942c4,old_hex=e.va(0x4942c4,4).hex(),original_target=0x495448,target_symbol='iq4_jpeg_only_delete_wrapper_61'))
(O/'EXACT.json').write_text(json.dumps(dict(stock_sha256=hashlib.sha256(U.read_bytes()).hexdigest(),BL_hooks=hooks,pins=rows,delete_policy_table=[dict(sd_mode=i,xqd_raw=b[4],sd_raw=b[5],sd_jpeg=b[6])for i,b in enumerate([e.va(0xb7eaa0+j*8,8)for j in range(6)])],camera_accessed=False),indent=2)+'\n')
for name,a,z in [('Native_DeleteFile',0x493e60,0x4948e4),('Native_FileDelete',0x82595c,0x8259a8),('Native_PathDelete',0x826a8c,0x826b1c)]:
 q=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d','--start-address='+hex(a),'--stop-address='+hex(z),str(U)],capture_output=True,text=True);assert q.returncode==0;(O/(name+'.asm')).write_text(q.stdout)
print('Exact native windows captured:',len(rows),'and two unmodified original BL words')
