#!/usr/bin/env perl

use strict;

use warnings;

my $link = 'https://github.com/vim/vim.git';

my $clone = system("git clone https://github.com/vim/vim.git");
chdir "vim";
system("make");
system("make install");
system("make install clean");
chdir "../";
system("rm -r vim");

# aliasing
my $shell = `echo \$SHELL`;
if($shell =~ qr/csh/){
	system "./setrc alias vi vim";
}elsif($shell =~ qr/bash/){
    system "./setrc alias vi='vim'";
}

# xclip
system("./xclip");

# .vimrc
system("cp .vimrc $ENV{HOME}");
