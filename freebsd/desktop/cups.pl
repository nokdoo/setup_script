#!/usr/bin/env perl

use strict;
use warnings;

my $write;

system "pkg install -y cups";

open ($write, '>>', '/etc/devfs.rules') or die "Can't open file";
while (<DATA>){
    print $write $_;
}

=pod

/etc/devfs.rules
X.Y.Z 의 내용은 
dmesg | grep Samsung
을 입력했을 때 나오는 ugenX.Y.Z
로 각각 바꿔주자 Z가 없다면 생략

=cut

system "echo 'cupsd_enable=\"YES\"' >> /etc/rc.conf";
system "sysrc devfs_system_ruleset+=system";

system "/etc/rc.d/devfs restart";
system "/usr/local/etc/rc.d/cupsd restart";

print "\n\n";
print "        read cups.pl\n\n\n";

__DATA__
[system=10]
add path 'unlpt*' mode 0660 group cups
add path 'ulpt*' mode 0660 group cups
add path 'lpt*' mode 0660 group cups
add path 'usb/X.Y.Z' mode 0660 group cups
