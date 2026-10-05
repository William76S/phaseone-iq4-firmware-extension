#!/usr/bin/env python3
"""Host-only planning/validation for finite original Sys reads. No transport API.

This module neither loads an SDK nor sends/executes a command. A sole device
executor must separately validate FF.0 Start/auth, its native sender, actual
runtime input parsing, tool options and current program identity before use.
Output bytes/EEPROM contents are never printed or interpreted as credentials.
"""
from dataclasses import dataclass, asdict
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import struct

EEPROM_PARENT = '/sys/devices/platform/amba/ff030000.i2c'
EEPROM_PATTERN = re.compile(re.escape(EEPROM_PARENT) + r'/i2c-([0-9])/\1-0057/eeprom\Z')
USER_PATHS = {'/mnt/qspi/User/p1linux', '/run/media/storage/User/p1linux'}
MAX_CHUNK = 8192
MAX_REPLY_TEXT = 32760


class ContractError(ValueError):
    pass


def _require(condition, reason):
    if not condition:
        raise ContractError(reason)


def _sha(data):
    return hashlib.sha256(data).hexdigest()


def _lex_generated(text):
    """Model only our restricted generated alphabet, not a generic shell lexer."""
    _require(text.isascii() and '\0' not in text and '\\' not in text, 'unsupported lexer alphabet')
    tokens = []
    i = 0
    while i < len(text):
        if text[i] in ' \t=':
            i += 1
            continue
        if text[i] == '"':
            end = text.find('"', i + 1)
            _require(end >= 0, 'unclosed quoted token')
            tokens.append(text[i+1:end])
            i = end + 1
        else:
            end = i
            while end < len(text) and text[end] not in ' \t=':
                end += 1
            tokens.append(text[i:end])
            i = end
    _require(len(tokens) < 40, 'token cap would be reached')
    return tokens


def verify_two_layer_text(host_text):
    """First quoted token protects spaces; second parse is deliberately simple."""
    _require(host_text.isascii() and '\n' not in host_text and '\r' not in host_text,
             'host text must be one finite ASCII line')
    _require(host_text.startswith('"Sys ') and host_text.endswith('"'), 'outer quote wrapper required')
    inner = host_text[1:-1]
    _require(not any(c in inner for c in ['"', '=', '\\', '\t', '\0']),
             'inner quotes/equals/escapes/tabs are not supported')
    # The actual reader appends newline; generated text must not append another.
    first = _lex_generated('IqpDevelRaw ' + host_text)
    _require(first == ['IqpDevelRaw', inner], 'outer parser would destroy inner command')
    second = _lex_generated(first[1])
    _require(second and second[0] == 'Sys', 'exact original command name required')
    reconstructed = ''.join(' ' + s for s in second[1:])
    _require(reconstructed == ' ' + inner[4:], 'Sys reconstruction changed command text')
    _require(len(reconstructed.encode('ascii')) <= 255, 'Sys snprintf 255-byte limit')
    return {'outer_tokens': len(first), 'inner_tokens': len(second),
            'sys_bytes_with_leading_space': len(reconstructed)}


@dataclass(frozen=True)
class ReadCommand:
    label: str
    host_text: str
    begin_marker: str
    end_marker: str
    expected_bytes: int | None = None
    offset: int | None = None

    def public_plan(self):
        return {**asdict(self), 'parser_checks': verify_two_layer_text(self.host_text),
                'transport_not_included': True, 'runtime_tool_options_verified': False}


def _command(label, os_text, nonce, expected=None, offset=None):
    _require(bool(re.fullmatch(r'[0-9a-f]{8,12}', nonce)), 'nonce must be 8..12 lower hex chars')
    begin, end = 'IQ4B_' + nonce, 'IQ4E_' + nonce
    # && ensures an od/stat/readlink failure cannot be hidden by a successful final printf.
    host_text = '"Sys printf ' + begin + '; ' + os_text + ' && printf ' + end + '"'
    verify_two_layer_text(host_text)
    return ReadCommand(label, host_text, begin, end, expected, offset)


def discovery_commands(nonce):
    """Fixed finite read-only templates; no path, bus, PID or tool guessed as observed."""
    templates = [
        ('p1linux_pid', '/bin/pidof p1linux'),
        ('eeprom_dynamic_paths', '/bin/ls -d ' + EEPROM_PARENT + '/i2c-[0-9]/[0-9]-0057/eeprom'),
        ('od_runtime_help', '/usr/bin/od --help 2>&1'),
        ('stat_runtime_help', '/bin/stat --help 2>&1'),
        ('readlink_runtime_help', '/usr/bin/readlink --help 2>&1'),
        ('sha256_runtime_help', '/usr/bin/sha256sum --help 2>&1'),
    ]
    return [_command(label, text, _sha((nonce + label).encode())[:10])
            for label, text in templates]


def extract_marked_text(command, reply_text):
    _require(isinstance(reply_text, bytes), 'reply must be assembled bytes')
    _require(len(reply_text) <= MAX_REPLY_TEXT and b'\0' not in reply_text, 'invalid or too large text reply')
    try:
        text = reply_text.decode('ascii')
    except UnicodeDecodeError as e:
        raise ContractError('non-ASCII output') from e
    _require(text.startswith(command.begin_marker) and text.endswith(command.end_marker),
             'missing exact markers or extra output; not a completed successful read')
    middle = text[len(command.begin_marker):len(text)-len(command.end_marker)]
    _require(command.begin_marker not in middle and command.end_marker not in middle,
             'duplicate transaction marker')
    return middle


def parse_pid(command, reply_text):
    text = extract_marked_text(command, reply_text).strip()
    _require(bool(re.fullmatch(r'[1-9][0-9]{0,8}', text)), 'expected exactly one process PID')
    return int(text)


def parse_eeprom_path(command, reply_text):
    lines = extract_marked_text(command, reply_text).strip().splitlines()
    _require(len(lines) == 1 and EEPROM_PATTERN.fullmatch(lines[0]) is not None,
             'expected one observed matching EEPROM path, same single-digit bus twice')
    return lines[0]


def _path(path):
    _require(isinstance(path,str) and (path in USER_PATHS or EEPROM_PATTERN.fullmatch(path) is not None),
             'path must be an observed original User file or exact EEPROM leaf')
    return path


def process_identity_commands(pid, nonce):
    _require(isinstance(pid, int) and 0 < pid < 10**9, 'invalid observed PID')
    exe = '/proc/' + str(pid) + '/exe'
    return [_command('runtime_exe_readlink', '/usr/bin/readlink ' + exe, nonce),
            _command('runtime_exe_sha256', '/usr/bin/sha256sum ' + exe,
                     _sha((nonce + 'exe_sha').encode())[:10])]


def parse_user_exe_path(command, reply_text):
    path = extract_marked_text(command, reply_text).strip()
    _require(path in USER_PATHS, 'runtime exe is not a known observed User path; no deleted/Factory inference')
    return path


def metadata_command(path, nonce):
    # No spaces in format: quotes are unnecessary after the second lexer.
    return _command('original_metadata', '/bin/stat -L -c %s:%f:%u:%g:%a:%Y:%i ' + _path(path), nonce)


def parse_metadata(command, reply_text):
    text = extract_marked_text(command, reply_text).strip()
    fields = text.split(':')
    _require(len(fields) == 7 and all(re.fullmatch(r'[0-9]+', fields[i]) for i in [0,2,3,5,6])
             and re.fullmatch(r'[0-9a-fA-F]+', fields[1]) and re.fullmatch(r'[0-7]+', fields[4]),
             'unexpected stat format/options/output')
    size, mode, uid, gid, permissions, mtime, inode = [
        int(fields[0]), int(fields[1],16), int(fields[2]), int(fields[3]),
        int(fields[4],8), int(fields[5]), int(fields[6])]
    _require(0 < size < 2**31 and mode & 0xf000 == 0x8000, 'must be positive-size regular binary file')
    return {'size': size, 'mode': mode, 'uid': uid, 'gid': gid,
            'permissions': permissions, 'mtime': mtime, 'inode': inode}


def hex_read_command(path, offset, count, nonce):
    _path(path)
    _require(isinstance(offset,int) and 0 <= offset < 2**31, 'invalid byte offset')
    _require(isinstance(count,int) and 0 < count <= MAX_CHUNK, 'invalid finite chunk length')
    text = '/usr/bin/od -An -v -tx1 -j ' + str(offset) + ' -N ' + str(count) + ' ' + path
    return _command('original_hex_chunk', text, nonce, count, offset)


def eof_probe_command(path, length, nonce):
    _require(0 < length < 2**31, 'invalid confirmed full byte length')
    result = hex_read_command(path, length, 1, nonce)
    return ReadCommand('original_eof_probe', result.host_text, result.begin_marker,
                       result.end_marker, 0, length)


def parse_hex_chunk(command, reply_text):
    body = extract_marked_text(command, reply_text)
    _require(re.fullmatch(r'[ \t\r\n0-9a-fA-F]*', body) is not None,
             'hex output contains errors, address columns, star folding, or unexpected text')
    tokens = body.split()
    _require(all(re.fullmatch(r'[0-9a-fA-F]{2}', token) for token in tokens), 'od byte token must be exactly two hex chars')
    _require(command.expected_bytes is not None and len(tokens) == command.expected_bytes,
             'short/extra bytes; read is not complete')
    return bytes(int(token,16) for token in tokens)


def digest_command(path, nonce):
    return _command('original_whole_file_sha256', '/usr/bin/sha256sum ' + _path(path), nonce)


def parse_digest(command, reply_text, expected_path):
    text = extract_marked_text(command, reply_text).strip()
    match = re.fullmatch(r'([0-9a-fA-F]{64})  ' + re.escape(expected_path), text)
    _require(match is not None, 'unexpected sha256sum output/options/path')
    return match.group(1).lower()


class FragmentAssembler:
    """Consume already extracted Common payloads; never build an outgoing packet."""
    def __init__(self, correlation, max_text=MAX_REPLY_TEXT):
        _require(isinstance(correlation,int) and 0 <= correlation <= 255, 'invalid correlation')
        _require(0 < max_text <= MAX_REPLY_TEXT, 'invalid output bound')
        self.correlation, self.limit = correlation, max_text
        self.sequence, self.done = 0, False
        self.parts = []

    def accept(self, common_class, common_type, payload):
        _require(not self.done, 'reply after final fragment')
        _require((common_class,common_type) == (0xff,0x81), 'wrong Common reply class/type')
        _require(len(payload) >= 20 and payload[0] == 2 and payload[4] == 1, 'wrong shell reply discriminator/type')
        _require(payload[5] == self.correlation and payload[7] == self.sequence, 'wrong correlation or sequence')
        flags = payload[6]
        _require(flags in ([1,3] if self.sequence == 0 else [0,2]), 'invalid first/intermediate/final flags')
        length = struct.unpack_from('<I', payload,8)[0]
        offset = struct.unpack_from('<H', payload,12)[0]
        total = struct.unpack_from('<I',payload,16)[0]
        _require(offset == 20 and total == len(payload) == 20 + length, 'declared output span mismatch')
        part = payload[20:]
        _require(b'\0' not in part and len(part) <= 32768, 'invalid text fragment')
        _require(sum(map(len,self.parts)) + len(part) <= self.limit, 'finite output bound exceeded')
        self.parts.append(part)
        self.done = flags in [2,3]
        self.sequence += 1
        _require(self.sequence <= 255, 'sequence wrap is outside validated contract')

    def result(self):
        _require(self.done, 'no final fragment; not a complete transaction')
        return b''.join(self.parts)


class BackupPass:
    def __init__(self, path, metadata):
        self.path = _path(path)
        _require(metadata['size'] > 0, 'metadata has no exact length')
        self.metadata = dict(metadata)
        self.data = bytearray()

    def append(self, command, complete_reply_text):
        _require(command.offset == len(self.data), 'gap, duplicate or reordered chunk')
        chunk = parse_hex_chunk(command, complete_reply_text)
        _require(len(self.data) + len(chunk) <= self.metadata['size'], 'chunk exceeds observed original size')
        self.data.extend(chunk)

    def finish(self, after_metadata, eof_command, eof_reply, whole_file_digest):
        _require(self.metadata == after_metadata, 'original metadata changed during read')
        _require(len(self.data) == self.metadata['size'], 'assembled full size mismatch')
        _require(eof_command.offset == len(self.data) and eof_command.expected_bytes == 0,
                 'missing exact EOF boundary probe')
        _require(parse_hex_chunk(eof_command,eof_reply) == b'', 'data beyond observed size')
        _require(_sha(self.data) == whole_file_digest, 'whole-file target digest mismatch')
        return bytes(self.data)


def save_private_double_read(directory, first, second, metadata_first, metadata_second):
    """Local exclusive save after validation; no credential decoding or device write."""
    _require(os.name == 'posix', 'POSIX private saver is not a Windows owner/DACL proof; use verified native private saver')
    _require(first == second and metadata_first == metadata_second, 'independent reads/metadata differ')
    _require(len(first) == metadata_first['size'], 'full original length mismatch')
    directory = Path(directory)
    directory.mkdir(mode=0o700, parents=True, exist_ok=False)
    for name, value in [('original_read1.bin',first),('original_read2.bin',second)]:
        fd = os.open(directory/name, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
        with os.fdopen(fd,'wb') as f:
            f.write(value)
            f.flush()
            os.fsync(f.fileno())
    summary = {'bytes':len(first), 'sha256':_sha(first), 'double_read_equal':True,
               'metadata_equal':True, 'metadata':metadata_first,
               'payload_or_PIN_semantics_parsed':False,
               'restoration_verified':False, 'hardware_feature_acceptance':False}
    fd = os.open(directory/'integrity.json', os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(fd,'w') as f:
        json.dump(summary,f,indent=2)
        f.write('\n')
    return summary


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action',choices=['discovery','process','metadata','hex','eof','digest'])
    parser.add_argument('--nonce',required=True)
    parser.add_argument('--pid',type=int)
    parser.add_argument('--path')
    parser.add_argument('--offset',type=int,default=0)
    parser.add_argument('--count',type=int,default=256)
    args = parser.parse_args()
    if args.action == 'discovery': commands = discovery_commands(args.nonce)
    elif args.action == 'process': commands = process_identity_commands(args.pid,args.nonce)
    elif args.action == 'metadata': commands = [metadata_command(args.path,args.nonce)]
    elif args.action == 'hex': commands = [hex_read_command(args.path,args.offset,args.count,args.nonce)]
    elif args.action == 'eof': commands = [eof_probe_command(args.path,args.offset,args.nonce)]
    else: commands = [digest_command(args.path,args.nonce)]
    print(json.dumps({'host_only_plan':True,'camera_accessed':False,
                      'requires_native_sender_and_validated_development_channel':True,
                      'commands':[c.public_plan() for c in commands]},indent=2))


if __name__ == '__main__':
    main()
