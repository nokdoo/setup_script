#!/usr/bin/env perl

use warnings;
use strict;

system("./pkg install -y xorg xfce");

open(my $rc, ">>", "/etc/rc.conf");
print $rc "dbus_enable=\"YES\"";
close($rc);
