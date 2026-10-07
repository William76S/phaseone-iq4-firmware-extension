#!/usr/bin/env python3
"""Finite gallery fixtures, exact native A64 objects and frozen link input."""
from pathlib import Path
import argparse,hashlib,json,shlex,struct,subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
BASE=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_22.json'
def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 assert out.is_relative_to(ROOT) and not out.exists()
 assert row(BASE)['sha256']=='89e55e72db5f8746ba41f0fa9bb5c01012ab9cceeaddc06ba437950217fb1cfd'
 base=json.loads(BASE.read_text());compiler=ROOT/base['compiler']['path'];assert row(compiler)==base['compiler']
 out.mkdir(parents=True);commands=[];objects=[]
 def run(argv,label):
  argv=list(map(str,argv));r=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(label=label,argv=argv,exit=r.returncode,stdout=r.stdout,stderr=r.stderr))
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  assert r.returncode==0,(label,r.stdout,r.stderr);return r.stdout
 run(['python3',HERE/'collect.py'],'exact_original_pins')
 exact=json.loads((HERE/'EXACT.json').read_text());assert row(ROOT/exact['stock']['path'])==exact['stock']
 cases=['busy','badfile','entropyfail','metadata','retire','preview','zoom','cancel']
 sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk'
 for kind,extra in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  geom=out/('geometry_host_'+kind+'.o');test=out/('test_geometry_'+kind)
  flags=['-std=c11','-O1','-Wall','-Wextra','-Werror',*extra]
  run(['/usr/bin/clang',*flags,'-c',HERE/'geometry.c','-o',geom],'geometry_'+kind)
  run(['/usr/bin/clang',*flags,HERE/'test_geometry.c',geom,'-o',test],'compile_geometry_'+kind)
  run([test],'geometry_cases_'+kind)
  exe=out/('test_gallery_'+kind)
  run(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O1','-Wall','-Wextra','-Werror',*extra,HERE/'test_gallery.cpp',geom,'-o',exe],'compile_gallery_'+kind)
  for case in cases:run([exe,case],kind+'_'+case)
 for src,name in [('gallery.cpp','gallery.o'),('geometry.c','geometry.o'),('wrappers.S','wrappers.o')]:
  flags=list(base['C_flags'])
  if src.endswith('.cpp'):flags[flags.index('-std=c11')]='-std=c++17'
  if src.endswith('.S'):flags=['-target','aarch64-linux-gnu.2.28','-g0','-fPIC','-funwind-tables']
  run([compiler,'cc',*flags,'-MMD','-MF',out/(name+'.d'),'-c',HERE/src,'-o',out/name],name)
  objects.append(row(out/name))
  (out/(name+'.asm')).write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/name],name+'_inspect'))
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',out/name],name+'_undefined')
 run([ROOT/'build/dual-exposure-host-venv/bin/python',HERE/'prove_wrappers.py','--build',out],'actual_A64_wrapper_Rectangle_geometry')
 (out/'wrappers.eh_frame.txt').write_text(run(['/Library/Developer/CommandLineTools/usr/bin/llvm-dwarfdump','--eh-frame',out/'wrappers.o'],'native_parent_CFA_inspect'))
 headers={}
 for name in ['gallery.o','geometry.o','wrappers.o']:
  dep=(out/(name+'.d')).read_text().replace('\\\n',' ')
  for s in shlex.split(dep.split(':',1)[1]):
   p=Path(s);p=p if p.is_absolute() else ROOT/p
   if p.suffix in ['.h','.inc']:headers[str(p.resolve())]=row(p)
 assert str(ROOT/'tools/firmware/stock_jpeg_decode_55/decode.h') in headers
 assert str(ROOT/'tools/firmware/native_runtime_01/self_read.h') in headers
 members=[row(HERE/n)for n in ['gallery.cpp','gallery.h','geometry.c','geometry.h','wrappers.S','pins.h','EXACT.json','collect.py','build.py','test_geometry.c','test_gallery.cpp','prove_wrappers.py','README.md']]
 members.append(row(ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py'))
 manifest=out/'SOURCE_SHA256.json'
 manifest.write_text(json.dumps(dict(schema='iq4_stock_real_JPEG_gallery_sources_55',members=members,target_header_closure=list(headers.values()),compiler=row(compiler),baseline=row(BASE),stock=exact['stock'],objects=objects,A64_proof=row(out/'A64_WRAPPERS.json'),commands=row(out/'COMMANDS.json'),camera_accessed=False,target_executed=False),indent=2)+'\n')
 bl=[];aux=[]
 for h in exact['BL_hooks']:
  op=struct.unpack('<I',bytes.fromhex(h['original_u32_LE']))[0];assert op>>26==0x25
  delta=op&0x3ffffff;delta-=0x4000000 if delta&0x2000000 else 0
  bl.append(dict(va=h['va'],old_hex=h['original_u32_LE'],original_target=h['va']+4*delta,target_symbol=h['replacement_symbol']))
 for h in exact['auxiliary_hooks']:
  aux.append(dict(va=h['va'],old_hex=h['original_u32_LE'],target_symbol=h['replacement_symbol'],branch_kind='B'))
 aliases=[dict(symbol=a['symbol'],va=a['va'])for a in exact['aliases']]
 functions=['iq4_stock_jpeg_only_gallery_bound_55','iq4_stock_jpeg_gallery_bind_55','iq4_stock_jpeg_gallery_prepare_retire_55','iq4_stock_jpeg_gallery_commit_retire_55','iq4_stock_jpeg_gallery_metadata_55','iq4_stock_jpeg_gallery_is_photo_55','iq4_stock_jpeg_gallery_card_refresh_55','iq4_stock_jpeg_gallery_preview_enqueue_55','iq4_stock_jpeg_gallery_final_enqueue_55','iq4_jpeg_gallery_inverse_roi_55','iq4_jpeg_gallery_rotate_rgb_55']
 link=dict(schema='iq4_stock_real_JPEG_gallery_link_55',objects=objects,aliases=aliases,BL_hooks=bl,auxiliary_hooks=aux,required_functions=functions,source_manifest=str(manifest.relative_to(ROOT)),source_manifest_sha256=row(manifest)['sha256'],runtime_pin_header=str((HERE/'pins.h').relative_to(ROOT)),runtime_pin_arrays=['JpegGalleryPins55','JpegGalleryHookPins55'],native_RAW_and_RAWplusJPEG_transparent=True,registry_capacity=1024,retire_preflight_full_JPEG_entropy=True,retire_preflight_RGB_scratch_bytes=97200,camera_accessed=False,target_executed=False,hardware_accepted=False)
 (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n')
 report=dict(schema='iq4_real_JPEG_gallery_build_55',objects=objects,link=row(out/'LINK.json'),source_manifest=row(manifest),commands=row(out/'COMMANDS.json'),A64_proof=row(out/'A64_WRAPPERS.json'),normal_catalog_cases=len(cases),ASan_UBSan_catalog_cases=len(cases),normal_geometry_checks=12,ASan_UBSan_geometry_checks=12,A64_wrapper_Rectangle_cases=20,record_lookup_always_in_explicit_catalog_mutex=True,card_guard_resolver_decode_outside_catalog_mutex=True,decoder_and_native_service_fixtures_explicit=True,actual_entropy_decoder_evidence_separate=True,not_executed=['native full catalog enumeration','full LCD outer functions','physical display','JPEG-only capture/retire','card hot-swap'],camera_accessed=False,target_executed=False,hardware_accepted=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(dict(build=row(out/'BUILD.json'),link=row(out/'LINK.json'),source_manifest=row(manifest),objects=objects)))
if __name__=='__main__':main()
