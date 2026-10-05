#!/usr/bin/env python3
"""Build native C muxer, actual own MJPEG file/decode, no camera execution."""
from pathlib import Path
import argparse,hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[2]
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert not out.exists() and out.is_relative_to(ROOT);out.mkdir(parents=True)
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert row(zig)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 ffmpeg=Path('/opt/homebrew/bin/ffmpeg');probe=Path('/opt/homebrew/bin/ffprobe');assert ffmpeg.is_file() and probe.is_file();commands=[]
 def run(argv,kind):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,text=True,capture_output=True);commands.append(dict(kind=kind,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk').strip();run([ffmpeg,'-version'],'decoder_identity');run([probe,'-version'],'probe_identity');assert run([zig,'version'],'target_compiler_identity').strip()=='0.15.2'
 run([ffmpeg,'-v','error','-f','lavfi','-i','testsrc2=size=128x96:rate=30','-frames:v','3','-c:v','mjpeg','-q:v','2','-threads','1',out/'fixture_%d.jpg'],'own_synthetic_JPEG_generation')
 frames=[out/f'fixture_{i}.jpg' for i in (1,2,3)];assert all(p.is_file() for p in frames)
 hostflags=['-std=c11','-O2','-g','-Wall','-Wextra','-Werror'];clang='/Library/Developer/CommandLineTools/usr/bin/clang'
 units=[ROOT/'src/recording/native_mkv.c',ROOT/'tools/firmware/f3_stream_transaction_02/stream.c',ROOT/'tools/firmware/f3_save_transaction_01/transaction.c']
 host=[]
 for san in (False,True):
  suffix='sanitized' if san else 'normal';exe=out/f'mkv_{suffix}';geometry=out/f'geometry_{suffix}';movie=out/f'actual_host_{suffix}.mkv';decoded=out/f'decoded_{suffix}.rgb'
  flags=hostflags+(['-fsanitize=address,undefined','-fno-omit-frame-pointer'] if san else [])
  run([clang,'-isysroot',sdk,*flags,ROOT/'tests/test_native_mkv.c',*units,'-o',exe],'own_host_compile')
  result=json.loads(run([exe,*frames,movie],'own_host_execution'))
  run([clang,'-isysroot',sdk,*flags,ROOT/'tests/test_export_geometry.c',ROOT/'src/codec/export_geometry.c','-o',geometry],'own_geometry_compile');geo=json.loads(run([geometry],'own_geometry_execution'))
  parsed=json.loads(run([probe,'-v','error','-show_entries','stream=codec_name,width,height,time_base:packet=pts_time','-of','json',movie],'actual_host_file_probe'))
  assert parsed['streams'][0]['codec_name']=='mjpeg' and parsed['streams'][0]['width']==128 and parsed['streams'][0]['height']==96
  pts=[p['pts_time'] for p in parsed['packets']];assert pts==['0.000000','0.033333','0.078000'],pts
  run([ffmpeg,'-v','error','-i',movie,'-fps_mode','passthrough','-pix_fmt','rgb24','-f','rawvideo',decoded],'actual_host_entropy_decode')
  data=decoded.read_bytes();assert len(data)==128*96*3*3
  hashes=[hashlib.sha256(data[i*36864:(i+1)*36864]).hexdigest() for i in range(3)];assert len(set(hashes))==3
  host.append(dict(sanitized=san,result=result,geometry=geo,probe=parsed,decoded_frames=3,distinct_decoded_hashes=hashes,movie=row(movie),decoded=row(decoded)))
 objects=[]
 target=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-fPIC','-ffunction-sections','-fdata-sections','-funwind-tables','-fno-asynchronous-unwind-tables']
 for unit in [ROOT/'src/recording/native_mkv.c',ROOT/'src/codec/export_geometry.c']:
  obj=out/(unit.stem+'.o');run([zig,'cc',*target,'-c',unit,'-o',obj],'target_compile_only');objects.append(row(obj))
 sources=[ROOT/'src/recording/native_mkv.c',ROOT/'src/recording/native_mkv.h',ROOT/'src/codec/export_geometry.c',ROOT/'src/codec/export_geometry.h',ROOT/'tests/test_native_mkv.c',ROOT/'tests/test_export_geometry.c',Path(__file__).resolve(),*units[1:]]
 report=dict(schema='iq4_freestanding_native_mkv_build_01',source=[row(p) for p in sources],host=host,objects=objects,target_executed=False,device_accessed=False,new_sensor_frame_rate_verified=False,file_publication_verified_by_muxer=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
