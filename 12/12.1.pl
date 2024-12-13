# DISCLAIMER : J'ai pas réussi à trouver



#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(time);
use List::Util qw(all);

open my $fh, '<', '12/12.txt' or die $!;

my @array;
while (<$fh>) {
  chomp;
  my @arr = split //;
  push @array, \@arr;
}
close $fh;

sub calcDifferentNeighbours {
  my ($i, $j, $array_ref) = @_;
  my @array = @$array_ref;

  my $val = $array[$i][$j];

  my @neighbours;

  # $neighbours++ if $i == 0 || $array[$i-1][$j] ne $val;
  # $neighbours++ if $i == $#array || $array[$i+1][$j] ne $val;
  # $neighbours++ if $j == 0 || $array[$i][$j-1] ne $val;
  # $neighbours++ if $j == $#{$array[$i]} || $array[$i][$j+1] ne $val;

  push @neighbours, [$i-1,$j] if $i ==0 || $array[$i-1][$j] ne $val;
  push @neighbours, [$i+1,$j] if $i == $#array || $array[$i+1][$j] ne $val;
  push @neighbours, [$i,$j-1] if $j == 0 || $array[$i][$j-1] ne $val;
  push @neighbours, [$i,$j+1] if $j == $#{$array[$i]} || $array[$i][$j+1] ne $val;

  return @neighbours;
}

sub calcSameNeighbours {
  my ($i, $j, $array_ref) = @_;
  my @array = @$array_ref;

  my $val = $array[$i][$j];

  my @neighbours;

  push @neighbours, [$i-1,$j] if $i != 0 && $array[$i-1][$j] eq $val;
  push @neighbours, [$i+1,$j] if $i != $#array && $array[$i+1][$j] eq $val;
  push @neighbours, [$i,$j-1] if $j != 0 && $array[$i][$j-1] eq $val;
  push @neighbours, [$i,$j+1] if $j != $#{$array[$i]} && $array[$i][$j+1] eq $val;
}
sub isInGrid {
  my ($i, $j, $array_ref) = @_;
  my @array = @$array_ref;

  return ($i < 0 || $i > $#array || $j < 0 || $j > $#{$array[$i]}) ? 0 : 1;
}

sub calcAreaAndPerimeter {
  my ($i, $j, $array_ref, $area_ref, $visited_ref, $nbWall_ref) = @_;
  my @array = @$array_ref;

  my $val = $array[$i][$j];

  # Different Neighbours

  my @diffNeighbours = calcDifferentNeighbours($i, $j, $array_ref);
  my $lengthDifferentNeighbours = scalar @diffNeighbours;

  if($lengthDifferentNeighbours == 4) {
    $$nbWall_ref += 4;
  } elsif ($lengthDifferentNeighbours == 3) {
    $$nbWall_ref += 2;
  } elsif ($lengthDifferentNeighbours == 2) {
    if($diffNeighbours[0]->[0] != $diffNeighbours[1]->[0] && $diffNeighbours[0]->[1] != $diffNeighbours[1]->[1]) {
      $$nbWall_ref += 1;
    }
  }

  my @diags = ([1,1],[-1,-1],[1,-1],[-1,1]);
  foreach my $diag (@diags){
    my $a = [$i + $diag->[0], $j];
    my $b = [$i, $j + $diag->[1]];
    if(
      all {isInGrid($_->[0], $_->[1], \@array) 
      && $array[$_->[0]][$_->[1]] eq $val} ($a, $b) 
      && $array[$i + $diag->[0]][$j + $diag->[1]] ne $val
    ) {
      $$nbWall_ref += 1;
    }
  }

  return if $visited_ref->{"$i $j"};

  $$area_ref++;
  $visited_ref->{"$i $j"} = 1;

  # Same Neighbours
  my @sameNeighbours = calcSameNeighbours($i, $j, $array_ref);
  foreach my $neighbour (@sameNeighbours) {
    calcAreaAndPerimeter($neighbour->[0], $neighbour->[1], $array_ref, $area_ref, $visited_ref, $nbWall_ref);
  }
}

my $res = 0;
my %visited;
my $time = time;

for my $i (0..$#array) {
  for my $j (0..$#{$array[$i]}) {
    next if exists $visited{"$i $j"};
    my $area = 0;
    my $nbWall = 0;
    calcAreaAndPerimeter($i, $j, \@array, \$area, \%visited, \$nbWall);
    $res += $area * $nbWall;
  }
}

print time - $time, "\n";
print "$res\n";
