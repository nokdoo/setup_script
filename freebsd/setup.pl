#!/usr/env/bin perl

use strict;
use warnings;

system("echo 'allscreens_kbdflags=\"-b quiet.off\"' >> /etc/rc.conf");

system("pkg install -y sudo");
system("echo 'nokdoot ALL=(ALL) ALL' >> /etc/sudoers");

system("pkg install -y xorg");

system("pkg install -y i3 i3lock i3status dmenu");

system("echo '/usr/local/bin/i3' >> /usr/home/nokdoot/.xinitrc");

system("echo 'hald_enable=\"YES\"' >> /etc/rc.conf");
system("echo 'dbus_enable=\"YES\"' >> /etc/rc.conf");
