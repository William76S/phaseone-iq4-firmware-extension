#!/usr/bin/env python3
"""Own ABI fixtures and pinned ET_REL compile/inspection; no native calls."""
from pathlib import Path
import ast,hashlib,json,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
OUT=ROOT/'analysis/firmware/f1_entry_button_ports_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(cmd):
 p=subprocess.run(list(map(str,cmd)),cwd=ROOT,capture_output=True,text=True)
 if p.returncode:raise RuntimeError(p.stdout+p.stderr)
 return p.stdout
def main():
 for p in HERE.glob('*.py'):ast.parse(p.read_bytes(),str(p))
 build=ROOT/'build/f1_entry_button_ports01_host';build.mkdir(exist_ok=True)
 sdk=run(['xcrun','--show-sdk-path']).strip()
 flags=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1']
 tests={}
 expected='3 owned ABI argument fixtures; production EN0/null19; native/device execution zero\n'
 for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=build/name;run(flags+extra+[HERE/'test_contracts.cpp',HERE/'contracts.cpp','-o',exe]);text=run([exe])
  if text!=expected:raise ValueError('Own-only host receipt changed')
  tests[name]={'owned_argument_fixtures':3,'production_enabled':False,'receipt':text.strip()}
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
 if sha(zig)!=lock['zig_binary_sha256'] or run([zig,'version']).strip()!=lock['version']:raise ValueError('Pinned compiler mismatch')
 obj=OUT/'contracts.aarch64.o'
 run([zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-c',HERE/'contracts.cpp','-o',obj])
 sys.path.insert(0,str(ROOT/'tools/firmware/windows_aarch64_toolchain_01'));import probes
 target=probes.inspect_elf(obj,1)
 if target['undefined_symbols']:raise ValueError('Metadata ET_REL must have zero undefined symbols')
 text=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--section-headers',obj])
 if '.init_array' in text or '.fini_array' in text:raise ValueError('Unexpected constructor')
 (OUT/'sections.txt').write_text(text)
 report={'schema_version':1,'tests':tests,'target_ET_REL':target,'native_calls':0,'actual_runtime_guard':False,'actual_ABI_acceptance':False,'production_entry_enabled':False,'target_executed':False,'camera_access':False,'source_sha256':{p.name:sha(p) for p in sorted(HERE.iterdir()) if p.is_file()}}
 (OUT/'build_validation.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps({'owned_argument_fixtures_each':3,'production_EN0_null19':True,'target_ET_REL_sha256':sha(obj),'target_undefined':0,'target_executed':False,'camera_access':False}))
if __name__=='__main__':main()
