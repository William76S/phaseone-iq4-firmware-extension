#include "provider.hpp"
#include <cstdio>
int main(){std::printf("[%zu,%zu,%zu,%zu,%zu,%zu,%zu,%zu]\n",sizeof(iq4::f1::normal08::PublishedIngress),sizeof(iq4::f1::normal08::IngressStatus),sizeof(iq4::f1::normal08::WriteFacts),sizeof(iq4::f1::normal08::Geometry),offsetof(iq4::f1::normal08::PublishedIngress,metadata),offsetof(iq4::f1::normal08::IngressStatus,last),sizeof(iq4::f1::normal08::ScalerCapture),offsetof(iq4::f1::normal08::ScalerCapture,arguments));}
