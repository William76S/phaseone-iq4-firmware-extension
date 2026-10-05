#include "card.h"
#include <assert.h>
#include <stdio.h>
#include <string.h>
int main(void){const char*tests[]={"pos:\t0\nflags:\t02300000\nmnt_id:\t381\nino:\t2\n","mnt_id: 4294967295\n","mnt_id:\t0\n","mnt_id:\t1\nmnt_id:\t1\n","mnt_id: 18446744073709551616\n","mnt_id: 1","mnt_id: +1\n","pos: 0\n","mnt_id: 1x\n","mnt_id:\t\n","mnt_id: 0001\n"};unsigned groups=0;for(unsigned i=0;i<sizeof(tests)/sizeof(tests[0]);++i){uint64_t id=0;int result=f3_fdinfo_mount_id_05(tests[i],strlen(tests[i]),&id);assert(result==(i==0||i==1||i==10));if(result)assert(id==(i==0?381:i==1?UINT32_MAX:1));++groups;}char embedded[]="mnt_id: 1\n\0junk\n";uint64_t id=0;assert(!f3_fdinfo_mount_id_05(embedded,sizeof(embedded)-1,&id));printf("{\"fdinfo_parser_groups\":%u,\"passed\":true}\n",groups+1);}
