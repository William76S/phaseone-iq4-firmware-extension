#!/usr/bin/env python3
"""Finite original-window predicate tests; does not execute target payloads."""
from pathlib import Path
import importlib.util,json,re
HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('ui03_lineage',HERE/'materialize.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
def main():
 facts=m.validate();stock=(m.ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();baseline=m.code_windows(stock);checks=[]
 for va,word in m.WORDS:
  b=bytearray(stock);b[va-0x400000]^=0xff
  assert m.code_windows(b)==baseline;checks.append({'name':'exact_csu_patch_word_excluded','va':va,'passed':True})
 for va in (0x9ef0b8,0x9ef0c4,0x9ef0d0):
  b=bytearray(stock);b[va-0x400000]^=0xff
  assert m.code_windows(b)!=baseline;checks.append({'name':'surrounding_word_still_hashed','va':va,'passed':True})
 old=[(int(v),int(n),h)for v,n,h in re.findall(r'\{(\d+)ULL,(\d+)ULL,"([0-9a-f]{64})"\}',(m.ROOT/'tools/firmware/f1_user_ui_entry_02/stock_windows.hpp').read_text())]
 assert len(baseline)==7 and sum(x[1]for x in baseline)==sum(x[1]for x in old)-16
 checks.append({'name':'exact_lineage_and_seven_original_windows','passed':True})
 result={'schema':1,'tests':len(checks),'passed':True,'checks':checks,'CSU_old_words_verified':facts['CSU_original_words'],'target_executed':False,'SDK_Windows_network_device_operations':0}
 print(json.dumps(result,indent=2))
if __name__=='__main__':main()
