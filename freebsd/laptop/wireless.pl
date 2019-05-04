#!/usr/bin/env perl

use stirct;
use warnings;

system "sysrc wlans_iwm0=wlan0";
system "sysrc ifconfig_wlan0=WPA";
system "sysrc ifconfig_wlan0+=DHCP";

system "cp wpa_supplicant.conf /etc/";

print "        service netif restart";
