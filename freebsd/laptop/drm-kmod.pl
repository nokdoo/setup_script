#!/usr/bin/env perl

use strict;
use warnings;

system "pkg install -y drm-kmod";

system "echo 'kld_list=\"/boot/modules/i915kms.ko\"' >> /etc/rc.conf";

system "pw usermod nokdoot -G video";

print "		reboot!!\n";

