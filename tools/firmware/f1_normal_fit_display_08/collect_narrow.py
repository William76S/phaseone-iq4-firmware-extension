#!/usr/bin/env python3
"""Only three original background candidates; exact bytes, no target calls."""
import hashlib,json,re,subprocess
from hook_plan import ROOT,HERE,USER_SHA
OUT=ROOT/'analysis/firmware/f1_normal_fit_display_build_08'
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists();source=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';raw=source.read_bytes();assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()==USER_SHA
 rows=[];OUT.mkdir(parents=True,exist_ok=True)
 for name,start,end in [('Control_outline_wrapper',0x45ac38,0x45acb4),('Outline_argument_wrapper',0x46f0c4,0x46f184),('Outline_point_line_edges_dispatch',0x46ed20,0x46f0c4)]:
  data=raw[start-0x400000:end-0x400000];assert data[-4:]==bytes.fromhex('c0035fd6')
  text=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',source],cwd=ROOT,text=True)
  lines=[x.split(' <')[0].split(' //')[0].rstrip()for x in text.splitlines()if re.match(r'  [0-9a-f]+:',x)]
  p=OUT/(name+'_COMPLETE.disasm.txt');p.write_text('EXACT USER SHA256 '+USER_SHA+'\nSTATIC ONLY; three finite outline candidates, not background fill proof.\n'+'\n'.join(lines)+'\n')
  rows.append({'name':name,'start_va':hex(start),'end_va_exclusive':hex(end),'bytes':len(data),'bytes_hex':data.hex(),'sha256':hashlib.sha256(data).hexdigest(),'disassembly':str(p.relative_to(ROOT)),'disassembly_sha256':hashlib.sha256(p.read_bytes()).hexdigest()})
 (OUT/'BACKGROUND_EXACT.json').write_text(json.dumps({'schema':'iq4_f1_normal08_outline_negative_exact_v1','original_UserSHA':USER_SHA,'original_User_bytes':len(raw),'source':str(source.relative_to(ROOT)),'functions':rows,'whole_interior_background_clean_verified':False,'positive_edges':['46ef20..46ef30 top horizontal','46ef64..46ef74 bottom horizontal','46efd0..46efe0 left vertical','46f014..46f024 right vertical'],'may_promote_Control_6c_to_full_clear':False,'target_executed':False},indent=2)+'\n')
 print(json.dumps({'functions':3,'bytes':sum(r['bytes']for r in rows),'full_background_clear':False}))
if __name__=='__main__':main()
