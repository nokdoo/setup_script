#!/usr/bin/env perl

use strict;
use warnings;

system "pkg install -y nvidia-driver";

# nvidia-modeset is only available for driver versions >= 358.009
system "sysrc kld_list+=\"nvidia-modeset\"";

system "mkdir -p /usr/local/etc/X11/xorg.conf.d";

system "cp driver-nvidia.conf /usr/local/etc/X11/xorg.conf.d/";

print "		reboot!!\n";

