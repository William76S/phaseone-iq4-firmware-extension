#pragma once
#include "../../sdk/readonly_octets_native_01/profiles.hpp"
// Only this command renderer expands. The actual sender/readiness/receiver,
// owner/callback lifetime and cleanup remain the frozen readonly implementation.
namespace IQ4RestoreBaseline03 {
using Plan=IQ4Stage2::Plan;
inline Plan Parse(std::string const& data){return IQ4Stage2::Parse(data);}
inline bool Regular(std::string const& path){return path=="/p1/scripts/boot_run_p1linux.sh"||path=="/etc/inittab";}
inline bool NewLabel(std::string const& label){
 return label=="baseline_regular_metadata"||label=="baseline_regular_sha256"||label=="baseline_regular_octets_chunk"||label=="baseline_regular_octets_eof"||
  label=="baseline_user_cmdline"||label=="baseline_user_environment"||label=="baseline_parent_cmdline"||label=="baseline_user_stat"||label=="baseline_parent_stat"||
  label=="baseline_user_status"||label=="baseline_user_maps"||label=="baseline_user_mountinfo"||label=="baseline_kernel_cmdline"||label=="baseline_syscall_facts"||label=="baseline_syscall_probe_sha"||label=="baseline_pthread_sha256";
}
inline IQ4Shell::Command Command(Plan const& p){
 if(!NewLabel(p.label))return IQ4ReadonlyOctets01::Command(p);
 using IQ4Shell::Require;Require(p.userSha==IQ4Stage2::UserSha());
 Require(p.nonce.size()>=8&&p.nonce.size()<=12);for(char c:p.nonce)Require((c>='0'&&c<='9')||(c>='a'&&c<='f'));
 std::string os;
 if(p.label=="baseline_regular_metadata"||p.label=="baseline_regular_sha256"){
  Require(p.pid==0&&p.offset==0&&p.count==0&&Regular(p.path));
  os=(p.label=="baseline_regular_metadata"?"/bin/stat -L -c %s:%f:%u:%g:%a:%Y:%i ":"/usr/bin/sha256sum ")+p.path;
 }else if(p.label=="baseline_regular_octets_chunk"||p.label=="baseline_regular_octets_eof"){
  Require(p.pid==0&&Regular(p.path)&&p.offset<65536);
  if(p.label=="baseline_regular_octets_chunk")Require(p.count>0&&p.count<=4096&&p.count<=65536-p.offset);else Require(p.count==2);
  os="/usr/bin/hexdump -v -b -s "+std::to_string(p.offset)+" -n "+std::to_string(p.count)+" "+p.path+" 2>&1";
 }else if(p.label=="baseline_user_cmdline"||p.label=="baseline_user_environment"||p.label=="baseline_parent_cmdline"){
  Require(p.pid>1&&p.pid<=999999999&&p.path.empty()&&p.offset==0&&p.count==4097);
  os="/usr/bin/hexdump -v -b -n 4097 /proc/"+std::to_string(p.pid)+(p.label=="baseline_user_environment"?"/environ":"/cmdline")+" 2>&1";
 }else if(p.label=="baseline_kernel_cmdline"||p.label=="baseline_syscall_facts"||p.label=="baseline_syscall_probe_sha"||p.label=="baseline_pthread_sha256"){
  Require(p.pid==0&&p.path.empty()&&p.offset==0&&p.count==0);
  if(p.label=="baseline_kernel_cmdline")os="/bin/cat /proc/cmdline 2>&1";
  else if(p.label=="baseline_syscall_facts")os="/run/iq4_f1_baseline03/readfacts";
  else if(p.label=="baseline_pthread_sha256")os="/usr/bin/sha256sum /lib/libpthread-2.28.so";
  else os="/usr/bin/sha256sum /run/iq4_f1_baseline03/readfacts";
 }else{
  Require(p.pid>1&&p.pid<=999999999&&p.path.empty()&&p.offset==0&&p.count==0);
  std::string leaf;
  if(p.label=="baseline_user_stat"||p.label=="baseline_parent_stat")leaf="stat";
  else if(p.label=="baseline_user_status")leaf="status";
  else if(p.label=="baseline_user_maps")leaf="maps";
  else if(p.label=="baseline_user_mountinfo")leaf="mountinfo";
  else throw std::runtime_error("baseline_read_profile_not_whitelisted");
  os="/bin/cat /proc/"+std::to_string(p.pid)+"/"+leaf+" 2>&1";
 }
 IQ4Shell::Command c{p.label,"","IQ4B_"+p.nonce,"IQ4E_"+p.nonce};c.text="\"Sys printf "+c.begin+"; "+os+" && printf "+c.end+"\"";
 Require(c.text==p.text&&IQ4ShellInput::WithinSafeTextLength(c.text.size()));unsigned quotes=0,tokens=1;
 for(unsigned char b:c.text){Require(b>=32&&b<=126&&b!='='&&b!='\\');if(b=='"')++quotes;if(b==' ')++tokens;}Require(quotes==2&&tokens<40);return c;
}
}
