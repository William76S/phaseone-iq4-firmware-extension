#!/usr/bin/env python3
"""Mechanical exact-body derivative of the frozen octet parser, SDK-free."""
from pathlib import Path
import ast,difflib,hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
 assert not (HERE/'SOURCE_SHA256.json').exists(),'Frozen; do not regenerate'
 p=ROOT/'tools/sdk/read_hex_octets_01/contract.py';s=p.read_text()
 lock=json.loads((p.parent/'SOURCE_SHA256.json').read_text());rows=lock.get('files',lock.get('members',[]))
 r=next(x for x in rows if x.get('name',x.get('path','')).endswith('contract.py'))
 assert hashlib.sha256(p.read_bytes()).hexdigest()==r['sha256']
 n=next(x for x in ast.parse(s).body if isinstance(x,ast.FunctionDef) and x.name=='parse_hex_chunk');old=ast.get_source_segment(s,n)
 new=old.replace('def parse_hex_chunk(command, reply):','def parse_fixed_octets(command, reply, offset, expected_bytes):').replace('    _validate_read_command(command)','    original._require(type(offset) is int and 0 <= offset < 65536 and type(expected_bytes) is int and 1 <= expected_bytes <= 4096, "fixed parser range")').replace('count = command.expected_bytes','count = expected_bytes').replace('command.offset','offset')
 pre='''# Mechanically derived strict parser body. Path/command identity is checked\n# by the new finite contract before entry. No SDK/tool/device operation.\nimport re,sys\nfrom pathlib import Path\nsys.path.insert(0,str(Path(__file__).resolve().parents[1]))\nimport sys_read_backup_host as original\n\n'''
 (HERE/'derived_octet_parser.py').write_text(pre+new+'\n')
 (HERE/'OCTET_PARSER_DIFF.txt').write_text(''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='frozen/parse_hex_chunk',tofile='new/parse_fixed_octets')))
 print(hashlib.sha256((pre+new+'\n').encode()).hexdigest())
if __name__=='__main__':main()
