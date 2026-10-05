#pragma once
#include "../../sdk/shell_guard_242/profiles_stage2.hpp"
// A new finite renderer. No fallback to arbitrary commands, paths or PIDs.
namespace IQ4F1Loader11 {
using Plan=IQ4Stage2::Plan;
inline Plan Parse(std::string const&data){return IQ4Stage2::Parse(data);}
inline std::string Flag(std::string const&label){
 if(label=="loader11_preflight")return "--preflight";
 if(label=="loader11_entry_read")return "--entry-read";
 if(label=="loader11_hook_read")return "--hook-read";
 if(label=="loader11_stage_ui_marker")return "--stage-ui-marker";
 if(label=="loader11_stage_launcher")return "--stage-launcher";
 if(label=="loader11_arm")return "--arm";
 if(label=="loader11_disable")return "--disable";
 if(label=="loader11_hook_install")return "--hook-install";
 if(label=="loader11_hook_restore")return "--hook-restore";
 throw std::runtime_error("loader11_profile_not_whitelisted");
}
inline IQ4Shell::Command Command(Plan const&p){
 using IQ4Shell::Require;
 Require(p.userSha==IQ4Stage2::UserSha()&&p.pid==0&&p.path.empty()&&p.offset==0&&p.count==0);
 Require(p.nonce.size()>=8&&p.nonce.size()<=12);for(char c:p.nonce)Require((c>='0'&&c<='9')||(c>='a'&&c<='f'));
 IQ4Shell::Command c{p.label,"","IQ4B_"+p.nonce,"IQ4E_"+p.nonce};
 c.text="\"Sys printf "+c.begin+"; /run/iq4_f1_observe02/entrytool "+Flag(p.label)+" 2>&1 && printf "+c.end+"\"";
 Require(c.text==p.text&&IQ4ShellInput::WithinSafeTextLength(c.text.size()));
 unsigned quotes=0,tokens=1;for(unsigned char b:c.text){Require(b>=32&&b<=126&&b!='='&&b!='\\');if(b=='"')++quotes;if(b==' ')++tokens;}
 Require(quotes==2&&tokens<40);return c;
}
}
