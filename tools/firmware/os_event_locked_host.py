#!/usr/bin/env python3
"""Finite host-only OsEvent Locked query plan and reply validator.

No SDK, transport, shell, device or write API. This does not prove the current
camera supports a command. It intentionally cannot construct an event setter,
an arbitrary name query, or a PinCode/PIN/credential reader.
"""
from dataclasses import dataclass, asdict
import re
from sys_read_backup_host import ContractError, _require, _lex_generated

USER_SHA256 = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
READ_BODY = '"OsEvent list Locked -f"'
HEADER = '  Name                               Log Notify Value                        Type           Waiting Threads'
DIVIDER = '------------------------------------+---+------+----------------------------+--------------+----------------------'
MAX_REPLY = 4096


@dataclass(frozen=True)
class LockedObservation:
    name: str
    value: bool
    type_name: str
    log_enabled: int
    notification_flag: str
    waiting_threads: int
    exact_name_rows: int = 1
    evidence_level: str = 'received_text_only'


def readonly_plan():
    # This command is parsed directly by OsCommands. It never passes Sys's
    # destructive join. The complete quoted body protects the second lexer.
    first = _lex_generated('IqpDevelRaw ' + READ_BODY)
    _require(first == ['IqpDevelRaw', 'OsEvent list Locked -f'], 'outer parser mismatch')
    second = _lex_generated(first[1])
    _require(second == ['OsEvent', 'list', 'Locked', '-f'], 'inner parser mismatch')
    return {'label': 'only_locked_prefix_read', 'host_text': READ_BODY,
            'outer_tokens': 2, 'inner_tokens': 4,
            'query_filter_is_prefix': True,
            'must_receive_exactly_one_bool_Locked_row': True,
            'bound_User_sha256': USER_SHA256,
            'requires_runtime_identity_and_native_channel_support': True,
            'transport_not_included': True, 'write_plan_not_included': True}


def validate_locked_reply(reply):
    """Validate only already assembled finite native output, including completion.

    A caller must first establish final-fragment/correlation/sequence/span with
    the separate FragmentAssembler. This function cannot prove completion by
    itself. Unknown output is rejected rather than silently stripped.
    """
    _require(isinstance(reply, bytes) and 0 < len(reply) <= MAX_REPLY, 'invalid reply span')
    _require(b'\0' not in reply and b'\r' not in reply, 'NUL or unsupported line ending')
    try:
        text = reply.decode('ascii')
    except UnicodeDecodeError as exc:
        raise ContractError('non-ASCII reply') from exc
    _require(text.endswith('\n'), 'partial final row')
    lines = text.splitlines()
    _require(len(lines) == 3 and lines[:2] == [HEADER, DIVIDER],
             'unexpected header, additional row, prefix match or extra output')
    # The original formatter uses fixed minimum field widths, not CSV.
    # Loaded _ZTIb is expected to name bool as b; do not accept another type.
    match = re.fullmatch(r'  (Locked) +([01]) +([ 01H]) +(true|false) +(b) +([0-9]{1,8})', lines[2])
    _require(match is not None, 'not an exact canonical bool Locked row')
    name, log, notify, value, typ, wait = match.groups()
    return LockedObservation(name, value == 'true', typ, int(log), notify, int(wait))


def public_observation(observation):
    _require(isinstance(observation, LockedObservation), 'observation required')
    return asdict(observation)
