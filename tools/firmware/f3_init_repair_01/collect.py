#!/usr/bin/env python3
from pathlib import Path
import hashlib,importlib.util,json,re,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_init_repair_01'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def main():
 s=importlib.util.spec_from_file_location('init_repair_elf',ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py');m=importlib.util.module_from_spec(s);sys.modules[s.name]=m;s.loader.exec_module(m)
 loader=ROOT/'analysis/firmware/f4_ram_loader_static/ld-2.28.analysis.elf';kernel=ROOT/'analysis/firmware/kernel.config.txt'
 assert row(loader)['sha256']=='9be1d9704ad489d8d573f6a9fb851d4522f92481de5795d9defee99ba96dce8f'
 assert row(kernel)['sha256']=='da0ad7799b5836a54d4790af89e0215f35aba31821e779d5aaa199b5dbe7fc34'
 assert 'CONFIG_ARM64_4K_PAGES=y' in kernel.read_text() and 'CONFIG_ARM64_PAGE_SHIFT=12' in kernel.read_text()
 e=m.Elf(loader.read_bytes(),3);windows=[];commands=[]
 for name,start,end in [('load_segment_alignment',0x5944,0x59ec),('et_dyn_mapping_and_bias',0x5738,0x57c4),('mmap_syscall',0x166c8,0x16718)]:
  raw=e.data[e.va_offset(start,end-start):e.va_offset(start,end-start)+end-start]
  argv=['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),str(loader)]
  q=subprocess.run(argv,capture_output=True,text=True);assert q.returncode==0;(OUT/(name+'.asm')).write_text(q.stdout);commands.append(dict(argv=argv,exit=q.returncode))
  windows.append(dict(name=name,va=start,bytes=len(raw),hex=raw.hex(),sha256=hashlib.sha256(raw).hexdigest()))
 emit(OUT/'LOADER_STATIC.json',dict(schema='iq4_original_loader_bias_01',loader=row(loader),kernel=row(kernel),runtime_page_bytes=4096,library_PT_LOAD_p_align=65536,windows=windows,commands=commands,conclusion='p_align tests file VA/offset congruence; original ET_DYN mapping records unrounded mmap return as load bias',target_executed=False))
 graph=json.loads((ROOT/'analysis/firmware/native_copy_rtti_static_01/GRAPH.json').read_text());graph['base_alignment']=4096;graph['ELF_PT_LOAD_p_align']=65536;graph['bias_alignment_evidence']=row(OUT/'LOADER_STATIC.json');emit(OUT/'GRAPH.json',graph)
 user=ROOT/'analysis/firmware/f1_f3_f4_user_integration_build_04_recording_repair_01/P1Linux_RatioMask_JPEG_LVRecording_6.03.33.bin';ue=m.Elf(user.read_bytes(),2);pins=[]
 def check(file,va,raw):
  actual=ue.data[ue.va_offset(va,len(raw)):ue.va_offset(va,len(raw))+len(raw)];assert raw==actual,(str(file),hex(va));pins.append(dict(source=str(file.relative_to(ROOT)),va=va,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest(),candidate_equal=True))
 for relative in ['f3_gallery_source_snapshot_01/pins.inc','f3_saved_raw_capture_03/capture_pins.inc','f3_native_jpeg8_binding_01/code_pins.h']:
  p=ROOT/'tools/firmware'/relative;t=p.read_text();arrays={name:bytes(int(x,16) for x in re.findall(r'0x([0-9a-fA-F]{2})\b',data)) for name,data in re.findall(r'(\w+)\[\]\s*=\s*\{(.*?)\};',t,re.S)}
  for va,name in re.findall(r'\{\(uintptr_t\)0x([0-9a-fA-F]+)u,sizeof\((\w+)\)',t):check(p,int(va,16),arrays[name])
  for va,n,name in re.findall(r'\{(?:UINT64_C\()?0x([0-9a-fA-F]+)\)?,\s*(\d+),\s*(\w+)\}',t):
   raw=arrays[name];assert len(raw)==int(n);check(p,int(va,16),raw)
 p=ROOT/'tools/firmware/f3_native_render_02/api_pins.h';t=p.read_text()
 for va,data in re.findall(r'\{0x([0-9a-fA-F]+),\{([^}]+)\}\}',t):check(p,int(va,16),bytes(int(x,16) for x in re.findall(r'0x([0-9a-fA-F]{2})\b',data)))
 data=re.search(r'iq4_source_syscall_pin_02\[32\]=\{([^}]+)\}',t).group(1);check(p,0x40ae40,bytes(int(x,16)for x in re.findall(r'0x([0-9a-fA-F]{2})\b',data)))
 assert len(pins)==61,len(pins)
 emit(OUT/'INSTALL_PINS.json',dict(schema='iq4_candidate33_install_pins_01',candidate=row(user),pins=pins,count=len(pins),bytes=sum(x['bytes']for x in pins),no_mismatch=True,target_executed=False))
 print('61 install pin windows match candidate33; original loader proof collected')
if __name__=='__main__':main()
