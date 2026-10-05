#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS={'Main_contexts_actual_weights':(0x41a730,0x41a7d4),'Context_ctor_actual_arguments':(0x5e36f0,0x5e3750),'Context_ctor_weight_store':(0x5e3b04,0x5e3b50),'Main_XQD_context_plus8':(0x4247b0,0x424844),'Main_SD_context_plus10':(0x424844,0x42489c),'Main_manager_array_count3':(0x4248cc,0x424928),'Manager_ctor_array_identity':(0x8daedc,0x8db024),'Actual_selection_before_notify_and_refsum':(0x8dc4cc,0x8dc638),'Actual_predicate':(0x8dc278,0x8dc3fc)}
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
 o,raw=get(0xdbc280,0x60);table=dict(VA='0xdbc280',offset=o,bytes=len(raw),sha256=sha(raw),hex=raw.hex(),slots={hex(i):hex(struct.unpack_from('<Q',raw,i)[0])for i in range(0,len(raw),8)})
 result=dict(schema='iq4_actual_fanout_weights_review_01',UserSHA256=SHA,windows=rows,table=table,target_executed=False,camera_access=False)
 (HERE/'EXACT.json').write_text(json.dumps(result,indent=2)+'\n')
 print('exact',sha((HERE/'EXACT.json').read_bytes()))
if __name__=='__main__':main()
