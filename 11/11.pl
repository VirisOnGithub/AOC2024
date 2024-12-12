#!/usr/bin/perl
use strict;
use warnings;

open my $fh, '<', '11/11test.txt' or die $!;

sub log10 {
  my $n = shift;
  return log($n) / log(10);
}

sub calcStones {
  my @array = @{$_[0]};
  my @newAr;
  for my $item (@array) {
    if ($item == 0) {
      push @newAr, 1;
    } else {
      my $log10_item = log10($item);
      if (int($log10_item) % 2 == 1) {
        my $nb = int($log10_item) + 1;
        my $first = int($item / (10 ** ($nb / 2)));
        my $second = $item % (10 ** ($nb / 2));
        push @newAr, ($first, $second);
      } else {
        push @newAr, $item * 2024;
      }
    }
  }
  return \@newAr;
}

while (<$fh>) {
  chomp;
  my @array = split;
  for my $i (1..25) {
    # print $i, "\n";
    @array = @{calcStones(\@array)};
  }
  print scalar @array, "\n";
}