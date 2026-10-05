#!/usr/bin/env python3
"""Narrow original User/Boot byte windows; host disassembly only."""
from pathlib import Path
import hashlib,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_scaler_hook_install_build_10'
USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
BOOT_SHA='7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists()
 OUT.mkdir(parents=True,exist_ok=True)
 sys.path.insert(0,str(HERE.parent))
 from save_setup_security_collect_static import sections,span
 from sys_eeprom_range_restore_collect_static import symbolized_elf
 user=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';u=user.read_bytes();assert sha(u)==USER_SHA
 boot=ROOT/'analysis/firmware/extracted/Boot_4.00.13.bin';b=boot.read_bytes();assert sha(b)==BOOT_SHA
 primary=ROOT/'analysis/firmware/f1_scaler_kernel_reference_10/PRIMARY_REFERENCE_MANIFEST.json'
 refs={str(primary.relative_to(ROOT)):sha(primary.read_bytes())}
 for s in json.loads(primary.read_text())['sources']:
  p=ROOT/s['path'];assert len(p.read_bytes())==s['bytes']and sha(p.read_bytes())==s['sha256'];refs[s['path']]=s['sha256']
 ix=struct.unpack_from('<256H',b,0x9eb100);tokens=[b[0x9ead00+i:b.index(0,0x9ead00+i)]for i in ix]
 base=struct.unpack_from('<Q',b,0x984a00)[0];assert base==0xffffff8008080000
 assert struct.unpack_from('<Q',b,0x984b00)[0]==34114
 q=0x984c00;syms=[];markers=[]
 for i in range(34114):
  if i%256==0:markers.append(q-0x984c00)
  n=b[q];s=b''.join(tokens[v]for v in b[q+1:q+1+n]).decode('ascii');q+=1+n
  off=struct.unpack_from('<I',b,0x963400+4*i)[0];syms.append({'name':s[1:],'type':s[0],'linked_va':base+off,'relative_offset':off})
 assert q==0x9ea7b5 and all(struct.unpack_from('<Q',b,0x9ea800+8*i)[0]==v for i,v in enumerate(markers))
 unique=sorted(set(s['linked_va']for s in syms));ends=dict(zip(unique,unique[1:]))
 for s in syms:s['size']=ends.get(s['linked_va'],s['linked_va'])-s['linked_va']
 by={s['name']:s for s in syms};names=['__arm64_sys_ptrace','arch_ptrace','ptrace_request','generic_ptrace_pokedata','ptrace_access_vm','__access_remote_vm','copy_to_user_page','sync_icache_aliases','__flush_icache_range','__clean_dcache_area_pou','kick_all_cpus_sync','do_nothing','smp_call_function_many']
 image=b[0x97400:0xdd4440];analysis=OUT/'kernel_narrow.analysis.elf';analysis.write_bytes(symbolized_elf(image,base,syms))
 dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
 result={'scope':'offline original complete function windows; not runtime qualification','UserSHA':USER_SHA,'BootSHA':BOOT_SHA,'boot_kernel_banner':'4.19.0-p1-iq4-82477-gff46069','runtime_kernel_match_verified':False,'device_operations':0,'target_execution':False,'user_windows':[],'kernel_windows':[],'read_only_refs':refs}
 for name,a,z in [('timer_ctor',0x70be10,0x70be60),('timer_dtor',0x70be60,0x70be84),('timer_stop',0x70bee0,0x70bf3c),('steady_clock_adapter',0x7172bc,0x7172f4)]:
  off,blob,_=span(u,sections(u),a,z);path=OUT/(name+'.user.disasm.txt')
  path.write_text(subprocess.check_output([dump,'-d',f'--start-address={a:#x}',f'--stop-address={z:#x}',str(user)],text=True))
  result['user_windows'].append({'name':name,'va':a,'end_va_exclusive':z,'file_offset':off,'bytes':len(blob),'bytes_hex':blob.hex(),'sha256':sha(blob),'disassembly':str(path.relative_to(ROOT)),'disassembly_sha256':sha(path.read_bytes())})
 for name in names:
  s=by[name];a=s['linked_va'];z=a+s['size'];off=0x97400+s['relative_offset'];blob=b[off:off+s['size']];assert 0<len(blob)<12000
  path=OUT/(name+'.kernel.disasm.txt');path.write_text(subprocess.check_output([dump,'-d',f'--start-address={a:#x}',f'--stop-address={z:#x}',str(analysis)],text=True))
  result['kernel_windows'].append({'name':name,'linked_va':a,'end_va_exclusive':z,'boot_file_offset':off,'bytes':len(blob),'bytes_hex':blob.hex(),'sha256':sha(blob),'disassembly':str(path.relative_to(ROOT)),'disassembly_sha256':sha(path.read_bytes())})
 (OUT/'EXACT_BYTES.json').write_text(json.dumps(result,indent=2)+'\n');(OUT/'.gitignore').write_text('*.o\n*.elf\nhost_*\n')
 print(json.dumps({'user_complete_functions':4,'kernel_complete_functions':len(names),'kernel_image_sha256':sha(image),'runtime_match':False,'device_operations':0}))
if __name__=='__main__':main()
