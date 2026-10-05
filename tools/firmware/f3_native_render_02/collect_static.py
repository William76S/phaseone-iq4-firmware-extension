#!/usr/bin/env python3
"""Finite original bytes, disassembly and explicit unbound ABI inputs. Offline."""
import hashlib, importlib.util, json, re, struct, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
spec=importlib.util.spec_from_file_location('frozen_exact',ROOT/'tools/firmware/f3_render_plan_01/collect_static.py')
exact=importlib.util.module_from_spec(spec);spec.loader.exec_module(exact)
WINDOWS={
 'Codec8_full':(0x9217a0,0x921fe8),
 'Row_dispatch_full':(0x921fe8,0x922148),
 'Row_job_full':(0x922640,0x9227b0),
 'RawReader_full':(0x9227b0,0x922ae0),
 'Preview_reader_arguments':(0x963c48,0x963d34),
 'Preview_source_geometry_arguments':(0x963ae0,0x963b2c),
 'RawReader_storage_full':(0x922170,0x9222e0),
 'RawReader_getters':(0x9224b0,0x922560),
 'Owned_pool_ctor_start_dispatch_join':(0x716a84,0x717028),
 'Owned_worker_full':(0x716854,0x716a84),
 'Owned_worker_dtors':(0x71714c,0x7171c8),
 'Native_thread_start':(0x713704,0x7137ec),
 'ICE_pool_calls':(0x7b5398,0x7b5410),
 'ICE_pool_start_call':(0x7b5704,0x7b5728),
 'Profile_configure_full':(0x961208,0x962058),
 'Settings_dtor':(0x7bbf44,0x7bbfc8),
 'RawReader_rect_copy':(0x93c7e0,0x93c864),
 'Native_settings_constructor':(0x7bbc54,0x7bbf44),
 'Original_JPEG_output_enum':(0x7b7e00,0x7b7e88),
 'CImageBuffer_format_actual':(0x904398,0x9043a8),
 'Native_color_transfers':(0x9753e0,0x9756a0),
 'Native_color_transform':(0x9756a0,0x975c60),
 'Reader_constructor_dependency_fields':(0x7d92b8,0x7d9368),
 'Capture_constructor_dependency_fields':(0x7c6f3c,0x7c712c),
 'Worker_name_cstring':(0x70aa14,0x70aa68),
}
HOOKS={0x963d28:0x9227b0,0x9226c0:0x921fe8,0x9226d8:0x921fe8,0x922a1c:0x716e60}
INPUT_LOADS=[0x9219fc,0x921aac,0x921b34,0x921b58,0x921b7c,
             0x921d84,0x921e50,0x921ed0,0x921f50,0x921fb8]
ABI={
 'settings_construct':(0x7bbc54,'x0=owned settings[0x2c8]'),
 'settings_destroy':(0x7bbf44,'x0=constructed settings; nondeleting'),
 'generator_construct':(0x962058,'x0=generator[0x1f0],x1=exclusive base,x2=u64 bytes'),
 'generator_destroy':(0x9622a8,'x0=constructed generator; nondeleting'),
 'image_construct':(0x904550,'x0=zeroed CImageBuffer[0x58]'),
 'image_destroy':(0x903ca8,'x0=constructed CImageBuffer; nondeleting'),
 'configure_source':(0x960478,'x0=generator,w1=sensorID,x2=owned mutable tags'),
 'configure_profile':(0x961208,'x0=generator,x1=settings,w2=profileSlot(0 finite scope)'),
 'process':(0x963a28,'x0=generator,x1=RawInput,x2=RGB32,x3=planar,x4=settings,x5=pool,x6=cancel; w0=outer bool not completion'),
 'pool_construct':(0x716a84,'x0=pool[0x18],x1=name,w2=count,w3=priority,w4=stack'),
 'pool_start':(0x716c58,'x0=constructed pool; starts all workers, NOT destructor'),
 'pool_join':(0x716e60,'x0=started owned pool; waits all queued functions'),
 'image_plane':(0x9043c8,'x0=CImageBuffer; x0=borrowed plane pointer'),
 'image_width':(0x904448,'x0=CImageBuffer; w0=width'),
 'image_height':(0x904450,'x0=CImageBuffer; w0=height'),
 'image_stride':(0x904468,'x0=CImageBuffer; w0=byte stride'),
 'image_format':(0x9043a0,'x0=CImageBuffer; w0=[x0+0x1c] format; 904398 is always0'),
}
def sha(b):return hashlib.sha256(b).hexdigest()
def refill_cfg(text):
 instructions={}
 for s in text.splitlines():
  m=re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s+(\S+)\s*(.*)',s)
  if m:instructions[int(m[1],16)]=(m[3],m[4].split('//')[0].strip())
 cuts={(0x9219e0,0x9219e4),(0x921d10,0x9219e4),
       (0x921db0,0x921d58),(0x921dd4,0x921d58)}
 def maximum(entry,stop):
  visiting=set();cache={}
  def walk(pc):
   if pc in stop:return (0,0)
   if pc in cache:return cache[pc]
   assert pc in instructions and pc not in visiting,hex(pc)
   visiting.add(pc);op,args=instructions[pc]
   if op=='ret':edges=[]
   elif op=='b':edges=[int(args,16)]
   elif op.startswith('b.') or op in ('cbz','cbnz','tbz','tbnz'):
    edges=[pc+4,int(args.split(',')[-1].strip(),16)]
   else:
    assert op not in ('br','blr','bl'),(hex(pc),op)
    edges=[pc+4]
   children=[walk(to) for to in edges if (pc,to) not in cuts]
   reads=(1 if pc in INPUT_LOADS else 0)+max((c[0] for c in children),default=0)
   writes=(1 if op in ('strh','sturh') else 0)+max((c[1] for c in children),default=0)
   visiting.remove(pc);cache[pc]=(reads,writes);return cache[pc]
  result=walk(entry);return {'entry':entry,'max_word_reads_per_iteration':result[0],
   'max_halfword_writes_per_iteration':result[1],'acyclic_nodes':len(cache),'cycle_cuts':[list(x) for x in sorted(cuts)]}
 group=maximum(0x9219e8,{0x921d18});tail=maximum(0x921d58,set())
 assert group['max_word_reads_per_iteration']<=9 and group['max_halfword_writes_per_iteration']==8
 assert tail['max_word_reads_per_iteration']==1 and tail['max_halfword_writes_per_iteration']==1
 # Exact loop bound/increments, independent of input contents.
 for pc,op,fragment in [(0x921860,'sub','w18, w12, #0x8'),(0x92186c,'lsr','w20, w18, #3'),
  (0x921888,'add','x17, x17, w20, uxtw #4'),(0x9219a4,'add','x9, x9, #0x10'),
  (0x921d08,'add','x9, x9, #0x10'),(0x921da8,'strh','[x2], #0x2'),(0x921dcc,'strh','[x2], #0x2')]:
  assert instructions[pc][0]==op and fragment in instructions[pc][1]
 return {'eight_pixel_group':group,'tail_pixel':tail,'width_scope':[8,65500],
         'conservative_bytes':'4*(9*floor(width/8)+(width%8))','native_codec_executed':False}
def main():
 image=exact.ExactImage(exact.ORIGINAL)
 out=ROOT/'analysis/firmware/f3_native_render_02/static';out.mkdir(parents=True,exist_ok=True)
 assert sum(b-a for a,b in WINDOWS.values())<32768
 windows=[];runs=[];texts={}
 for name,(start,end) in WINDOWS.items():
  off,raw=image.get(start,end-start)
  argv=[exact.OBJDUMP,'-d',f'--start-address={start}',f'--stop-address={end}',str(exact.ORIGINAL)]
  p=subprocess.run(argv,text=True,capture_output=True,check=True)
  text='\n'.join(re.sub(r'\s+<[^>]*>','',s) for s in p.stdout.splitlines() if s.startswith('  '))+'\n'
  count=0
  for s in text.splitlines():
   m=re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s',s)
   if m:
    va,w=int(m[1],16),int(m[2],16)
    assert start<=va<end and struct.unpack('<I',image.get(va,4)[1])[0]==w;count+=1
  assert count==(end-start)//4
  (out/(name+'.asm')).write_text(text);texts[name]=text
  windows.append(dict(name=name,va=start,end_va=end,file_offset=off,bytes=len(raw),instructions=count,
                      raw_hex=raw.hex(),raw_sha256=sha(raw),disasm_sha256=sha(text.encode())))
  runs.append(dict(argv=argv,exit=p.returncode,stderr=p.stderr))
 loads=[]
 for s in texts['Codec8_full'].splitlines():
  if re.search(r'ldr\s+w\d+, \[x\d+\], #0x4',s):loads.append(int(s.split(':')[0],16))
 assert loads==INPUT_LOADS
 cfg=refill_cfg(texts['Codec8_full'])
 tables=[]
 for name,va,n in [('Codec8_lookup64',0xdc6c30,64),('Native_color_table',0xdcca80,0x160),
                   ('Native_sRGB_matrix',0xdccde0,72),('Native_sRGB_inverse',0xdcce30,72)]:
  off,raw=image.get(va,n);tables.append(dict(name=name,va=va,file_offset=off,bytes=n,raw_hex=raw.hex(),raw_sha256=sha(raw)))
 lookup=bytes.fromhex(tables[0]['raw_hex']);assert max(lookup)==10 and len(lookup)==64
 # Exact selectors and transform call used by original JPEG settings+20=5.
 assert exact.bl_target(0x9615e8,struct.unpack('<I',image.get(0x9615e8,4)[1])[0])==0x9756a0
 calls=[]
 for pc,to in HOOKS.items():
  raw=image.get(pc,4)[1];word=struct.unpack('<I',raw)[0]
  assert exact.bl_target(pc,word)==to
  calls.append(dict(va=pc,old_hex=raw.hex(),original_target=to))
 result=dict(schema='iq4_f3_render02_static',original_sha256=exact.SHA,original_bytes=exact.SIZE,
             target_executed=False,device_accessed=False,finite_total_bytes=sum(w['bytes'] for w in windows),
             windows=windows,tables=tables,hooks=calls,codec8_input_word_loads=loads,codec8_cfg=cfg,
             codec8_ceiling='4*(9*floor(width/8)+(width%8)); finite acyclic per-iteration CFG')
 (out/'EXACT.json').write_text(json.dumps(result,indent=2)+'\n')
 (out/'RUN.json').write_text(json.dumps(runs,indent=2)+'\n')
 pins=[w for w in windows if w['name'] in ('Codec8_full','Row_dispatch_full','Row_job_full','RawReader_full','Preview_reader_arguments','RawReader_storage_full','RawReader_getters','RawReader_rect_copy')]
 pins.append(tables[0])
 h=['/* Generated exact pinned original. Hook slots verified separately. */','#pragma once',
    '#include <stdint.h>','#include <stddef.h>',
    'struct Iq4DecodePin02 {uintptr_t va;size_t n;const unsigned char*bytes;};']
 for i,w in enumerate(pins):h.append('static const unsigned char iq4_decode_bytes_%d[]={%s};'%(i,','.join('0x'+w['raw_hex'][j:j+2] for j in range(0,len(w['raw_hex']),2))))
 h.append('static const struct Iq4DecodePin02 iq4_decode_pins_02[]={'+','.join('{0x%x,%d,iq4_decode_bytes_%d}'%(w['va'],w['bytes'],i) for i,w in enumerate(pins))+'};')
 (ROOT/'tools/firmware/f3_native_render_02/decode_pins.h').write_text('\n'.join(h)+'\n')
 bindings=[]
 for name,(va,contract) in ABI.items():
  off,raw=image.get(va,32);bindings.append(dict(name=name,va=va,file_offset=off,prefix_hex=raw.hex(),sha256=sha(raw),aapcs64=contract,target_runtime_accepted=False))
 (ROOT/'tools/firmware/f3_native_render_02/ORIGINAL_BINDING_INPUT.json').write_text(json.dumps(dict(original_sha256=exact.SHA,target_abi_verified=False,fixed_address_factory='native_binding.cpp',fixed_factory_implemented=True,functions=bindings),indent=2)+'\n')
 source_binding=ROOT/'tools/firmware/f3_raw_file_source_01/ORIGINAL_BINDING_INPUT.json'
 source_json=json.loads(source_binding.read_text());assert source_json['original_sha256']==exact.SHA
 source_functions=source_json['functions'];assert len(source_functions)==16
 ah=['/* Generated finite exact original API prefixes; not target acceptance. */','#pragma once',
     '#include <stdint.h>','#include <stddef.h>','struct Iq4ApiPin02{uintptr_t va;unsigned char bytes[32];};']
 for symbol,functions in [('iq4_render_api_pins_02',bindings),('iq4_source_api_pins_02',source_functions)]:
  lines=[]
  for b in functions:
   raw=image.get(b['va'],32)[1];assert raw.hex()==b['prefix_hex']
   lines.append('{0x%x,{%s}}'%(b['va'],','.join('0x%02x'%x for x in raw)))
  ah.append('static const struct Iq4ApiPin02 '+symbol+'[]={'+','.join(lines)+'};')
 ah.append('static const unsigned char iq4_source_syscall_pin_02[32]={'+','.join('0x%02x'%x for x in image.get(0x40ae40,32)[1])+'};')
 (ROOT/'tools/firmware/f3_native_render_02/api_pins.h').write_text('\n'.join(ah)+'\n')
 print(json.dumps(dict(windows=len(windows),instructions=sum(w['instructions'] for w in windows),bytes=result['finite_total_bytes'],exact_sha256=sha((out/'EXACT.json').read_bytes()))))
if __name__=='__main__':main()
