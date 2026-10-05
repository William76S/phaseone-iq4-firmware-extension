#pragma once
#include <stdint.h>
#include <stddef.h>
/* One local constructor status, never UI/mask readiness. PID/tick binding is
 * derived by supervisor from its kernel peer and saved pre-exec record. */
enum { F1_STATUS_BYTES=16 };
static inline void f1_status_encode(uint8_t out[16],unsigned startup){
    const uint8_t magic[4]={'F','1','S','2'};for(unsigned i=0;i<16;i++)out[i]=0;
    for(unsigned i=0;i<4;i++)out[i]=magic[i];out[4]=1;out[5]=startup==4?2:3;out[6]=(uint8_t)startup;out[12]=16;
}
static inline int f1_status_decode(const uint8_t*data,size_t n,unsigned*startup){
    if(n!=16||data[0]!='F'||data[1]!='1'||data[2]!='S'||data[3]!='2'||data[4]!=1||data[6]>7||data[5]!=(data[6]==4?2:3)||data[12]!=16)return 0;
    for(unsigned i=7;i<16;i++)if(i!=12&&data[i])return 0;
    *startup=data[6];return 1;
}
