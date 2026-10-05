#!/usr/bin/env python3
"""Finite host-only native permission read plan; no transport or event writes.

The five names bind the exact package's PinGroup bool constructors. This module
cannot request arbitrary events, dump a directory, or access any PIN/code value.
"""
from dataclasses import dataclass, asdict
import re
from os_event_locked_host import USER_SHA256, HEADER, DIVIDER, MAX_REPLY
from sys_read_backup_host import ContractError, _require, _lex_generated

PERMISSIONS = ('Unlocked', 'UnlockFirmwareUpdate', 'UnlockUI', 'UnlockCapture',
               'UnlockRestoreToDefault')
GROUP_OFFSETS = {'Unlocked':0x768, 'UnlockFirmwareUpdate':0x840, 'UnlockUI':0x918,
                 'UnlockCapture':0x9f0, 'UnlockRestoreToDefault':0xac8}


@dataclass(frozen=True)
class PermissionObservation:
    name: str
    value: bool
    type_name: str
    log_enabled: int
    notification_flag: str
    waiting_threads: int
    exact_name_rows: int = 1
    evidence_level: str = 'received_text_only'


def permission_read_plan(name):
    _require(isinstance(name,str) and name in PERMISSIONS, 'name outside finite permission whitelist')
    inner = 'OsEvent list ' + name + ' -f'
    body = '"' + inner + '"'
    first = _lex_generated('IqpDevelRaw ' + body)
    _require(first == ['IqpDevelRaw', inner], 'outer parser mismatch')
    _require(_lex_generated(first[1]) == ['OsEvent','list',name,'-f'], 'inner parser mismatch')
    return {'label':'native_permission_read_' + name, 'name':name, 'host_text':body,
            'outer_tokens':2, 'inner_tokens':4, 'PinGroup_bool_offset':hex(GROUP_OFFSETS[name]),
            'query_filter_is_prefix':True, 'must_receive_exactly_one_expected_bool_row':True,
            'bound_User_sha256':USER_SHA256, 'requires_verified_runtime_identity':True,
            'requires_verified_native_channel_support':True, 'transport_not_included':True,
            'write_plan_not_included':True}


def permission_read_plans():
    return [permission_read_plan(name) for name in PERMISSIONS]


def validate_permission_reply(name,reply):
    permission_read_plan(name)  # Reject arbitrary or credential names first.
    _require(isinstance(reply,bytes) and 0 < len(reply) <= MAX_REPLY, 'invalid reply span')
    _require(b'\0' not in reply and b'\r' not in reply, 'NUL or unsupported line ending')
    try:
        text = reply.decode('ascii')
    except UnicodeDecodeError as exc:
        raise ContractError('non-ASCII reply') from exc
    _require(text.endswith('\n'), 'partial final row')
    lines = text.splitlines()
    _require(len(lines)==3 and lines[:2]==[HEADER,DIVIDER], 'extra row, prefix collision or unknown output')
    match = re.fullmatch(r'  ('+re.escape(name)+r') +([01]) +([ 01H]) +(true|false) +(b) +([0-9]{1,8})',lines[2])
    _require(match is not None, 'not the exact expected canonical bool permission row')
    got,log,notify,value,typ,wait=match.groups()
    return PermissionObservation(got,value=='true',typ,int(log),notify,int(wait))


def permission_snapshot(observations):
    _require(isinstance(observations,(list,tuple)) and len(observations)==len(PERMISSIONS),
             'one observation for each of five names required')
    _require(all(isinstance(o,PermissionObservation) and o.name in PERMISSIONS and
                 isinstance(o.value,bool) and o.type_name=='b' and o.exact_name_rows==1
                 for o in observations), 'invalid typed permission observations')
    _require(len({o.name for o in observations})==len(PERMISSIONS), 'duplicate or missing permission')
    return {name:next(o.value for o in observations if o.name==name) for name in PERMISSIONS}


def stable_permission_snapshot(first,second):
    a,b=permission_snapshot(first),permission_snapshot(second)
    _require(a==b, 'permissions changed between two sequential read passes')
    return a


def all_unlocked_permissions(snapshot):
    _require(isinstance(snapshot,dict) and set(snapshot)==set(PERMISSIONS) and
             all(isinstance(v,bool) for v in snapshot.values()), 'invalid permission snapshot')
    return all(snapshot.values())


def public_permission_observation(observation):
    _require(isinstance(observation,PermissionObservation), 'typed permission observation required')
    return asdict(observation)
