#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_half_export_54';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(argv,label):
  p=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(label=label,argv=list(map(str,argv)),exit=p.returncode,stdout=p.stdout,stderr=p.stderr))
  (OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert p.returncode==0,(label,p.stdout,p.stderr)
  return p.stdout
 run(['python3',HERE/'collect.py'],'exact_original_binding')
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();exe=OUT/'test_runtime'
 run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1',
  '-std=c++17','-O1','-Wall','-Wextra','-Werror','-DIQ4_STOCK_JPEG_TEST',
  HERE/'runtime.cpp',HERE/'test_runtime.cpp','-o',exe],'host_compile_owning_runtime')
 cases=['4k','half','mismatch','encode_failure','wrong_name','timeout','save_failure']
 for case in cases:run([exe,case],'runtime_'+case)
 objects=[];flags=['-target','aarch64-linux-gnu.2.28','-DIQ4_JPEG_API_VERSION=82',
  '-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics',
  '-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 for src,driver,std in [('runtime.cpp','c++','-std=c++17'),('half_settings.c','cc','-std=c11')]:
  obj=OUT/(Path(src).stem+'.o');run([ZIG,driver,*flags,std,'-c',HERE/src,'-o',obj],src)
  objects.append(row(obj));(OUT/(obj.name+'.asm')).write_text(run([
   '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],src+'_inspect'))
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj],src+'_undefined')
 # Sink source has not changed since its real JPEG80 encode+entropy decode,
 # bounded-capacity/cancel/HOLD cases and JPEG82 target compilation.
 prior=ROOT/'analysis/firmware/f3_stock_half_export_build_01/BUILD.json'
 sink=json.loads(prior.read_text());assert all(row(ROOT/q['path'])==q for q in sink['sources'])
 assert all(row(ROOT/q['path'])==q for q in sink['objects']);objects.extend(sink['objects'])
 result=dict(schema='iq4_stock_half_export_build_54',objects=objects,host_runtime_cases=cases,
  actual_host_sink_build=row(prior),host_runtime_codec='explicit fixture, ownership only',
  sink_actual_host_encode_decode=True,original_nativeARGB_proof='analysis/firmware/native_jpeg_ARGB_audit_01/A64_ARGB.json',
  source_lease_audit='analysis/firmware/native_half_lease_audit_01/SOURCE_SHA256.json',
  full_raw_dimensions=[14204,10652],half_jpeg_dimensions=[7102,5326],quality=100,
  camera_accessed=False,target_device_executed=False)
 (OUT/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result))
if __name__=='__main__':main()
