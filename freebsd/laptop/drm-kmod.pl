#!/usr/bin/env perl

use strict;
use warnings;

system "pkg install -y drm-kmod";

system "sysrc kld_list+=\"/boot/modules/i915kms.ko\"";

system "pw groupmod video -m nokdoot";

print "		reboot!!\n";

