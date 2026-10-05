#!/usr/bin/env python3
"""Original User byte collection only; no target/library execution."""
import argparse,hashlib,json,struct,subprocess,tarfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
API=[('std_error',0x9a20f0,0x9a2148),('create_compress',0x9a2148,0x9a2248),
     ('destroy_compress',0x9a2248,0x9a224c),('set_defaults',0x9a34b8,0x9a3648),
     ('set_quality',0x9a2fc8,0x9a3120),('start_compress',0x9a39e0,0x9a3a84),
     ('write_scanlines',0x9a3a88,0x9a3b7c),('finish_compress',0x9a22f0,0x9a246c),
     ('destroy_tail',0x9a3d28,0x9a3d5c)]
OTHER=[('encoder_factory',0x98cf48,0x98cf94),('encoder_ctor',0x98d0d8,0x98d1dc),
       ('encoder_full',0x98d680,0x98d8a8),('encoder_rgb32',0x98d950,0x98d9fc),
       ('encoder_rgb24',0x98d8a8,0x98d950),('encoder_error_exit',0x98cf08,0x98cf48),
       ('ICE_encoder_owner',0x7b5598,0x7b55d0),('ICE_encoder_call',0x7b8134,0x7b81dc),
       ('buffer_plane',0x9043c8,0x90441c),('buffer_stride',0x904468,0x904470),
       ('default_colorspace',0x9a33d0,0x9a34b8)]

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True)
    p.add_argument('--emit-code-pins',action='store_true');a=p.parse_args()
    if a.output.exists():raise ValueError('Fresh output required')
    d=USER.read_bytes()
    if hashlib.sha256(d).hexdigest()!=SHA:raise ValueError('Wrong original User')
    h=struct.unpack_from('<16sHHIQQQIHHHHHH',d)
    if h[1:3]!=(2,183):raise ValueError('Original AArch64 ET_EXEC required')
    ph=[struct.unpack_from('<IIQQQQQQ',d,h[5]+i*h[9])for i in range(h[10])]
    def offset(va):
        for kind,flags,off,base,_,filesz,_,_ in ph:
            if kind==1 and base<=va<base+filesz:return off+va-base
        raise ValueError('Not original file-backed VA')
    a.output.mkdir(parents=True)
    def run(*args):return subprocess.run([OBJ,*args,str(USER)],check=True,capture_output=True,text=True).stdout
    syms=run('--dynamic-syms')
    dynamic=run('-p')
    if any('jpeg' in line.lower()for line in syms.splitlines()):raise ValueError('Unexpected jpeg dynamic symbol')
    needed=[line.strip().split(None,1)[1]for line in dynamic.splitlines()if line.strip().startswith('NEEDED')]
    if any('jpeg' in x.lower()for x in needed):raise ValueError('Unexpected jpeg dependency')
    (a.output/'dynamic_symbols.txt').write_text('\n'.join(x.rstrip()for x in syms.splitlines())+'\n')
    (a.output/'dynamic_headers.txt').write_text('\n'.join(x.rstrip()for x in dynamic.splitlines())+'\n')
    records=[];header=['/* Generated from exact original User by collect.py; no execution. */',
        '#ifndef IQ4_JPEG82_CODE_PINS_01_H','#define IQ4_JPEG82_CODE_PINS_01_H',
        'typedef struct Iq4Jpeg82CodePin01 {uintptr_t va;size_t bytes;const uint8_t *original;} Iq4Jpeg82CodePin01;',
        'static const uint8_t iq4_jpeg82_original_sha01[32]={'+','.join('0x'+SHA[i:i+2]for i in range(0,64,2))+'};']
    for name,start,end in API+OTHER:
        off=offset(start);b=d[off:off+end-start]
        if offset(end-1)!=off+len(b)-1:raise ValueError('Noncontiguous span')
        text=run('-d',f'--start-address={hex(start)}',f'--stop-address={hex(end)}')
        (a.output/(name+'.asm')).write_text('INPUT_SHA256 '+SHA+'\nSTATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE\n'+'\n'.join(x.rstrip()for x in text.splitlines())+'\n')
        records.append(dict(name=name,va=hex(start),end=hex(end),file_offset=hex(off),bytes=len(b),sha256=hashlib.sha256(b).hexdigest(),exact_hex=b.hex()))
        if (name,start,end)in API:
            header.append('static const uint8_t iq4_jpeg82_pin_'+name+'01[]={')
            header.extend('    '+','.join('0x%02x'%x for x in b[i:i+16])+','for i in range(0,len(b),16))
            header.append('};')
    header.append('static const Iq4Jpeg82CodePin01 iq4_jpeg82_code_pins01[]={')
    header.extend('    {(uintptr_t)0x%xu,sizeof(iq4_jpeg82_pin_%s01),iq4_jpeg82_pin_%s01},'%(start,name,name)for name,start,end in API)
    header.extend(['};','#endif',''])
    generated='\n'.join(header)
    if a.emit_code_pins:(HERE/'code_pins.h').write_text(generated)
    elif (HERE/'code_pins.h').read_text()!=generated:raise ValueError('Source pins not reproducible')
    vt=d[offset(0xdce100):offset(0xdce100)+0x60]
    slots={hex(i):hex(struct.unpack_from('<Q',vt,i)[0])for i in range(0,len(vt),8)}
    assert slots['0x20']=='0x98d8a8' and slots['0x28']=='0x98d950'
    version=d[0x9d27d0:].split(b'\0',1)[0].decode('ascii')
    assert version=='libjpeg-turbo version 1.5.3 (build 0)'
    report=dict(schema='iq4_f3_native_jpeg82_static_01',original_User_sha256=SHA,
        original_User_bytes=len(d),elf_type='ET_EXEC',machine='AArch64',api_version=82,
        compressor_bytes=584,error_mgr_bytes=168,destination_mgr_bytes=40,
        libjpeg_version_string=dict(va='0xdd27d0',file_offset='0x9d27d0',text=version),
        dynamic_jpeg_symbols=[],needed_libraries=needed,encoder_vtable=dict(va='0xdce100',file_offset=hex(offset(0xdce100)),bytes_hex=vt.hex(),slots=slots),
        functions={name:hex(start)for name,start,end in API if name!='destroy_tail'},
        ranges=records,code_pin_bytes=sum(end-start for _,start,end in API),
        static_abi_closed=True,target_encoder_executed=False,runtime_binding_verified=False,
        target_API82_has_been_called=False,sdk_loaded=False,device_access=False)
    # Existing official source cache: verify against already-pinned archive,
    # read only, with no extraction/network/configure/library execution.
    archive=ROOT/'evidence/codec/downloads/libjpeg-turbo-1.5.3.tar.gz'
    archive_sha='b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523'
    if hashlib.sha256(archive.read_bytes()).hexdigest()!=archive_sha:raise ValueError('Official cached archive identity')
    upstream=[]
    with tarfile.open(archive,'r:gz')as tf:
        for name in ['jcapimin.c','jcapistd.c','jcomapi.c','jerror.c','jcparam.c','jpeglib.h','jmorecfg.h']:
            member='libjpeg-turbo-1.5.3/'+name
            b=tf.extractfile(member).read()
            cached=ROOT/'evidence/codec/downloads/libjpeg-turbo-1.5.3'/name
            if cached.read_bytes()!=b:raise ValueError('Cached source not exact upstream: '+name)
            upstream.append(dict(name=name,archive_member=member,bytes=len(b),sha256=hashlib.sha256(b).hexdigest()))
    report['upstream_reference']=dict(official_release='1.5.3',cached_package_sha256=archive_sha,members=upstream,
        native_private_version_82_not_claimed_identical_to_stock_API80=True)
    (a.output/'EXACT.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(dict(output=str(a.output),windows=len(records),code_pin_bytes=report['code_pin_bytes'],static_only=True)))
if __name__=='__main__':main()
