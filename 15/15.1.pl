#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '15/15test.txt' or die $!;

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
    if ($grid[$i-2][$j] eq '.' && $grid[$i-2][$j+1] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $grid[$i][$j+1] = '.';
      $i -= 2;
      $grid[$i][$j] = '@';
      $grid[$i][$j+1] = '.';
    } elsif ($grid[$i-2][$j] eq '[' && $grid[$i-2][$j+1] eq ']') {
      my $k = $i - 2;
      while ($k > 0 && $grid[$k][$j] eq '[' && $grid[$k][$j+1] eq ']') {
        $k -= 2;
      }
      if ($grid[$k][$j] eq '.' && $grid[$k][$j+1] eq '.') {
        for (my $m = $k; $m < $i; $m += 2) {
          $grid[$m][$j] = '[';
          $grid[$m][$j+1] = ']';
        }
        $grid[$i][$j] = '.';
        $grid[$i][$j+1] = '.';
        $i -= 2;
        $grid[$i][$j] = '@';
        $grid[$i][$j+1] = '.';
      }
    }
  }

  if ($char eq 'v') {
    if ($grid[$i+2][$j] eq '.' && $grid[$i+2][$j+1] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $grid[$i][$j+1] = '.';
      $i += 2;
      $grid[$i][$j] = '@';
      $grid[$i][$j+1] = '.';
    } elsif ($grid[$i+2][$j] eq '[' && $grid[$i+2][$j+1] eq ']') {
      my $k = $i + 2;
      while ($k < @grid - 1 && $grid[$k][$j] eq '[' && $grid[$k][$j+1] eq ']') {
        $k += 2;
      }
      if ($grid[$k][$j] eq '.' && $grid[$k][$j+1] eq '.') {
        for (my $m = $k; $m > $i; $m -= 2) {
          $grid[$m][$j] = '[';
          $grid[$m][$j+1] = ']';
        }
        $grid[$i][$j] = '.';
        $grid[$i][$j+1] = '.';
        $i += 2;
        $grid[$i][$j] = '@';
        $grid[$i][$j+1] = '.';
      }
    }
  }

  if ($char eq '<') {
    if ($grid[$i][$j-2] eq '.' && $grid[$i][$j-1] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $grid[$i][$j+1] = '.';
      $j -= 2;
      $grid[$i][$j] = '@';
      $grid[$i][$j+1] = '.';
    } elsif ($grid[$i][$j-2] eq '[' && $grid[$i][$j-1] eq ']') {
      my $k = $j - 2;
      while ($k > 0 && $grid[$i][$k] eq '[' && $grid[$i][$k+1] eq ']') {
        $k -= 2;
      }
      if ($grid[$i][$k] eq '.' && $grid[$i][$k+1] eq '.') {
        for (my $m = $k; $m < $j; $m += 2) {
          $grid[$i][$m] = '[';
          $grid[$i][$m+1] = ']';
        }
        $grid[$i][$j] = '.';
        $grid[$i][$j+1] = '.';
        $j -= 2;
        $grid[$i][$j] = '@';
        $grid[$i][$j+1] = '.';
      }
    }
  }

  if ($char eq '>') {
    if ($grid[$i][$j+2] eq '.' && $grid[$i][$j+3] eq '.') {
      $grid[$i][$j] = '.';  # Clear current position
      $grid[$i][$j+1] = '.';
      $j += 2;
      $grid[$i][$j] = '@';
      $grid[$i][$j+1] = '.';
    } elsif ($grid[$i][$j+2] eq '[' && $grid[$i][$j+3] eq ']') {
      my $k = $j + 2;
      while ($k < @{$grid[$i]} - 1 && $grid[$i][$k] eq '[' && $grid[$i][$k+1] eq ']') {
        $k += 2;
      }
      if ($grid[$i][$k] eq '.' && $grid[$i][$k+1] eq '.') {
        for (my $m = $k; $m > $j; $m -= 2) {
          $grid[$i][$m] = '[';
          $grid[$i][$m+1] = ']';
        }
        $grid[$i][$j] = '.';
        $grid[$i][$j+1] = '.';
        $j += 2;
        $grid[$i][$j] = '@';
        $grid[$i][$j+1] = '.';
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

my $expanded_grid = expand_map(\@grid);
display($expanded_grid);

# Remplit les instructions
while (<$fh>){
  chomp;
  foreach my $char (split //){
    move($char, $expanded_grid, \$i, \$j);
  }
}
display($expanded_grid);
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

sub expand_map {
  my @grid = @{$_[0]};
  my @new_grid;

  foreach my $row (@grid) {
    my @new_row;
    foreach my $tile (@$row) {
      if ($tile eq '#') {
        push @new_row, '##';
      } elsif ($tile eq 'O') {
        push @new_row, '[]';
      } elsif ($tile eq '.') {
        push @new_row, '..';
      } elsif ($tile eq '@') {
        push @new_row, '@.';
      }
    }
    push @new_grid, [split //, join '', @new_row];
  }

  return \@new_grid;
}

# calculateGPS($expanded_grid);