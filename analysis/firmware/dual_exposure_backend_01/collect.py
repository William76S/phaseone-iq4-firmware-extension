#!/usr/bin/env python3
"""Finite original-byte windows for Dual Ratio provenance; local/offline only."""
from pathlib import Path
import hashlib,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];SRC=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS=[('Main_status',0x41a118,0x41a130),('Status_dual_fields',0x5c1e14,0x5c1e74),('Main_sensors',0x41e550,0x41e610),('Main_controller_arguments',0x41e844,0x41e9b4),('Controller_ctor_arguments',0x7988e0,0x79894c),('Controller_sensor_field',0x7992e0,0x79930c),('Controller_status_field',0x799388,0x799418),('Controller_ratio_subscription',0x79954c,0x79957c),('Controller_initial_ratio',0x793bf0,0x793c28),('Controller_ratio_event',0x79cb08,0x79cbb8),('Sensor_ratio_setter',0x80e794,0x80e800),('IMX411_ratio_product',0x822adc,0x822b04),('IMX461_ratio_product',0x81c1c0,0x81c1e8),('Ratio_config',0x5c3454,0x5c3504),('Float_current_getter',0x432314,0x43234c),('Float_setter',0x44136c,0x4413ec),('U32_current_getter',0x40c880,0x40c8b4),('Original_dual_update',0x5384cc,0x538684),('Native_base_bounds',0x538684,0x538854),('Main_sequence_group',0x41a1bc,0x41a1d4),('Main_CoreUiData_sequence',0x426de8,0x426df0),('CoreUiData_sequence_field',0x431230,0x43123c),('Dual_busy_pointer',0x5364a8,0x5364c0),('Dual_busy_dispatch',0x5378e0,0x537958),('RunningSequence_ctor',0x5f9d3c,0x5f9ddc)]
b=SRC.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);P=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
def off(v,n):
 for p in P:
  if p[0]==1 and p[3]<=v and v+n<=p[3]+p[5]:return p[2]+v-p[3]
 raise ValueError(hex(v))
def row(p):
 d=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(d),sha256=hashlib.sha256(d).hexdigest())
out=Path(sys.argv[1]).resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
rows=[]
for name,a,z in WINDOWS:
 o=off(a,z-a);d=b[o:o+z-a];cmd=['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={hex(a)}',f'--stop-address={hex(z)}',str(SRC.relative_to(ROOT))]
 q=subprocess.run(cmd,cwd=ROOT,text=True,capture_output=True);assert q.returncode==0
 p=out/(name+'.asm');p.write_text('\n'.join(x.rstrip()for x in q.stdout.splitlines())+'\n')
 rows.append(dict(name=name,va=a,bytes=len(d),file_offset=o,sha256=hashlib.sha256(d).hexdigest(),hex_LE=d.hex(),disassembly=row(p),command=cmd))
vts=[]
for vt in [0xd8d540,0xd8d8d8,0xd8dd98,0xd8eee0,0xd90028]:
 o=off(vt-16,0x98);d=b[o:o+0x98];r=struct.unpack_from('<Q',b,off(vt-8,8))[0];nv=struct.unpack_from('<Q',b,off(r+8,8))[0];no=off(nv,1);name=b[no:b.index(0,no)].decode()
 assert struct.unpack_from('<Q',b,off(vt+0x80,8))[0]==0x80e794
 vts.append(dict(vtable=vt,RTTI=r,name_va=nv,name=name,slot80=0x80e794,window_va=vt-16,bytes=len(d),file_offset=o,hex_LE=d.hex(),sha256=hashlib.sha256(d).hexdigest()))
ns=0xbd0790;no=off(ns,16);assert b[no:no+16]==b'RunningSequence\0'
j=dict(schema='iq4_dual_ratio_hardware_forward_static_01',source=row(SRC),windows=rows,sensor_vtables=vts,RunningSequence_string=dict(va=ns,bytes=16,file_offset=no,hex_LE=b[no:no+16].hex()),level='static_analysis',target_executed=False,camera_accessed=False)
p=out/'EXACT.json';p.write_text(json.dumps(j,indent=2)+'\n');print(len(rows),'exact windows;',len(vts),'sensor tables')
