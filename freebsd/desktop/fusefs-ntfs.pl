#!/usr/bin/env perl

use strict;
use warnings;

system "pkg install -y fusefs-ntfs";
system "echo 'fuse_load=\"YES\"' >> /boot/loader.conf";
system "sysctl -w vfs.usermount=1";
