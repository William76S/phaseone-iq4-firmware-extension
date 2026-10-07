#!/usr/bin/env python3
"""Finite Windows project-local acquisition and public cross-compile probes.

Default preflight has no network or file mutation. --acquire is an explicit
Root-controlled action on Windows only. No SDK/device/private original input.
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import ssl
import stat
import struct
import subprocess
import sys
import time
import unicodedata
import urllib.request
import zipfile

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
VERSION='0.15.2';ARCHIVE_ROOT='zig-x86_64-windows-0.15.2'
URL='https://ziglang.org/download/0.15.2/'+ARCHIVE_ROOT+'.zip'
ZIP_SIZE=92614574;ZIP_SHA='3a0ed1e8799a2f8ce2a6e6290a9ff22e6906f8227865911fb7ddedc3cc14cb0c'
DEST=ROOT/'build/toolchains/zig-x86_64-windows-0.15.2-acquired01'
MAX_ENTRIES=30000;MAX_TOTAL=768*1024*1024;MAX_MEMBER=256*1024*1024
R1=ROOT/'tools/firmware/record1_ram_restore_01'

def sha(b):return hashlib.sha256(b).hexdigest()
def whole_hash(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(512*1024),b''):h.update(b)
    return h.hexdigest()
def dump(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def regular(p):
    s=p.lstat()
    return stat.S_ISREG(s.st_mode) and not p.is_symlink() and not (getattr(s,'st_file_attributes',0)&0x400)
def no_reparse_chain(p):
    for q in [p]+list(p.parents):
        if q.exists() and (q.is_symlink() or (getattr(q.lstat(),'st_file_attributes',0)&0x400)):return False
    return True

def source_lock():
    p=json.loads((HERE/'toolchain.windows.lock.json').read_text())
    expected={'schema':'iq4_windows_zig_source_lock_v1','version':VERSION,'host':'x86_64-windows',
      'archive_root':ARCHIVE_ROOT,'archive_name':ARCHIVE_ROOT+'.zip','url':URL,
      'archive_size':ZIP_SIZE,'archive_sha256':ZIP_SHA,'target':'aarch64-linux-gnu.2.17','zig_exe_sha256':None}
    if any(type(p.get(k)) is not type(v) or p[k]!=v for k,v in expected.items()):raise ValueError('source lock changed')
    return p

def private_acl(p):
    if os.name!='nt':return False
    script=r'''$ErrorActionPreference='Stop';$a=Get-Acl -LiteralPath $env:IQ4_ZIG_ACL_PATH;
$sid=[Security.Principal.WindowsIdentity]::GetCurrent().User.Value;
$owner=([Security.Principal.NTAccount]$a.Owner).Translate([Security.Principal.SecurityIdentifier]).Value;
$ok=($owner -eq $sid);$allow=@($sid,'S-1-5-18','S-1-5-32-544');
foreach($r in $a.Access){$id=$r.IdentityReference.Translate([Security.Principal.SecurityIdentifier]).Value;if($allow -notcontains $id){$ok=$false}}
if($ok){'PRIVATE_OK'}else{'PRIVATE_REFUSED'}'''
    env=dict(os.environ);env['IQ4_ZIG_ACL_PATH']=str(p)
    r=subprocess.run(['powershell.exe','-NoProfile','-NonInteractive','-Command',script],env=env,capture_output=True,text=True,timeout=15)
    return r.returncode==0 and r.stdout.strip()=='PRIVATE_OK'

def host_gate():
    if os.name!='nt' or platform.machine().lower() not in ('amd64','x86_64'):raise ValueError('requires Windows x86_64')
    parent=DEST.parent
    if not parent.is_dir() or not parent.resolve().is_relative_to(ROOT.resolve()) or not no_reparse_chain(parent) or not private_acl(parent):raise ValueError('project toolchain parent protection absent')

def verify_archive(path,size=ZIP_SIZE,digest=ZIP_SHA):
    if not regular(path) or path.stat().st_size!=size or whole_hash(path)!=digest:raise ValueError('archive mismatch')

def download(path):
    # Source lock is not a user URL parameter. Refuse redirects/mirror/fallback.
    source_lock();deadline=time.monotonic()+1200
    request=urllib.request.Request(URL,headers={'User-Agent':'IQ4-local-toolchain-01','Accept-Encoding':'identity'})
    with urllib.request.urlopen(request,timeout=20,context=ssl.create_default_context()) as response, path.open('xb') as out:
        if response.geturl()!=URL or response.status!=200:raise ValueError('download origin changed')
        declared=response.headers.get('Content-Length')
        if declared is not None and (not declared.isdecimal() or int(declared)!=ZIP_SIZE):raise ValueError('download size header changed')
        count=0;h=hashlib.sha256()
        while True:
            if time.monotonic()>deadline:raise ValueError('download deadline')
            b=response.read(512*1024)
            if not b:break
            count+=len(b)
            if count>ZIP_SIZE:raise ValueError('download exceeds lock')
            out.write(b);h.update(b)
        if count!=ZIP_SIZE or h.hexdigest()!=ZIP_SHA:raise ValueError('download mismatch')

def safe_parts(info,root=ARCHIVE_ROOT):
    name=info.filename
    if type(name) is not str or not name or getattr(info,'orig_filename',name)!=name or len(name)>512 or '\\' in name or name.startswith('/') or name!=unicodedata.normalize('NFC',name):raise ValueError('unsafe ZIP name')
    parts=name.rstrip('/').split('/')
    if parts[0]!=root or (len(parts)<2 and not (name==root+'/' and info.is_dir())):raise ValueError('archive root mismatch')
    for p in parts:
        if not p or len(p)>255 or p in ('.','..') or p[-1] in (' ','.') or any(ord(c)<32 or c in '<>:"|?*' or 0xd800<=ord(c)<=0xdfff for c in p):raise ValueError('unsafe ZIP path')
        stem=p.split('.')[0].upper()
        if stem in {'CON','PRN','AUX','NUL','CONIN$','CONOUT$'} or re.fullmatch('(COM|LPT)[1-9¹²³]',stem):raise ValueError('reserved Windows name')
    mode=info.external_attr>>16;kind=stat.S_IFMT(mode)
    if kind not in (0,stat.S_IFREG,stat.S_IFDIR) or (info.external_attr&0x400) or (info.flag_bits&1):raise ValueError('ZIP link/reparse/encrypted member')
    if info.compress_type not in (zipfile.ZIP_STORED,zipfile.ZIP_DEFLATED):raise ValueError('unsupported ZIP compression')
    if info.file_size<0 or info.file_size>MAX_MEMBER or (info.is_dir() and info.file_size):raise ValueError('ZIP member extent')
    return tuple(parts)

def inspect_members(z,root=ARCHIVE_ROOT):
    members=z.infolist()
    if not members or len(members)>MAX_ENTRIES:raise ValueError('ZIP entry count')
    total=0;seen={};files=set();dirs=set();out=[];explicit_root=False;spellings={}
    for info in members:
        # Official zip may include its single explicit root directory.
        if info.filename==root+'/':
            if explicit_root or not info.is_dir() or info.file_size or getattr(info,'orig_filename',info.filename)!=info.filename:raise ValueError('ZIP root shape')
            safe_parts(info,root)
            explicit_root=True
            continue
        parts=safe_parts(info,root);key='/'.join(parts).casefold()
        if key in seen:raise ValueError('duplicate/case-colliding ZIP name')
        for i in range(1,len(parts)+1):
            spelling='/'.join(parts[:i]);folded=spelling.casefold()
            if folded in spellings and spellings[folded]!=spelling:raise ValueError('case-colliding ZIP directory')
            spellings[folded]=spelling
        seen[key]=info.is_dir();total+=info.file_size
        if total>MAX_TOTAL:raise ValueError('ZIP total extent')
        (dirs if info.is_dir() else files).add(key);out.append((info,parts))
    for key in seen:
        prefix=key.split('/')
        if any('/'.join(prefix[:i]) in files for i in range(1,len(prefix))):raise ValueError('ZIP file/directory conflict')
    if root.casefold()+'/zig.exe' not in files:raise ValueError('compiler missing')
    return out,total

def archive_members(archive):
    # Re-derive member hashes from the locked archive each verification;
    # acquisition.json cannot replace the archive-to-exe trust chain.
    receipts={}
    with zipfile.ZipFile(archive) as z:
        members,_=inspect_members(z)
        for info,parts in members:
            if info.is_dir():continue
            h=hashlib.sha256();count=0
            with z.open(info) as source:
                for b in iter(lambda:source.read(512*1024),b''):
                    count+=len(b)
                    if count>info.file_size:raise ValueError('archive member exceeds extent')
                    h.update(b)
            if count!=info.file_size:raise ValueError('archive member shorter than extent')
            receipts['/'.join(parts[1:])]={'sha256':h.hexdigest(),'size':count}
    return receipts

def extract_verified(archive,dest,root=ARCHIVE_ROOT):
    # Caller verifies the locked archive before this function. No extractall.
    if dest.exists():raise ValueError('extraction must be fresh')
    with zipfile.ZipFile(archive) as z:
        members,total=inspect_members(z,root);dest.mkdir()
        receipts={}
        for info,parts in members:
            rel=Path(*parts[1:]);path=dest/rel
            if info.is_dir():path.mkdir(parents=True,exist_ok=True);continue
            path.parent.mkdir(parents=True,exist_ok=True)
            if not no_reparse_chain(path.parent):raise ValueError('created directory reparse')
            h=hashlib.sha256();count=0
            with z.open(info) as source,path.open('xb') as target:
                while True:
                    b=source.read(512*1024)
                    if not b:break
                    count+=len(b)
                    if count>info.file_size:raise ValueError('member exceeds declared extent')
                    target.write(b);h.update(b)
            if count!=info.file_size or not regular(path):raise ValueError('extracted member changed')
            receipts[rel.as_posix()]={'sha256':h.hexdigest(),'size':count}
    return receipts,total

def pe_x64(path):
    if not regular(path):raise ValueError('compiler not regular')
    with path.open('rb') as f:
        b=f.read(64)
        if len(b)!=64 or b[:2]!=b'MZ':raise ValueError('compiler not PE')
        off=struct.unpack_from('<I',b,60)[0]
        if off<64 or off>1024*1024:raise ValueError('PE header extent')
        f.seek(off);p=f.read(26)
    if len(p)!=26 or p[:4]!=b'PE\0\0' or struct.unpack_from('<H',p,4)[0]!=0x8664 or struct.unpack_from('<H',p,24)[0]!=0x20b:raise ValueError('compiler not x64 PE32+')

def check_tree(tree,members):
    actual={}
    if not no_reparse_chain(tree):raise ValueError('toolchain tree reparse')
    for path in tree.rglob('*'):
        if not no_reparse_chain(path):raise ValueError('toolchain member reparse')
        if path.is_dir():continue
        if not regular(path):raise ValueError('toolchain member not regular')
        actual[path.relative_to(tree).as_posix()]={'sha256':whole_hash(path),'size':path.stat().st_size}
    if actual!=members:raise ValueError('toolchain tree changed')

def verified_compiler():
    host_gate();source_lock();verify_archive(DEST/'archive.zip')
    receipt=json.loads((DEST/'acquisition.json').read_text())
    if receipt.get('schema')!='iq4_windows_zig_acquisition_v1' or receipt.get('archive_sha256')!=ZIP_SHA or receipt.get('archive_size')!=ZIP_SIZE:raise ValueError('acquisition receipt changed')
    expected=archive_members(DEST/'archive.zip')
    if expected!=receipt.get('members'):raise ValueError('receipt no longer matches locked archive')
    tree=DEST/'toolchain';check_tree(tree,expected);exe=tree/'zig.exe';pe_x64(exe)
    if not private_acl(DEST) or not private_acl(exe) or whole_hash(exe)!=receipt.get('zig_exe_sha256'):raise ValueError('compiler digest/protection changed')
    version=subprocess.check_output([str(exe),'version'],cwd=DEST,text=True,timeout=30).strip()
    if version!=VERSION or version!=receipt.get('zig_version'):raise ValueError('compiler version changed')
    return exe,receipt

def acquire():
    host_gate();source_lock()
    if DEST.exists():raise ValueError('fresh toolchain directory required')
    DEST.mkdir()
    if not private_acl(DEST):raise ValueError('fresh toolchain protection absent')
    part=DEST/'archive.zip.part';download(part);verify_archive(part);part.rename(DEST/'archive.zip')
    members,total=extract_verified(DEST/'archive.zip',DEST/'toolchain')
    check_tree(DEST/'toolchain',members);exe=DEST/'toolchain/zig.exe';pe_x64(exe)
    if not private_acl(exe):raise ValueError('compiler protection absent')
    digest=whole_hash(exe)
    version=subprocess.check_output([str(exe),'version'],cwd=DEST,text=True,timeout=30).strip()
    if version!=VERSION:raise ValueError('compiler version mismatch')
    dump(DEST/'acquisition.json',{'schema':'iq4_windows_zig_acquisition_v1','archive_sha256':ZIP_SHA,'archive_size':ZIP_SIZE,
      'zig_exe_sha256':digest,'zig_version':version,'extracted_files':len(members),'uncompressed_bytes':total,'members':members,
      'Windows_compiler_version_executed':True,'target_executed':False,'device_accessed':False,'private_originals_read':False})
    return {'acquired':True,'zig_exe_sha256':digest,'zig_version':version,'target_executed':False,'device_accessed':False}

def main():
    p=argparse.ArgumentParser();a=p.add_mutually_exclusive_group();a.add_argument('--acquire',action='store_true');a.add_argument('--verify',action='store_true');a.add_argument('--build-probes',action='store_true');args=p.parse_args()
    source_lock()
    if args.acquire:result=acquire()
    elif args.verify or args.build_probes:
        exe,receipt=verified_compiler()
        if args.build_probes:
            import probes
            result=probes.build(exe,DEST/'probes',receipt['zig_exe_sha256'],Windows_actual=True)
        else:result={'verified':True,'zig_exe_sha256':receipt['zig_exe_sha256'],'zig_version':VERSION,'target_executed':False,'device_accessed':False}
    else:result={'preflight_only':True,'download_requested':False,'url':URL,'archive_size':ZIP_SIZE,'archive_sha256':ZIP_SHA,
      'requires_fresh_project_directory':True,'Windows_x64_required_for_acquire':True,'network_accessed':False,'device_accessed':False,'private_originals_read':False}
    print(json.dumps(result));return 0

if __name__=='__main__':
    try:raise SystemExit(main())
    except Exception:
        print(json.dumps({'toolchain_refused':True,'device_accessed':False,'private_originals_read':False,'target_executed':False}));raise SystemExit(2)
