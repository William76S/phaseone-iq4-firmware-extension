#!/usr/bin/env python3
"""Finite native Locked false/true/false controller contract; no transport.

The adapter boundary is intentionally unimplemented. Tests use a synthetic
adapter only. No SDK, OS shell, device, arbitrary property, PIN or record writer
exists in this module. Callers must use the reviewed original-SDK executor.
"""
from dataclasses import dataclass
import hashlib
import math
import struct
from sys_read_backup_host import ContractError, FragmentAssembler, EEPROM_PATTERN, USER_PATHS, _lex_generated, _require
from os_event_locked_host import USER_SHA256, readonly_plan, validate_locked_reply
from os_event_permissions_host import PERMISSIONS, permission_read_plan, validate_permission_reply

USER_BYTES = 11874544
MAX_TRANSACTIONS = 512
STABLE_ROUNDS = 3
MAX_ROUNDS = 6
MIN_ROUND_GAP = 0.2
MAX_PHASE_SECONDS = 60.0
SET_BODIES = {False: '"OsEvent set Locked 0 -f"', True: '"OsEvent set Locked 1 -f"'}


class HoldUncertain(Exception):
    """No more commands/Stop/Close/retry; sole executor retains original owners."""


class EvidenceMismatch(Exception):
    """Command completed/cleaned; observations failed. Bounded recovery may run."""


class IdentityChanged(Exception):
    pass


class EepromChanged(Exception):
    pass


@dataclass(frozen=True)
class Plan:
    transaction_id: int
    label: str
    host_text: str


@dataclass(frozen=True)
class NativeReply:
    transaction_id: int
    raw_records: bytes
    original_cleanup_verified: bool
    controller_idle_verified: bool


@dataclass(frozen=True)
class Identity:
    pid: int
    start_ticks: int
    path: str
    user_sha256: str
    user_bytes: int
    metadata: tuple


@dataclass(frozen=True)
class Capture:
    """Already validated by finite Sys BackupPass, never PIN-decoded here."""
    path: str
    data: bytes
    metadata_before: tuple
    metadata_after: tuple
    device_digest: str
    exact_eof_verified: bool
    full_read_validated: bool


@dataclass(frozen=True)
class Gate:
    actual_query_pass: bool
    actual_echo_pass: bool
    fixed_sdk_same_owner_verified: bool
    single_executor_lease: bool
    private_originals_owner_dacl_verified: bool
    quiescent_operations_verified: bool


def finite_set_plan(transaction_id, value):
    _require(type(value) is bool and type(transaction_id) is int and transaction_id > 0,
             'finite setter requires canonical bool and transaction id')
    body = SET_BODIES[value]
    first = _lex_generated('IqpDevelRaw ' + body)
    _require(first == ['IqpDevelRaw', body[1:-1]], 'outer setter lexer')
    _require(_lex_generated(first[1]) == ['OsEvent', 'set', 'Locked', '1' if value else '0', '-f'],
             'inner setter lexer')
    _require(len(body.encode('ascii')) < 255, 'finite setter length')
    return Plan(transaction_id, 'original_Locked_bool_set_' + ('1' if value else '0'), body)


def complete_native_text(reply, plan):
    """Use unmodified private LE32-length Common payload records, not a final bool."""
    if not isinstance(reply, NativeReply) or type(reply.transaction_id) is not int or reply.transaction_id != plan.transaction_id:
        raise HoldUncertain()
    if reply.original_cleanup_verified is not True or reply.controller_idle_verified is not True:
        raise HoldUncertain()
    raw = reply.raw_records
    if not isinstance(raw, bytes) or not 0 < len(raw) <= 38880:
        raise HoldUncertain()
    parser, pos = FragmentAssembler(71), 0
    try:
        while pos < len(raw):
            _require(pos + 4 <= len(raw), 'record length truncated')
            size = struct.unpack_from('<I', raw, pos)[0]
            pos += 4
            _require(20 <= size <= 32788 and pos + size <= len(raw), 'record body span')
            frame = raw[pos:pos + size]
            pos += size
            _require(struct.unpack_from('<I', frame)[0] == 2, 'full LE32 raw discriminator')
            parser.accept(0xff, 0x81, frame)
        return parser.result()
    except (ContractError, struct.error):
        raise HoldUncertain() from None


class Workflow:
    """One-use state machine; adapter performs only reviewed finite original calls.

    Required adapter methods: identity(), quiescent(), capture_eeprom(),
    transact(Plan)->NativeReply, monotonic()->float, wait(seconds). The real
    adapter is NOT included. Capture must be an actual full post-action read,
    not a cached original; receipts are evidence records, not attestations.
    """
    def __init__(self, adapter, gate, identity, first, second, baseline_permissions):
        self.adapter, self.gate, self.original_identity = adapter, gate, identity
        self.first, self.second = first, second
        self.baseline_permissions = dict(baseline_permissions)
        self.state = 'NEW'
        self.transactions = 0
        self.write_requests = 0
        self.recovery_used = False
        self.maybe_changed = False
        self.rollback_verified = False
        self.started = False
        self.history = []
        self.full_eeprom_checks = 0

    def _validate_capture(self, cap):
        if not isinstance(cap, Capture) or cap.full_read_validated is not True or cap.exact_eof_verified is not True:
            raise EvidenceMismatch()
        if not isinstance(cap.path, str) or EEPROM_PATTERN.fullmatch(cap.path) is None:
            raise EvidenceMismatch()
        if not isinstance(cap.data, bytes) or not 0 < len(cap.data) <= 2 * 1024 * 1024:
            raise EvidenceMismatch()
        if not isinstance(cap.metadata_before, tuple) or cap.metadata_before != cap.metadata_after:
            raise EvidenceMismatch()
        # Tuple order is the frozen stat parser: size/mode/uid/gid/permissions/mtime/inode.
        m = cap.metadata_before
        if len(m) != 7 or any(type(x) is not int or x < 0 for x in m):
            raise EvidenceMismatch()
        if m[0] != len(cap.data) or m[1] & 0xf000 != 0x8000:
            raise EvidenceMismatch()
        if hashlib.sha256(cap.data).hexdigest() != cap.device_digest:
            raise EvidenceMismatch()

    def _gate(self):
        if not isinstance(self.gate, Gate) or any(x is not True for x in self.gate.__dict__.values()):
            raise EvidenceMismatch()
        i = self.original_identity
        if not isinstance(i, Identity) or type(i.pid) is not int or i.pid <= 0 or type(i.start_ticks) is not int or i.start_ticks <= 0:
            raise IdentityChanged()
        if i.user_sha256 != USER_SHA256 or i.user_bytes != USER_BYTES or i.path not in USER_PATHS:
            raise IdentityChanged()
        if not isinstance(i.metadata, tuple) or len(i.metadata) != 7 or any(type(x) is not int or x < 0 for x in i.metadata):
            raise IdentityChanged()
        if i.metadata[0] != USER_BYTES or i.metadata[1] & 0xf000 != 0x8000:
            raise IdentityChanged()
        if set(self.baseline_permissions) != set(PERMISSIONS) or any(type(x) is not bool for x in self.baseline_permissions.values()):
            raise EvidenceMismatch()
        if self.baseline_permissions['Unlocked'] is not False:
            raise EvidenceMismatch()
        self._validate_capture(self.first)
        self._validate_capture(self.second)
        if self.first != self.second:
            raise EepromChanged()

    def _runtime(self):
        if self.adapter.identity() != self.original_identity or self.adapter.quiescent() is not True:
            raise IdentityChanged()

    def _eeprom(self):
        actual = self.adapter.capture_eeprom()
        self._validate_capture(actual)
        self.full_eeprom_checks += 1
        if actual != self.first:
            raise EepromChanged()

    def _command(self, name=None, value=None):
        self.transactions += 1
        if self.transactions > MAX_TRANSACTIONS:
            raise HoldUncertain()
        if value is not None:
            plan = finite_set_plan(self.transactions, value)
            self.write_requests += 1
            if self.write_requests > 4:
                raise HoldUncertain()
            self.maybe_changed = True
        else:
            p = readonly_plan() if name == 'Locked' else permission_read_plan(name)
            plan = Plan(self.transactions, p['label'], p['host_text'])
        # An adapter exception may include unknown Send or still-running command.
        try:
            reply = self.adapter.transact(plan)
        except Exception:
            raise HoldUncertain() from None
        text = complete_native_text(reply, plan)
        try:
            got = validate_locked_reply(text) if value is not None or name == 'Locked' else validate_permission_reply(name, text)
        except ContractError:
            raise EvidenceMismatch() from None
        if value is not None and got.value is not value:
            raise EvidenceMismatch()
        return got.value

    def _round(self):
        before = self._command(name='Locked')
        permissions = {n: self._command(name=n) for n in PERMISSIONS}
        after = self._command(name='Locked')
        if before is not after:
            return None
        return (before, tuple(permissions[n] for n in PERMISSIONS))

    def _stable(self, expected=None):
        initial = self.adapter.monotonic()
        if type(initial) not in (int, float) or not math.isfinite(initial) or initial < 0:
            raise EvidenceMismatch()
        previous_time, previous, count = initial, None, 0
        for k in range(MAX_ROUNDS):
            if k:
                self.adapter.wait(MIN_ROUND_GAP)
                now = self.adapter.monotonic()
                if type(now) not in (int, float) or not math.isfinite(now) or now < previous_time + MIN_ROUND_GAP or now > initial + MAX_PHASE_SECONDS:
                    raise EvidenceMismatch()
                previous_time = now
            observed = self._round()
            now = self.adapter.monotonic()
            if type(now) not in (int, float) or not math.isfinite(now) or now < previous_time or now > initial + MAX_PHASE_SECONDS:
                raise EvidenceMismatch()
            previous_time = now
            acceptable = observed is not None and (expected is None or observed == expected)
            count = count + 1 if acceptable and observed == previous else (1 if acceptable else 0)
            previous = observed
            if count >= STABLE_ROUNDS:
                return observed
        raise EvidenceMismatch()

    def _target(self, locked):
        values = self.baseline_permissions if locked else {n: True for n in PERMISSIONS}
        return locked, tuple(values[n] for n in PERMISSIONS)

    def _perform(self, value, prior, label):
        self._runtime()
        self._eeprom()
        self._stable(self._target(prior))
        self.history.append(label + '_requested')
        self._command(value=value)
        self._stable(self._target(value))
        self._eeprom()
        self._runtime()
        self.history.append(label + '_verified')

    def _restore_after_complete_failure(self):
        # No retry of an uncertain packet, no false after a failed trial.
        if self.recovery_used:
            raise EvidenceMismatch()
        self.recovery_used = True
        self._runtime()
        self._eeprom()
        state = self._stable()
        if state[0] is False:
            self.history.append('bounded_original_true_recovery_requested')
            self._command(value=True)
            self._stable(self._target(True))
        elif state != self._target(True):
            raise EvidenceMismatch()
        self._eeprom()
        self._runtime()
        self.history.append('original_baseline_recovered_after_failure')
        self.state = 'RESTORED_AFTER_FAILURE'

    def public_result(self):
        return {'schema_version': 1, 'action': 'native_volatile_Locked_roundtrip',
                'state': self.state, 'trial_complete': self.state == 'COMPLETE_TEMPORARY_FALSE',
                'original_true_and_permissions_roundtrip_verified': self.rollback_verified,
                'final_temporary_false_verified': self.state == 'COMPLETE_TEMPORARY_FALSE',
                'original_recovered_after_failed_trial': self.state == 'RESTORED_AFTER_FAILURE',
                'write_requests': self.write_requests, 'native_transactions': self.transactions,
                'actual_full_eeprom_equality_checks': self.full_eeprom_checks,
                'history': list(self.history), 'PIN_read_or_attempted': False,
                'explicit_PIN_Level_counter_record_command_generated': False,
                'whole_EEPROM_equality_at_success': self.state == 'COMPLETE_TEMPORARY_FALSE',
                'vendor_transitive_sideeffects_globally_excluded': False,
                'persistent_repair_verified': False, 'reboot_survival_verified': False,
                'f4_complete': False, 'raw_response_or_credential_hash_exported': False}

    def run(self):
        if self.started:
            raise ContractError('one-use workflow cannot repeat')
        self.started = True
        try:
            self._gate()
            self.state = 'BASELINE_CHECK'
            self._runtime()
            self._eeprom()
            self._stable(self._target(True))
            self._eeprom()
            self._runtime()
            self.state = 'TEMPORARY_CLEAR'
            self._perform(False, True, 'temporary_false')
            self.state = 'ROLLBACK_ORIGINAL'
            self._perform(True, False, 'original_true_rollback')
            self.rollback_verified = True
            self.state = 'FINAL_TEMPORARY_CLEAR'
            self._perform(False, True, 'final_temporary_false')
            self.state = 'COMPLETE_TEMPORARY_FALSE'
        except HoldUncertain:
            self.state = 'HOLD_UNCERTAIN_NATIVE_OWNER'
        except (IdentityChanged, EepromChanged):
            self.state = 'HOLD_IDENTITY_OR_EEPROM_CHANGED'
        except EvidenceMismatch:
            if not self.maybe_changed:
                self.state = 'REJECTED_BEFORE_WRITE'
            else:
                try:
                    self._restore_after_complete_failure()
                except HoldUncertain:
                    self.state = 'HOLD_UNCERTAIN_NATIVE_OWNER'
                except (IdentityChanged, EepromChanged):
                    self.state = 'HOLD_IDENTITY_OR_EEPROM_CHANGED'
                except EvidenceMismatch:
                    self.state = 'HOLD_FAILED_BASELINE_RECOVERY'
        except Exception:
            # Do not disclose vendor exception text or infer cancellation.
            self.state = 'HOLD_UNCLASSIFIED_ADAPTER_FAILURE'
        return self.public_result()
