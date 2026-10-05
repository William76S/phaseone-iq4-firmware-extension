#!/usr/bin/env python3
"""Finite software-ID-zero revision. Host execution only; target objects only."""
import argparse
import hashlib
import json
import struct
import subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
SDK=Path('/Library/Developer/CommandLineTools/SDKs/MacOSX15.4.sdk')
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def save(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
 commands=[];host=[]
 def run(argv):
  p=subprocess.run(list(map(str,argv)),cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=list(map(str,argv)),exit=p.returncode,stdout=p.stdout,stderr=p.stderr));save(out/'COMMANDS.json',commands)
  if p.returncode:raise RuntimeError(p.stdout+p.stderr)
  return p.stdout
 assert run([ZIG,'version']).strip()=='0.15.2'
 ffmpeg=Path('/opt/homebrew/bin/ffmpeg');ffprobe=Path('/opt/homebrew/bin/ffprobe')
 assert ffmpeg.is_file() and ffprobe.is_file();run([ffmpeg,'-version']);run([ffprobe,'-version'])
 units=[HERE/'test_zero.c',HERE/'native_mkv.c',ROOT/'tools/firmware/f4_codec_cleanup_01/bounded_jpeg.c',ROOT/'tools/firmware/f4_codec_cleanup_01/worker.c',ROOT/'tools/firmware/f3_stream_transaction_02/stream.c',ROOT/'tools/firmware/f3_save_transaction_01/transaction.c']
 libraries=[ROOT/'evidence/codec/build/libjpeg8/.libs/libjpeg.a',ROOT/'evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a']
 for sanitized in [False,True]:
  mode='sanitized' if sanitized else 'normal';exe=out/f'test_{mode}'
  flags=['-std=c11','-Wall','-Wextra','-Werror','-isysroot',SDK,'-DIQ4_JPEG_API_VERSION=80','-O1' if sanitized else '-O2']
  if sanitized:flags+=['-g','-fsanitize=address,undefined','-fno-omit-frame-pointer']
  run(['/usr/bin/clang',*flags,*units,libraries[int(sanitized)],'-o',exe])
  movies=[out/f'{name}_{mode}.mkv' for name in ['zero','wrap','recovered']]
  result=json.loads(run([exe,*movies]));assert result['groups']==14
  media=[]
  for movie in movies:
   probe=json.loads(run([ffprobe,'-v','error','-show_entries','stream=codec_name,width,height,time_base:packet=pts_time','-of','json',movie]))
   assert probe['streams'][0]['codec_name']=='mjpeg' and probe['streams'][0]['width']==64 and probe['streams'][0]['height']==48
   assert [x['pts_time']for x in probe['packets']]==['0.000000','0.033333','0.078000']
   decoded=movie.with_suffix('.rgb');run([ffmpeg,'-v','error','-i',movie,'-fps_mode','passthrough','-pix_fmt','rgb24','-f','rawvideo',decoded]);data=decoded.read_bytes();assert len(data)==3*64*48*3
   hashes=[hashlib.sha256(data[i*9216:(i+1)*9216]).hexdigest() for i in range(3)];assert len(set(hashes))==3
   media.append(dict(movie=row(movie),decoded=row(decoded),distinct_decoded_frames=hashes,probe=probe))
  assert media[0]['distinct_decoded_frames']==media[1]['distinct_decoded_frames']==media[2]['distinct_decoded_frames']
  host.append(dict(mode=mode,binary=row(exe),**result,media=media))
 objects=[]
 for n in [1,2]:
  obj=out/f'native_mkv_{n}.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-fPIC','-ffunction-sections','-fdata-sections','-funwind-tables','-fno-asynchronous-unwind-tables','-Wall','-Wextra','-Werror','-c',HERE/'native_mkv.c','-o',obj]);b=obj.read_bytes();assert b[:7]==b'\x7fELF\x02\x01\x01' and struct.unpack_from('<HH',b,16)==(1,183);objects.append(row(obj))
 assert objects[0]['sha256']==objects[1]['sha256'];undefined=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',out/'native_mkv_1.o']);defined=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--defined-only','--extern-only',out/'native_mkv_1.o']);disasm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/'native_mkv_1.o']);(out/'native_mkv.asm').write_text(disasm)
 original=ROOT/'src/recording/native_mkv.c';expected=original.read_text().replace('#include "native_mkv.h"','#include "../../../src/recording/native_mkv.h"',1).replace('n>m->max_packet_bytes||!local','n>m->max_packet_bytes||!ns',1).replace('!id||stamp<first','!stamp||stamp<first',1);assert (HERE/'native_mkv.c').read_text()==expected
 build=dict(schema='iq4_native_mkv_software_identity_zero_01',host=host,objects=objects,byte_identical=True,undefined=undefined,defined=defined,compiler=row(ZIG),libraries=[row(p)for p in libraries],source=[row(p)for p in units]+[row(original),row(ROOT/'src/recording/native_mkv.h')],exact_changes={'include':'derivative relative path','packet':'reject zero observed_ns; allow initial local_sequence=0','scanner':'reject zero observed_ns; allow software flag2 initial local_sequence=0','header_layout_changed':False,'journal_layout_or_CRC_changed':False,'identity_flags_changed':False,'ordering_or_worker_extension_changed':False},target_executed=False,camera_accessed=False,sensor_FPS_proven=False)
 save(out/'BUILD.json',build)
 previous=json.loads((ROOT/'analysis/firmware/f1_f4_user_integration_build_01_attempt03/LINK_REPORT.json').read_text());old=[x for x in previous['objects']if x['label'].endswith('/native_mkv.o')];assert len(old)==1;oldpath=ROOT/old[0]['label'];assert row(oldpath)['sha256']==old[0]['sha256']
 src=sorted(p for p in HERE.iterdir()if p.is_file() and p.name not in ['SOURCE_SHA256.json','LINK_OVERLAY.json']);save(HERE/'SOURCE_SHA256.json',dict(files=[row(p)for p in src],build=row(out/'BUILD.json'),commands=row(out/'COMMANDS.json'),dependencies=[row(p)for p in units if p.parent!=HERE]+[row(original),row(ROOT/'src/recording/native_mkv.h')],target_executed=False))
 save(HERE/'LINK_OVERLAY.json',dict(schema='iq4_f4_mkv_software_zero_one_object_overlay',source=row(HERE/'SOURCE_SHA256.json'),replace_only=row(oldpath),replacement=objects[0],ABI_unchanged=True,additional_aliases=[],other_objects_unchanged=True,target_executed=False))
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),overlay=row(HERE/'LINK_OVERLAY.json'),groups_each=14,objects=objects)))
if __name__=='__main__':main()
