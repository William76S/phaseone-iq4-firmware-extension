#!/usr/bin/env python3
"""Synthetic failure/rollback tests; no original SDK or camera executes."""
import unittest
from dataclasses import replace
from volatile_lock_roundtrip_host import *
from os_event_locked_host import HEADER, DIVIDER

BASE = dict(zip(PERMISSIONS, [False, False, True, True, False]))
DATA = bytes((n * 7) & 255 for n in range(16384))
META = (len(DATA), 0x81a4, 0, 0, 0o644, 1, 1)
CAPTURE = Capture('/sys/devices/platform/amba/ff030000.i2c/i2c-1/1-0057/eeprom', DATA, META, META, hashlib.sha256(DATA).hexdigest(), True, True)
IDENTITY = Identity(123, 42, '/mnt/qspi/User/p1linux', USER_SHA256, USER_BYTES,
                    (USER_BYTES, 0x81ed, 0, 0, 0o755, 2, 2))
GATE = Gate(True, True, True, True, True, True)


def text(name, value):
    row = f'  {name:<32}    0       {"true" if value else "false":<28} {"b":<16} 1\n'
    return (HEADER + '\n' + DIVIDER + '\n' + row).encode('ascii')


def received_record(payload, flags=3):
    # Synthetic incoming ff/81 application fixture, never a device packet.
    frame = bytearray(20)
    struct.pack_into('<I', frame, 0, 2)
    frame[4:8] = bytes([1, 71, flags, 0])
    struct.pack_into('<I', frame, 8, len(payload))
    struct.pack_into('<H', frame, 12, 20)
    struct.pack_into('<I', frame, 16, 20 + len(payload))
    value = bytes(frame) + payload
    return struct.pack('<I', len(value)) + value


class Fake:
    def __init__(self, fault=None, delay_rounds=0):
        self.locked, self.permissions, self.clock = True, dict(BASE), 0.0
        self.fault, self.delay_rounds = fault, delay_rounds
        self.pending, self.pending_reads = None, 0
        self.commands, self.writes, self.captures = [], [], 0

    def identity(self):
        return replace(IDENTITY, start_ticks=43) if self.fault == 'identity_after_write' and self.writes else IDENTITY

    def quiescent(self):
        return self.fault != 'not_quiescent'

    def capture_eeprom(self):
        self.captures += 1
        if self.fault == 'eeprom_changed' and self.writes:
            data = DATA[:-1] + bytes([DATA[-1] ^ 1])
            return replace(CAPTURE, data=data, device_digest=hashlib.sha256(data).hexdigest())
        if self.fault == 'metadata_changed' and self.writes:
            return replace(CAPTURE, metadata_before=META[:-1] + (9,), metadata_after=META[:-1] + (9,))
        return CAPTURE

    def monotonic(self):
        return float('nan') if self.fault == 'nan_clock' else self.clock

    def wait(self, seconds):
        self.clock += seconds + 0.001

    def transact(self, plan):
        self.commands.append(plan.host_text)
        setting = plan.host_text in SET_BODIES.values()
        if setting:
            value = plan.host_text == SET_BODIES[True]
            self.writes.append(value)
            self.locked = value
            self.pending = dict(BASE) if value else {n: True for n in PERMISSIONS}
            self.pending_reads = self.delay_rounds * 7
            if self.pending_reads == 0:
                self.permissions = self.pending
                self.pending = None
            payload = text('Locked', value)
            if self.fault == 'set_wrong_value' and len(self.writes) == 1:
                payload = text('Locked', not value)
            if self.fault == 'duplicate_set_row' and len(self.writes) == 1:
                payload += text('Locked', value).split(b'\n', 2)[2]
            if self.fault == 'send_exception':
                raise RuntimeError('private vendor exception must never escape')
            if self.fault == 'no_final':
                return NativeReply(plan.transaction_id, received_record(payload, 1), True, True)
            if self.fault == 'cleanup_missing':
                return NativeReply(plan.transaction_id, received_record(payload), False, True)
            if self.fault == 'wrong_transaction':
                return NativeReply(plan.transaction_id + 1, received_record(payload), True, True)
        else:
            name = plan.host_text.split()[2]
            if self.pending is not None:
                self.pending_reads -= 1
                if self.pending_reads <= 0:
                    self.permissions, self.pending = self.pending, None
            value = self.locked if name == 'Locked' else self.permissions[name]
            if self.fault == 'permissions_never_recompute' and self.writes and self.locked is False:
                value = True if name == 'Locked' else BASE[name]
                if name == 'Locked':
                    value = False
            if self.fault == 'rollback_permissions_different' and self.writes and self.locked is True and name == 'UnlockUI':
                value = False
            payload = text(name, value)
            if self.fault == 'prefix_collision_before_write' and not self.writes:
                payload = text(name + 'Other', value)
        return NativeReply(plan.transaction_id, received_record(payload), True, True)


def workflow(adapter=None, **kwargs):
    return Workflow(adapter or Fake(), kwargs.get('gate', GATE), kwargs.get('identity', IDENTITY),
                    kwargs.get('first', CAPTURE), kwargs.get('second', CAPTURE), kwargs.get('permissions', BASE))


class RoundtripTests(unittest.TestCase):
    def test_success_exact_false_true_false_and_complete_eeprom_checks(self):
        fake = Fake()
        result = workflow(fake).run()
        self.assertEqual(result['state'], 'COMPLETE_TEMPORARY_FALSE')
        self.assertEqual(fake.writes, [False, True, False])
        self.assertTrue(result['original_true_and_permissions_roundtrip_verified'])
        self.assertTrue(result['whole_EEPROM_equality_at_success'])
        self.assertGreaterEqual(fake.captures, 8)
        self.assertEqual({c for c in fake.commands if ' set ' in c}, set(SET_BODIES.values()))

    def test_delayed_observers_require_three_consecutive_target_rounds(self):
        fake = Fake(delay_rounds=2)
        result = workflow(fake).run()
        self.assertEqual(result['state'], 'COMPLETE_TEMPORARY_FALSE')
        self.assertGreater(result['native_transactions'], workflow(Fake()).run()['native_transactions'])

    def test_each_gate_false_rejects_before_any_write(self):
        for name in GATE.__dict__:
            fake = Fake()
            self.assertEqual(workflow(fake, gate=replace(GATE, **{name: False})).run()['state'], 'REJECTED_BEFORE_WRITE')
            self.assertEqual(fake.writes, [])

    def test_wrong_runtime_hash_or_start_identity_never_writes(self):
        for ident in [replace(IDENTITY, user_sha256='0' * 64), replace(IDENTITY, start_ticks=43)]:
            fake = Fake()
            self.assertEqual(workflow(fake, identity=ident).run()['state'], 'HOLD_IDENTITY_OR_EEPROM_CHANGED')
            self.assertEqual(fake.writes, [])

    def test_double_original_mismatch_and_unvalidated_eof_rejected(self):
        fake = Fake()
        self.assertEqual(workflow(fake, second=replace(CAPTURE, exact_eof_verified=False)).run()['state'], 'REJECTED_BEFORE_WRITE')
        self.assertEqual(fake.writes, [])
        fake = Fake()
        other = DATA[:-1] + b'\0'
        changed = replace(CAPTURE, data=other, device_digest=hashlib.sha256(other).hexdigest())
        self.assertEqual(workflow(fake, second=changed).run()['state'], 'HOLD_IDENTITY_OR_EEPROM_CHANGED')

    def test_prefix_collision_or_nan_clock_before_write_rejected(self):
        for fault in ['prefix_collision_before_write', 'nan_clock']:
            fake = Fake(fault)
            self.assertEqual(workflow(fake).run()['state'], 'REJECTED_BEFORE_WRITE')
            self.assertEqual(fake.writes, [])

    def test_unknown_send_final_or_cleanup_holds_without_rollback_retry(self):
        for fault in ['send_exception', 'no_final', 'cleanup_missing', 'wrong_transaction']:
            fake = Fake(fault)
            result = workflow(fake).run()
            self.assertEqual(result['state'], 'HOLD_UNCERTAIN_NATIVE_OWNER')
            self.assertEqual(fake.writes, [False])
            self.assertFalse(result['final_temporary_false_verified'])
            self.assertNotIn('private vendor', str(result))

    def test_complete_wrong_echo_or_duplicate_row_recovery_once_then_no_false(self):
        for fault in ['set_wrong_value', 'duplicate_set_row']:
            fake = Fake(fault)
            result = workflow(fake).run()
            self.assertEqual(result['state'], 'RESTORED_AFTER_FAILURE')
            self.assertEqual(fake.writes, [False, True])
            self.assertFalse(result['trial_complete'])

    def test_permissions_fail_recompute_restore_true_only(self):
        fake = Fake('permissions_never_recompute')
        result = workflow(fake).run()
        self.assertEqual(result['state'], 'RESTORED_AFTER_FAILURE')
        self.assertEqual(fake.writes, [False, True])

    def test_rollback_permissions_must_exactly_equal_original(self):
        fake = Fake('rollback_permissions_different')
        result = workflow(fake).run()
        self.assertEqual(result['state'], 'HOLD_FAILED_BASELINE_RECOVERY')
        self.assertEqual(fake.writes, [False, True])
        self.assertFalse(result['original_true_and_permissions_roundtrip_verified'])

    def test_eeprom_metadata_or_user_change_after_write_blocks_other_writes(self):
        for fault in ['eeprom_changed', 'metadata_changed', 'identity_after_write']:
            fake = Fake(fault)
            result = workflow(fake).run()
            self.assertEqual(result['state'], 'HOLD_IDENTITY_OR_EEPROM_CHANGED')
            self.assertEqual(fake.writes, [False])

    def test_unquiescent_session_or_baseline_permissions_mismatch_no_write(self):
        for fake, perm in [(Fake('not_quiescent'), BASE), (Fake(), {n: False for n in PERMISSIONS})]:
            result = workflow(fake, permissions=perm).run()
            self.assertIn(result['state'], ['HOLD_IDENTITY_OR_EEPROM_CHANGED', 'REJECTED_BEFORE_WRITE'])
            self.assertEqual(fake.writes, [])

    def test_one_use_cannot_repeat_completed_or_failed_workflow(self):
        for fake in [Fake(), Fake('prefix_collision_before_write')]:
            w = workflow(fake)
            w.run()
            before = list(fake.commands)
            with self.assertRaises(ContractError):
                w.run()
            self.assertEqual(fake.commands, before)

    def test_no_general_setter_names_values_or_text_substitution(self):
        for bad in [0, 1, '0', 'false', None, 'PinCode']:
            with self.assertRaises(ContractError):
                finite_set_plan(1, bad)
        for val in [False, True]:
            self.assertEqual(finite_set_plan(1, val).host_text, SET_BODIES[val])

    def test_full_le32_front_guard_and_missing_final_not_text_success(self):
        plan = finite_set_plan(1, False)
        raw = bytearray(received_record(text('Locked', False)))
        raw[5] = 1
        with self.assertRaises(HoldUncertain):
            complete_native_text(NativeReply(1, bytes(raw), True, True), plan)
        with self.assertRaises(HoldUncertain):
            complete_native_text(NativeReply(1, received_record(text('Locked', False), 1), True, True), plan)


if __name__ == '__main__':
    unittest.main()
