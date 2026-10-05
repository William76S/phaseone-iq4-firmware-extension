#!/usr/bin/env python3
"""Exact-original, finite, offline collection. No vendor code is executed."""
import argparse
import hashlib
import json
import re
import struct
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
ORIGINAL = ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
SIZE = 11874544
OBJDUMP = '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
WINDOWS = {
    'RawJpegRequest_complete': (0x48c394, 0x48cd0c),
    'IFM_request_complete': (0x496ab0, 0x496b5c),
    'IFM_backing_constructor': (0x4959ec, 0x495ce0),
    'RawEffectiveRect_complete': (0x487e98, 0x487ef4),
    'RawPayloadReader_complete': (0x7d9630, 0x7d9710),
    'Worker_complete': (0x7b749c, 0x7b8410),
    'RawTagsPool_complete': (0x7baadc, 0x7bb224),
    'PreviewProcess_complete': (0x963a28, 0x964b10),
    'RawReaderConstructor_complete': (0x9227b0, 0x922ae0),
    'RawReaderStorageConstruct_and_bytes': (0x922170, 0x9222e0),
    'RawSourceConfigure_complete': (0x960478, 0x960770),
    'RenderPipeline_complete': (0x919d58, 0x91b278),
    'RenderStageThreadInvoke': (0x919b10, 0x919b30),
    'PipelineStage_inputROI': (0x916e38, 0x916e78),
    'PipelineStage_outputROI': (0x916e78, 0x916ef8),
    'CImageBuffer_attach': (0x903f70, 0x904010),
    'CImageBuffer_region_resize': (0x904010, 0x904030),
    'CImageBuffer_reference_copy': (0x904148, 0x9041f0),
    'CImageBuffer_destroy': (0x903ca8, 0x903d00),
    'CImageBuffer_plane': (0x9043c8, 0x904420),
    'CImageBuffer_getters': (0x904438, 0x904488),
    'CImageBuffer_format': (0x904398, 0x9043c8),
    'CImageBuffer_construct': (0x904550, 0x9045d0),
    'RGB32_to_RGB24': (0x7b982c, 0x7b9948),
    'GeneratorConstruct_complete': (0x962058, 0x9622a8),
    'GeneratorDestroy_complete': (0x9622a8, 0x962618),
    'NativeRawInputConstruct_complete': (0x7bbac0, 0x7bbafc),
    'NativeSettingsConstruct_complete': (0x7bbc54, 0x7bbf44),
    'GeneratorConstructCaller': (0x7b53c4, 0x7b540c),
    'PipelineConfigure_complete': (0x916fa8, 0x918958),
    'RawSourceFactory_complete': (0x944e88, 0x946b18),
    'ProfileConfigure_ABI_head': (0x961208, 0x961288),
    'PayloadPool_getters': (0x495094, 0x4950c4),
}
WORDS = {
    0x48c76c: 0x72a7df40,  # upper 0.49 binary32 high word
    0x48c7c0: 0x72a78460,  # lower 0.01 binary32 high word
    0x48c7d4: 0x94000aef,  # clamp helper
    0x48c948: 0x94000dac,  # queue call; independently checked by BL target too
    0x7b7ed0: 0x9406aed6,  # actual preview process call
    0x7b81d4: 0xd63f0260,  # VT+28 borrowed RGB32 encoder
    0x7b8250: 0x94000577,  # RGB32-to-RGB24 copy
    0x7b8320: 0x94052e62,  # primary plane destroy
    0x963ed0: 0xbd000260,  # scale temporarily replaced by one
    0x963f8c: 0x1e28003b,  # FCVTPS (ceil), not decompiler truncation
    0x963f90: 0x1e280014,
    0x964468: 0x97ff1b70,  # RGB32 resample
    0x964484: 0x97ff1b27,  # planar resample
    0x91ae78: 0x52800064,  # intermediate format3
    0x91aec4: 0x52800064,  # second format3
    0x91aee8: 0xf9400800,  # allocated arena capacity at +10
    0x91aef0: 0x54ff80e2,
    0x91a788: 0x9e660160,
    0x91a78c: 0x97f7f1b5,  # join all stage workers
    0x7b53d4: 0xd2a76c02,  # generator backing 950MiB
    0x7b53e0: 0x9406b31e,
    0x9621e4: 0xd2a0a000,  # fixed prefix 80MiB
    0x962200: 0xa919d677,  # remaining bytes and base at generator+198/+1a0
    0x91a92c: 0xb940f3e0,  # completed stage count
    0x91a930: 0xb94133e1,  # total stages
    0x91a940: 0x54000080,  # equality exit, otherwise cancelled exit possible
}
CALLS = {
    0x496b4c: 0x48c394,
    0x48c7d4: 0x48f390,
    0x48c938: 0x48ed70,  # this is the copy, not the queue
    0x48c948: 0x48fff8,
    0x7b7ed0: 0x963a28,
    0x7b8250: 0x7b982c,
    0x7b8320: 0x903ca8,
    0x963f44: 0x919d58,
    0x964354: 0x919d58,
    0x96441c: 0x919d58,
    0x964860: 0x919d58,
    0x964468: 0x92b228,
    0x964484: 0x92b120,
    0x91ae94: 0x903f70,
    0x91aec8: 0x903f70,
    0x91a75c: 0x716cb4,
    0x91a78c: 0x716e60,
}

def sha(data):
    return hashlib.sha256(data).hexdigest()

class ExactImage:
    def __init__(self, path):
        if path.stat().st_size != SIZE:
            raise ValueError('wrong original file size')
        self.data = path.read_bytes()
        if sha(self.data) != SHA:
            raise ValueError('wrong original SHA256')
        h = struct.unpack_from('<16sHHIQQQIHHHHHH', self.data)
        if h[0][:7] != b'\x7fELF\x02\x01\x01' or h[1] != 2 or h[2] != 183:
            raise ValueError('not the fixed AArch64 ELF64 little-endian ET_EXEC')
        if h[9] != 56 or h[10] > 64 or h[5] + h[9] * h[10] > SIZE:
            raise ValueError('invalid program-header bounds')
        self.loads = []
        for i in range(h[10]):
            t, flags, off, va, _, fs, ms, align = struct.unpack_from(
                '<IIQQQQQQ', self.data, h[5] + i * h[9])
            if t == 1:
                if off + fs > SIZE or fs > ms:
                    raise ValueError('invalid file-backed LOAD')
                self.loads.append((va, fs, off, flags))

    def get(self, va, n):
        if n <= 0 or n > 65536 or va < 0 or va + n > (1 << 64):
            raise ValueError('finite read bounds')
        for base, fs, offset, flags in self.loads:
            if base <= va and va + n <= base + fs:
                off = offset + va - base
                return off, self.data[off:off+n]
        raise ValueError('VA is not entirely file backed')

def bl_target(va, word):
    if word >> 26 != 0b100101:
        raise ValueError('not direct BL')
    imm = word & 0x3ffffff
    if imm & (1 << 25):
        imm -= 1 << 26
    return va + imm * 4

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--original', type=Path, default=ORIGINAL)
    ap.add_argument('--output', type=Path,
                    default=ROOT/'analysis/firmware/f3_full_raw_native_adapter_01/static')
    a = ap.parse_args()
    image = ExactImage(a.original)
    if sum(end-start for start, end in WINDOWS.values()) > 65536:
        raise ValueError('collector total exceeded fixed 64KiB')
    locks = []
    for va, word in WORDS.items():
        off, raw = image.get(va, 4)
        actual = struct.unpack('<I', raw)[0]
        if actual != word:
            raise ValueError(f'exact word mismatch at {va:x}: {actual:08x} != {word:08x}')
        locks.append({'va': va, 'file_offset': off, 'word': f'{word:08x}'})
    calls = []
    for va, target in CALLS.items():
        _, raw = image.get(va, 4)
        if bl_target(va, struct.unpack('<I', raw)[0]) != target:
            raise ValueError(f'direct call mismatch at {va:x}')
        calls.append({'call_va': va, 'target_va': target})
    off, raw = image.get(0xdc4628, 80)
    bpp = list(struct.unpack('<20I', raw))
    if bpp != [2,3,6,12,4,0,0,0,0,0,0,1,2,4,0,0,0,0,4,0]:
        raise ValueError('fixed bytes-per-pixel table mismatch')
    a.output.mkdir(parents=True, exist_ok=True)
    windows = []
    runs = []
    for name, (start, end) in WINDOWS.items():
        off, raw = image.get(start, end-start)
        argv = [OBJDUMP, '-d', f'--start-address={start}',
                f'--stop-address={end}', str(a.original.resolve())]
        run = subprocess.run(argv, text=True, capture_output=True, check=True)
        text = '\n'.join(re.sub(r'\s+<[^>]*>', '', line)
                         for line in run.stdout.splitlines() if line.startswith('  ')) + '\n'
        # Each printed word must exactly match the file; no label implies ABI.
        count = 0
        for line in text.splitlines():
            match = re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s', line)
            if match:
                va, word = int(match[1], 16), int(match[2], 16)
                if not start <= va < end or struct.unpack('<I', image.get(va, 4)[1])[0] != word:
                    raise ValueError('disassembly did not match original word')
                count += 1
        if count != (end-start)//4:
            raise ValueError(f'incomplete disassembly for {name}: {count}')
        path = a.output/(name+'.asm')
        path.write_text(text)
        windows.append({'label': name, 'start_va': start, 'end_va': end,
                        'file_offset': off, 'bytes': len(raw), 'instructions': count,
                        'raw_sha256': sha(raw), 'raw_hex': raw.hex(),
                        'disasm': path.name, 'disasm_sha256': sha(text.encode())})
        runs.append({'argv': argv, 'exit': run.returncode, 'stderr': run.stderr})
    result = {'schema': 'iq4_f3_native_render_static_01', 'original_sha256': SHA,
              'original_bytes': SIZE, 'target_executed': False, 'device_accessed': False,
              'finite_total_bytes': sum(v['bytes'] for v in windows),
              'windows': windows, 'exact_word_locks': locks, 'direct_calls': calls,
              'bpp_table': {'va': 0xdc4628, 'file_offset': off, 'bytes': 80,
                            'values_formats1through20': bpp,
                            'raw_sha256': sha(image.get(0xdc4628, 80)[1])}}
    # table offset is independent from the last disassembly loop offset.
    result['bpp_table']['file_offset'] = image.get(0xdc4628, 80)[0]
    (a.output/'EXACT.json').write_text(json.dumps(result, indent=2)+'\n')
    (a.output/'RUN.json').write_text(json.dumps(runs, indent=2)+'\n')
    print(json.dumps({'windows': len(windows), 'instructions': sum(v['instructions'] for v in windows),
                      'exact_word_locks': len(locks), 'direct_calls': len(calls),
                      'target_executed': False, 'exact_json_sha256': sha((a.output/'EXACT.json').read_bytes())}))

if __name__ == '__main__':
    main()
