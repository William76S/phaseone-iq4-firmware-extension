#!/usr/bin/env python3
"""Own stdlib-only closure/privacy failures; no compiler, vendor or SDK call."""
import json, tempfile, unittest
from pathlib import Path
import bundle
from replay_objects import compiler_commands

class Tests(unittest.TestCase):
 def setUp(self):self.temp=tempfile.TemporaryDirectory();self.root=Path(self.temp.name)
 def tearDown(self):self.temp.cleanup()
 def put(self,n,b=b'x\n'):
  p=self.root/n;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);return p
 def test_dep_continuation_spaces(self):
  self.assertEqual(bundle.make_dependencies('target.o: a.cpp \\\n b\\ space.hpp ../c.h\n'),['a.cpp','b space.hpp','../c.h'])
 def test_dep_no_colon(self):
  with self.assertRaises(bundle.Refused):bundle.make_dependencies('a.o a.c')
 def test_outside_dep(self):
  with self.assertRaises(bundle.Refused):bundle.normalize_dep(self.root,'../outside.h')
 def test_local_include_recursive(self):
  self.put('a.c',b'#include "sub/b.h"\n');self.put('sub/b.h',b'#include "../c.h"\n');self.put('c.h')
  self.assertEqual(bundle.quoted_closure(self.root,{'a.c'}),{'a.c','sub/b.h','c.h'})
 def test_missing_include(self):
  self.put('a.c',b'#include "missing.h"\n')
  with self.assertRaises(bundle.Refused):bundle.quoted_closure(self.root,{'a.c'})
 def test_binary_disguised_source(self):
  self.put('a.h',b'\x7fELF'+bytes(20))
  with self.assertRaises(bundle.Refused):bundle.source_bytes(self.root,'a.h')
 def test_vendor_suffix_rejected(self):
  self.put('User.bin')
  with self.assertRaises(bundle.Refused):bundle.source_bytes(self.root,'User.bin')
 def test_symlink_rejected(self):
  self.put('a.h');(self.root/'b.h').symlink_to(self.root/'a.h')
  with self.assertRaises(bundle.Refused):bundle.source_bytes(self.root,'b.h')
 def test_changed_source_refused(self):
  self.put('a.h');j={'schema':bundle.SCHEMA,'members':[bundle.record(self.root,'a.h')]};self.put('a.h',b'changed\n')
  with self.assertRaises(bundle.Refused):bundle.verify_members(self.root,j)
 def test_unfrozen_final_refused(self):
  with self.assertRaises(bundle.Refused):bundle.emit(self.root,{'UI_revision':'03','UI_source_frozen':False},self.root/'out.zip',None,None,None)
 def test_wrong_display_source_identity_refused(self):
  j={'UI_revision':'03','UI_source_frozen':True,'backend_source_frozen':True,'UI_source_manifest_sha256':'a'*64,'display_source_manifest_sha256':'b'*64,'backend_source_set_sha256':'c'*64}
  with self.assertRaises(bundle.Refused):bundle.emit(self.root,j,self.root/'out.zip','a'*64,'d'*64,'c'*64)
  self.assertFalse((self.root/'out.zip').exists())
 def test_compile_records_never_tests(self):
  for n,count in [('analysis/firmware/f1_user_ui_entry_03/OBJECTS_AND_BINDINGS.json',9),('analysis/firmware/f1_stock_display_payload_build_13/BUILD.json',2)]:
   cmds=[]
   for i in range(count):cmds.append(['/tmp/zig','cc','-c',str(self.root/f'{count}_{i}.c'),'-o',str(self.root/f'{count}_{i}.o')])
   cmds.append(['/usr/bin/clang','-c',str(self.root/'host.c'),'-o',str(self.root/'host.exe')])
   self.put(n,json.dumps({'commands':cmds}).encode())
  _,rows=bundle.compile_records(self.root,'03');self.assertEqual(len(rows),11);self.assertTrue(all(r['output'].endswith('.o')for r in rows))
 def test_replay_refuses_existing_objects(self):
  self.put('a.c');self.put('a.o')
  j={'original_project_root':'/old','compiler_records':[{'source':'a.c','output':'a.o','original_argv':['/old/zig','cc','-c','/old/a.c','-o','/old/a.o']}]*11}
  with self.assertRaises(bundle.Refused):compiler_commands(j,self.root,self.root/'zig')
if __name__=='__main__':
 result=unittest.TextTestRunner(verbosity=2).run(unittest.defaultTestLoader.loadTestsFromTestCase(Tests))
 print(json.dumps({'own_host_tests':result.testsRun,'passed':result.wasSuccessful(),'compiler_executed':False,'target_or_SDK_executed':False}))
 raise SystemExit(0 if result.wasSuccessful()else 1)
