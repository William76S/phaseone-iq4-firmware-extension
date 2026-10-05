#!/usr/bin/env python3
"""Six exact sizes: independent pixels, real host JPEG8/checked lifecycle, A64 objects."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';HOST='/Library/Developer/CommandLineTools/usr/bin/clang'
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 if out.exists() or not out.is_relative_to(ROOT):raise ValueError('fresh local output required')
 assert row(ZIG)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(kind=kind,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk').strip();assert run([ZIG,'version'],'target_compiler_identity').strip()=='0.15.2'
 pixels=[ROOT/'src/codec/export_pixels.c',ROOT/'src/codec/export_geometry.c'];codec=HERE/'jpeg_export.c'
 for san in (False,True):
  suffix='sanitized' if san else 'normal';flags=['-isysroot',sdk,'-std=c11','-O2','-g','-Wall','-Wextra','-Werror']+(['-fsanitize=address,undefined','-fno-omit-frame-pointer'] if san else [])
  # Pixel geometry is frozen and unchanged; rerun only JPEG/lifecycle tests.
  library=ROOT/('evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a' if san else 'evidence/codec/build/libjpeg8/.libs/libjpeg.a')
  assert row(library)['sha256']==('742cfcdb479326b1a5be567c318b27c8c3ef8d59edbf64925eeea87a61f8d4e8' if san else '3c0912bd72422550c2780b278e1beb7eb856a1fea849b8df33223bc684448fe7')
  exe=out/('export_'+suffix);run([HOST,*flags,HERE/'test_export.c',HERE/'stream_export.c',codec,ROOT/'src/codec/stream_rgb32.c',*pixels,library,'-o',exe],'actual_host_jpeg_compile');tests.append(dict(sanitized=san,kind='real_JPEG_and_checked_file_fixture',output=json.loads(run([exe],'actual_host_jpeg_execute')),library=row(library)))
 flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-ffunction-sections','-fdata-sections','-fPIC','-Wall','-Wextra','-Werror'];objects=[]
 for source,name in [(pixels[0],'export_pixels.o'),(pixels[1],'export_geometry.o'),(codec,'jpeg_export.o'),(HERE/'stream_export.c','stream_export.o')]:
  obj=out/name;run([ZIG,'cc',*flags,'-c',source,'-o',obj],'target_compile_only');h=struct.unpack_from('<16sHHIQQQIHHHHHH',obj.read_bytes());assert h[1]==1 and h[2]==183;objects.append(dict(**row(obj),ET_REL=True,target_executed=False))
  dis=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],'target_object_inspect');(out/(name+'.asm')).write_text('\n'.join(x.rstrip() for x in dis.splitlines())+'\n')
 sources=[*pixels,ROOT/'src/codec/export_pixels.h',ROOT/'src/codec/export_geometry.h',codec,ROOT/'src/codec/stream_export.h',HERE/'stream_export.c',HERE/'stream_export.h',HERE/'test_export.c',ROOT/'tests/test_export_pixels.c',Path(__file__).resolve()]
 result=dict(schema='iq4_stream_export_04_cleanup_hold',source=[row(p) for p in sources],host=tests,objects=objects,compiler=row(ZIG),actual_RAW_decoded=False,camera_executed=False,firmware_produced=False,global_JPEG_only_capture_proved=False)
 (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
if __name__=='__main__':main()
