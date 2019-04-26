#!/usr/env/bin perl

use strict;
use warnings;

system "pkg install -y virtualbox-ose";
system "echo 'vboxdrv_load=\"YES\"' >> /boot/loader.conf";
system "echo 'vboxnet_enable=\"YES\"' >> /etc/rc.conf";
system "pw groupmod vboxusers -m nokdoot";
system "chown root:vboxusers /dev/vboxnetctl";
system "chmod 0660 /dev/vboxnetctl";
system "echo 'own	vboxnetctl	root:vboxusers' >> /etc/devfs.conf";
system "echo 'perm	vboxnetctl	0660' >> /etc/devfs.conf";

print "        virtualbox-ose-additions 도 추가로 깔고 이후에 나오는 메세지 확인하기 (wheel 을 꼭 넣어야 하는건가)";
