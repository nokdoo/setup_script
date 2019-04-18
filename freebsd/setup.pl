#!/usr/env/bin perl

use strict;
use warnings;

system("pkg update -f");
system("pkg upgrade -f");

my $read;
my $write;
my @content;

open ( $read, '<', '/etc/pkg/FreeBSD.conf') or die;
for my $line ( <$read> ) {
	$line =~ s/pkg\.FreeBSD\.org/pkg0\.twn\.FreeBSD\.org/;
	push @content, $line;
}
close $read;

open ( $write, '>', '/etc/pkg/FreeBSD.conf') or die;
for ( @content ) {
	print $write $_;
} 
close $write;
undef @content;

system("echo 'allscreens_kbdflags=\"-b quiet.off\"' >> /etc/rc.conf");

system("pkg install -y sudo");
system("echo 'nokdoot ALL=(ALL) ALL' >> /usr/local/etc/sudoers");

system("pkg install -y xorg");
system("pkg install -y i3 i3lock i3status dmenu");
system("echo 'exec /usr/local/bin/i3' >> /usr/home/nokdoot/.xinitrc");
system("pkg install -y x11/slim");

system("mkdir -p /usr/home/nokdoot/.config/i3 && cp config /usr/home/nokdoot/.config/i3/");

open ( $read, '<', '/etc/ttys') or die;
for my $line ( <$read> ) {
	if ( $line =~ /^ttyv8/ ) {
		$line =~ s/xdm/slim/;
		$line =~ s/off/on/;
	}	
	push @content, $line;
}
close $read;

open ( $write, '>', '/etc/ttys') or die;
for ( @content ) {
	print $write $_;
}
close $write;
undef @content;


system("echo 'hald_enable=\"YES\"' >> /etc/rc.conf");
system("echo 'dbus_enable=\"YES\"' >> /etc/rc.conf");

system("pkg install -y bash");

system("pkg install -y ko-nanumcoding-ttf"); 
system("fc-cache");
system("pkg install -y xfce4-terminal");
system("pkg install -y uim uim-gtk3");

print "		open uim-pref-gtk3\n";
print "		chsh -s bash on nokdoot\n";
print "		reboot!!!!\n";
