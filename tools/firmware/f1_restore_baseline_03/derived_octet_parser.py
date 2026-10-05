# Mechanically derived strict parser body. Path/command identity is checked
# by the new finite contract before entry. No SDK/tool/device operation.
import re,sys
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
import sys_read_backup_host as original

def parse_fixed_octets(command, reply, offset, expected_bytes):
    """Decode exact-count -b bytes, validating every hex address and padding.

    Native final, owner/DACL and normal cleanup are external receipt gates.
    Tool stderr is merged by the fixed profile and rejected as noncanonical.
    """
    original._require(type(offset) is int and 0 <= offset < 65536 and type(expected_bytes) is int and 1 <= expected_bytes <= 4096, "fixed parser range")
    body = original.extract_marked_text(command, reply)
    original._require(body.endswith('\n') and '\r' not in body,
                      'canonical complete LF octet output required')
    lines = body[:-1].split('\n')
    count = expected_bytes
    row_count = (count + 15) // 16
    original._require(len(lines) == row_count + 1, 'exact octet data-row/terminal count')
    original._require(re.fullmatch(r'[0-9a-f]{7}', lines[-1]) is not None
                      and int(lines[-1], 16) == offset + count,
                      'terminal address differs from exact observed boundary')
    value = bytearray()
    for row in lines[:-1]:
        original._require(len(row) == 71 and re.fullmatch(r'[0-9a-f]{7}', row[:7]) is not None
                          and row[7] == ' ', 'canonical seven-digit hex address/data row required')
        original._require(int(row[:7], 16) == offset + len(value),
                          'octet row address is duplicate, skipped or out of order')
        data = row[8:]
        actual = min(16, count - len(value))
        for index in range(16):
            token = data[index * 4:index * 4 + 3]
            if index < actual:
                original._require(re.fullmatch(r'[0-3][0-7]{2}', token) is not None,
                                  'exact three-digit octal byte required')
                value.append(int(token, 8))
            else:
                original._require(token == '   ', 'partial row has extra bytes/nonblank padding')
            if index < 15:
                original._require(data[index * 4 + 3] == ' ', 'canonical octet-cell separator required')
    original._require(len(value) == count, 'complete exact octet count required')
    return bytes(value)
