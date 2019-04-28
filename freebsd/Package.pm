package Pkg {

use strict;
use warnings;

    my $read;
    my $write;
    my @content;

    # update/upgrade pkg
    sub update_pkg {
        system("pkg update -f");
        system("pkg upgrade -f");
    }

    # change the url of pkg repository
    sub change_repo {
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
    }

}

