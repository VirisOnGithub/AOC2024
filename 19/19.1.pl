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

my $res = 0;

while (<$fh>) {
    chomp;
    my @count = (0) x (length($_) + 1);

    foreach my $pattern (@patterns) {
        if(index($_, $pattern) == 0){
            $count[length($pattern)]++;
        }
    }

    for my $i (0 .. $#count) {
        if ($count[$i] > 0) {
            foreach my $pattern (@patterns) {
                if (index($_, $pattern, $i) == $i) {
                    $count[$i + length($pattern)] += $count[$i];
                }
            }
        }
    }

    $res += $count[-1];
}

print $res;