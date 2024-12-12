#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(sum);

open my $fh, '<', '11/11.txt' or die $!;

while (<$fh>) {
  chomp;
  my @array = split ' ';
  my %items = map { $_ => 1 } @array;
  for my $i (1..75) {
    my %newItems;
    while (my ($key, $value) = each %items) {
      $key =~ s/^0+//;  # Remove leading zeros
      $key = 0 if $key eq '';
      if ($key == 0) {
        $newItems{1} += $value;
      } elsif (length($key) % 2 == 0) {
        my ($first, $second) = (substr($key, 0, length($key) / 2), substr($key, length($key) / 2));
        $newItems{$first} += $value;
        $newItems{$second} += $value;
      } else {
        $newItems{$key * 2024} += $value;
      }
    }
    %items = %newItems;
  }
  while (my ($key, $value) = each %items) {
    print "$key: $value\n";
  }
  print "Total sum: ", sum(values %items), "\n";
}