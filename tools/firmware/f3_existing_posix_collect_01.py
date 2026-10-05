#!/usr/bin/env python3
"""Freeze only exact existing original PLT bytes; never execute an imported call."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,sys
ROOT=Path(__file__).resolve().parents[2]
BASE=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py'
assert hashlib.sha256(BASE.read_bytes()).hexdigest()=='3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9'
p=argparse.ArgumentParser();p.add_argument('--stock',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
blob=a.stock.read_bytes();assert len(blob)==11874544 and hashlib.sha256(blob).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
s=importlib.util.spec_from_file_location('finite_P1_existing_imports',BASE);m=importlib.util.module_from_spec(s);sys.modules[s.name]=m;s.loader.exec_module(m)
e=m.Elf(blob,2);imports=m.original_imports(e)
names=['open','open64','openat','close','write','read','fsync','fdatasync','link','linkat','rename','renameat','renameat2','unlink','unlinkat','fstat','fstat64','__fxstat','__fxstat64','stat','lstat','__xstat','fstatfs','flock','fcntl','fcntl64','getrandom','syscall','__errno_location','snprintf','statfs','mmap','munmap']
rows={n:imports.get(n) for n in names}
for x in rows.values():
 if x:
  assert x['kind']=='original_plt'
  assert blob[e.va_offset(x['proof_va'],16):][:16]==bytes.fromhex(x['proof_bytes'])
out=a.output.resolve();assert not out.exists() and out.is_relative_to(ROOT);out.mkdir(parents=True)
result={'schema':'iq4_existing_POSIX_PLT_finite_static_01','input_sha256':hashlib.sha256(blob).hexdigest(),'symbols':rows,'original_PLT_GOT_relocation_and_words_checked':True,'null_means_no_existing_symbol_not_no_kernel_syscall_support':True,'target_or_import_or_SDK_or_device_executed':False,'collector_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
(out/'IMPORTS.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'present':[k for k,v in rows.items() if v],'output_sha256':hashlib.sha256((out/'IMPORTS.json').read_bytes()).hexdigest(),'executed_target':False},indent=2))
