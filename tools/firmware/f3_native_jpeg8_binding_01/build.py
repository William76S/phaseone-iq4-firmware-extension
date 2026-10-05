#!/usr/bin/env python3
"""Own synthetic host code reader + target ET_REL only; no target execution."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZIG_SHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
HOST='/Library/Developer/CommandLineTools/usr/bin/clang'
OBJ='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def inspect(p):
    d=p.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',d)
    assert h[0][:6]==b'\x7fELF\x02\x01'and h[1:3]==(1,183)
    sections=[struct.unpack_from('<IIQQQQIIQQ',d,h[6]+i*h[11])for i in range(h[12])]
    assert not any(s[2]&0x400 or s[1]==6 for s in sections)
    undefined=[]
    for s in sections:
        if s[1]!=2:continue
        st=sections[s[6]];strings=d[st[4]:st[4]+st[5]]
        for off in range(s[4],s[4]+s[5],s[9]):
            name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',d,off)
            if name and index==0:undefined.append(strings[name:strings.index(b'\0',name)].decode())
    return dict(**row(p),type='ET_REL',machine=183,undefined_symbols=sorted(set(undefined)),executed=False)
def main():
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
    out=a.output.resolve()
    if out.exists()or not out.is_relative_to(ROOT):raise ValueError('Fresh project output required')
    if row(ZIG)['sha256']!=ZIG_SHA:raise ValueError('Pinned Zig identity required')
    out.mkdir(parents=True);commands=[]
    def run(argv,kind):
        q=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True)
        commands.append(dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
        (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
        if q.returncode:raise RuntimeError(q.stdout+q.stderr)
        return q.stdout
    assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2'
    sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
    flags=['-std=c11','-O2','-Wall','-Wextra','-Werror','-DIQ4_JPEG_API_VERSION=82']
    results=[]
    for name,extra in [('unadmitted_host',[]),('synthetic',['-DIQ4_JPEG82_SYNTHETIC_HOST_TEST_ONLY']),
                       ('synthetic_asan_ubsan',['-DIQ4_JPEG82_SYNTHETIC_HOST_TEST_ONLY','-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=out/name
        run([HOST,'-isysroot',sdk,*flags,*extra,HERE/'native_jpeg82.c',HERE/'test_binding.c','-o',exe],'own_host_compile')
        results.append(dict(name=name,result=json.loads(run([exe],'own_host_synthetic_execution'))))
    targetflags=['-target','aarch64-linux-gnu.2.28',*flags,'-g0','-ffreestanding','-fno-stack-protector',
        '-mno-outline-atomics','-fPIC','-funwind-tables','-fno-asynchronous-unwind-tables']
    objects=[]
    for source,name in [(HERE/'native_jpeg82.c','native_jpeg82.o'),(ROOT/'src/codec/stream_rgb32.c','stream_rgb32.o')]:
        obj=out/name
        run([ZIG,'cc',*targetflags,'-MMD','-MF',out/(name+'.d'),'-c',source,'-o',obj],'cross_compile_only')
        record=inspect(obj)
        if name=='native_jpeg82.o'and record['undefined_symbols']:raise ValueError('Binding object must have no helper/native imports')
        objects.append(record)
        text=run([OBJ,'-dr',obj],'static_ET_REL_inspect')
        (out/(name+'.asm')).write_text('\n'.join(x.rstrip()for x in text.splitlines())+'\n')
    report=dict(schema='iq4_f3_native_jpeg82_binding_build_01',compiler=row(ZIG),
        source_files=[row(HERE/x)for x in ['native_jpeg82.c','native_jpeg82.h','code_pins.h','test_binding.c']],
        codec_sources=[row(ROOT/'src/codec'/x)for x in ['bounded_jpeg.h','stream_rgb32.c']],objects=objects,host_results=results,
        native_functions_executed=False,target_encoder_executed=False,sdk_loaded=False,device_access=False,
        firmware_produced=False)
    (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(dict(output=str(out),host_results=results,objects=objects),indent=2))
if __name__=='__main__':main()
