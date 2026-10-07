#!/usr/bin/env python3
"""Bind only JPEG-owned LCD consumers to the exact original User."""
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
 data=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
 assert hashlib.sha256(data).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 def at(va,n):return data[va-0x400000:va-0x400000+n].hex()
 aliasmap={'iq4_stock_jpeg_gallery_zoom_continue_55':0x488238,'iq4_stock_jpeg_gallery_zoom_failure_55':0x4888b8,'iq4_stock_jpeg_gallery_preview_continue_55':0x48a99c,'iq4_stock_jpeg_gallery_preview_failure_55':0x48acc8,'iq4_stock_jpeg_gallery_final_continue_55':0x48bc28,'iq4_stock_jpeg_gallery_final_failure_55':0x48bfb4,'iq4_stock_jpeg_gallery_metadata_resume_55':0x488bd4}
 hooks=[{'va':v,'replacement_symbol':s}for v,s in [(0x492d9c,'iq4_stock_jpeg_gallery_card_refresh_55'),(0x48aaa8,'iq4_stock_jpeg_gallery_preview_enqueue_55'),(0x488654,'iq4_stock_jpeg_gallery_final_enqueue_55'),(0x48bd7c,'iq4_stock_jpeg_gallery_final_enqueue_55')]]
 aux=[{'va':v,'replacement_symbol':f'iq4_stock_jpeg_gallery_{name}_55','kind':'B'}for v,name in [(0x488234,'zoom_gate'),(0x48a998,'preview_gate'),(0x48bc24,'final_gate'),(0x488bd0,'metadata_entry')]]
 for h in hooks+aux:h['original_u32_LE']=at(h['va'],4)
 functions=[0x411bc0,0x411bf4,0x48f4bc,0x48f4f0,0x827348,0x48dce8,0x48dd9c,0x48dd4c,0x70f2f8,0x48fff8,0x490288,0x48da14,0x48d9e4,0x709be4,0x49037c,0x48ae68,0x826010,0x826080,0x826388,0x48df80,0x48f36c,0x48b828,0x487ab8]
 pins=[{'va':v,'bytes':16,'original_LE':at(v,16)}for v in functions]
 pins.extend({'va':h['va']+4,'bytes':16,'original_LE':at(h['va']+4,16)}for h in hooks+aux)
 lines=['#ifndef IQ4_STOCK_JPEG_GALLERY_55_PINS_H','#define IQ4_STOCK_JPEG_GALLERY_55_PINS_H','#include <stdint.h>','#include <stddef.h>','struct JpegGalleryPin55 {uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,p in enumerate(pins):lines.append('static const unsigned char JpegGalleryBytes55_%d[]={%s};'%(i,','.join('0x'+p['original_LE'][x:x+2]for x in range(0,len(p['original_LE']),2))))
 lines+=['static const JpegGalleryPin55 JpegGalleryPins55[]={']+['{%#x,%d,JpegGalleryBytes55_%d},'%(p['va'],p['bytes'],i)for i,p in enumerate(pins)]+['};','extern "C" {']
 for h in aux:lines.append('void '+h['replacement_symbol']+'(void);')
 lines+=['}','struct JpegGalleryHookPin55 {uintptr_t va,target;uint32_t opcode;};','static const JpegGalleryHookPin55 JpegGalleryHookPins55[]={']
 for h in hooks+aux:lines.append('{%#x,(uintptr_t)&%s,%#x},'%(h['va'],h['replacement_symbol'],0x14000000 if h in aux else 0x94000000))
 lines+=['};','#endif'];(HERE/'pins.h').write_text('\n'.join(lines)+'\n')
 exact={'stock':{'path':'analysis/firmware/extracted/P1Linux_6.03.21.bin','bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()},'aliases':[{'symbol':s,'va':v,'original_first16_LE':at(v,16)}for s,v in aliasmap.items()],'BL_hooks':hooks,'auxiliary_hooks':aux,'pins':pins,'camera_accessed':False}
 (HERE/'EXACT.json').write_text(json.dumps(exact,indent=2)+'\n');print(f'{len(pins)} original windows; {len(hooks)} BL + {len(aux)} B owned JPEG consumers')
if __name__=='__main__':main()
