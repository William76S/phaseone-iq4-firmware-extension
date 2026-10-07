/* Production menu with native UI allocation/event fixtures and real stock
 * ELF reads for pins/vtables. No inferred camera UI or card behavior. */
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "menu.c"
static unsigned char *image61;static size_t bytes61;
static void *owned61[4];static unsigned alloc61,append61,set61,refuse61,unbound61;
static uintptr_t q61,m61;
static uint32_t chosen61,quality61=100;
static void store61(void*p,size_t off,uintptr_t v){memcpy((char*)p+off,&v,8);}
static uint64_t u6461(size_t p){uint64_t x;assert(p+8<=bytes61);memcpy(&x,image61+p,8);return x;}
static uint32_t u3261(size_t p){uint32_t x;assert(p+4<=bytes61);memcpy(&x,image61+p,4);return x;}
static uint16_t u1661(size_t p){uint16_t x;assert(p+2<=bytes61);memcpy(&x,image61+p,2);return x;}
int iq4_native_self_read_01(void*c,uintptr_t p,void*out,size_t n){(void)c;
 for(unsigned i=0;i<u1661(56);++i){size_t ph=u6461(32)+i*u1661(54);if(u3261(ph)!=1)continue;uint64_t va=u6461(ph+16),len=u6461(ph+32),off=u6461(ph+8);
  if(p>=va&&p+n>=p&&p+n<=va+len){memcpy(out,image61+off+p-va,n);return 1;}}
 if(p<UINT64_C(0x100000000))return 0;memcpy(out,(void*)p,n);return 1;
}
uint32_t iq4_extensions_installation_stage_02(void){return 100;}
int iq4_f4_native_current_02(uintptr_t*out){*out=q61;return 1;}
int iq4_f4_menu_new_03(size_t n,void**out){assert(alloc61<4);*out=owned61[alloc61++]=calloc(1,n);assert(*out);return 1;}
int iq4_f4_menu_ctor_03(uintptr_t c,void*p){(void)p;assert(c==0x4e5744||c==0x4e9d30);return 1;}
int iq4_f4_menu_append_03(void*root,void*item){assert(root==size_menu);assert(item==size_items[0]||item==quality_item||item==status_item);++append61;return 1;}
int iq4_stock_jpeg_extended_size_get_02(uint32_t*out){if(unbound61)return 0;*out=chosen61;return 1;}
int iq4_stock_jpeg_extended_size_set_02(uint32_t v){assert(v==0);++set61;if(refuse61||unbound61)return 0;chosen61=v;return 1;}
int iq4_stock_jpeg_quality_get_02(uint32_t*out){if(unbound61)return 0;*out=quality61;return 1;}
int iq4_stock_jpeg_last_failure_55(uint32_t*stage,uint32_t*detail){if(unbound61)return 0;*stage=0;*detail=0;return 1;}
int main(){
 FILE*f=fopen("analysis/firmware/extracted/P1Linux_6.03.21.bin","rb");assert(f);fseek(f,0,SEEK_END);bytes61=ftell(f);rewind(f);image61=malloc(bytes61);assert(image61&&fread(image61,1,bytes61,f)==bytes61);fclose(f);
 unsigned char root[0x118]={0},original[0x38]={0},dto[312]={0},q[0x200]={0},m[32]={0};
 store61(root,0,0xb8f9b8);uint32_t title=389;memcpy(root+0x14,&title,4);store61(original,0,0xb8fd40);store61(original,0x18,(uintptr_t)dto);store61(dto,0,0xbbf3f8);
 q61=(uintptr_t)q;m61=(uintptr_t)m;store61(q,0,0xb91f48);store61(q,0x1c8,m61);store61(m,0,0xb8f358);store61(m,8,q61);
 void*child=iq4_stock_jpeg_size_child_02(root,original,0x4f052c);assert(child==size_menu&&child!=original&&alloc61==4&&append61==3);
 for(unsigned i=0;i<24;++i){uintptr_t native;assert(word(0xb8f9a8+8*i,&native));if(i!=5&&i!=6)assert(menu_table[i]==native);}
 for(unsigned i=0;i<22;++i){uintptr_t native;assert(word(0xb90738+8*i,&native));if(i!=5&&i!=6&&i!=12)assert(item_table[i]==native);}
 assert(iq4_stock_jpeg_size_child_02(root,original,0x4f052c)==child&&alloc61==4&&append61==3);
 char b[64];assert(!strcmp(menu_value(child,b,sizeof b),"4K"));assert(!strcmp(item_value(size_items[0],b,sizeof b),"Selected"));
 assert(!strcmp(item_name(quality_item,b,sizeof b),"JPEG Quality")&&!strcmp(item_value(quality_item,b,sizeof b),"100"));
 assert(!strcmp(item_value(status_item,b,sizeof b),"Ready"));assert(activate(size_items[0])==1&&set61==1);
 assert(!activate(quality_item)&&!activate(status_item)&&set61==1);
 refuse61=1;assert(!activate(size_items[0])&&set61==2);refuse61=0;
 chosen61=1;assert(!strcmp(menu_value(child,b,sizeof b),"")&&!strcmp(item_value(size_items[0],b,sizeof b),""));chosen61=0;
 unbound61=1;assert(!strcmp(menu_value(child,b,sizeof b),"")&&!strcmp(item_value(quality_item,b,sizeof b),"")&&!strcmp(item_value(status_item,b,sizeof b),"Unavailable"));
 for(unsigned i=0;i<alloc61;++i)free(owned61[i]);free(image61);
 puts("PASS 61 production menu, full24/22 vtables from actual stock ELF, one4K row, Selected, Quality100, unbound refusal");
}
