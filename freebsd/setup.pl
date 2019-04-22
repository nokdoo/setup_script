#!/usr/env/bin perl

use strict;
use warnings;

my $read;
my $write;
my @content;



# update/upgrade pkg
system("pkg update -f");
system("pkg upgrade -f");


# change the url of pkg repository 
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



# turn off beep sound
system("echo 'allscreens_kbdflags=\"-b quiet.off\"' >> /etc/rc.conf");



# install sudo and add nokdoot to sudo
system("pkg install -y sudo");
system("pw groupadd sudo");
system("echo '%sudo ALL=(ALL:ALL) ALL' >> /usr/local/etc/sudoers");
system("pw usermod nokdoot -G sudo");



# install xorg and i3
system("pkg install -y xorg");
system("echo 'hald_enable=\"YES\"' >> /etc/rc.conf");
system("echo 'dbus_enable=\"YES\"' >> /etc/rc.conf");

system("pkg install -y i3 i3lock i3status dmenu");
system("echo 'exec /usr/local/bin/i3' >> /usr/home/nokdoot/.xinitrc");
system("mkdir -p /usr/home/nokdoot/.config/i3 && cp config /usr/home/nokdoot/.config/i3/");
system("cp i3-new-workspace /usr/local/bin/");

=pod

# install slim(is deprecated by problem with login_conf and unmanaged display manager)
system("pkg install -y x11/slim");

# convert display manager from xdm to slim
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

=cut


# install bash 
system("pkg install -y bash");



# set locale
system("cp .login_conf /usr/home/nokdoot/");

# install nanum font
system("pkg install -y ko-nanumfonts-ttf"); 
system("fc-cache");

# install xfce4-terminal for hangul. xterm and uxterm do not support hangul
system("pkg install -y xfce4-terminal");

# install uim and uim manager
system("pkg install -y uim uim-gtk3");

print "		open uim-pref-gtk3\n";
print "		chsh -s bash on nokdoot\n";
print "		reboot!!!!\n";
