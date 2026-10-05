#!/usr/bin/env python3
"""Hash-bound, offline updater evidence. No vendor code, SDK or device executes."""
import argparse
import hashlib
import io
import json
from pathlib import Path
import struct
import subprocess
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[2]
USER = 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USER_SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
FWR = ROOT.parent / 'Firmware-BP-IQ4-IQ4_6.03.18.fwr'
FWR_SHA = 'a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300'
BASE = ROOT / 'analysis/firmware/firmware_package_acceptance_static_01'
REFERENCES = {
    'tools/firmware/save_setup_security_collect_static.py': 'aac5df8cfa3f819f196921181b1efa7679be0b4627ef4031419cd888358b5f18',
    'analysis/firmware/unwind_functions.json': '3d3d54d925492731a5d7f4b19514a5664e349c0a776a4922848f043435b83fb8',
    'analysis/firmware/bootstrap_recovery_static/rootfs_exact_sources.json': '468f263e41717c527318316fc3a94fa46fc688bb634317ae74400eab6ba8e7d3',
}

def sha(b): return hashlib.sha256(b).hexdigest()
def dump(path, value): path.write_text(json.dumps(value, ensure_ascii=False, indent=2)+'\n')

def collect(out):
    for name, digest in REFERENCES.items():
        if sha((ROOT/name).read_bytes()) != digest:
            raise ValueError('changed frozen dependency: '+name)
    sys.path.insert(0, str(ROOT/'tools/firmware'))
    from save_setup_security_collect_static import sections, span
    raw = (ROOT/USER).read_bytes()
    if sha(raw) != USER_SHA or len(raw) != 11874544:
        raise ValueError('unknown User baseline')
    source = FWR.read_bytes()
    if sha(source) != FWR_SHA:
        raise ValueError('unknown FWR baseline')
    if out.exists() and any(out.iterdir()):
        raise ValueError('fresh output directory required')
    out.mkdir(parents=True, exist_ok=True)
    layout = sections(raw)
    functions = json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions']
    exact = {'schema': 'iq4_updater_exact_static_v1', 'evidence_level': 'offline_static_only',
             'User': {'path': USER, 'bytes': len(raw), 'sha256': USER_SHA},
             'firmware_or_SDK_executed': False, 'camera_accessed': False,
             'device_acceptance_or_recovery_verified': False, 'functions': [], 'data': []}
    seen = set()
    for line in (BASE/'targets.txt').read_text().splitlines():
        if not line or line.startswith('#'): continue
        a,b,name=line.split(); start,end=int(a,16),int(b,16)
        index=functions.index(start)
        if end != functions[index+1] or start in seen:
            raise ValueError('target must be one unique complete unwind range')
        seen.add(start)
        offset,body,section=span(raw,layout,start,end)
        text=subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d', '--no-show-raw-insn',
            '--section=.text', f'--start-address={start:#x}', f'--stop-address={end:#x}', USER
        ], cwd=ROOT, text=True)
        normalized='STATIC ONLY; linked VAs. Nearest exported labels are not private function names.\n'+''.join(x.rstrip()+'\n' for x in text.splitlines())
        path=out/(name+'.disasm.txt'); path.write_text(normalized)
        exact['functions'].append({'name':name,'start_va':hex(start),'end_va_exclusive':hex(end),
            'complete_unwind_range':True,'file_offset':hex(offset),'section':section,
            'bytes':len(body),'bytes_hex':body.hex(),'bytes_sha256':sha(body),
            'disassembly':path.name,'disassembly_sha256':sha(path.read_bytes())})
    def data(name,start,size):
        offset,body,section=span(raw,layout,start,start+size)
        item={'name':name,'va':hex(start),'file_offset':hex(offset),'section':section,
              'bytes':size,'bytes_hex':body.hex(),'bytes_sha256':sha(body)}
        exact['data'].append(item)
        return body
    def cstring(name,addr):
        for size in range(1,257):
            offset,body,section=span(raw,layout,addr,addr+size)
            if body[-1]==0:
                text=body[:-1].decode('ascii')
                data(name,addr,size)
                exact['data'][-1]['ascii']=text
                return text
        raise ValueError('unterminated bounded static string')
    header=data('Native_imageHeader',0xdda870,180)
    exact['native_header_version']=[header[16],header[17],struct.unpack_from('<H',header,18)[0]]
    data('ManifestParser_attribute_names',0xc3de38,0x100)
    data('ManifestParser_component_type_names',0xc3da90,0xa0)
    for ident in (4,60,5,6,14,61,15,16):
        matches=[]
        for i in range(86):
            va=0xf55f18+i*40; _,body,_=span(raw,layout,va,va+40)
            if struct.unpack_from('<I',body)[0]==ident:matches.append((va,body))
        if len(matches)!=1: raise ValueError('fixed fileId not unique')
        va,body=matches[0];data('FileManager_file_'+str(ident),va,40)
        exact['data'][-1].update({'internal_file_id':ident,'flags':struct.unpack_from('<I',body,16)[0],
            'folder_id':struct.unpack_from('<I',body,24)[0]})
        cstring('FileManager_basename_'+str(ident),struct.unpack_from('<Q',body,8)[0])
    for ident in (0,1,4,5,15,16):
        matches=[]
        for i in range(19):
            va=0xf55cb8+i*32; _,body,_=span(raw,layout,va,va+32)
            if struct.unpack_from('<I',body)[0]==ident:matches.append((va,body))
        if len(matches)!=1: raise ValueError('fixed folderId not unique')
        va,body=matches[0];data('FileManager_folder_'+str(ident),va,32)
        cstring('FileManager_folder_path_'+str(ident),struct.unpack_from('<Q',body,8)[0])
    for name,va in [('full_update_requires_boot_error',0xc38ce8),('stock_manifest_name',0xf56ce8),
                    ('Qspi_boot_marker_device_path',0xc3e070)]:
        if name=='stock_manifest_name':
            pointer=data(name+'_pointer',va,8);va=struct.unpack('<Q',pointer)[0]
        cstring(name,va)
    dump(out/'exact_bytes.json',exact)
    with zipfile.ZipFile(io.BytesIO(source)) as archive:
        if len(archive.infolist())!=20 or archive.testzip() is not None or archive.comment:
            raise ValueError('original ZIP20 CRC invariant')
        entries=[]
        for item in archive.infolist():
            body=archive.read(item.filename)
            # Store inventory and exact original XML, never copy firmware payloads.
            entries.append({'name':item.filename,'bytes':len(body),'sha256':sha(body),
                'crc32':f'{item.CRC:08x}','compression_method':item.compress_type,
                'compressed_size':item.compress_size,'zip_flags':item.flag_bits,
                'local_header_offset':item.header_offset})
        xml=archive.read('manifest.xml')
        (out/'original_manifest.xml').write_bytes(xml)
    dump(out/'zip20_inventory.json',{'source_file_name':FWR.name,'bytes':len(source),
        'sha256':FWR_SHA,'ZIP_CRC_verified':True,'cryptographic_authentication_verified':False,
        'manifest_bytes':len(xml),'manifest_sha256':sha(xml),'entries':entries})
    rootfs=json.loads((ROOT/'analysis/firmware/bootstrap_recovery_static/rootfs_exact_sources.json').read_text())
    candidates=[r for r in rootfs['regular_files'] if any('P1LINUX_FWUPGR_PATH' in s for s in r['text_lines'])]
    if len(candidates)!=1:raise ValueError('rootfs runner not unique')
    runner=candidates[0];body=bytes.fromhex(runner['content_hex'])
    if sha(body)!=runner['sha256']:raise ValueError('frozen runner bytes mismatch')
    dump(out/'runner_upgrade_reference.json',{'evidence_level':'packaged_rootfs_static_only',
        'source_ramdisk_sha256':rootfs['source_ramdisk_sha256'],'path':runner['path'],
        'whole_source_bytes':len(body),'whole_source_sha256':sha(body),
        'not_actual_runtime_runner_backup':True,
        'lines':[{'line':i+1,'text':s} for i,s in enumerate(runner['text_lines'])
                 if 20<=i+1<=70 or 90<=i+1<=130]})
    dump(out/'manifest.json',{'schema':'iq4_updater_static_collection_manifest_v1',
        'evidence_level':'offline_static_only','references':REFERENCES,
        'functions':len(exact['functions']),'data_records':len(exact['data']),
        'files':{str(p.relative_to(out)):sha(p.read_bytes()) for p in sorted(out.iterdir())}})
    print(f'{len(exact["functions"])} complete unwind ranges; {len(exact["data"])} data records; ZIP20 CRC checked; no target code executed')

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-directory',type=Path,default=BASE/'evidence')
    args=parser.parse_args();out=args.output_directory.resolve()
    if ROOT not in out.parents:raise ValueError('fresh project-local output required')
    collect(out)
if __name__=='__main__':main()
