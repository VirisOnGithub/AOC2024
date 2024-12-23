#!/usr/bin/perl
use strict;
use warnings;
use lib './18/';
use bfs qw(bfs);
use Clone qw(clone);

my $gridWidth = 71;

my @grid = map { [(1) x $gridWidth] } 1..$gridWidth;
my ($start_x, $start_y) = (0, 0);
my ($end_x, $end_y) = ($gridWidth-1, $gridWidth-1);

open my $fh, '<', '18/18.txt' or die "Cannot open file: $!";

while (<$fh>) {
    chomp;
    if(/(\d+),(\d+)/){
        $grid[$1][$2] = 0;
        my @clone = @{clone(\@grid)};
        if(bfs(\@clone, $start_x, $start_y, $end_x, $end_y) == -1){
            print "$1,$2\n";
            last;
        }
    }
}

# Display the grid

sub display {
    my @grid = @{$_[0]};
    for my $i (0..$gridWidth-1) {
        for my $j (0..$gridWidth-1) {
            print $grid[$i][$j] == 1 ? '.' : $grid[$i][$j] == 0 ? '#' : $grid[$i][$j] == 2 ? 'X' : '';
        }
        print "\n";
    }
}

sub printRaw {
    my @grid = @{$_[0]};
    for my $i (0..$gridWidth-1) {
        for my $j (0..$gridWidth-1) {
            print $grid[$i][$j];
        }
        print "\n";
    }
}