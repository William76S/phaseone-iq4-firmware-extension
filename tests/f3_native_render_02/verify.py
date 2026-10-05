#!/usr/bin/env python3
"""Fresh offline host/sanitizer and reproducible AArch64 object validation."""
import argparse, hashlib, json, re, struct, subprocess, sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
HERE=ROOT/'tools/firmware/f3_native_render_02'
TEST=Path(__file__).resolve().parent
SOURCE=ROOT/'tools/firmware/f3_raw_file_source_01'
CORE=ROOT/'tools/firmware/f3_core_native_receipt_01'
SDK=Path('/Library/Developer/CommandLineTools/SDKs/MacOSX15.4.sdk')
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=sha(p))
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 if out.exists() or not out.is_relative_to(ROOT):raise ValueError('fresh output within project required')
 out.mkdir(parents=True);commands=[];host=[];objects=[]
 def run(argv):
  p=subprocess.run([str(x) for x in argv],cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(argv=[str(x) for x in argv],exit=p.returncode,stdout=p.stdout,stderr=p.stderr))
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if p.returncode:raise RuntimeError(p.stdout+p.stderr)
  return p.stdout
 assert run([ZIG,'version']).strip()=='0.15.2'
 assert sha(ZIG)=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 fixtures=out/'fixtures';run([sys.executable,ROOT/'tests/f3_raw_file_source_01/make_fixture.py',fixtures])
 for sanitized in (False,True):
  name='sanitized' if sanitized else 'normal';directory=out/name;directory.mkdir()
  common=['-Wall','-Wextra','-Werror','-isysroot',SDK,'-I',HERE,'-I',SOURCE,'-DIQ4_NATIVE_HOST_FIXTURE']
  flags=['-O1','-g','-fsanitize=address,undefined','-fno-omit-frame-pointer'] if sanitized else ['-O2']
  cf=['-std=c11',*common,*flags];cxx=['-std=c++17',*common,*flags,'-isystem',SDK/'usr/include/c++/v1']
  exe=directory/'test_decode';run(['/usr/bin/clang',*cf,HERE/'decode_receipt.c',TEST/'test_decode.c','-o',exe]);result=json.loads(run([exe]));host.append(dict(suite='decode',mode=name,binary=row(exe),**result))
  exe=directory/'test_adapter';run(['/usr/bin/clang++',*cxx,HERE/'adapter.cpp',SOURCE/'reader_stage.cpp',SOURCE/'source_builder.cpp',SOURCE/'host_posix.cpp',TEST/'test_adapter.cpp','-o',exe]);result=json.loads(run([exe,fixtures]));host.append(dict(suite='adapter',mode=name,binary=row(exe),**result))
  decode=directory/'decode.o';core=directory/'core.o'
  run(['/usr/bin/clang',*cf,'-c',HERE/'decode_receipt.c','-o',decode]);run(['/usr/bin/clang',*cf,'-c',CORE/'receipt.c','-o',core])
  exe=directory/'test_combined';run(['/usr/bin/clang++',*cxx,TEST/'test_combined.cpp',HERE/'completion.cpp',HERE/'adapter.cpp',SOURCE/'reader_stage.cpp',SOURCE/'source_builder.cpp',decode,core,'-o',exe]);result=json.loads(run([exe]));host.append(dict(suite='combined',mode=name,binary=row(exe),**result))
  exe=directory/'test_native_binding';run(['/usr/bin/clang++',*cxx,TEST/'test_native_binding.cpp',HERE/'native_binding.cpp',HERE/'native_file_ops.cpp',HERE/'persistent_pool.cpp','-o',exe]);result=json.loads(run([exe]));host.append(dict(suite='binding_pool',mode=name,binary=row(exe),**result))
 for source,unit,language in [(HERE/'adapter.cpp','adapter','c++'),(HERE/'completion.cpp','completion','c++'),(HERE/'decode_receipt.c','decode_receipt','cc'),(HERE/'wrappers.S','wrappers','cc'),(HERE/'native_binding.cpp','native_binding','c++'),(HERE/'native_file_ops.cpp','native_file_ops','c++'),(HERE/'persistent_pool.cpp','persistent_pool','c++')]:
  builds=[]
  for number in (1,2):
   obj=out/f'{unit}_aarch64_{number}.o';flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-fPIC','-Wall','-Wextra','-Werror']
   if source.suffix!='.S':flags+=['-std=c++17' if language=='c++' else '-std=c11','-ffunction-sections','-fdata-sections','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-funwind-tables']
   if source.suffix=='.c':flags+=['-mno-outline-atomics']
   run([ZIG,language,*flags,'-c',source,'-o',obj]);data=obj.read_bytes()
   assert data[:7]==b'\x7fELF\x02\x01\x01' and struct.unpack_from('<HH',data,16)==(1,183)
   builds.append(dict(**row(obj),ELF='ELF64LE AArch64 ET_REL'))
  assert builds[0]['sha256']==builds[1]['sha256']
  nm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',out/f'{unit}_aarch64_1.o'])
  disasm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/f'{unit}_aarch64_1.o']);(out/f'{unit}.asm').write_text('\n'.join(x.rstrip() for x in disasm.splitlines())+'\n')
  if unit=='wrappers':
   body=disasm.split('<iq4_f3_decode_native_reader_wrapper_02>:',1)[1].split('<iq4_f3_decode_native_row_wrapper_02>:',1)[0]
   assert re.search(r'add\s+x11, sp, #0x240',body), 'stack args must come from callerSP'
   assert re.search(r'mov\s+x2, sp',body), 'receipt must record actual native callSP'
   assert not re.search(r'add\s+x2, sp, #0x240',body), 'callerSP would misidentify the native reader frame'
   rowbody=disasm.split('<iq4_f3_decode_native_row_wrapper_02>:',1)[1].split('<iq4_f3_decode_native_join_wrapper_02>:',1)[0]
   assert re.search(r'stp\s+x19, x21, \[sp, #0x1b0\]',rowbody), 'preserve actual job and pair iterator'
   assert re.search(r'ldp\s+x1, x2, \[sp, #0x1b0\]',rowbody), 'after callback uses pre-call job and pair iterator'
  objects.append(dict(unit=unit,builds=builds,byte_identical=True,undefined=nm))
 deps=[SOURCE/'SOURCE.json',CORE/'SOURCE_SHA256.json',CORE/'receipt.c',CORE/'pins.h',HERE/'ORIGINAL_BINDING_INPUT.json',ROOT/'tools/firmware/f3_source_dependencies_01/SOURCE_SHA256.json']
 inputs=sorted(p for folder in (HERE,TEST) for p in folder.iterdir()
               if p.is_file() and p.suffix in ('.c','.cpp','.h','.hpp','.S','.py','.json','.txt','.md')
               and p.name not in ('SOURCE.json','SOURCE_SHA256.json','MANIFEST.json','LINK_INPUT.json'))
 result=dict(schema='iq4_f3_native_render_02_validation',host=host,target_objects=objects,
  dependencies=[row(p) for p in deps],source_inputs=[row(p) for p in inputs],compiler=row(ZIG),whole_native_saved_IIQ_render_executed=False,
  native_bitstream_validity_proved=False,color_sRGB_output_proved=False,orientation_metadata_available=False,
  target_executed=False,camera_accessed=False,firmware_produced=False,
  aarch64_wrapper_stack_contract_checked=True)
 (out/'VALIDATION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'host_groups_each':sum(x['groups'] for x in host if x['mode']=='normal'),'target_units':len(objects),'target_executed':False}))
if __name__=='__main__':main()
