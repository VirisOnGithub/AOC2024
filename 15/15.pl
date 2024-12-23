#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '15/15.txt' or die $!;

my @grid;

sub display {
  my @grid = @{$_[0]};
  foreach my $row (@grid){
    print join '', @$row;
    print "\n";
  }
}

sub findRobot {
  my @grid = @{$_[0]};
  my $robot;
  for (my $i = 0; $i < @grid; $i++){
    for (my $j = 0; $j < @{$grid[$i]}; $j++){
      if ($grid[$i][$j] eq '@'){
        $robot = [$i, $j];
      }
    }
  }
  return $robot;
}

sub move {
  my ($char, $g, $iref, $jref) = @_;
  my @grid = @$g;
  my $i = $$iref;
  my $j = $$jref;

  if ($char eq '^') {
    if ($grid[$i-1][$j] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $i--;
      $grid[$i][$j] = '@';
    } elsif ($grid[$i-1][$j] eq 'O') {
      my $k = $i - 1;
      while ($k > 0 && $grid[$k][$j] eq 'O') {
        $k--;
      }
      if ($grid[$k][$j] eq '.') {
        for (my $m = $k; $m < $i; $m++) {
          $grid[$m][$j] = 'O';
        }
        $grid[$i][$j] = '.';
        $i--;
        $grid[$i][$j] = '@';
      }
    }
  }

  if ($char eq 'v') {
    if ($grid[$i+1][$j] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $i++;
      $grid[$i][$j] = '@';
    } elsif ($grid[$i+1][$j] eq 'O') {
      my $k = $i + 1;
      while ($k < @grid - 1 && $grid[$k][$j] eq 'O') {
        $k++;
      }
      if ($grid[$k][$j] eq '.') {
        for (my $m = $k; $m > $i; $m--) {
          $grid[$m][$j] = 'O';
        }
        $grid[$i][$j] = '.';
        $i++;
        $grid[$i][$j] = '@';
      }
    }
  }

  if ($char eq '<') {
    if ($grid[$i][$j-1] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $j--;
      $grid[$i][$j] = '@';
    } elsif ($grid[$i][$j-1] eq 'O') {
      my $k = $j - 1;
      while ($k > 0 && $grid[$i][$k] eq 'O') {
        $k--;
      }
      if ($grid[$i][$k] eq '.') {
        for (my $m = $k; $m < $j; $m++) {
          $grid[$i][$m] = 'O';
        }
        $grid[$i][$j] = '.';
        $j--;
        $grid[$i][$j] = '@';
      }
    }
  }

  if ($char eq '>') {
    if ($grid[$i][$j+1] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $j++;
      $grid[$i][$j] = '@';
    } elsif ($grid[$i][$j+1] eq 'O') {
      my $k = $j + 1;
      while ($k < @{$grid[$i]} - 1 && $grid[$i][$k] eq 'O') {
        $k++;
      }
      if ($grid[$i][$k] eq '.') {
        for (my $m = $k; $m > $j; $m--) {
          $grid[$i][$m] = 'O';
        }
        $grid[$i][$j] = '.';
        $j++;
        $grid[$i][$j] = '@';
      }
    }
  }

  $$iref = $i;
  $$jref = $j;
  @$g = @grid;
}
# Remplit la grid
while (<$fh>){
  chomp;
  last if $_ eq "";
  push @grid, [split //];
}
my ($i , $j) = @{findRobot(\@grid)};

# Remplit les instructions
while (<$fh>){
  chomp;
  foreach my $char (split //){
    move($char, \@grid, \$i, \$j);
  }
}

# display(\@grid);

sub calculateGPS {
  my @grid = @{$_[0]};
  my $gps = 0;
  for (my $i = 0; $i < @grid; $i++){
    for (my $j = 0; $j < @{$grid[$i]}; $j++){
      if ($grid[$i][$j] eq 'O'){
        $gps += $i*100 + $j;
      }
    }
  }
  print "GPS: $gps\n";
}

calculateGPS(\@grid);