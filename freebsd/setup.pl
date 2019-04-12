#!/usr/env/bin perl

use strict;
use warnings;

system("echo 'allscreens_kbdflags=\"-b quiet.off\"' >> /etc/rc.conf");

system("pkg install -y sudo");

system("pkg install -y xorg");

system("pkg install -y i3 i3lock i3status dmenu");

system("echo 'exec /usr/local/bin/i3' >> /usr/home/nokdoot/.xinitrc");
system("pkg install -y x11/slim");

system("echo 'hald_enable=\"YES\"' >> /etc/rc.conf");
system("echo 'dbus_enable=\"YES\"' >> /etc/rc.conf");

print "     Check visudo\n";
print "     Check /etc/ttys off->on\n";
