#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(time);

open my $fh, '<', '12/12.txt' or die $!;

my @array;
while (<$fh>) {
  chomp;
  my @arr = split //;
  push @array, \@arr;
}
close $fh;

sub calcAreaAndPerimeter {
  my ($i, $j, $array_ref, $area_ref, $perimeter_ref, $visited_ref) = @_;
  my @array = @$array_ref;

  my $val = $array[$i][$j];

  return if $visited_ref->{"$i $j"};

  $$area_ref++;
  $visited_ref->{"$i $j"} = 1;

  if ($i == 0 || $array[$i-1][$j] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter($i-1, $j, $array_ref, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($i == $#array || $array[$i+1][$j] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter($i+1, $j, $array_ref, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($j == 0 || $array[$i][$j-1] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter($i, $j-1, $array_ref, $area_ref, $perimeter_ref, $visited_ref);
  }
  if ($j == $#{$array[$i]} || $array[$i][$j+1] ne $val) {
    $$perimeter_ref++;
  } else {
    calcAreaAndPerimeter($i, $j+1, $array_ref, $area_ref, $perimeter_ref, $visited_ref);
  }
}

my $res = 0;
my %visited;
my $time = time;

for my $i (0..$#array) {
  for my $j (0..$#{$array[$i]}) {
    next if exists $visited{"$i $j"};
    my $area = 0;
    my $perimeter = 0;
    calcAreaAndPerimeter($i, $j, \@array, \$area, \$perimeter, \%visited);
    $res += $area * $perimeter;
  }
}

print time - $time, "\n";
print "$res\n";
