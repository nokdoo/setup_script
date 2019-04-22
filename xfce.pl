#!/usr/bin/env perl

use warnings;
use strict;

system("./pkg install -y xorg xfce");

open(my $rc, ">>", "/etc/rc.conf");
print $rc "dbus_enable=\"YES\"";
close($rc);

system("echo \". /usr/local/etc/xdg/xfce4/xinitrc\" > ~/.xinitrc");
system("echo \". /usr/local/etc/xdg/xfce4/xinitrc\" > ~/.xsession");
