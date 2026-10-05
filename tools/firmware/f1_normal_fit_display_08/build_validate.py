#!/usr/bin/env python3
"""New owned fixtures, AArch64 ET_REL and static evidence; no target loading."""
from pathlib import Path
import hashlib,json,re,struct,subprocess,sys
from hook_plan import ROOT,HERE,source_evidence,plan,FIRST
OUT=ROOT/'analysis/firmware/f1_normal_fit_display_build_08'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def object_elf(raw):
 assert raw[:7]==b'\x7fELF\x02\x01\x01';h=struct.unpack_from('<16sHHIQQQIHHHHHH',raw)
 assert h[1]==1 and h[2]==183 and h[11]==64 and 0<h[12]<4096 and 0<h[13]<h[12]
 ss=[struct.unpack_from('<IIQQQQIIQQ',raw,h[6]+i*64)for i in range(h[12])];strings=ss[h[13]];names=raw[strings[4]:strings[4]+strings[5]]
 def string(b,i):assert i<len(b);end=b.find(b'\0',i);assert end>=i;return b[i:end].decode()
 sections={string(names,s[0]):s for s in ss};symbols=sections['.symtab'];assert symbols[9]==24;st=ss[symbols[6]];strings=raw[st[4]:st[4]+st[5]];undefined=[];defined=[]
 for o in range(symbols[4],symbols[4]+symbols[5],24):
  n,info,other,sec,value,size=struct.unpack_from('<IBBHQQ',raw,o)
  if n and info>>4 in(1,2):
   name=string(strings,n)
   (undefined if sec==0 else defined).append(name)
 return h,sections,sorted(set(defined)),sorted(set(undefined))
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen source cannot be rebuilt'
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('host_*\n')
 commands=[];refs={}
 def run(args):
  args=list(map(str,args));commands.append(args);p=subprocess.run(args,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 manifest=HERE.parent/'f1_native_entry_binding_07/SOURCE_SHA256.json';d=json.loads(manifest.read_text());refs[str(manifest.relative_to(ROOT))]=sha(manifest)
 for group in ('members','frozen_refs','review_artifacts'):
  for r in d.get(group,[]):p=ROOT/r['path'];assert p.stat().st_size==r['bytes']and sha(p)==r['sha256'];refs[r['path']]=r['sha256']
 sdk=run(['xcrun','--show-sdk-path']).strip();inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 source=[HERE/'normal_fit.cpp',HERE/'provider.cpp',HERE/'test_normal.cpp',HERE.parent/'f1_native_entry_binding_07/binding.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
 tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('host_'+name);run(['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-DIQ4_F1_NORMAL08_OWNED_HOST_FIXTURE','-isystem',sdk+'/usr/include/c++/v1',*flags,*inc,*source,'-o',exe]);receipt=run([exe]);assert receipt=='11 owned normal-fit/production-ingress/OFF/zoom/owner fault groups PASS; target execution zero\n';tests[name]={'groups':11,'receipt':receipt.strip()}
 contract=json.loads(run([sys.executable,HERE/'test_plan.py']));assert contract['passed']and contract['checks']==15
 narrow=json.loads(run([sys.executable,HERE/'collect_narrow.py']));assert narrow['functions']==3 and not narrow['full_background_clear']
 user=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';refs[str(user.relative_to(ROOT))]=sha(user)
 tool=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==tool['zig_binary_sha256']and run([zig,'version']).strip()==tool['version'];refs['tools/target/toolchain.lock.json']=sha(ROOT/'tools/target/toolchain.lock.json')
 cc=[zig,'c++','-target',tool['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
 objects=[]
 for name in('normal_fit','provider','hook_capture','integration'):
  p=OUT/(name+'.o');run([*cc,'-c',HERE/(name+'.cpp'),'-o',p]);objects.append(p)
 asm=OUT/'scaler_bridge.o';run([zig,'cc','-target',tool['target'],'-fPIC','-c',HERE/'scaler_bridge.S','-o',asm]);objects.append(asm)
 layout=OUT/'layout_target.o';run([*cc,'-c',HERE/'layout_target.cpp','-o',layout]);host_layout=OUT/'host_layout';run(['/usr/bin/clang++','-std=c++17','-O2','-isystem',sdk+'/usr/include/c++/v1',*inc,HERE/'layout_host.cpp','-o',host_layout]);actual_layout=json.loads(run([host_layout]));_,layout_sections,_,_=object_elf(layout.read_bytes());ro=layout_sections['.rodata'];layout_raw=layout.read_bytes()[ro[4]:ro[4]+ro[5]];assert len(layout_raw)==64 and list(struct.unpack('<8Q',layout_raw))==actual_layout
 (OUT/'PUBLICATION_LAYOUT.json').write_text(json.dumps({'schema':'iq4_f1_normal08_ingress_layout_v8','symbol':'iq4_f1_normal_fit_ingress_observed_08','PublishedIngress_bytes':actual_layout[0],'IngressStatus_bytes':actual_layout[1],'WriteFacts_bytes':actual_layout[2],'Geometry_bytes':actual_layout[3],'publication_metadata_offset':actual_layout[4],'status_last_offset':actual_layout[5],'ScalerCapture_bytes':actual_layout[6],'capture_arguments_offset':actual_layout[7],'target_object_sha256':sha(layout),'host_and_AArch64_same':True,'actual_module_loaded':False},indent=2)+'\n')
 dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';dwarf='/Library/Developer/CommandLineTools/usr/bin/llvm-dwarfdump'
 disasm={}
 for p in objects:
  s=run([dump,'-dr',p]);(OUT/(p.stem+'_COMPLETE.disasm.txt')).write_text(s);disasm[p.stem]=s
 a=disasm['scaler_bridge'];assert a.count('blr\tx16')==1 and 'iq4_f1_scaler_after_08'in a
 assert 'sub\tsp, sp, #0x400'in a or 'sub\tsp, sp, #1024'in a
 assert 'iq4_f1_scaler_trampoline_08'in a
 for i in range(0,32,2):assert f'stp\tq{i}, q{i+1}'in a and f'ldp\tq{i}, q{i+1}'in a
 for i in range(0,18,2):assert f'stp\tx{i}, x{i+1}'in a and f'ldp\tx{i}, x{i+1}'in a
 for s in('tpidr_el0','nzcv','fpcr','fpsr'):assert s in a.lower()
 # This also binds the actual C++ call edge to the frozen installer; no
 # inherited configure() flag or fixture macro is used in target compilation.
 assert 'install_selection_once_on_ui'in disasm['normal_fit']and 'observe_stock_paint_on_ui'in disasm['normal_fit']
 frames=run([dwarf,'--eh-frame',asm]);(OUT/'SCALER_BRIDGE_CFI.txt').write_text(frames);assert 'CFA=WSP+1024'in frames and 'W30=[CFA-880]'in frames and 'W29=[CFA-888]'in frames
 object_metadata=[]
 for p in objects:
  h,sections,defined,undefined=object_elf(p.read_bytes());assert h[1]==1 and h[2]==183
  object_metadata.append({'path':str(p.relative_to(ROOT)),'bytes':p.stat().st_size,'sha256':sha(p),'elf_type':'ET_REL','sections':sorted(sections),'defined':defined,'undefined':undefined})
 exact=ROOT/'analysis/firmware/f1_geometry_probe_03/static/exact_bytes.json';e=json.loads(exact.read_text());refs[str(exact.relative_to(ROOT))]=sha(exact)
 rows=[]
 for name in('Scaler_dispatch_complete','Default_multirow_complete','RGB24_row_wrapper_complete','RGB24_row_leaf_complete','Blit_zero_clip_and_return_complete','Blit_quarterturn_dispatch_complete','Manager_draw_scope_complete','LV_paint_complete'):
  r=next(r for r in e['ranges']if r['name']==name);raw=bytes.fromhex(r['bytes_hex']);assert sha_bytes(raw)==r['sha256'];p=ROOT/r['disassembly'];assert sha(p)==r['disassembly_sha256'];refs[r['disassembly']]=sha(p)
  rows.append({k:r[k]for k in('name','start_va','end_va_exclusive','file_offset','sha256','disassembly','disassembly_sha256')})
 original=next(r for r in e['ranges']if r['name']=='Scaler_dispatch_complete');raw=bytes.fromhex(original['bytes_hex']);assert struct.unpack_from('<I',raw)[0]==FIRST and len(raw)==0x450
 evidence={'schema':'iq4_f1_normalfit08_static_hook_assessment','source':source_evidence(),'exact_original_functions':rows,'original_entry_first_word':hex(FIRST),'first_instruction':'sub sp,sp,#0x100','original_body_bytes':len(raw),'original_stack_argument_extent_bytes':40,'accepted_original_call_return_pcs_for_zero_rotation_RGB24_only':['0x475908'],'rejected_other_zero_rotation_formats':['0x475838','0x4759cc'],'original_fp_saved_return_chain':['caller 47552c FP+8 = 0x47718c','caller 477038 FP+8 = 0x51ddd0','LV paint FP+8 = 0x4abe94','Control Draw FP+8 = 0x4e33bc'],'synthetic_byte_plan':plan(0x500000,0x500100,0x7ffff0000000),'entry_word_relocation_possible':True,'transparent_installation_proven':False,'actual_write_token_issuer_present':True,'supported_provider_profile':'RootReviewedInlineUIRetainedUntilPresent','actual_provider_contract_received':False,'production_provider_getter_called':False,'production_native_blit_or_fill_called':False,'target_text_written':False,'target_loaded':False,'default_mask_enabled':False}
 (OUT/'HOOK_ASSESSMENT.json').write_text(json.dumps(evidence,indent=2)+'\n')
 result={'schema':'iq4_f1_normal_fit_display_source_preparation_v8','stage':'source_and_ET_REL_only','tests':tests,'plan_tests':contract,'objects':object_metadata,'dependencies':refs,'actual_UI_or_module_loaded':False,'actual_selection_port_installed':False,'actual_provider_lease_unknown':True,'production_PaintToken_issuer':'ProvenProviderAdapter::dispatch_scaler_return_on_ui','actual_provider_contract_received':False,'actual_fresh_stock_write_verified':False,'default_mask_enabled':False,'new_enabled_SO_generated':False,'device_or_SDK_or_Windows_or_network_used':False,'frozen_sources_modified':False,'commands':commands}
 (OUT/'BUILD_VALIDATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'tests':tests,'plan_tests':contract,'objects':object_metadata,'target_loaded':False,'issuer':'ProvenProviderAdapter::dispatch_scaler_return_on_ui'},indent=2))
def sha_bytes(b):return hashlib.sha256(b).hexdigest()
if __name__=='__main__':main()
