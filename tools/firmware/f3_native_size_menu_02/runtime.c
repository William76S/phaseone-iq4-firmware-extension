#include "../f3_capture_menu_06/policy.h"
#include "../native_activity_01/activity.h"
#include "../f4_native_menu_03/native_calls.h"
#include "../f4_native_source_02/native_calls.h"
#include "../native_runtime_01/self_read.h"
#include "pins.h"
#include <string.h>
extern uint32_t iq4_extensions_installation_stage_02(void);
static void *size_menu,*size_items[6],*saved_original;
static uintptr_t saved_parent,queue,manager,menu_table[24],item_table[22];
static unsigned building,held;
static const char*const names[6]={"4K","8K","75%","50%","25%","100%"};
static const uint32_t scales[6]={F3_LONG384001,F3_LONG768001,F3_75_PERCENT01,F3_50_PERCENT01,F3_25_PERCENT01,F3_FULL01};
static int rd(uintptr_t p,void*b,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&iq4_native_self_read_01(0,p,b,n)==1;}
static int word(uintptr_t p,uintptr_t*v){uintptr_t a;if(!rd(p,v,8)||!rd(p,&a,8)||a!=*v)return 0;return 1;}
static int pins(void){unsigned char b[64];for(unsigned i=0;i<sizeof SizePins01/sizeof*SizePins01;++i){const struct SizePin01*p=SizePins01+i;for(size_t j=0;j<p->bytes;j+=sizeof b){size_t n=p->bytes-j;if(n>sizeof b)n=sizeof b;if(!rd(p->va+j,b,n)||memcmp(b,p->data+j,n))return 0;}}return 1;}
static void put(void*p,size_t off,uintptr_t v){memcpy((char*)p+off,&v,8);}
static char*text(char*b,int32_t n,const char*s){int32_t i=0;if(!b||n<=0)return(char*)"";for(;i+1<n&&s[i];++i)b[i]=s[i];b[i]=0;return b;}
static unsigned index_of(void*p){for(unsigned i=0;i<6;++i)if(p&&p==size_items[i])return i;return 6;}
static const char*selected(uint32_t scale){for(unsigned i=0;i<6;++i)if(scales[i]==scale)return names[i];return "Unavailable";}
static int on_ui(void){uintptr_t q,v,m,back;return queue&&iq4_f4_native_current_02(&q)&&q==queue&&word(q,&v)&&v==0xb91f48&&word(q+0x1c8,&m)&&m==manager&&word(m,&v)&&v==0xb8f358&&word(m+8,&back)&&back==q;}
static char*menu_name(void*p,char*b,int32_t n){return text(b,n,p==size_menu?"JPEG Size":"");}
static char*menu_value(void*p,char*b,int32_t n){struct F3SettingsSnapshot06 s;return text(b,n,p==size_menu&&iq4_f3_settings_snapshot_06(&s)?selected(s.size_mode):"Unavailable");}
static char*item_name(void*p,char*b,int32_t n){unsigned i=index_of(p);return text(b,n,i<6?names[i]:"");}
static char*item_value(void*p,char*b,int32_t n){unsigned i=index_of(p);struct F3SettingsSnapshot06 s;return text(b,n,i<6&&iq4_f3_settings_snapshot_06(&s)&&s.size_mode==scales[i]?"Selected":"");}
static uint32_t activate(void*p){unsigned i=index_of(p);struct Iq4ActivitySnapshot01 a={0};
 if(i>=6||held||!on_ui()||iq4_activity_snapshot_01(&a)!=IQ4_ACTIVITY_OK01||a.actor||a.held)return 0;
 return (uint32_t)iq4_f3_scale_set_on_ui_01(scales[i]);
}
static int construct(void**out,size_t bytes,uintptr_t fn,uintptr_t*table){if(!iq4_f4_menu_new_03(bytes,out)||!*out||!iq4_f4_menu_ctor_03(fn,*out))return 0;put(*out,0,(uintptr_t)&table[2]);return 1;}
/* The original PropertyEnum was already constructed at the exact caller.
 * Keep it and its original DTO/event unchanged for the lifetime of the UI.
 * Only substitute the child pointer passed to native SubMenu::Append. */
void*iq4_f3_storage_size_child_01(void*root,void*original,uintptr_t pc){
 uintptr_t parent=(uintptr_t)root,v,dto,q,m,back;uint32_t title;
 if(iq4_extensions_installation_stage_02()!=100||pc!=0x4f052c||!root||!original||parent<4096||(parent&7)||((uintptr_t)original&7)||held||building||!pins()||
 !word(parent,&v)||v!=0xb8f9b8||!rd(parent+0x14,&title,4)||title!=389||
 !word((uintptr_t)original,&v)||v!=0xb8fd40||!word((uintptr_t)original+0x18,&dto)||!word(dto,&v)||v!=0xbbf3f8)return original;
 if(!iq4_f4_native_current_02(&q)||!word(q,&v)||v!=0xb91f48||!word(q+0x1c8,&m)||!word(m,&v)||v!=0xb8f358||!word(m+8,&back)||back!=q)return original;
 if(saved_parent)return saved_parent==parent&&saved_original==original&&queue==q&&manager==m?size_menu:original;
 queue=q;manager=m;building=1;
 for(unsigned i=0;i<24;++i)if(!word(0xb8f9a8+8*i,&menu_table[i]))goto fail;
 for(unsigned i=0;i<22;++i)if(!word(0xb90738+8*i,&item_table[i]))goto fail;
 menu_table[5]=(uintptr_t)menu_name;menu_table[6]=(uintptr_t)menu_value;
 item_table[5]=(uintptr_t)item_name;item_table[6]=(uintptr_t)item_value;item_table[12]=(uintptr_t)activate;
 if(!construct(&size_menu,0x118,0x4e5744,menu_table))goto fail;
 for(unsigned i=0;i<6;++i)if(!construct(size_items+i,0x38,0x4e9d30,item_table))goto fail;
 for(unsigned i=0;i<6;++i)if(!iq4_f4_menu_append_03(size_menu,size_items[i]))goto fail;
 saved_parent=parent;saved_original=original;building=0;return size_menu;
 fail:held=1;return original; /* No partly built replacement is attached. */
}
#if defined(__aarch64__) && defined(__linux__)
__asm__(
".text\n.p2align 2\n.global iq4_f3_storage_size_append_wrapper_01\n.type iq4_f3_storage_size_append_wrapper_01,%function\n"
"iq4_f3_storage_size_append_wrapper_01:\n.cfi_startproc\nsub sp,sp,#0x110\n.cfi_def_cfa_offset 0x110\nstp x29,x30,[sp,#0x100]\n.cfi_offset x29,-16\n.cfi_offset x30,-8\nmov x29,sp\n.cfi_def_cfa_register x29\n"
"stp x0,x1,[sp,#0x00]\nstp x2,x3,[sp,#0x10]\nstp x4,x5,[sp,#0x20]\nstp x6,x7,[sp,#0x30]\nstr x8,[sp,#0x40]\nmrs x9,nzcv\nstr x9,[sp,#0x48]\nstp q0,q1,[sp,#0x50]\nstp q2,q3,[sp,#0x70]\nstp q4,q5,[sp,#0x90]\nstp q6,q7,[sp,#0xb0]\n"
"mov x2,x30\nbl iq4_f3_storage_size_child_01\nstr x0,[sp,#0x08]\n"
"ldp q0,q1,[sp,#0x50]\nldp q2,q3,[sp,#0x70]\nldp q4,q5,[sp,#0x90]\nldp q6,q7,[sp,#0xb0]\nldr x9,[sp,#0x48]\nmsr nzcv,x9\nldp x0,x1,[sp,#0x00]\nldp x2,x3,[sp,#0x10]\nldp x4,x5,[sp,#0x20]\nldp x6,x7,[sp,#0x30]\nldr x8,[sp,#0x40]\nldp x29,x30,[sp,#0x100]\n.cfi_def_cfa sp,0x110\n.cfi_restore x29\n.cfi_restore x30\nadd sp,sp,#0x110\n.cfi_def_cfa_offset 0\n"
"movz x16,#0x58b8\nmovk x16,#0x4e,lsl #16\nbr x16\n.cfi_endproc\n.size iq4_f3_storage_size_append_wrapper_01,.-iq4_f3_storage_size_append_wrapper_01\n");
#endif
