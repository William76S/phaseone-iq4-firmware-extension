#!/usr/bin/env python3
"""Build only the private JPEG gallery decoder, never the camera exporter."""
import argparse,hashlib,json,subprocess,tarfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
ARCHIVE=ROOT/'evidence/codec/downloads/libjpeg-turbo-1.5.3.tar.gz'
ARCHIVE_SHA='b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523'
UNITS='jdapimin jdapistd jdarith jaricom jdatasrc jdcoefct jdcolor jddctmgr jdhuff jdinput jdmainct jdmarker jdmaster jdmerge jdphuff jdpostct jdsample jdtrans jcomapi jidctflt jidctfst jidctint jidctred jquant1 jquant2 jutils jmemmgr jmemnobs jsimd_none'.split()
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
 assert row(ARCHIVE)['sha256']==ARCHIVE_SHA;vendor=out/'vendor';vendor.mkdir();upstream=[]
 with tarfile.open(ARCHIVE,'r:gz')as tf:
  for m in tf.getmembers():
   parts=Path(m.name).parts
   if len(parts)==2 and m.isfile() and (parts[-1].endswith(('.h','.c')) or parts[-1]in('README.ijg','LICENSE.md')):
    b=tf.extractfile(m).read();p=vendor/parts[-1];p.write_bytes(b);upstream.append(row(p))
 (vendor/'jconfig.h').write_text('#define JPEG_LIB_VERSION 80\n#define LIBJPEG_TURBO_VERSION 1.5.3\n#define LIBJPEG_TURBO_VERSION_NUMBER 1005003\n#define BITS_IN_JSAMPLE 8\n#define HAVE_STDDEF_H 1\n#define HAVE_STDLIB_H 1\n#define HAVE_UNSIGNED_CHAR 1\n#define HAVE_UNSIGNED_SHORT 1\n#define MEM_SRCDST_SUPPORTED 1\n#define D_ARITH_CODING_SUPPORTED 1\n')
 (vendor/'jconfigint.h').write_text('#define BUILD "IQ4-55-private-gallery"\n#define INLINE inline __attribute__((always_inline))\n#define PACKAGE_NAME "libjpeg-turbo"\n#define VERSION "1.5.3"\n#define SIZEOF_SIZE_T 8\n')
 commands=[]
 def run(argv,label):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,(label,q.stdout,q.stderr);return q.stdout
 sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip();lib=ROOT/'evidence/codec/build/libjpeg8/.libs/libjpeg.a'
 for san in (False,True):
  exe=out/('test_san'if san else 'test');flags=['-fsanitize=address,undefined','-fno-omit-frame-pointer']if san else[]
  run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*flags,'-I',ROOT/'src/codec/vendor/libjpeg-turbo-1.5.3',HERE/'decode.c',ROOT/'tools/firmware/stock_jpeg_gallery_55/exif.c',HERE/'test_decode.c',lib,'-o',exe],'host_compile')
  fixture=out/('half_san.jpg'if san else'half.jpg');print(run([exe,fixture],'host_actual_decode').strip(),flush=True)
  fileexe=out/('file_san'if san else'file');run(['/usr/bin/clang','-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*flags,'-DIQ4_DECODER_HOST_TEST55','-I',ROOT/'src/codec/vendor/libjpeg-turbo-1.5.3',HERE/'decode.c',HERE/'file.c',ROOT/'tools/firmware/stock_jpeg_gallery_55/exif.c',HERE/'test_file.c',lib,'-o',fileexe],'host_file_compile');print(run([fileexe,fixture],'host_actual_file').strip(),flush=True)
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';objects=[];flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-ffunction-sections','-fdata-sections','-funwind-tables','-fno-asynchronous-unwind-tables','-I',vendor]
 for unit in [HERE/'decode.c',HERE/'file.c',*[vendor/(x+'.c')for x in UNITS]]:
  obj=out/(unit.stem+'.o');run([zig,'cc',*flags,'-c',unit,'-o',obj],'target_compile_'+unit.stem);objects.append(row(obj))
 individual=list(objects);merged=out/'jpeg_gallery_vendor.o';run([zig,'cc','-target','aarch64-linux-gnu.2.28','-nostdlib','-r',*[out/(x+'.o')for x in UNITS],'-o',merged],'target_merge_vendor');objects=objects[:2]+[row(merged)]
 sources=[row(HERE/x)for x in ['decode.h','decode.c','file.c','test_decode.c','test_file.c','build.py']];sources.extend([row(ROOT/'tools/firmware/stock_jpeg_gallery_55/exif.c'),row(ROOT/'tools/firmware/stock_jpeg_gallery_55/exif.h')]);sources.extend(upstream);sources.extend([row(vendor/'jconfig.h'),row(vendor/'jconfigint.h')]);manifest=dict(schema='iq4_private_gallery_decoder_source_55',members=sources,archive=row(ARCHIVE),compiler=row(zig),host_library=row(lib),commands=row(out/'COMMANDS.json'),individual_objects=individual,merged_object=row(merged),camera_accessed=False)
 # The extracted official archive members are inputs, not altered originals.
 (out/'SOURCE_SHA256.json').write_text(json.dumps(manifest,indent=2)+'\n');locked=row(out/'SOURCE_SHA256.json')
 stock=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();va=4238912;aliases=[dict(symbol='iq4_gallery_syscall_55',va=va,kind='exact original syscall PLT, JPEG read-only source',original_first16_LE=stock[va-0x400000:va-0x400000+16].hex())]
 link=dict(schema='iq4_private_gallery_decoder_link_55',objects=objects,aliases=aliases,BL_hooks=[],auxiliary_hooks=[],required_functions=['iq4_stock_jpeg_decode_rgb_55','iq4_stock_jpeg_decode_file_55','iq4_stock_jpeg_probe_file_55','iq4_stock_jpeg_decode_crop_rgb_55','iq4_stock_jpeg_decode_crop_file_55','iq4_stock_jpeg_probe_bytes_55','iq4_stock_jpeg_decoder_bound_55'],source_manifest=locked['path'],source_manifest_sha256=locked['sha256'],camera_accessed=False,target_executed=False,codec='private upstream API80, not native private82')
 (out/'LINK.json').write_text(json.dumps(link,indent=2)+'\n');print(json.dumps(dict(objects=len(objects),link=row(out/'LINK.json'),camera_accessed=False)))
if __name__=='__main__':main()
