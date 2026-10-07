/* Preserve the frozen55 JPEG gallery. Only deletion identity access is added. */
#include "../stock_jpeg_gallery_55/gallery.cpp"

/* Native DeleteFile has already retired the catalog record and may have freed
 * the node. retired_node is an identity token only: never dereference it or
 * look up the now-shifted catalog index. Original DeleteMarkedFiles already
 * holds cat+1c0 across DeleteFile; these APIs require that caller-owned mutex
 * and never lock it again. They do not invoke any native call or file I/O. */
extern "C" int iq4_stock_jpeg_gallery_delete_card_61(uintptr_t cat,
 uintptr_t retired_node,const char*name,uint32_t*card_out){
 if(!name||!card_out||getHeld()||!cat||cat!=catalog55()||!jpeg_name(name))return 0;
 Entry55*match=nullptr;
  for(auto&e:entries){
   if(e.state!=1||e.catalog!=cat||memcmp(e.name,name,13))continue;
   if((e.node&&e.node!=retired_node)||(e.card!=10&&e.card!=11)||match)return 0;
   match=&e;
  }
  if(!match)return 0;*card_out=match->card;return 1;
}
extern "C" int iq4_stock_jpeg_gallery_forget_deleted_61(uintptr_t cat,
 uintptr_t retired_node,const char*name,uint32_t card){
 if(!name||getHeld()||!cat||cat!=catalog55()||!jpeg_name(name)||(card!=10&&card!=11))return 0;
 Entry55*match=nullptr;
  for(auto&e:entries){
   if(e.state!=1||e.catalog!=cat||memcmp(e.name,name,13))continue;
   if((e.node&&e.node!=retired_node)||e.card!=card||match)return 0;
   match=&e;
  }
  if(!match)return 0;*match={};return 1;
}
extern "C" int iq4_stock_jpeg_gallery_delete_path_61(uintptr_t cat,
 uintptr_t retired_node,const char*name,uint32_t card,const char*absolute){
 if(!name||!absolute||getHeld()||!cat||cat!=catalog55()||!jpeg_name(name)||
    (card!=10&&card!=11)||!memchr(absolute,0,260))return 0;
 Entry55*match=nullptr;
  for(auto&e:entries){
   if(e.state!=1||e.catalog!=cat||memcmp(e.name,name,13))continue;
   if((e.node&&e.node!=retired_node)||e.card!=card||memcmp(e.path,absolute,260)||match)return 0;
   match=&e;
  }
  return match?1:0;
}
