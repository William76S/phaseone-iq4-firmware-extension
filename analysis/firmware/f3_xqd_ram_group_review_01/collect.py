#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS={'XQD_embedded_RAM_ctor':(0x8de850,0x8de8a4),'RamFS_ctor':(0x827fc4,0x828084),'RAM_writer_argument':(0x8df328,0x8df350),'Writer_ctor_FS_save':(0x7d8e30,0x7d8e78),'Writer_open_FS_dispatch':(0x7d8928,0x7d89a0),'RamFS_open':(0x82813c,0x828244),'RamFS_write':(0x828350,0x828458),'XQD_final_card_open':(0x8df664,0x8df6cc),'Native_fanout_notify_refsum':(0x8dc4dc,0x8dc638)}
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 b=USER.read_bytes();assert len(b)==11874544 and sha(b)==SHA
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);ps=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 def get(v,n):
  q=[x for x in ps if x[0]==1 and x[3]<=v and v+n<=x[3]+x[5]];assert len(q)==1;p=q[0];o=p[2]+v-p[3];return o,b[o:o+n]
 rows=[]
 for name,(v,e)in WINDOWS.items():
  o,raw=get(v,e-v);q=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={v}',f'--stop-address={e}',str(USER)],text=True,capture_output=True,check=True)
  text='\n'.join(s.rstrip()for s in q.stdout.splitlines()if s.startswith('  '))+'\n';(HERE/(name+'.asm')).write_text(text);rows.append(dict(label=name,VA=hex(v),end=hex(e),offset=o,bytes=len(raw),sha256=sha(raw),hex=raw.hex(),asm=name+'.asm'))
 o,raw=get(0xd91bf8,0x108);table=dict(VA='0xd91bf8',address_point='0xd91c08',offset=o,bytes=len(raw),sha256=sha(raw),hex=raw.hex(),slots={hex(i-16):hex(struct.unpack_from('<Q',raw,i)[0])for i in range(0,len(raw),8)})
 o,rtti=get(0xd91d48,24);_,name=get(0xd91d60,16)
 peers=[]
 for p in ['tools/firmware/f3_saved_raw_capture_03/runtime.cpp','tools/firmware/f3_saved_raw_capture_03/native_factory.cpp','tools/firmware/f3_native_executor_03/executor.cpp']:
  t=(ROOT/p).read_bytes();peers.append(dict(path=p,bytes=len(t),sha256=sha(t),status='point-in-time draft identity; peer-owned files not frozen by this collector'))
 result=dict(schema='iq4_XQD_RAM_group_review_01',UserSHA256=SHA,windows=rows,table=table,rtti=dict(VA='0xd91d48',offset=o,hex=rtti.hex(),name_VA='0xd91d60',name=name.split(b'\0')[0].decode()),peer_draft_sources=peers,target_executed=False,camera_access=False)
 (HERE/'EXACT.json').write_text(json.dumps(result,indent=2)+'\n')
 print('exact',sha((HERE/'EXACT.json').read_bytes()))
if __name__=='__main__':main()
