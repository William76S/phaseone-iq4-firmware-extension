#!/usr/bin/env python3
"""Verify generated original-byte pin tables against the actual linked User."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,re,sys
ROOT=Path(__file__).resolve().parents[3]
DEFAULT=['tools/firmware/f3_native_jpeg8_binding_01/code_pins.h','tools/firmware/f3_native_render_02/api_pins.h','tools/firmware/f3_gallery_source_snapshot_01/pins.inc','tools/firmware/f3_saved_raw_capture_03/capture_pins.inc']
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def parse(p):
 s=p.read_text();values={};out=[]
 def blob(t):
  parts=[x.strip()for x in t.split(',')if x.strip()];assert parts and all(re.fullmatch(r'0x[0-9a-fA-F]{1,2}|\d+',x)for x in parts);return bytes(int(x,0)for x in parts)
 for name,b in re.findall(r'(?:static const|inline constexpr) (?:unsigned char|uint8_t)\s+(\w+)\[\d*\]\s*=\s*\{([^{}]*)\}',s):values[name]=blob(b)
 for va,b in re.findall(r'\{\s*(0x[0-9a-fA-F]+|\d+)\s*,\s*\{([^{}]*)\}\s*\}',s):out.append((int(va,0),blob(b)))
 for va,n,name in re.findall(r'\{\s*(0x[0-9a-fA-F]+|\d+)\s*,\s*(0x[0-9a-fA-F]+|\d+)\s*,\s*(\w+)\s*\}',s):
  assert name in values,(p,name);b=values[name];assert len(b)==int(n,0),(p,name,n,len(b));out.append((int(va,0),b))
 for va,name,ref in re.findall(r'\{\s*(?:\(uintptr_t\))?(0x[0-9a-fA-F]+|\d+)u?\s*,\s*sizeof\((\w+)\)\s*,\s*(\w+)\s*\}',s):
  assert name==ref and name in values,(p,name);out.append((int(va,0),values[name]))
 if 'iq4_source_syscall_pin_02' in values:
  consumer=ROOT/'tools/firmware/f3_native_render_02/native_file_ops.cpp'
  assert 'read(context,0x40ae40,b,32)' in consumer.read_text()
  assert len(values['iq4_source_syscall_pin_02'])==32
  out.append((0x40ae40,values['iq4_source_syscall_pin_02']))
 assert out,p;return out

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);ap.add_argument('--header',action='append',default=[]);ap.add_argument('--output',default='ORIGINAL_PIN_CHECK.json');a=ap.parse_args();out=a.build.resolve();j=json.loads((out/'BUILD.json').read_text());user=ROOT/j['User']['path'];assert row(user)==j['User']
 path=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py';assert row(path)['sha256']=='05c7bb3eabcd471d7ef2fbe8a53c014abcc62e212a9234810521e0ec91557b6d';sp=importlib.util.spec_from_file_location('pin_verifier_elf',path);m=importlib.util.module_from_spec(sp);sys.modules[sp.name]=m;sp.loader.exec_module(m);e=m.Elf(user.read_bytes(),2);checks=[]
 for header in DEFAULT+a.header:
  p=ROOT/header;windows=[]
  for va,b in parse(p):
   off=e.va_offset(va,len(b));actual=e.data[off:off+len(b)];windows.append(dict(va=hex(va),bytes=len(b),matches=actual==b))
  checks.append(dict(header=row(p),windows=windows))
 assert sum(len(x['windows'])for x in checks[:4])==61
 report=dict(User=row(user),groups=checks,total_windows=sum(len(x['windows'])for x in checks),all_match=all(w['matches']for x in checks for w in x['windows']),static_only=True,target_executed=False)
 assert Path(a.output).name==a.output
 (out/a.output).write_text(json.dumps(report,indent=2)+'\n');assert report['all_match'],[(x['header']['path'],w)for x in checks for w in x['windows']if not w['matches']];print(report['total_windows'],'actual linked original-byte windows match')
if __name__=='__main__':main()
