#!/usr/bin/env perl

use strict;
use warnings;

my $shell = `echo \$SHELL`;
print $shell if ($shell =~ qr/csh/);
