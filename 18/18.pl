#!/usr/bin/perl
use strict;
use warnings;
use lib './18/';
use bfs qw(bfs);

my $gridWidth = 7;

# Define a 7x7 grid full of ones
my @grid = map { [(1) x $gridWidth] } 1..$gridWidth;

my $nbIterations = 2;

open my $fh, '<', '18/18test.txt' or die "Cannot open file: $!";

while (<$fh>) {
    chomp;
    if(/(\d+),(\d+)/){
        $grid[$1][$2] = 0;
    }
    $nbIterations--;
    last if $nbIterations == 0;
}

# Define start and end points
my ($start_x, $start_y) = (0, 0);
my ($end_x, $end_y) = ($gridWidth-1, $gridWidth-1);

# Find the shortest path
my $shortest_path = bfs(\@grid, $start_x, $start_y, $end_x, $end_y);
print "The shortest path length is: $shortest_path\n";

# Display the grid

for my $i (0..$gridWidth-1) {
    for my $j (0..$gridWidth-1) {
        print $grid[$i][$j] == 1 ? '.' : $grid[$i][$j] == 0 ? '#' : $grid[$i][$j] == 2 ? 'X' : '';
    }
    print "\n";
}