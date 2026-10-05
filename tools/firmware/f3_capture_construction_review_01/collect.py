#!/usr/bin/env python3
import hashlib,json,pathlib,struct,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent
U=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS=[('start_libc_main_csu_arguments',0x40b38c,0x40b3dc),('Main_call_from_main',0x40bd78,0x40bdbc),('Main_creates_starts_UI',0x4270bc,0x4270ec),('UI_constructor_vtable',0x4ed574,0x4ed5c4),('UI_run_builds_menu',0x4ef2f0,0x4ef304),('menu_build_owner_args',0x4f01d4,0x4f0208),('FileSettings_title_root_append',0x4f0ac0,0x4f0af4),('FileSettings_final_append',0x4f0d20,0x4f0d38),('UI_vtable_Run',0xb91f38,0xb91f60)]
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 b=U.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA;out=ROOT/'analysis/firmware/f3_capture_construction_review_01';out.mkdir(exist_ok=True);rows=[]
 for name,a,z in WINDOWS:
  raw=b[a-0x400000:z-0x400000];p=out/(name+'.asm');r=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={a}',f'--stop-address={z}',str(U)],text=True,capture_output=True,check=True);p.write_text('\n'.join(x.rstrip()for x in r.stdout.splitlines())+'\n');rows.append(dict(name=name,start=a,end=z,file_offset=a-0x400000,bytes_hex=raw.hex(),sha256=hashlib.sha256(raw).hexdigest(),assembly=row(p)))
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);ss=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])];calls=[]
 for s in ss:
  if not(s[2]&4):continue
  for p in range(s[4],s[4]+s[5]-3,4):
   ins=struct.unpack_from('<I',b,p)[0]
   if ins&0xfc000000!=0x94000000:continue
   va=s[3]+p-s[4];imm=ins&0x3ffffff;imm-=0x4000000 if imm&0x2000000 else 0
   if va+4*imm==0x4f01d4:calls.append(va)
 assert calls==[0x4ef300];arrays=[s for s in ss if s[1]==14];assert len(arrays)==1;init=arrays[0];entries=struct.unpack_from('<%dQ'%(init[5]//8),b,init[4]);assert len(entries)==340
 vt=struct.unpack_from('<Q',b,0xb91f58-0x400000)[0];assert vt==0x4ed960
 cpp=ROOT/'analysis/firmware/f3_save_coordinator_build_06/coordinator.o';c=cpp.read_bytes();ch=struct.unpack_from('<16sHHIQQQIHHHHHH',c);css=[struct.unpack_from('<IIQQQQIIQQ',c,ch[6]+i*ch[11])for i in range(ch[12])];assert not any(s[1]in(14,16)for s in css)
 result=dict(schema='iq4_f3_stock_FileSettings_construction_review_01',stock_User=row(U),windows=rows,original_init_array=dict(va=init[3],bytes=init[5],count=340,entries_sha256=hashlib.sha256(b[init[4]:init[4]+init[5]]).hexdigest()),original_start_main=0x40b4e8,original_csu=0x9ef0b0,FileSettings_build_function=[0x4f01d4,0x4f3034],direct_BL_callers=calls,call_search_scope='all original executable ELF sections; does not assert all indirect callers absent',UI_Run_vtable_slot=0x4ed960,coordinator_object=row(cpp),coordinator_has_INIT_or_PREINIT_sections=False,conclusion='normal stock Main->CThread.Start->UI.Run->FileSettings runs after libc csu constructors; no wrapper05 necessary for this timing',factory_registration_failure='actual ready remains false; not upgraded by static timing; failed factory is not blindly retried',target_executed=False,camera_access=False)
 (out/'REVIEW.json').write_text(json.dumps(result,indent=2)+'\n');members=[p for p in out.iterdir()if p.is_file()and p.name!='SHA256.json']+[HERE/'collect.py'];(out/'SHA256.json').write_text(json.dumps(dict(files=[row(p)for p in sorted(members)],target_executed=False,camera_access=False),indent=2)+'\n');print(row(out/'REVIEW.json'));print(row(out/'SHA256.json'))
if __name__=='__main__':main()
