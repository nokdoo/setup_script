#!/usr/bin/env perl

my $location = `which redshift`;

exec `../pkg install -y redshift` unless ($location);

print <DATA>;

__DATA__
Set the value of Exec to 'redshift-gtk -t 4600:4600 -b 1.0:0.9' of file '.config/autostart/redshift-gtk.desktop'
