#include "fixed_profiles.hpp"
#include <cassert>
#include <fstream>
#include <iostream>
#include <iterator>
template<class F>void rejects(F f){bool yes=false;try{f();}catch(...){yes=true;}assert(yes);}
int main(int argc,char**argv){
 assert(argc==2);std::ifstream in(argv[1],std::ios::binary);assert(in.good());
 std::string data((std::istreambuf_iterator<char>(in)),{});auto p=IQ4F1Loader11::Parse(data);auto c=IQ4F1Loader11::Command(p);
 assert(c.text==p.text&&c.text.size()<=242);auto bad=p;bad.pid=2;rejects([&]{IQ4F1Loader11::Command(bad);});bad=p;bad.path="/etc/passwd";rejects([&]{IQ4F1Loader11::Command(bad);});bad=p;bad.label="loader11_arbitrary";rejects([&]{IQ4F1Loader11::Command(bad);});bad=p;bad.text+="; kill 1";rejects([&]{IQ4F1Loader11::Command(bad);});
 std::cout<<c.text<<'\n';
}
