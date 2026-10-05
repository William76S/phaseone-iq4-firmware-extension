#!/usr/bin/env python3
"""Seal only own reserved RO bytes after an exact-linked-ELF unwind review."""
from pathlib import Path
import argparse, hashlib, importlib.util, json, struct, sys
ROOT=Path(__file__).resolve().parents[3]
CAPACITY=131072
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);ap.add_argument('--loader-proof',type=Path);a=ap.parse_args();out=a.build.resolve()
 report_path=out/'LINK_REPORT.json';build_path=out/'BUILD.json';review_path=out/'LINKED_UNWIND_STATIC.json'
 report=json.loads(report_path.read_text());build=json.loads(build_path.read_text());review=json.loads(review_path.read_text())
 user=ROOT/build['User']['path'];data=user.read_bytes();before=sha(data)
 assert before==build['User']['sha256']==report['candidate_sha256']==review['User']['sha256']
 assert review['verification_kind']=='exact-linked-ELF-static' and not review['cpp_unwind_target_accepted']
 assert review['schema']=='iq4_exact_linked_ELF_own_unwind_static_02' and review['all_own_immutable_unwind_dependencies_verified']
 for source in review['verifier']:
  raw=(ROOT/source['path']).read_bytes();assert len(raw)==source['bytes'] and sha(raw)==source['sha256']
 assert review['all_own_FDE_PC_ranges_and_EH_header_pairs_verified'] and review['all_own_LSDA_actions_and_landing_pads_verified']
 backend=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py';assert sha(backend.read_bytes())=='3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9'
 spec=importlib.util.spec_from_file_location('contract_seal_backend',backend);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m);e=m.Elf(data,2)
 address=report['own_symbols']['iq4_linked_contract_seal_01'];offset=e.va_offset(address,CAPACITY)
 assert data[offset:offset+CAPACITY]==bytes(CAPACITY), 'already sealed or modified reservation'
 owner=[h for h in e.sh if h[2]&2 and not h[2]&1 and h[3]<=address and address+CAPACITY<=h[3]+h[5]];assert len(owner)==1
 # Recheck the own immutable dependency provenance against actual ET_REL
 # relocation/symbol extents. No ordinary Job/arena/GOT state is admitted.
 dependency_path=ROOT/'tools/firmware/native_linked_unwind_02/dependencies.py'
 dep_spec=importlib.util.spec_from_file_location('contract_seal_dependencies',dependency_path);dep_module=importlib.util.module_from_spec(dep_spec);sys.modules[dep_spec.name]=dep_module;dep_spec.loader.exec_module(dep_module)
 dependencies=dep_module.UnwindDependencies(ROOT,e,m,report)
 for entry in review['immutable_unwind_dependencies']:
  p,n=entry['va'],entry['bytes'];assert entry['no_dynamic_relocation_target'] and sha(data[e.va_offset(p,n):e.va_offset(p,n)+n])==entry['sha256']
  if entry['kind'] in ('personality_indirection_cell','type_indirection_cell'):
   target=dependencies.cell(p,'personality'if entry['kind']=='personality_indirection_cell'else'type')
   if entry['kind']=='type_indirection_cell':dependencies.rtti(target)
  elif entry['kind']=='own_immutable_RTTI':dependencies.rtti(p)
 for copy in review['loader_COPY_dependencies']:dependencies.copy(copy['symbol'],copy['reason'])
 expected_immutable,expected_copies=dependencies.result()
 assert expected_immutable==review['immutable_unwind_dependencies'] and expected_copies==review['loader_COPY_dependencies']
 loader_proof=None;loader_proof_content=None;composition=None
 if expected_copies:
  assert a.loader_proof is not None,'typed COPY RTTI requires exact native loader ABI proof and composed runtime guard'
  proof_path=a.loader_proof.resolve();loader_proof=json.loads(proof_path.read_text())
  loader_proof_content=loader_proof
  assert loader_proof['schema']=='iq4_native_COPY_RTTI_exact_static_ABI_01'
  fields=('symbol','va','bytes','dynsym_index','version_index','needed_library','version_name')
  expected={tuple(copy[k]for k in fields)for copy in expected_copies}
  observed={tuple(copy[k]for k in fields)for copy in loader_proof['bindings']};assert expected==observed
  for name in ('runtime_verifier_object','actual_libstdcxx','source_manifest','original_user','static_graph'):
   item=loader_proof[name];raw=(ROOT/item['path']).read_bytes();assert len(raw)==item['bytes'] and sha(raw)==item['sha256']
  obj=loader_proof['runtime_verifier_object'];assert any(item['sha256']==obj['sha256'] and item['bytes']==obj['bytes']for item in report['objects'])
  guard=loader_proof['runtime_verifier_symbol'];assert guard=='iq4_native_copy_rtti_current_01' and guard in report['own_symbols']
  # The installed F3 callback must actually call both guards, with seal failure
  # branching past the loader guard. Symbol presence or a metadata boolean is
  # insufficient. Only CBZ W0 or exact CMP W0,1 / B.NE flow is admitted.
  name='iq4_extensions_contract_current_01';assert name in report['own_symbols']
  funcs=[]
  for (oi,table),symbols in dependencies.link.symtabs.items():
   for si,symbol in enumerate(symbols):
    if symbol[6]==name and symbol[1]&15==2 and symbol[5]:funcs.append((dependencies.link.symbol((oi,table,si)),symbol[5],oi))
  assert len(funcs)==1 and funcs[0][0]==report['own_symbols'][name]
  va,n,oi=funcs[0];code=data[e.va_offset(va,n):e.va_offset(va,n)+n];calls=[];conditional=[]
  for at in range(0,n,4):
   word=struct.unpack_from('<I',code,at)[0];pc=va+at
   if word&0xfc000000 in (0x14000000,0x94000000):
    delta=word&0x3ffffff;delta-=1<<26 if delta&(1<<25)else 0;target=pc+delta*4
    if word&0xfc000000==0x94000000 or target in (report['own_symbols']['iq4_linked_contract_current_01'],report['own_symbols'][guard]):calls.append((pc,target))
   if word&0xff00001f==0x34000000:
    delta=(word>>5)&0x7ffff;delta-=1<<19 if delta&(1<<18)else 0;conditional.append((pc,pc+delta*4))
   if word&0xff00001f==0x54000001 and at>=4 and struct.unpack_from('<I',code,at-4)[0]==0x7100041f:
    delta=(word>>5)&0x7ffff;delta-=1<<19 if delta&(1<<18)else 0;conditional.append((pc,pc+delta*4))
  assert len(calls)==2 and calls[0][1]==report['own_symbols']['iq4_linked_contract_current_01'] and calls[1][1]==report['own_symbols'][guard]
  assert any(calls[0][0]<pc<calls[1][0]<target<=va+n for pc,target in conditional),'seal failure must skip loader call'
  composition=dict(symbol=name,va=va,bytes=n,sha256=sha(code),object=report['objects'][oi],calls=calls,seal_failure_skips_loader=True)
  loader_proof=dict(path=str(proof_path.relative_to(ROOT)),bytes=proof_path.stat().st_size,sha256=sha(proof_path.read_bytes()),runtime_verifier_symbol=guard,runtime_contract_composition=composition,target_executed=False)
 ranges=[]
 def add(p,n,immutable_dependency=False):
  assert n>0 and 0x400000<=p and p+n<=0x10000000
  segment=[h for h in e.ph if h[0]==1 and h[3]<=p and p+n<=h[3]+h[5] and (not h[1]&2 or immutable_dependency)];assert segment,hex(p)
  if p<address+CAPACITY and address<p+n:
   if p<address:ranges.append((p,address))
   if address+CAPACITY<p+n:ranges.append((address+CAPACITY,p+n))
  else:ranges.append((p,p+n))
 for i,h in enumerate(e.sh):
  if h[2]&2 and not h[2]&1 and h[1]!=8 and h[5] and h[4]>=report['baseline_bytes']:add(h[3],h[5])
 for h in report['hooks']+report.get('auxiliary_hooks',[]):
  va=h.get('site_va',h.get('va'));add(int(va,0)if isinstance(va,str)else va,4)
 for name,proof in report['original_import_bindings'].items():
  p,n=proof['proof_va'],len(bytes.fromhex(proof['proof_bytes']))
  copies=[copy for copy in expected_copies if p<copy['va']+copy['bytes'] and copy['va']<p+n]
  if copies:
   assert len(copies)==1 and name==copies[0]['symbol'] and p==copies[0]['va'] and proof['kind']=='original_defined_dynsym'
   # The loader writes R_COPY slots. Exact relocation/version metadata and the
   # actual native library callback replace their misleading file-zero hash.
  else:add(p,n)
 for entry in expected_immutable:add(entry['va'],entry['bytes'],immutable_dependency=True)
 merged=[]
 for p,end in sorted(ranges):
  if merged and p<=merged[-1][1]:merged[-1]=(merged[-1][0],max(end,merged[-1][1]))
  else:merged.append((p,end))
 assert merged and len(merged)<=2048
 total=sum(end-p for p,end in merged);assert 0<total<=32*1024*1024
 # Every own FDE and LSDA and PC range must be covered, not merely the count.
 def covered(p,n):return any(start<=p and p+n<=end for start,end in merged)
 for entry in review['own_FDEs']:
  assert covered(entry['pc'],entry['bytes']) and covered(entry['fde'],8)
  if entry['lsda']:assert covered(entry['lsda']['address'],1)
 identity_path=ROOT/'tools/firmware/native_linked_unwind_02/identity.py'
 identity_spec=importlib.util.spec_from_file_location('contract_seal_identity',identity_path);identity_module=importlib.util.module_from_spec(identity_spec);sys.modules[identity_spec.name]=identity_module;identity_spec.loader.exec_module(identity_module)
 identity,canonical,review_sha,locations=identity_module.semantic_identity(review,report,loader_proof_content,composition)
 raw_review_sha=sha(review_path.read_bytes())
 seal=bytearray(CAPACITY);seal[:8]=b'IQ4LC01\0'
 struct.pack_into('<IIIIQ',seal,8,1,len(merged),1,0,total);seal[32:97]=review_sha.encode()+b'\0'
 records=[]
 for i,(p,end) in enumerate(merged):
  n=end-p;at=e.va_offset(p,n);digest=hashlib.sha256(data[at:at+n]).digest()
  struct.pack_into('<QQ',seal,128+i*48,p,n);seal[144+i*48:176+i*48]=digest
  records.append(dict(va=p,bytes=n,sha256=digest.hex()))
 patched=bytearray(data);patched[offset:offset+CAPACITY]=seal
 # The reserved RO span is the sole post-link mutation. Original byte guard
 # spans and all actual instructions/CFI/LSDA/imports remain byte-for-byte.
 assert patched[:offset]==data[:offset] and patched[offset+CAPACITY:]==data[offset+CAPACITY:]
 assert not(out/'CONTRACT_SEAL.json').exists()
 assert not(out/'LINKED_UNWIND_SEMANTIC_IDENTITY.json').exists()
 (out/'LINKED_UNWIND_SEMANTIC_IDENTITY.json').write_bytes(canonical)
 (out/'LINKED_UNWIND_UNSEALED_STATIC.json').write_bytes(review_path.read_bytes());review_path.unlink()
 report['linked_contract_seal']=dict(va=address,file_offset=offset,bytes=CAPACITY,unsealed_User_sha256=before,static_review_sha256=review_sha,static_review_identity_kind='directory-independent-semantic-review',raw_review_JSON_sha256=raw_review_sha,regions=records,immutable_unwind_dependencies=expected_immutable,loader_COPY_dependencies=expected_copies,loader_ABI_proof=loader_proof,cpp_unwind_target_accepted=False)
 report['candidate_sha256']=sha(patched);user.write_bytes(patched);report_path.write_text(json.dumps(report,indent=2)+'\n')
 build['User']['sha256']=sha(patched);build['link_report']=dict(path=str(report_path.relative_to(ROOT)),bytes=report_path.stat().st_size,sha256=sha(report_path.read_bytes()))
 build['linked_contract_sealed']=True;build_path.write_text(json.dumps(build,indent=2)+'\n')
 receipt=dict(schema='iq4_exact_linked_contract_RO_seal_02',unsealed_User_sha256=before,sealed_User=build['User'],static_review_sha256=review_sha,static_review_identity_kind='directory-independent-semantic-review',raw_review_JSON_sha256=raw_review_sha,semantic_identity_file=dict(path=str((out/'LINKED_UNWIND_SEMANTIC_IDENTITY.json').relative_to(ROOT)),bytes=len(canonical),sha256=review_sha),artifact_locations_omitted_from_semantic_identity=locations,reserved_RO_span_only=True,regions=records,immutable_unwind_dependencies=expected_immutable,loader_COPY_dependencies=expected_copies,loader_ABI_proof=loader_proof,original_bytes_unchanged=True,instructions_CFI_LSDA_unchanged=True,target_executed=False,camera_accessed=False)
 (out/'CONTRACT_SEAL.json').write_text(json.dumps(receipt,indent=2)+'\n');print(len(records),'actual immutable regions sealed; no target acceptance')
if __name__=='__main__':main()
