#!/usr/bin/perl
use strict;
use warnings;

sub touch {
    my $file = shift;
    open my $fh, '>', $file or die $!;
    close $fh;
}

for my $i (1..25) {
    if(!(-d "$i")){
        mkdir "$i";
        touch "$i/$i.txt";
        touch "$i/${i}test.txt";
        touch "$i/$i.pl";
        touch "$i/$i.1.pl";
    }
}

