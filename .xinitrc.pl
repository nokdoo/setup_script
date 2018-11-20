#!/usr/bin/env perl

use strict;
use warnings;

system("echo \". /usr/local/etc/xdg/xfce4/xinitrc\" > ~/.xinitrc");
system("echo \". /usr/local/etc/xdg/xfce4/xinitrc\" > ~/.xsession");
