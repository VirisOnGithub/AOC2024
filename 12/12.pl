#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '12/12.txt' or die $!;

my @array;
while (<$fh>) {
  chomp;
  my @arr = split //;
  push @array, \@arr;
}

sub calcAreaAndPerimeter {
  my ($i, $j) = @{$_[0]};
  my @array = @{$_[1]};
  my $area_ref = $_[2];
  my $perimeter_ref = $_[3];
  my $visited_ref = $_[4];

  my $val = $array[$i][$j];

  if ($visited_ref->{"$i $j"}) {
    return 0;
  }

  $$area_ref++;
  $visited_ref->{"$i $j"} = 1;

  if ($i == 0 || $array[$i-1][$j] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter([$i-1, $j], \@array, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($i == $#array || $array[$i+1][$j] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter([$i+1, $j], \@array, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($j == 0 || $array[$i][$j-1] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter([$i, $j-1], \@array, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($j == $#{$array[$i]} || $array[$i][$j+1] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter([$i, $j+1], \@array, $area_ref, $perimeter_ref, $visited_ref);
  }

  return 0;
}

my $res=0;

my %visited;
for my $i (0..$#array) {
  for my $j (0..$#{$array[$i]}) {
    my $val = $array[$i][$j];
    my $area = 0;
    my $perimeter = 0;
    if(exists $visited{"$i $j"}) {
      next;
    }
    calcAreaAndPerimeter([$i, $j], \@array, \$area, \$perimeter, \%visited);
    $res += $area * $perimeter;
  }
}

print "$res\n";