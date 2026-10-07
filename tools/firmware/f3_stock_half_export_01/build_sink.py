#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_stock_half_export_build_01';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(argv,kind):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(kind=kind,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(kind,q.stdout,q.stderr);return q.stdout
 lib=ROOT/'evidence/codec/build/libjpeg8/.libs/libjpeg.a';sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();exe=OUT/'test_sink'
 run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',HERE/'sink.c',HERE/'test_sink.c',lib,'-o',exe],'host_compile_actual_JPEG80')
 result=run([exe],'actual_host_half_encode_entropy_decode_focus');print(result,end='')
 target=OUT/'sink.o';flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-DIQ4_JPEG_API_VERSION=82','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
 run([ZIG,'cc',*flags,'-c',HERE/'sink.c','-o',target],'target_compile_only');(OUT/'sink.asm').write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',target],'target_object_inspect'));undefined=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',target],'target_undefined')
 report=dict(schema='iq4_stock_half_sink_build_01',sources=[row(HERE/x)for x in ['half.h','sink.h','sink.c','test_sink.c','build_sink.py']],objects=[row(target)],host_codec=row(lib),host_result=json.loads(result.splitlines()[-1]),target_undefined=undefined,actual_native_codec_executed=False,camera_accessed=False,firmware_produced=False)
 (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(objects=report['objects'],target_undefined=undefined)))
if __name__=='__main__':main()
