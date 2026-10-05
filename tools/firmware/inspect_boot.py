#!/usr/bin/env python3
"""Hash-bound static Boot inspection. Extract selected regular files, never mount or execute."""
import argparse,hashlib,json,math,stat,struct,zlib
from pathlib import Path
EXPECTED='7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e'
UIMAGE_OFFSET=0xddc0c0
SQUASH_OFFSET=0x1d441c0
def device_tree(data,offset):
 magic,size,structoff,stroff,*_=struct.unpack_from('>10I',data,offset)
 if magic!=0xd00dfeed:raise ValueError('Invalid FDT magic')
 d=data[offset:offset+size]; st=structoff; names=[]; properties=[]
 while st<len(d):
  token=struct.unpack_from('>I',d,st)[0];st+=4
  if token==1:
   end=d.index(0,st);names.append(d[st:end].decode());st=(end+4)&~3
  elif token==2:names.pop()
  elif token==3:
   length,noff=struct.unpack_from('>2I',d,st);st+=8;value_offset=st
   end=d.index(0,stroff+noff);name=d[stroff+noff:end].decode();value=d[st:st+length];st=(st+length+3)&~3
   properties.append({'path':'/'+('/'.join(names[1:])),'name':name,'hex':value.hex(),'offset_in_dtb':value_offset,'printable':value.rstrip(bytes(1)).decode(errors='replace') if name in ('model','compatible','bootargs','status','device_type') else None})
  elif token==4:pass
  elif token==9:break
  else:raise ValueError('Invalid FDT token')
 return d,{'boot_file_offset':offset,'size':size,'sha256':hashlib.sha256(d).hexdigest(),'properties':properties}
class Ext2:
 def __init__(self,data):
  self.data=data; s=data[1024:2048]
  if struct.unpack_from('<H',s,56)[0]!=0xef53: raise ValueError('Not ext2')
  self.bs=1024<<struct.unpack_from('<I',s,24)[0]; self.ipg=struct.unpack_from('<I',s,40)[0]; self.isize=struct.unpack_from('<H',s,88)[0] or 128
  self.gdt=(struct.unpack_from('<I',s,20)[0]+1)*self.bs
 def inode(self,num):
  group,index=divmod(num-1,self.ipg); table=struct.unpack_from('<I',self.data,self.gdt+32*group+8)[0]; off=table*self.bs+index*self.isize; b=self.data[off:off+self.isize]
  mode,uid,size=struct.unpack_from('<HHI',b); gid=struct.unpack_from('<H',b,24)[0]; blocks=struct.unpack_from('<15I',b,40)
  if stat.S_ISREG(mode): size|=struct.unpack_from('<I',b,108)[0]<<32
  return {'inode':num,'inode_offset':off,'mode':mode,'uid':uid,'gid':gid,'size':size,'blocks':blocks,'inline':b[40:100]}
 def indirect(self,block,depth):
  if not block:return []
  refs=struct.unpack_from('<'+str(self.bs//4)+'I',self.data,block*self.bs)
  if depth==1:return list(refs)
  return [v for p in refs if p for v in self.indirect(p,depth-1)]
 def contents(self,n):
  if stat.S_ISLNK(n['mode']) and n['size']<=60: return n['inline'][:n['size']],[]
  count=math.ceil(n['size']/self.bs); blocks=list(n['blocks'][:12])
  for i in range(3):
   if len(blocks)>=count:break
   blocks.extend(self.indirect(n['blocks'][12+i],i+1))
  blocks=blocks[:count]
  if len(blocks)<count: raise ValueError('Truncated block map')
  return b''.join(self.data[p*self.bs:(p+1)*self.bs] if p else bytes(self.bs) for p in blocks)[:n['size']],blocks
 def walk(self,num=2,path='',ancestors=()):
  n=self.inode(num); content,blocks=self.contents(n); item={k:v for k,v in n.items() if k not in ('blocks','inline')}; item.update({'path':'/'+path,'data_blocks':blocks,'sha256':hashlib.sha256(content).hexdigest()})
  if stat.S_ISLNK(n['mode']):item['symlink_target']=content.decode(errors='replace')
  yield item,content
  if stat.S_ISDIR(n['mode']):
   if num in ancestors:raise ValueError('Directory cycle')
   off=0
   while off<len(content):
    child,rl,nl,ft=struct.unpack_from('<IHBB',content,off)
    if rl<8 or rl%4 or off+rl>len(content):raise ValueError('Bad directory entry')
    name=content[off+8:off+8+nl].decode(errors='strict');off+=rl
    if child and name not in ('.','..'):
     if '/' in name or not name:raise ValueError('Unsafe directory name')
     yield from self.walk(child,(path+'/' if path else '')+name,ancestors+(num,))
def main():
 a=argparse.ArgumentParser();a.add_argument('boot',type=Path);a.add_argument('--out',type=Path,required=True);args=a.parse_args();b=args.boot.read_bytes();sha=hashlib.sha256(b).hexdigest()
 if sha!=EXPECTED:raise SystemExit('Unknown Boot SHA256')
 args.out.mkdir(parents=True,exist_ok=True);h=bytearray(b[UIMAGE_OFFSET:UIMAGE_OFFSET+64]); vals=struct.unpack('>7I4B32s',h);magic,hcrc,ts,size,load,entry,dcrc,osv,arch,typ,comp,name=vals
 if magic!=0x27051956 or comp!=1:raise ValueError('Unexpected uImage header')
 h[4:8]=bytes(4)
 if zlib.crc32(h)!=hcrc:raise ValueError('uImage header CRC32 mismatch')
 gz=b[UIMAGE_OFFSET+64:UIMAGE_OFFSET+64+size]
 if zlib.crc32(gz)!=dcrc:raise ValueError('uImage data CRC32 mismatch')
 disk=zlib.decompress(gz,31); ext=Ext2(disk);items=[]
 selected=('etc/init.d/','etc/rcS.d/','p1/scripts/')
 exact=('etc/inittab','etc/fstab','etc/modules','etc/ld.so.conf','sbin/init_shell','sbin/reboot','releasenote.txt','VERSION')
 extracted=args.out/'rootfs_static'; extracted.mkdir(exist_ok=True)
 for n,c in ext.walk():
  items.append(n);p=n['path'].lstrip('/')
  if stat.S_ISREG(n['mode']) and (p in exact or p.startswith(selected)):
   target=extracted/p;target.parent.mkdir(parents=True,exist_ok=True)
   if target.exists() and target.read_bytes()!=c:raise ValueError('Changed extraction '+p)
   if not target.exists():target.write_bytes(c);target.chmod(0o444)
 image=args.out/'P1_ramdisk.ext2';
 if not image.exists():image.write_bytes(disk);image.chmod(0o444)
 squashed=args.out/'boot.squashfs';squash_size=struct.unpack_from('<Q',b,SQUASH_OFFSET+40)[0]
 if not squashed.exists():squashed.write_bytes(b[SQUASH_OFFSET:SQUASH_OFFSET+squash_size]);squashed.chmod(0o444)
 config=zlib.decompress(b[0x891de0:],31);(args.out/'kernel.config.txt').write_bytes(config)
 trees=[]
 for offset in (0x86430,0xdd4440):
  d,metadata=device_tree(b,offset);(args.out/f'boot_dtb_{offset:x}.dtb').write_bytes(d);trees.append(metadata)
 (args.out/'device_trees.json').write_text(json.dumps(trees,indent=2)+'\n')
 # An ASCII environment block appended to this exact image; no runtime boot
 # environment, physical recovery activation, or secure-boot state is inferred.
 (args.out/'boot_environment.static.txt').write_bytes(b[0x44891c0:0x448986b])
 report={'evidence_level':'static_analysis','source_sha256':sha,'uimage':{'file_offset':UIMAGE_OFFSET,'data_offset':UIMAGE_OFFSET+64,'compressed_size':size,'header_crc32':f'{hcrc:08x}','data_crc32':f'{dcrc:08x}','crc_validation':'passed','architecture_id':arch,'architecture_caution':'Header ID does not establish CPU execution architecture','name':name.rstrip(bytes(1)).decode()},'ramdisk':{'sha256':hashlib.sha256(disk).hexdigest(),'size':len(disk),'block_size':ext.bs,'format':'ext2','image':str(image),'files':items},'squashfs':{'file_offset':SQUASH_OFFSET,'size':squash_size,'sha256':hashlib.sha256(squashed.read_bytes()).hexdigest()},'cryptographic_signature_validation':'not established'}
 (args.out/'boot_inventory.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({k:v for k,v in report.items() if k!='ramdisk'},indent=2));print('ramdisk',report['ramdisk']['sha256'],'files',len(items))
if __name__=='__main__':main()
