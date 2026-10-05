"""SDK-free local syscall fixtures around verbatim production ctor helpers.

No target/User/library execution. macOS fixture maps Linux /proc and credentials
to local files and syscall responses; actual Linux ownership remains unverified.
"""
import ctypes,hashlib,json,os,shutil,subprocess,sys,tempfile,unittest
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
class Constructor(unittest.TestCase):
 @classmethod
 def setUpClass(cls):
  cls.tmp=tempfile.TemporaryDirectory(prefix='iq4_f1_role_local_');cls.path=Path(cls.tmp.name);cls.state=cls.path/'state'
  src=(HERE/'ctor_status.cpp').read_text();begin=src.index('bool same(');end=src.rfind('\n}')
  body=src[begin:end];body=body.replace('__attribute__((constructor)) void role_constructor()','void role_constructor()')
  cls.production_span_sha256=hashlib.sha256(src[begin:end].encode()).hexdigest()
  # Actual ordinary host file operations, with explicit Linux-credential/proc
  # fixtures. These replacements are confined to this local test translation.
  header=r'''
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <cstring>
#include <cstdio>
#include <cstdlib>
#include <cerrno>
#include <atomic>
#include <cstdint>
#include "sha256.h"
#include "status.h"
#include "module.hpp"
#ifdef __APPLE__
#define st_mtim st_mtimespec
struct ucred {pid_t pid;uid_t uid;gid_t gid;};
#define SO_PEERCRED 0x7714
#endif
extern "C" int f4_parse_stat(const char*,std::size_t,std::uint64_t,std::uint64_t*);
extern "C" {iq4::f1::entry01::PublishedObservation iq4_f1_entry_observed;unsigned iq4_f1_role_ctor_status;}
static int fixture_type=SOCK_SEQPACKET,fixture_uid=0,fixture_gid=0,fixture_peer_pid=42,fixture_bad_path=0,fixture_send_result=16,fixture_close_result=0;
static unsigned sent=0,closed198=0,fd_stat_count=0;static int fd_replace_at=0,fd_regular=0;
static void root_metadata(struct stat*s){if(s->st_uid==getuid())s->st_uid=0;if(s->st_gid==getgid())s->st_gid=0;}
static int local_lstat(const char*p,struct stat*s){
 if(!std::strcmp(p,F1_ROLE_STATE "/control.sock")){std::memset(s,0,sizeof *s);s->st_mode=S_IFSOCK|0600;return 0;}
 int r=lstat(p,s);if(!r)root_metadata(s);return r;
}
static int local_fstat(int fd,struct stat*s){if(fd==198){++fd_stat_count;std::memset(s,0,sizeof *s);s->st_mode=(fd_regular?S_IFREG:S_IFSOCK)|0600;s->st_ino=fd_replace_at&&fd_stat_count>=static_cast<unsigned>(fd_replace_at)?199:198;return 0;}int r=fstat(fd,s);if(!r)root_metadata(s);return r;}
static int local_open(const char*p,int flags){
 if(!std::strncmp(p,"/proc/",6))p=std::strstr(p,"/stat")?F1_ROLE_STATE "/proc.stat":F1_ROLE_TOOL;
 return open(p,flags);
}
static ssize_t local_readlink(const char*p,char*b,size_t n){(void)p;size_t z=std::strlen(F1_ROLE_TOOL);if(z>=n)return -1;std::memcpy(b,F1_ROLE_TOOL,z);return static_cast<ssize_t>(z);}
static int local_getsockopt(int fd,int level,int option,void*out,socklen_t*len){
 if(fd!=198||level!=SOL_SOCKET)return -1;
 if(option==SO_TYPE&&*len==sizeof(int)){*static_cast<int*>(out)=fixture_type;return 0;}
 if(option==SO_PEERCRED&&*len==sizeof(ucred)){ucred p{fixture_peer_pid,static_cast<uid_t>(fixture_uid),static_cast<gid_t>(fixture_gid)};std::memcpy(out,&p,sizeof p);return 0;}
 return -1;
}
static int local_getpeername(int fd,sockaddr*out,socklen_t*len){
 if(fd!=198||*len<sizeof(sockaddr_un))return -1;sockaddr_un p{};p.sun_family=AF_UNIX;
 std::strcpy(p.sun_path,fixture_bad_path?"/wrong/socket":F1_ROLE_STATE "/control.sock");std::memcpy(out,&p,sizeof p);*len=sizeof p;return 0;
}
static ssize_t local_send(int fd,const void*data,size_t n,int flags){
 unsigned code{};if(fd!=198||n!=16||flags!=(MSG_DONTWAIT|MSG_NOSIGNAL)||!f1_status_decode(static_cast<const uint8_t*>(data),n,&code))return -1;++sent;return fixture_send_result;
}
static int local_close(int fd){if(fd==198){++closed198;return fixture_close_result;}return close(fd);}
#define lstat local_lstat
#define fstat local_fstat
#define open local_open
#define readlink local_readlink
#define getsockopt local_getsockopt
#define getpeername local_getpeername
#define send local_send
#define close local_close
'''
  defines='#define F1_ROLE_ENABLED 1\n#define F1_ROLE_STATE '+json.dumps(str(cls.state))+'\n#define F1_ROLE_TOOL F1_ROLE_STATE "/entrytool"\n'
  tail=r'''
extern "C" void fixture_reset(void){fixture_type=SOCK_SEQPACKET;fixture_uid=fixture_gid=fixture_bad_path=0;fixture_peer_pid=42;fixture_send_result=16;fixture_close_result=0;sent=closed198=fd_stat_count=0;fd_replace_at=fd_regular=0;iq4_f1_role_ctor_status=0;iq4_f1_entry_observed.startup.store(4);}
extern "C" void fixture_option(int key,int value){switch(key){case 1:fixture_type=value;break;case 2:fixture_uid=value;break;case 3:fixture_gid=value;break;case 4:fixture_bad_path=value;break;case 5:fixture_peer_pid=value;break;case 6:fixture_send_result=value;break;case 7:fixture_close_result=value;break;case 8:iq4_f1_entry_observed.startup.store(static_cast<unsigned>(value));break;case 9:fd_replace_at=value;break;case 10:fd_regular=value;break;}}
extern "C" unsigned fixture_run(void){role_constructor();return iq4_f1_role_ctor_status;}
extern "C" unsigned fixture_sent(void){return sent;}
extern "C" unsigned fixture_closed(void){return closed198;}
'''
  h=cls.path/'harness.cpp';h.write_text(defines+header+body+tail)
  parser=cls.path/'parser.o';subprocess.run(['clang','-std=c11','-DF4_MONITOR_PARSER_ONLY','-c',str(ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c'),'-o',str(parser)],check=True)
  sdk=subprocess.check_output(['xcrun','--show-sdk-path'],text=True).strip()
  cls.library=cls.path/'fixture.dylib';subprocess.run(['clang++','-std=c++17','-O1','-g','-shared','-fPIC','-Wall','-Wextra','-Werror','-Wno-macro-redefined','-isystem',sdk+'/usr/include/c++/v1','-I'+str(HERE),'-I'+str(ROOT/'tools/firmware/f1_module_entry_01'),'-I'+str(ROOT/'tools/firmware/f4_ui_bootstrap_02'),'-I'+str(ROOT/'src/core/include'),'-I'+str(ROOT/'src/display/include'),str(h),str(parser),'-o',str(cls.library)],check=True)
  cls.lib=ctypes.CDLL(str(cls.library));cls.lib.fixture_run.restype=ctypes.c_uint
 @classmethod
 def tearDownClass(cls):cls.tmp.cleanup()
 def setUp(self):
  if self.state.exists():shutil.rmtree(self.state)
  self.state.mkdir(mode=0o700);self.lib.fixture_reset();os.environ['IQ4_F1_MODULE_ENTRY_01']='OBSERVE'
  tool=self.state/'entrytool';tool.write_bytes(b'own host tool fixture; not target executable\n');tool.chmod(0o500)
  for name,data in [('entry.sha256',(hashlib.sha256(tool.read_bytes()).hexdigest()+'\n').encode()),('loaded.pid',f'{os.getpid()} 12345\n'.encode()),('proc.stat',self.stat_text(12345))]:
   p=self.state/name;p.write_bytes(data);p.chmod(0o600)
 def stat_text(self,tick,comm='p1linux'):
  # Field3 state, field4 PPID ... field22 ticks; remaining fields required by
  # the frozen parser are filled from a normal, full newline-terminated row.
  fields=['S']+['1']*49;fields[19]=str(tick)
  return f'{os.getpid()} ({comm}) '.encode()+' '.join(fields).encode()+b'\n'
 def assert_rejected(self,expected=2):
  self.assertEqual(self.lib.fixture_run(),expected);self.assertEqual(self.lib.fixture_sent(),0);self.assertEqual(self.lib.fixture_closed(),0)
 def test_authenticated_single_send_close(self):
  self.assertEqual(self.lib.fixture_run(),4);self.assertEqual(self.lib.fixture_sent(),1);self.assertEqual(self.lib.fixture_closed(),1)
 def test_wrong_env_retains_unknown_fd(self):
  os.environ['IQ4_F1_MODULE_ENTRY_01']='ENABLED';self.assert_rejected(1)
 def test_wrong_socket_type(self):self.lib.fixture_option(1,socket_stream());self.assert_rejected()
 def test_foreign_regular_fd_retained(self):self.lib.fixture_option(10,1);self.assert_rejected()
 def test_descriptor_replaced_before_send_retained(self):self.lib.fixture_option(9,3);self.assert_rejected()
 def test_descriptor_replaced_after_send_retained(self):
  self.lib.fixture_option(9,4);self.assertEqual(self.lib.fixture_run(),8);self.assertEqual(self.lib.fixture_sent(),1);self.assertEqual(self.lib.fixture_closed(),0)
 def test_nonroot_peer_uid_gid(self):
  for key in (2,3):self.lib.fixture_reset();self.lib.fixture_option(key,1000);self.assert_rejected()
 def test_wrong_peer_path(self):self.lib.fixture_option(4,1);self.assert_rejected()
 def test_invalid_peer_pid(self):self.lib.fixture_option(5,1);self.assert_rejected()
 def test_staged_tool_hash_changed(self):
  p=self.state/'entrytool';p.chmod(0o600);p.write_bytes(b'changed');p.chmod(0o500);self.assert_rejected()
 def test_tool_symlink_rejected(self):
  p=self.state/'entrytool';p.rename(self.state/'other');p.symlink_to(self.state/'other');self.assert_rejected()
 def test_private_hash_mode_rejected(self):(self.state/'entry.sha256').chmod(0o644);self.assert_rejected()
 def test_private_loaded_identity_wrong_pid(self):(self.state/'loaded.pid').write_text('1 12345\n');self.assert_rejected()
 def test_changed_start_ticks(self):(self.state/'proc.stat').write_bytes(self.stat_text(12346));self.assert_rejected()
 def test_non_user_comm(self):(self.state/'proc.stat').write_bytes(self.stat_text(12345,'other'));self.assert_rejected()
 def test_truncated_proc_row(self):(self.state/'proc.stat').write_bytes(b'1 (p1linux) S\n');self.assert_rejected()
 def test_private_identity_symlink(self):
  p=self.state/'loaded.pid';p.rename(self.state/'other');p.symlink_to(self.state/'other');self.assert_rejected()
 def test_private_identity_hardlink(self):os.link(self.state/'loaded.pid',self.state/'other');self.assert_rejected()
 def test_unknown_publication_retains_fd(self):self.lib.fixture_option(8,8);self.assert_rejected(3)
 def test_known_user_rejection_reports_failure_once(self):
  self.lib.fixture_option(8,3);self.assertEqual(self.lib.fixture_run(),5);self.assertEqual(self.lib.fixture_sent(),1);self.assertEqual(self.lib.fixture_closed(),1)
 def test_send_failure_closes_only_authenticated_fd(self):
  self.lib.fixture_option(6,-1);self.assertEqual(self.lib.fixture_run(),6);self.assertEqual(self.lib.fixture_sent(),1);self.assertEqual(self.lib.fixture_closed(),1)
 def test_close_failure_explicit(self):
  self.lib.fixture_option(7,-1);self.assertEqual(self.lib.fixture_run(),7);self.assertEqual(self.lib.fixture_sent(),1);self.assertEqual(self.lib.fixture_closed(),1)
def socket_stream():return 1
if __name__=='__main__':unittest.main()
