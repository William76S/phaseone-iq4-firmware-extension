/* Included by the independent loader. No caller pathname/PID/address accepted.
 * Reads only the pinned own publication. No SDK, callback or firmware call. */
static int f1_loaded_identity(uint64_t *pid,uint64_t *ticks){
 char b[96],canonical[96];size_t n;struct stat st;
 if(lstat(S_PATH("loaded.pid"),&st)||!S_ISREG(st.st_mode)||st.st_uid||st.st_gid||(st.st_mode&07777)!=0600||st.st_nlink!=1||!read_bounded(S_PATH("loaded.pid"),b,sizeof b-1,&n))return 0;
 b[n]=0;unsigned long long p,t;char tail;
 if(sscanf(b,"%llu %llu%c",&p,&t,&tail)!=3||tail!='\n'||p<=1||p>10000000||!t)return 0;
 int z=snprintf(canonical,sizeof canonical,"%llu %llu\n",p,t);
 if(z<=0||(size_t)z!=n||memcmp(b,canonical,n))return 0;
 uint64_t actual,unused;if(!proc_stat(p,&actual,&unused,1)||actual!=t||!proc_exe(p,F4_USER))return 0;
 *pid=p;*ticks=t;return 1;
}
static int f1_same_file(const struct stat*a,const struct stat*b){return a->st_dev==b->st_dev&&a->st_ino==b->st_ino&&a->st_size==b->st_size&&a->st_mtim.tv_sec==b->st_mtim.tv_sec&&a->st_mtim.tv_nsec==b->st_mtim.tv_nsec&&a->st_ctim.tv_sec==b->st_ctim.tv_sec&&a->st_ctim.tv_nsec==b->st_ctim.tv_nsec;}
static int f1_map_publication(uint64_t pid,const struct stat*module,uint64_t*address){
 char path[64],row[4096];snprintf(path,sizeof path,"/proc/%llu/maps",(unsigned long long)pid);
 FILE*f=fopen(path,"re");if(!f)return 0;
 uint64_t bias=0;unsigned anchor=0,cover=0,rows=0;int okay=1;
 /* First LOAD has VA/file offset zero. Its mapping provides load bias only;
  * all subsequent maps use the actual ELF LOAD VA/file-offset relation. */
 while(fgets(row,sizeof row,f)){
  if(++rows>4096||!strchr(row,'\n')){okay=0;break;}
  unsigned long long a,z,o,ino;unsigned ma,mi;char perms[5],name[4096];int at=0;
  if(sscanf(row,"%llx-%llx %4s %llx %x:%x %llu %n",&a,&z,perms,&o,&ma,&mi,&ino,&at)!=7||a>=z){okay=0;break;}
  size_t len=strlen(row+at);if(!len||len>=sizeof name)continue;memcpy(name,row+at,len+1);if(name[len-1]=='\n')name[--len]=0;
  if(strcmp(name,F4_MODULE))continue;
  if(ma!=major(module->st_dev)||mi!=minor(module->st_dev)||ino!=(uint64_t)module->st_ino||perms[3]!='p'){okay=0;break;}
  if(o==0&&perms[0]=='r'&&perms[1]=='-'&&perms[2]=='-'){if(anchor++&&bias!=a){okay=0;break;}bias=a;}
 }
 if(ferror(f)||fclose(f)||!okay||anchor!=1||bias>UINT64_MAX-F1_ENTRY_VA-F1_ENTRY_BYTES)return 0;
 *address=bias+F1_ENTRY_VA;f=fopen(path,"re");if(!f)return 0;rows=0;
 while(fgets(row,sizeof row,f)){
  if(++rows>4096||!strchr(row,'\n')){okay=0;break;}
  unsigned long long a,z,o,ino;unsigned ma,mi;char perms[5];int at=0;
  if(sscanf(row,"%llx-%llx %4s %llx %x:%x %llu %n",&a,&z,perms,&o,&ma,&mi,&ino,&at)!=7||a>=z){okay=0;break;}
  size_t len=strlen(row+at);if(!len)continue;if(row[at+len-1]=='\n')row[at+--len]=0;
  if(a<=*address&&z-*address>=F1_ENTRY_BYTES&&*address<z){
   if(strcmp(row+at,F4_MODULE)||ma!=major(module->st_dev)||mi!=minor(module->st_dev)||ino!=(uint64_t)module->st_ino||perms[0]!='r'||perms[1]!='w'||perms[2]!='-'||perms[3]!='p'){okay=0;break;}
   uint64_t expected=F1_ENTRY_LOAD_FILE_PAGE+(a-bias-F1_ENTRY_LOAD_VA_PAGE);
   if(a<bias+F1_ENTRY_LOAD_VA_PAGE||o!=expected){okay=0;break;}cover++;
  }
 }
 if(ferror(f)||fclose(f))okay=0;return okay&&cover==1;
}
static int f1_pread_once(int fd,void*out,size_t n,uint64_t address){
 if(address>INT64_MAX||n>(uint64_t)INT64_MAX-address)return 0;
 ssize_t got;do{got=pread(fd,out,n,(off_t)address);}while(got<0&&errno==EINTR);return got==(ssize_t)n;
}
static int f1_entry_read(void){
 if(!root_mount_gate()||!own_dir()||!flags_gate()||!user_file_gate()||!module_gate()||!tool_gate()||!runner_check(F4_RUNNER,0,1))return fail("entry_read_runtime_gate_refused");
 uint64_t pid,ticks,address,again,actual,unused;struct stat module,after;
 if(!f1_loaded_identity(&pid,&ticks)||lstat(F4_MODULE,&module)||!f1_map_publication(pid,&module,&address))return fail("entry_read_loaded_identity_or_map_refused");
 char path[64];snprintf(path,sizeof path,"/proc/%llu/mem",(unsigned long long)pid);
 int fd=open(path,O_RDONLY|O_CLOEXEC|O_NOFOLLOW);if(fd<0)return fail("entry_read_proc_permission_refused");
 unsigned char first[F1_ENTRY_BYTES],second[F1_ENTRY_BYTES];uint32_t before=1,end=1;
 int okay=f1_pread_once(fd,&before,4,address)&&!(before&1)&&f1_pread_once(fd,first,sizeof first,address)&&f1_pread_once(fd,second,sizeof second,address)&&f1_pread_once(fd,&end,4,address)&&before==end&&!(end&1)&&!memcmp(first,second,sizeof first)&&!memcmp(first,&before,4);
 if(close(fd))okay=0;
 if(!okay||!proc_stat(pid,&actual,&unused,1)||actual!=ticks||!proc_exe(pid,F4_USER)||lstat(F4_MODULE,&after)||!f1_same_file(&module,&after)||!module_gate()||!user_file_gate()||!f1_map_publication(pid,&after,&again)||again!=address)return fail("entry_read_changed_or_unstable_refused");
 printf("{\"schema\":\"iq4_f1_entry_copied_read_v7\",\"pid\":%llu,\"start_ticks\":%llu,\"module_sha256\":\"%s\",\"publication_va\":%llu,\"publication_bytes\":%u,\"sequence\":%u,\"first_hex\":\"",(unsigned long long)pid,(unsigned long long)ticks,F4_MODULE_SHA,(unsigned long long)address,F1_ENTRY_BYTES,before);
 for(size_t i=0;i<sizeof first;i++)printf("%02x",first[i]);printf("\",\"second_hex\":\"");for(size_t i=0;i<sizeof second;i++)printf("%02x",second[i]);puts("\",\"firmware_calls\":0,\"target_memory_writes\":0,\"mask_enabled\":false}");
 return ferror(stdout)?2:0;
}
