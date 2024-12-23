#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '19/19.txt' or die "Cannot open file: $!";

my @patterns;

while (<$fh>) {
    chomp;
    last if $_ eq '';
    @patterns = split /, /, $_;
}

my $regex = "^(" . join('|', @patterns) . ")+\$";

my $count = 0;

while (<$fh>) {
    chomp;
    $count++ if /$regex/;
}

print $count;