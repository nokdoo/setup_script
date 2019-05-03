#!/usr/bin/env perl

use stirct;
use warnings;

system "sysrc wlans_iwm0=wlan0";
system "sysrc ifconfig_wlan0=WPA";
system "sysrc ifconfig_wlan0+=DHCP";

system "echo 'network={' >> /etc/wpa_supplicant.conf";
system "echo '    ssid=\"wifiname\"' >> /etc/wpa_supplicant.conf";
system "echo '    psk=\"password\"' >> /etc/wpa_supplicant.conf";
system "echo '}' >> /etc/wpa_supplicant.conf";

system "service netif restart";
