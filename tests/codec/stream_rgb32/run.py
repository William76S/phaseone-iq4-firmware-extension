from pathlib import Path
import json,subprocess,hashlib,argparse
ROOT=Path(__file__).resolve().parents[3]
p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args();out=a.output.resolve()
assert not out.exists() and out.is_relative_to(ROOT)
lock=json.loads((ROOT/'tests/codec/stream_rgb32/SOURCE_SHA256.json').read_text())
for name,expected in lock['files'].items():
 data=(ROOT/name).read_bytes();assert len(data)==expected['bytes'] and hashlib.sha256(data).hexdigest()==expected['sha256'], name
out.mkdir(parents=True)
commands=[]
libraries=[]
def run(argv):
 argv=list(map(str,argv));r=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
 commands.append(dict(argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
 if r.returncode:raise RuntimeError(r.stdout+r.stderr)
for sanitized in [False,True]:
 mode='sanitized' if sanitized else 'normal';lib=ROOT/('evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a' if sanitized else 'evidence/codec/build/libjpeg8/.libs/libjpeg.a')
 assert lib.is_file()
 libraries.append({'path':str(lib.relative_to(ROOT)),'bytes':lib.stat().st_size,'sha256':hashlib.sha256(lib.read_bytes()).hexdigest()})
 flags=['-std=c11','-Wall','-Wextra','-Werror','-O1']
 if sanitized:flags+=['-g','-fsanitize=address,undefined','-fno-omit-frame-pointer']
 binary=out/('stream_'+mode)
 run(['clang',*flags,ROOT/'src/codec/stream_rgb32.c',ROOT/'src/codec/bounded_jpeg.c',ROOT/'tests/codec/stream_rgb32/test_stream.c',lib,'-o',binary])
 run([binary] if sanitized else [binary,out])
zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
assert hashlib.sha256(zig.read_bytes()).hexdigest()=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
run([zig,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-fPIC','-ffp-contract=off','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-DIQ4_JPEG_API_VERSION=82','-c',ROOT/'src/codec/stream_rgb32.c','-o',out/'stream_rgb32_aarch64.o'])
rows={}
for name in ['src/codec/stream_rgb32.c','src/codec/stream_rgb32.h','tests/codec/stream_rgb32/test_stream.c','tests/codec/stream_rgb32/run.py']:
 b=(ROOT/name).read_bytes();rows[name]={'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
for file in out.glob('*.jpg'):rows[file.name]={'bytes':file.stat().st_size,'sha256':hashlib.sha256(file.read_bytes()).hexdigest()}
rows['stream_rgb32_aarch64.o']={'bytes':(out/'stream_rgb32_aarch64.o').stat().st_size,'sha256':hashlib.sha256((out/'stream_rgb32_aarch64.o').read_bytes()).hexdigest()}
(out/'RESULT.json').write_text(json.dumps({'all_commands_passed':True,'host_encoding_full_native75_50_synthetic_geometry_and_decode':True,'normal_and_sanitized_failure_injection':True,'actual_AArch64_ET_REL_compile':True,'native_target_or_camera_run':False,'RAW_source_render_not_part_of_codec_test':True,'files':rows,'actual_host_libraries':libraries,'source_lock_sha256':hashlib.sha256((ROOT/'tests/codec/stream_rgb32/SOURCE_SHA256.json').read_bytes()).hexdigest()},indent=2)+'\n')
print((out/'RESULT.json').read_text())
