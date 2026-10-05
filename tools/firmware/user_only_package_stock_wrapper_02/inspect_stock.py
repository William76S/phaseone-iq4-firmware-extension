#!/usr/bin/env python3
"""Hash-bound stock FWP and ELF metadata; does not run firmware/vendor code."""
import argparse,json,struct,zipfile
from pathlib import Path
import package as q

def elf_metadata(raw):
 p=q.module()
 if p.sha(raw)!=p.USER_SHA or len(raw)!=p.USER_SIZE:raise ValueError('original User identity')
 h=struct.unpack_from('<HHIQQQIHHHHHH',raw,16);ph=h[4];n=h[9];programs=[]
 for i in range(n):
  t,flags,off,va,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',raw,ph+56*i);programs.append(dict(index=i,type=t,flags=flags,file_offset=off,va=va,file_size=fs,memory_size=ms,alignment=align))
 dyn=next(r for r in programs if r['type']==2);tags={}
 for i in range(0,dyn['file_size'],16):
  key,val=struct.unpack_from('<QQ',raw,dyn['file_offset']+i)
  if key==0:break
  tags.setdefault(key,[]).append(val)
 def off(va):
  spans=[r['file_offset']+va-r['va']for r in programs if r['type']==1 and r['va']<=va<r['va']+r['file_size']]
  if len(spans)!=1:raise ValueError('VA mapping')
  return spans[0]
 strva=tags[5][0];symva=tags[6][0];syment=tags[11][0];relva=tags[23][0];relsz=tags[2][0];vs=tags[0x6ffffff0][0];symbols=[]
 for pos in range(off(relva),off(relva)+relsz,24):
  target,info,addend=struct.unpack_from('<QQq',raw,pos);si=info>>32;name,flags,other,section,value,size=struct.unpack_from('<IBBHQQ',raw,off(symva)+si*syment);st=off(strva)+name;end=raw.index(0,st);text=raw[st:end].decode('ascii')
  if text in ('pthread_mutex_unlock','pthread_mutex_lock'):
   symbols.append(dict(name=text,dynsym_index=si,st_info=flags,weak_binding=flags>>4==2,section_index=section,value=value,size=size,version_index=struct.unpack_from('<H',raw,off(vs)+si*2)[0],relocation_type=info&0xffffffff,relocation_va=target,relocation_file_offset=pos,addend=addend))
 interp=next(r for r in programs if r['type']==3)
 return dict(original_user_sha256=p.USER_SHA,original_user_bytes=len(raw),entry_va=h[3],program_header_file_offset=ph,program_header_count=n,program_header_entry_bytes=56,program_header_end=ph+56*n,interpreter_file_offset=interp['file_offset'],spare_contiguous_program_header_bytes_before_interp=interp['file_offset']-(ph+56*n),programs=programs,DT_INIT=tags[12][0],DT_FINI=tags[13][0],DT_INIT_ARRAY=tags[25][0],DT_INIT_ARRAYSZ=tags[27][0],original_init_array_entries=tags[27][0]//8,DT_FINI_ARRAY=tags[26][0],DT_FINI_ARRAYSZ=tags[28][0],pthread_symbols=symbols,original_code_or_ELF_executed=False)

def main():
 a=argparse.ArgumentParser(description=__doc__);a.add_argument('--original-fwp',type=Path,default=q.DEFAULT_FWP);a.add_argument('--output-directory',type=Path,required=True);x=a.parse_args();outer,inner=q.load_stock_fwp(x.original_fwp);p=q.module();stock,_,_=p.load_stock(p.DEFAULT_FWR)
 if inner!=p.DEFAULT_FWR.read_bytes():raise ValueError('given original and official FWP inner differ')
 x.output_directory.mkdir(parents=True)
 with zipfile.ZipFile(x.original_fwp)as z:
  rows=[]
  for i in z.infolist():rows.append(dict(name=i.filename,bytes=i.file_size,compressed_bytes=i.compress_size,sha256=q.sha(z.read(i)),CRC32=f'{i.CRC:08x}',method=i.compress_type,flags=i.flag_bits,local_header_offset=i.header_offset))
  xml=z.read('manifest.xml')
 (x.output_directory/'stock_manifest.xml').write_bytes(xml)
 result=dict(schema='iq4_stock_fwp_offline_inspection_v1',original_fwp_bytes=q.FWP_SIZE,original_fwp_sha256=q.FWP_SHA,original_outer_manifest_sha256=q.XML_SHA,all_ZIP4_CRCs_checked=True,inner_fwr_byte_identical=True,members=rows,outer_root_attributes=outer.attrib,back_attributes=outer[0].attrib,User_ELF=elf_metadata(stock),camera_access=False,vendor_or_target_execution=False,modified_package_acceptance_or_recovery_verified=False)
 (x.output_directory/'INSPECTION.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(dict(file_inspection_passed=True,output_directory=str(x.output_directory),camera_access=False,vendor_or_target_execution=False)))
if __name__=='__main__':main()
