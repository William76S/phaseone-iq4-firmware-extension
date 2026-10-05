#!/usr/bin/env python3
"""Synthetic finite native bool output and snapshot integrity tests."""
import unittest
from os_event_permissions_host import *


def reply(name,value='true',typ='b',notify=' ',log=0,wait=1):
    row=f'  {name:<32}    {log}     {notify}   {value:<28} {typ:<16} {wait}\n'
    return (HEADER+'\n'+DIVIDER+'\n'+row).encode()


def observations(value='true'):
    return [validate_permission_reply(n,reply(n,value)) for n in PERMISSIONS]


class PermissionHostTests(unittest.TestCase):
    def test_exact_five_readonly_plans_and_lexer(self):
        p=permission_read_plans()
        self.assertEqual([x['name'] for x in p],list(PERMISSIONS))
        for x in p:
            self.assertEqual(x['host_text'],'"OsEvent list '+x['name']+' -f"')
            self.assertTrue(x['query_filter_is_prefix'])
            self.assertTrue(x['write_plan_not_included'])

    def test_forbidden_arbitrary_PIN_and_dump_names(self):
        for name in ['Locked','PinCode','SetPinCode','EncodedPinCode','PinCodeFails','all','',
                     'UnlockUI;foo','UnlockUI -ns',None]:
            with self.assertRaises(ContractError): permission_read_plan(name)
            with self.assertRaises(ContractError): validate_permission_reply(name,b'')

    def test_all_canonical_bool_values_and_notify_flags(self):
        for name in PERMISSIONS:
            for value in ['true','false']:
                for notify in [' ','0','1','H']:
                    got=validate_permission_reply(name,reply(name,value,notify=notify,log=1,wait=7))
                    self.assertEqual(got.name,name)
                    self.assertEqual(got.value,value=='true')
                    self.assertEqual(got.notification_flag,notify)

    def test_prefix_collision_or_another_whitelisted_name_rejected(self):
        for name in PERMISSIONS:
            for wrong in [name+'Other',name.lower(),'PinCode']:
                with self.assertRaises(ContractError): validate_permission_reply(name,reply(wrong))
        with self.assertRaises(ContractError):validate_permission_reply('UnlockUI',reply('Unlocked'))

    def test_duplicate_extra_and_missing_output_rejected(self):
        good=reply('UnlockUI')
        for data in [good+good,good+b'error\n',good.split(b'\n',2)[-1],b'']:
            with self.assertRaises(ContractError):validate_permission_reply('UnlockUI',data)

    def test_wrong_type_and_noncanonical_value_rejected(self):
        for data in [reply('UnlockUI',typ='j'),reply('UnlockUI',typ='bool'),
                     reply('UnlockUI',value='1'),reply('UnlockUI',value='TRUE'),
                     reply('UnlockUI',log=2)]:
            with self.assertRaises(ContractError):validate_permission_reply('UnlockUI',data)

    def test_partial_nonascii_NUL_CR_and_oversized_rejected(self):
        good=reply('UnlockUI')
        for data in [good[:-1],good+b'\0',good+b'\xff',good.replace(b'\n',b'\r\n'),b' '*4097]:
            with self.assertRaises(ContractError):validate_permission_reply('UnlockUI',data)

    def test_snapshot_exact_coverage_and_order_independence(self):
        got=observations()
        self.assertEqual(permission_snapshot(got),{n:True for n in PERMISSIONS})
        self.assertEqual(permission_snapshot(got[::-1]),permission_snapshot(got))
        for bad in [got[:-1],got+got[:1],got[:-1]+got[:1],['bad']*5]:
            with self.assertRaises(ContractError):permission_snapshot(bad)

    def test_two_pass_change_rejected_and_stability_only(self):
        self.assertEqual(stable_permission_snapshot(observations(),observations()),{n:True for n in PERMISSIONS})
        with self.assertRaises(ContractError):stable_permission_snapshot(observations(),observations('false'))
        self.assertFalse(all_unlocked_permissions(permission_snapshot(observations('false'))))
        self.assertTrue(all_unlocked_permissions(permission_snapshot(observations())))
        for bad in [{},{n:1 for n in PERMISSIONS},{'UnlockUI':True}]:
            with self.assertRaises(ContractError):all_unlocked_permissions(bad)

    def test_public_state_has_no_credential_fields(self):
        got=public_permission_observation(observations()[0])
        self.assertEqual(set(got),{'name','value','type_name','log_enabled','notification_flag',
                                  'waiting_threads','exact_name_rows','evidence_level'})


if __name__=='__main__':unittest.main()
