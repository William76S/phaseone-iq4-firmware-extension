#!/usr/bin/env python3
"""Synthetic formatter/rejection tests. No target code or transport executes."""
import unittest
from os_event_locked_host import *


def row(name='Locked', value='true', typ='b', log=0, notify=' ', wait=1):
    return f'  {name:<32}    {log}     {notify}   {value:<28} {typ:<16} {wait}\n'


def output(**kwargs):
    return (HEADER + '\n' + DIVIDER + '\n' + row(**kwargs)).encode()


class LockedHostTests(unittest.TestCase):
    def test_finite_readonly_plan(self):
        p = readonly_plan()
        self.assertEqual(p['host_text'], '"OsEvent list Locked -f"')
        self.assertTrue(p['query_filter_is_prefix'])
        self.assertTrue(p['write_plan_not_included'])

    def test_typed_true_false_and_notification_flags(self):
        for notify in [' ', '0', '1', 'H']:
            for val in ['true', 'false']:
                got = validate_locked_reply(output(value=val, notify=notify, log=1, wait=3))
                self.assertEqual(got.value, val == 'true')
                self.assertEqual(got.notification_flag, notify)

    def test_prefix_collision_duplicate_and_extra_rows_rejected(self):
        for data in [output(name='LockedOther'), output()+row().encode(),
                     output()+row(name='PinCode').encode(), output()+b'error\n']:
            with self.assertRaises(ContractError): validate_locked_reply(data)

    def test_missing_or_wrong_header_rejected(self):
        for data in [row().encode(), output().replace(b'Notify', b'Other!'), output()[1:]]:
            with self.assertRaises(ContractError): validate_locked_reply(data)

    def test_wrong_type_noncanonical_value_and_name_rejected(self):
        for data in [output(typ='j'), output(typ='bool'), output(value='1'),
                     output(value='TRUE'), output(name='locked'), output(log=2)]:
            with self.assertRaises(ContractError): validate_locked_reply(data)

    def test_partial_binary_nonascii_and_oversize_rejected(self):
        for data in [output()[:-1], b'', output()+b'\0', output()+b'\xff',
                     output().replace(b'\n', b'\r\n'), b' '*4097]:
            with self.assertRaises(ContractError): validate_locked_reply(data)

    def test_observation_carries_only_locked_state(self):
        p = public_observation(validate_locked_reply(output()))
        self.assertEqual(set(p), {'name','value','type_name','log_enabled','notification_flag',
                                 'waiting_threads','exact_name_rows','evidence_level'})


if __name__ == '__main__': unittest.main()
