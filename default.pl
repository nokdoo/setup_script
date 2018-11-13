#!/usr/bin/env perl

use strict;
use warnings;

# shell
sub shell{
	my $shell = `echo \$SHELL`;
	return $shell;
}

my $bash_regex = qr/.*\/bash$/;
sub setupBash{
	print "=====";
	my $shell = shell();
	return if($shell =~ $bash_regex);


	my $bash = findBash();
	
	if($bash !~ $bash_regex){
		system "./pkg install -y bash";
	}
	$bash = findBash();
	
	die "===== setupShell \$bash is not bash =====\n" unless ($bash =~ $bash_regex);
	system "chsh -s $bash";
	die "===== reboot to apply bash shell, and re-run this program =====\n";

	# ==bash==
	# You must find the .bashrc file or etc. 
	# and set the base commands like ll, ls ....

}

sub findBash{
	my $shells = `cat /etc/shells`;
	my $bash;
	foreach $_ (split ('\n', $shells)){
		if($_ =~ $bash_regex){
			$bash = $_;
			last;
		}
	}
	return $bash;
}
# Before you remove thie comment sign, you must complete part of '==bash=='. find this keyword on this script.
# setupBash();

system("chmod 755 pkg");

system("chmod 755 setrc");

# git
system "./pkg install -y git";

# wget
system "./pkg install -y wget";

