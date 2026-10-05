#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f4_start_repair_build_05'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
COMMON=['tools/firmware/f3_native_card_bridge_06/card.c','tools/firmware/movie_card_01/movie.c','tools/firmware/f4_mkv_software_zero_01/native_mkv.c','tools/firmware/f3_native_fs_adapter_04/host_posix.c','tools/firmware/f3_stream_transaction_02/stream.c','tools/firmware/f3_save_transaction_01/transaction.c','tests/f4_start_repair_05/test_chain.c']
def row(p):
 p=Path(p);b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[];results=[]
 def run(a):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);record=dict(argv=a,returncode=r.returncode,exit=r.returncode,stdout=r.stdout,stderr=r.stderr);commands.append(record);(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
  return record
 base=['/usr/bin/clang','-std=c11','-O1','-g','-Wall','-Wextra','-Werror','-pthread']
 old=OUT/'original_busy_repro';run([*base,'-DORIGINAL_BUSY_REPRO',ROOT/'tools/firmware/f4_native_source_02/movie_binding.c',*[ROOT/x for x in COMMON],'-o',old])
 args=[ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin',ROOT/'evidence/codec/host_encoded_samples/strided_rgb.jpg',OUT]
 results.append(run([old,*args,0]))
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-sanitize-recover=all','-fno-omit-frame-pointer'])]:
  exe=OUT/('chain_'+tag);run([*base,*flags,HERE/'movie_binding.c',*[ROOT/x for x in COMMON],'-o',exe])
  for i in range(9):results.append(run([exe,*args,i]))
 # Decode actual published products; timestamps here are named fixture values,
 # never reported as device cadence or achieved hardware fps.
 decode=[]
 for item in results:
  for line in item['stdout'].splitlines():
   record=json.loads(line)
   if 'published_path' not in record:continue
   movie=Path(record['published_path'])
   probe=run(['/opt/homebrew/bin/ffprobe','-v','error','-select_streams','v:0','-show_entries','stream=codec_name,width,height:frame=best_effort_timestamp_time','-of','json',movie])
   info=json.loads(probe['stdout']);times=[float(x['best_effort_timestamp_time'])for x in info['frames']]
   assert times==[0.0,0.037] and info['streams'][0]['codec_name']=='mjpeg'
   run(['/opt/homebrew/bin/ffmpeg','-v','error','-i',movie,'-f','null','-'])
   decode.append(dict(file=row(movie),times=times,stream=info['streams'][0],target_executed=False))
 (OUT/'DECODE.json').write_text(json.dumps(decode,indent=2)+'\n')
 obj=OUT/'movie_binding.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-fPIC','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/'movie_binding.d','-c',HERE/'movie_binding.c','-o',obj])
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f4_start_repair_build_05',commands=commands,inputs=[row(HERE/'movie_binding.c'),*[row(ROOT/x)for x in COMMON]],object=row(obj),original_failure_reproduced=True,normal_cases=9,sanitized_cases=9,actual_host_movie_decodes=len(decode),camera_accessed=False,target_executed=False),indent=2)+'\n')
 print(json.dumps(dict(original_failure_reproduced=True,normal_cases=9,sanitized_cases=9,object=row(obj),target_executed=False)))
if __name__=='__main__':main()
