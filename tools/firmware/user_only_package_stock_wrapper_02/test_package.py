"""Only in-memory host container fixtures; no candidate saved or executed."""
import io,struct,unittest,xml.etree.ElementTree as ET,zipfile
import package as q
class Tests(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.p=q.module();cls.outer,cls.inner=q.load_stock_fwp(q.DEFAULT_FWP);cls.stock,_,cls.attrs=cls.p.load_stock(cls.p.DEFAULT_FWR)
 def make(self,version_only=False,system=(8,2,1)):
  b=bytearray(self.stock);off=self.p.elf_layout(b)['image_header_offset'];struct.pack_into('<BBH',b,off+16,6,3,22)
  if not version_only:b.extend(b'HOST_ONLY_UNLOADED_FIXTURE')
  return q.build(self.stock,bytes(b),q.sha(b),self.attrs,self.outer,(6,3,19),(6,3,22),system)
 def test_actual_same_inner(self):self.assertEqual(self.inner,self.p.DEFAULT_FWR.read_bytes())
 def test_stock_shapes(self):
  self.assertEqual(self.outer.attrib,q.ROOT_ATTRS);self.assertEqual(self.outer[0].attrib,q.BACK_ATTRS);self.assertNotIn('minimum_update_version',self.outer.attrib)
 def test_deterministic_new_actual_schema(self):
  a,fwr,fwp=self.make();self.assertEqual((a,fwr,fwp),self.make());self.assertTrue(a['offline_candidate_generation_scope_passed']);self.assertFalse(a['device_acceptance_observed']);self.assertFalse(a['f1_feature_implementation_or_acceptance_proven']);self.assertFalse(a['fwp_outer_schema_reconstructed_from_static_consumer_not_stock_sample'])
  with zipfile.ZipFile(io.BytesIO(fwp))as z:
   self.assertEqual(z.namelist(),['manifest.xml',q.INNER]);self.assertEqual(z.read(q.INNER),fwr);self.assertIsNone(z.testzip());root=ET.fromstring(z.read('manifest.xml'));self.assertEqual(root.attrib,dict(q.ROOT_ATTRS,version='8.02.1'));self.assertEqual(len(root),1);self.assertEqual(root[0].attrib,dict(q.BACK_ATTRS,version='6.03.19'));self.assertEqual(root[0].text,q.INNER)
 def test_version_only_not_emittable(self):
  plan,_,_=self.make(True);self.assertTrue(plan['payload_changes_limited_to_image_header_version']);self.assertFalse(plan['offline_candidate_generation_scope_passed'])
 def test_same_system_not_emittable(self):self.assertFalse(self.make(system=(8,2,0))[0]['offline_candidate_generation_scope_passed'])
 def test_stock_selector_mutation_rejected(self):
  xml=ET.fromstring(ET.tostring(self.outer));xml[0].set('model_ids','0x125')
  with self.assertRaises(ValueError):q.build(self.stock,self.stock,self.p.USER_SHA,self.attrs,xml,self.p.RELEASE,self.p.APP,q.STOCK_SYSTEM)
 def test_app_header_mismatch(self):
  with self.assertRaises(ValueError):q.build(self.stock,self.stock,self.p.USER_SHA,self.attrs,self.outer,(6,3,19),(6,3,22),(8,2,1))
 def test_same_payload_plan_not_feature(self):
  plan,_,_=q.build(self.stock,self.stock,self.p.USER_SHA,self.attrs,self.outer,self.p.RELEASE,self.p.APP,q.STOCK_SYSTEM);self.assertFalse(plan['offline_candidate_generation_scope_passed']);self.assertFalse(plan['device_recovery_verified']);self.assertFalse(plan['f1_feature_implementation_or_acceptance_proven'])
if __name__=='__main__':unittest.main()
