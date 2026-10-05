#!/usr/bin/env python3
"""Target compile/static inspect only: firmware payload ET_REL, never execute."""
from pathlib import Path
import hashlib,importlib.util,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f1_user_ui_entry_03'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists();OUT.mkdir(parents=True,exist_ok=True)
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];commands=[]
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True)
  if p.returncode:
   fail=OUT/'BUILD_REJECTIONS.json';old=json.loads(fail.read_text())if fail.exists()else[];old.append({'argv':a,'exit':p.returncode,'stdout':p.stdout,'stderr':p.stderr,'target_executed':False});fail.write_text(json.dumps(old,indent=2)+'\n');raise RuntimeError(p.stdout+p.stderr)
  return p.stdout
 run(['python3','-B',HERE/'materialize.py'])
 cpp=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-mno-outline-atomics','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 sources=[HERE/'runtime.cpp',HERE/'module.cpp',HERE/'entry_binding_10.cpp',HERE/'inspector.cpp',ROOT/'tools/firmware/f1_native_ui_02/candidates.cpp',ROOT/'tools/firmware/f4_ui_bootstrap_02/bootstrap.cpp',ROOT/'tools/firmware/f4_ui_counter_01/counter.cpp']
 objects=[];undefined=set();defined=set();nm='/Library/Developer/CommandLineTools/usr/bin/llvm-nm';dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
 for src in sources:
  obj=OUT/(src.stem+'.o');run([*cpp,'-MD','-MF',OUT/(src.stem+'.d'),'-c',src,'-o',obj]);objects.append(obj)
 obj=OUT/'ctor_wrapper.o';run([zig,'cc','-target',lock['target'],'-fPIC','-MD','-MF',OUT/'ctor_wrapper.d','-c',HERE/'ctor_wrapper.S','-o',obj]);objects.append(obj)
 obj=OUT/'compare.o';run([zig,'cc','-target',lock['target'],'-O2','-fPIC','-ffunction-sections','-fvisibility=hidden','-MD','-MF',OUT/'compare.d','-c',HERE/'compare.c','-o',obj]);objects.append(obj)
 for obj in objects:
  (OUT/(obj.stem+'_COMPLETE.txt')).write_text(run([dump,'-dr',obj]))
  for line in run([nm,obj]).splitlines():
   words=line.split()
   if len(words)==2 and words[0]=='U':undefined.add(words[1])
   elif len(words)==3:defined.add(words[2])
 undefined-=defined
 # Preserve all allocated bodies and unwind; final backend does not GC EH.
 spec=importlib.util.spec_from_file_location('elf12',ROOT/'tools/firmware/f1_user_elf_integration_12/inspect.py');e=importlib.util.module_from_spec(spec);spec.loader.exec_module(e)
 stock=e.STOCK.read_bytes();assert hashlib.sha256(stock).hexdigest()==e.STOCK_SHA
 h,ph,records,d,sy,rel,fo=e.elf(stock)
 sh=[struct.unpack_from('<IIQQQQIIQQ',stock,h[6]+i*h[11])for i in range(h[12])];names=sh[h[13]];strings=stock[names[4]:names[4]+names[5]]
 sections={strings[s[0]:strings.index(0,s[0])].decode():s for s in sh};plt=sections['.plt'];slots=[r for r in rel if r['type']==1026]
 originals={}
 for i,r in enumerate(slots):
  va=plt[3]+32+16*i;offset=fo(va,16);w=struct.unpack_from('<IIII',stock,offset)
  assert w[0]&0x9f00001f==0x90000010 and w[1]&0xffc003ff==0xf9400211 and w[2]&0xffc003ff==0x91000210 and w[3]==0xd61f0220
  imm=((w[0]>>5)&0x7ffff)<<2|((w[0]>>29)&3)
  if imm&(1<<20):imm-=1<<21
  got=(va&~4095)+imm*4096+((w[1]>>10)&0xfff)*8;assert got==r['va']
  originals[r['symbol']]={'name':r['symbol'],'va':va,'file_offset':offset,'bytes':16,'original_hex':stock[offset:offset+16].hex(),'jump_slot_va':r['va'],'dynsym_index':r['symbol_index']}
 aliases={'iq4_stock_pthread_mutex_unlock_01':dict(originals['pthread_mutex_unlock'],alias_of='pthread_mutex_unlock'),'iq4_stock_lv_ctor_01':{'name':'iq4_stock_lv_ctor_01','va':0x5175b8,'file_offset':fo(0x5175b8,16),'bytes':16,'original_hex':stock[fo(0x5175b8,16):fo(0x5175b8,16)+16].hex(),'source_call_va':0x4eef2c,'original_call_word':0x9400a1a3}}
 bindings={n:aliases[n]if n in aliases else originals[n]for n in sorted(undefined)if n in originals or n in aliases}
 missing=sorted(set(undefined)-set(bindings))
 asm=(OUT/'ctor_wrapper_COMPLETE.txt').read_text();assert asm.count('R_AARCH64_CALL26\tiq4_stock_lv_ctor_01')==1 and asm.count('R_AARCH64_CALL26\tiq4_f1_publish_ctor_on_return_01')==1
 runtime=(OUT/'runtime_COMPLETE.txt').read_text();assert runtime.count('R_AARCH64_CALL26\tiq4_stock_pthread_mutex_unlock_01')==1 and not any('__aarch64_'in n for n in undefined)
 out={'schema':1,'stage':'real_firmware_UI_payload_ET_REL_not_yet_User','stock_SHA256':e.STOCK_SHA,'Normal11_source_SHA256':'eb4f73531c23942b192156bdef986bad3d8ebf282b24e9d2ca1c0e84d2acfde6','objects':[{'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':sha(p)}for p in objects],'initializer':'iq4_f1_firmware_initialize_01','UI_hook':'iq4_f1_firmware_unlock_01','ctor_hook':'iq4_f1_lv_ctor_wrapper_01','shared_state_symbol':'iq4_f1_state_01','shared_state_bytes':64,'default_requested_mode':0,'bindings':bindings,'object_level_undefined':sorted(undefined),'unbound_object_symbols_before_final_GC':missing,'UI_revision':'03','state_ABI_peer_revision':'01','outline_atomic_helpers':[],'original_unlock_static_call_count':1,'original_ctor_static_call_count':1,'original_ctor_stack_argument_forwarded':True,'target_executed':False,'firmware_generated':False,'UI_installed':False,'actual_display_qualification':False,'five_masks_available':False,'SDK_Windows_network_device_operations':0,'commands':commands}
 (OUT/'OBJECTS_AND_BINDINGS.json').write_text(json.dumps(out,indent=2)+'\n');print(json.dumps({'objects':len(objects),'undefined':sorted(undefined),'unbound':missing,'target_executed':False}))
if __name__=='__main__':main()
