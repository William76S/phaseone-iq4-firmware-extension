#define IQ4_JPEG_GALLERY_TEST
#include "gallery.cpp"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <initializer_list>
static constexpr uintptr_t Cat61=0x20000000,Node61=0x20010000;
static unsigned read61,calls61;
extern "C" int iq4_native_self_read_01(void*,uintptr_t,void*,size_t){++read61;std::abort();}
extern "C" uintptr_t iq4_gallery_test_call_55(uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t,uintptr_t){++calls61;std::abort();}
static char name61[13]="IMG0001.JPG";
static void reset61(uint32_t card=11,uintptr_t node=Node61){memset(entries,0,sizeof entries);held=0;bound_catalog=Cat61;read61=calls61=0;entries[0].catalog=Cat61;entries[0].node=node;entries[0].card=card;entries[0].state=1;memcpy(entries[0].name,name61,13);strcpy(entries[0].path,"/run/media/xqdcard/DCIM/100PHASE/IMG0001.JPG");}
int main(){unsigned tests=0;uint32_t card=99;
 for(auto nativecard:{10u,11u})for(auto node:{Node61,uintptr_t(0)}){reset61(nativecard,node);assert(iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61,name61,&card)==1&&card==nativecard);assert(entries[0].state==1);assert(iq4_stock_jpeg_gallery_forget_deleted_61(Cat61,Node61,name61,nativecard)==1&&!entries[0].state);assert(!read61&&!calls61);++tests;}
 reset61();card=99;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61+8,Node61,name61,&card)&&card==99&&!calls61);++tests;
 reset61();card=99;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61+8,name61,&card)&&card==99&&entries[0].state);++tests;
 reset61(12);card=99;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61,name61,&card)&&card==99);++tests;
 reset61();entries[1]=entries[0];card=99;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61,name61,&card)&&card==99);assert(!iq4_stock_jpeg_gallery_forget_deleted_61(Cat61,Node61,name61,11)&&entries[0].state&&entries[1].state);++tests;
 reset61();assert(!iq4_stock_jpeg_gallery_forget_deleted_61(Cat61,Node61,name61,10)&&entries[0].state);++tests;
 reset61();entries[0].state=2;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61,name61,&card));++tests;
 reset61();char other[13]="IMG0002.JPG";assert(!iq4_stock_jpeg_gallery_forget_deleted_61(Cat61,Node61,other,11)&&entries[0].state);++tests;
 reset61();held=1;assert(!iq4_stock_jpeg_gallery_delete_card_61(Cat61,Node61,name61,&card)&&!calls61);++tests;
 reset61();char absolute[260]={};strcpy(absolute,entries[0].path);assert(iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 reset61(11,0);assert(iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 reset61();assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61+8,name61,11,absolute));++tests;
 reset61();assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,10,absolute));++tests;
 reset61();strcpy(absolute,"/run/media/xqdcard/DCIM/101PHASE/IMG0001.JPG");assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 reset61();memset(absolute,0,sizeof absolute);strcpy(absolute,entries[0].path);entries[1]=entries[0];assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 reset61();entries[0].state=2;assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 reset61();held=1;assert(!iq4_stock_jpeg_gallery_delete_path_61(Cat61,Node61,name61,11,absolute));++tests;
 assert(!read61&&!calls61);
 printf("PASS %u finite gallery delete identity/forget cases; no catalog reads, native file or pixel calls\n",tests);
}
