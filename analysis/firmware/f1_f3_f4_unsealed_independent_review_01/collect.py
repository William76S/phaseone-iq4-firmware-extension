#!/usr/bin/env python3
"""Read-only actual linked User review; never loads or executes target code."""
from pathlib import Path
import hashlib,json,re,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];OUT=Path(__file__).resolve().parent
BD=ROOT/'analysis/firmware/f1_f3_f4_user_integration_build_01_unsealed_attempt02'
REPORT=BD/'LINK_REPORT.json';J=json.loads(REPORT.read_text())
CAND=BD/'P1Linux_RatioMask_JPEG_LVRecording_6.03.30.bin'
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
raw=CAND.read_bytes();original=STOCK.read_bytes()
def digest(b):return hashlib.sha256(b).hexdigest()
def ident(p):b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':digest(b)}
class Elf:
 def __init__(self,b):
  self.b=b;assert b[:6]==b'\x7fELF\x02\x01';assert struct.unpack_from('<H',b,18)[0]==183
  ph,=struct.unpack_from('<Q',b,32);sz,n=struct.unpack_from('<HH',b,54)
  self.ph=[struct.unpack_from('<IIQQQQQQ',b,ph+i*sz)for i in range(n)]
 def offset(self,va,n=1):
  p=[p for p in self.ph if p[0]==1 and p[3]<=va and va+n<=p[3]+p[5]];assert len(p)==1,(hex(va),n)
  return p[0][2]+va-p[0][3]
 def get(self,va,n):o=self.offset(va,n);return self.b[o:o+n]
 def u32(self,va):return struct.unpack('<I',self.get(va,4))[0]
 def u64(self,va):return struct.unpack('<Q',self.get(va,8))[0]
 def dynamic(self):
  p=next(p for p in self.ph if p[0]==2);d={}
  for o in range(p[2],p[2]+p[5],16):
   t,v=struct.unpack_from('<QQ',self.b,o)
   if not t:break
   d[t]=v
  return d
E=Elf(raw);S=Elf(original)
# Independent final ELF symbol-table walk binds report labels to actual definitions.
sho=struct.unpack_from('<Q',raw,40)[0];shsz,shnum,_=struct.unpack_from('<HHH',raw,58)
sections=[struct.unpack_from('<IIQQQQIIQQ',raw,sho+i*shsz)for i in range(shnum)]
symbols={}
for section in sections:
 if section[1]!=2:continue
 strings=sections[section[6]];names=raw[strings[4]:strings[4]+strings[5]]
 for at in range(section[4],section[4]+section[5],section[9]):
  no,info,other,idx,va,size=struct.unpack_from('<IBBHQQ',raw,at)
  name=names[no:names.find(b'\0',no)].decode()
  if idx and name:symbols[name]={'va':va,'bytes':size,'info':info}
assert E.ph==[tuple(x)for x in J['program_headers']]

assert len(raw)==13218984 and digest(raw)=='37bc1cddbbbdccdf0376ed931fdaffe559a9b074259e451702f56fdb31cb9a30'
assert len(original)==11874544 and digest(original)=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
objects=[]
for x in J['objects']:
 p=ROOT/x['label'];i=ident(p);i['report_match']=i['bytes']==x['bytes']and i['sha256']==x['sha256'];assert i['report_match'];objects.append(i)
assert len(objects)==62
labels=[x['path'] for x in objects]
required=['analysis/firmware/f3_capture_menu_build_05/menu.o','analysis/firmware/f4_native_entry_build_03/entry.o','analysis/firmware/f3_source_dependencies_build_02/dependencies.o','analysis/firmware/native_activity_build_01/activity.o']
assert all(labels.count(x)==1 for x in required)
assert not any(x.endswith('/f3_capture_menu_build_04/menu.o') or x.endswith('/f4_native_source_build_02_release_complete/entry.o')or'/f3_source_dependencies_build_01/'in x for x in labels)
def branch(pc,w):
 assert w&0x7c000000==0x14000000
 d=w&0x3ffffff
 if d&0x2000000:d-=0x4000000
 return pc+d*4
hooks=[]
for x in J['hooks']+J['auxiliary_hooks']:
 pc=x['va'];b=E.get(pc,4);old=S.get(pc,4);w=int.from_bytes(b,'little');to=branch(pc,w)
 assert b.hex()==x['new_bytes']and old.hex()==x['old_bytes']and to==x['new_target']==J['own_symbols'][x['symbol']]
 assert symbols[x['symbol']]['va']==to
 hooks.append({'va':pc,'va_hex':hex(pc),'file_offset':E.offset(pc,4),'old_hex':old.hex(),'actual_hex':b.hex(),'branch':'BL'if w&0xfc000000==0x94000000 else'B','actual_target':to,'target_hex':hex(to),'symbol':x['symbol']})
assert len(hooks)==16
allow=[(x[0],x[0]+x[1],x[2])for x in J['allowed_original_spans']]
changed=[i for i,(a,b)in enumerate(zip(raw,original))if a!=b]
assert all(any(lo<=i<hi for lo,hi,_ in allow)for i in changed)
# Active dynamic table and the executable's actual __libc_csu_init address pairs.
d=E.dynamic();sd=S.dynamic();start=d[25];n=d[27]//8;assert d[27]%8==0 and n==341
oldinit=S.get(sd[25],sd[27]);newinit=E.get(start,d[27]);assert newinit[:len(oldinit)]==oldinit
initlast=int.from_bytes(newinit[-8:],'little');assert initlast==J['own_symbols']['iq4_extensions_initialize_01']
def adrpadd(pc):
 a=E.u32(pc);b=E.u32(pc+4);assert a&0x9f000000==0x90000000 and b&0xff000000==0x91000000
 rd=a&31;assert (b&31)==rd and ((b>>5)&31)==rd
 imm=((a>>5)&0x7ffff)<<2|((a>>29)&3)
 if imm&(1<<20):imm-=1<<21
 page=(pc&~4095)+(imm<<12);val=page+(((b>>10)&0xfff)<<(12 if b&(1<<22)else 0))
 return {'pc':hex(pc),'bytes':E.get(pc,8).hex(),'rd':rd,'decoded_va':val}
endpair=adrpadd(0x9ef0bc);startpair=adrpadd(0x9ef0c8)
assert startpair['decoded_va']==start and endpair['decoded_va']==start+d[27]
assert d[12]==sd[12] and E.get(0x9ef0c4,4)==S.get(0x9ef0c4,4)
# Exact raw registered prefix arrays, not a synthetic bool substitute.
pinfiles=[
 'tools/firmware/f3_source_dependencies_02/pins.hpp',
 'tools/firmware/f3_saved_raw_capture_01/capture_pins.inc',
 'tools/firmware/f3_gallery_source_snapshot_01/pins.inc',
 'tools/firmware/f3_native_executor_01/pins.h',
 'tools/firmware/f3_capture_menu_04/code_pins.h',
 'tools/firmware/f4_native_source_02/code_pins.h',
 'tools/firmware/f3_native_render_02/api_pins.h',
 'tools/firmware/f3_native_render_02/decode_pins.h',
 'tools/firmware/f3_core_native_receipt_01/pins.h',
]
pins=[]
for name in pinfiles:
 text=(ROOT/name).read_text();arrays={}
 for match in re.finditer(r'(\w+)\s*\[(?:\d+)?\]\s*=\s*\{([^{}]*)\}',text):
  vals=re.findall(r'0x([0-9a-fA-F]{1,2})(?:\s*,|\s*$)',match[2]);
  if vals:arrays[match[1]]=bytes(int(v,16)for v in vals)
 for match in re.finditer(r'\{\s*(0x[0-9a-fA-F]+)\s*,\s*(\d+)\s*,\s*(\w+)\s*\}',text):
  va,size,arr=int(match[1],16),int(match[2]),match[3]
  if arr not in arrays:continue
  expected=arrays[arr];assert len(expected)==size,(name,arr,size,len(expected));actual=E.get(va,size)
  skipped=[]
  if name.endswith('/decode_pins.h'):
   skipped=[p for p in [0x963d28,0x9226c0,0x9226d8,0x922a1c]if va<=p<va+size]
  if name.endswith('/f3_core_native_receipt_01/pins.h'):
   skipped=[p for p in [0x964860,0x91a78c,0x91a964,0x963d28]if va<=p<va+size]
  differing=[i for i,(a,b)in enumerate(zip(actual,expected))if a!=b and not any(p<=va+i<p+4 for p in skipped)]
  pins.append({'file':name,'array':arr,'va':va,'bytes':size,'expected_sha256':digest(expected),'actual_sha256':digest(actual),'explicit_hook_exclusions':list(map(hex,skipped)),'unexcluded_mismatches':[hex(va+i)for i in differing]})
 # API struct has inline fixed32 arrays.
 if name.endswith('/api_pins.h'):
  for match in re.finditer(r'\{(0x[0-9a-fA-F]+),\{([^{}]+)\}\}',text):
   va=int(match[1],16);expected=bytes(int(v,16)for v in re.findall(r'0x([0-9a-fA-F]{1,2})(?:,|$)',match[2]));assert len(expected)==32
   actual=E.get(va,32);pins.append({'file':name,'va':va,'bytes':32,'expected_sha256':digest(expected),'actual_sha256':digest(actual),'unexcluded_mismatches':[hex(va+i)for i,(a,b)in enumerate(zip(actual,expected))if a!=b]})
  expected=arrays['iq4_source_syscall_pin_02'];assert E.get(0x40ae40,32)==expected
mismatch=[p for p in pins if p['unexcluded_mismatches']]
# Actual SourceDeps02 instruction admits B to actual acquired wrapper.
acq=next(h for h in hooks if h['va']==0x8dc4c0)
assert acq['branch']=='B'and acq['actual_target']==J['own_symbols']['iq4_f3_raw_acquired_wrapper_01']
a=acq['actual_target'];an=symbols[acq['symbol']]['bytes']
assert E.get(a,4)==S.get(0x8dc4c0,4)==bytes.fromhex('012400f9')
assert branch(a+an-4,E.u32(a+an-4))==0x8dc4c4
wait=symbols['iq4_f3_ifm_wait_wrapper_01'];assert wait['bytes']==4
assert branch(wait['va'],E.u32(wait['va']))==symbols['iq4_f3_ifm_wait_entry_01']['va']

# Detect runtime relocation targets inside static pin byte spans. This is not
# an emulator; unresolved imported/copy state belongs to the separate guard.
reloc=[]
if 7 in d:
 for off in range(0,d[8],d.get(9,24)):
  a,info,add=struct.unpack('<QQq',E.get(d[7]+off,24));rt=info&0xffffffff
  for p in pins:
   if p['va']<=a<p['va']+p['bytes']:reloc.append({'pin_file':p['file'],'pin_va':hex(p['va']),'target':hex(a),'type':rt,'symbol_index':info>>32})
seal=J['own_symbols']['iq4_linked_contract_seal_01'];sealzero=E.get(seal,128)==bytes(128);assert sealzero
R={'schema':'iq4_combined_unsealed_independent_review01','inputs':[ident(REPORT),ident(BD/'BUILD.json'),ident(ROOT/'tools/firmware/f1_f3_f4_user_integration_01/INPUTS.json'),ident(CAND),ident(STOCK)],'actual_object_count':len(objects),'actual_objects':objects,'replacement_paths_exactly_once':required,'hooks':hooks,'original_changed_byte_count':len(changed),'original_byte_changes_inside_report_whitelist':True,'startup':{'old_init_entries':len(oldinit)//8,'new_init_entries':n,'original_entries_byte_equal_prefix':True,'append_initializer':hex(initlast),'actual_array_start':hex(start),'actual_array_end':hex(start+d[27]),'csu_start_pair':startpair,'csu_end_pair':endpair,'middle_9ef0c4_preserved':True,'DT_INIT_preserved':hex(d[12])},'runtime_static_pin_checks':pins,'pin_count':len(pins),'pin_mismatches':mismatch,'pin_relocation_target_overlaps':reloc,'source_deps02_actual_B_target_match':True,'raw_acquired_actual_first_STR_replay_and_last_B_original_continue':True,'wait_wrapper_actual_tail_B_to_entry':True,'actual_final_symbols':{x:symbols[x]for x in ['iq4_extensions_initialize_01','iq4_f3_raw_acquired_wrapper_01','iq4_f3_ifm_wait_wrapper_01','iq4_f3_ifm_wait_entry_01','iq4_f3_raw_open_wrapper_01','iq4_f3_sd_store_wrapper_01','iq4_f4_menu_native_pop_wrapper_03','iq4_f3_file_settings_append_wrapper_04']},'linked_contract':{'seal_va':hex(seal),'actual_header_all_zero':sealzero,'factory_expected_rejects_unsealed':True},'target_executed':False,'camera_access':False,'SDK_loaded':False}
(OUT/'ACTUAL_BYTES.json').write_text(json.dumps(R,indent=2)+'\n')
print(json.dumps({'objects':len(objects),'hooks':len(hooks),'pins':len(pins),'mismatches':mismatch,'relocation_overlap':reloc,'startup':R['startup'],'unsealed':sealzero},indent=2))
