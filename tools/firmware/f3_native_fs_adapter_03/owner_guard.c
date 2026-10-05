#include "fs.h"
int f3_fs_native_owner_guard_03(int(*read_mem)(void*,uintptr_t,void*,size_t),void*ctx,uintptr_t owner){
 if(!read_mem||!owner)return 0;
 static const uint8_t expected_errno_location_03[16]={0xd0,0x59,0x0,0xb0,0x11,0x46,0x42,0xf9,0x10,0x22,0x12,0x91,0x20,0x2,0x1f,0xd6};
 uint8_t actual_errno_location_03[16];if(!read_mem(ctx,0x40a4e0,actual_errno_location_03,16))return 0;
 for(unsigned i=0;i<16;++i)if(actual_errno_location_03[i]!=expected_errno_location_03[i])return 0;
 static const uint8_t expected_syscall_03[16]={0xd0,0x59,0x0,0xb0,0x11,0x9e,0x44,0xf9,0x10,0xe2,0x24,0x91,0x20,0x2,0x1f,0xd6};
 uint8_t actual_syscall_03[16];if(!read_mem(ctx,0x40ae40,actual_syscall_03,16))return 0;
 for(unsigned i=0;i<16;++i)if(actual_syscall_03[i]!=expected_syscall_03[i])return 0;
 uint8_t a[32],b[32];uintptr_t vt=0;uint64_t table[38];
 if(!read_mem(ctx,0xf55e18,a,sizeof(a))||!read_mem(ctx,owner,&vt,sizeof(vt))||vt!=0xd91450||!read_mem(ctx,vt,table,sizeof(table)))return 0;
 static const uint64_t expected[38]={0x825e0cull,0x825e3cull,0x825e64ull,0x825ea0ull,0x46b174ull,0x825ed4ull,0x826010ull,0x826080ull,0x826388ull,0x8264c0ull,0x8267dcull,0x826a8cull,0x8272b8ull,0x8268a4ull,0x826958ull,0x82728cull,0x826734ull,0x46b2a8ull,0x46b2e0ull,0x827cc0ull,0x46b350ull,0x46b390ull,0x826b1cull,0x46b3d0ull,0x826b74ull,0x46b44cull,0x826bf0ull,0x827ec8ull,0x827f4cull,0x826ca8ull,0x826d6cull,0x826e04ull,0x46b504ull,0x826ea4ull,0x827044ull,0x827128ull,0x8271a8ull,0x82721cull};
 for(unsigned i=0;i<38;++i)if(table[i]!=expected[i])return 0;
 uint32_t id=0,flag=0;uintptr_t actual=0,name=0;
 for(unsigned i=0;i<4;++i){id|=(uint32_t)a[i]<<(8*i);flag|=(uint32_t)a[24+i]<<(8*i);}
 for(unsigned i=0;i<8;++i){name|=(uintptr_t)a[8+i]<<(8*i);actual|=(uintptr_t)a[16+i]<<(8*i);}
 if(id!=10||flag!=2||name!=0xc354f8||actual!=owner||!read_mem(ctx,0xf55e18,b,sizeof(b)))return 0;
 for(unsigned i=0;i<32;++i)if(a[i]!=b[i])return 0;return 1;
}
