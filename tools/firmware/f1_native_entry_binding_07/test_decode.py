#!/usr/bin/env python3
import struct,json
from decode_entry import decode
def main():
 v=[7,96,3,0,0,0,2,1,0,1,0,0,0,1,1,1,1,1];b=struct.pack('<II6I6Q6I',2,104,*v);assert len(b)==104;decode(b,b);checks=1
 cases=[(0,1),(4,103),(8,6),(12,95),(16,9),(20,1),(24,1),(28,1),(80,5),(84,0),(88,0),(92,0),(100,2)]
 for off,value in cases:
  bad=bytearray(b);struct.pack_into('<I',bad,off,value)
  try:decode(bytes(bad),bytes(bad))
  except ValueError:checks+=1
  else:raise AssertionError('Accepted bad field at '+str(off))
 try:decode(b,b[:-1])
 except ValueError:checks+=1
 else:raise AssertionError('Partial copy accepted')
 print(json.dumps({'checks':checks,'passed':True,'target_or_vendor_executed':False}))
if __name__=='__main__':main()
