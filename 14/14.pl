#!/usr/bin/perl
use strict;
use warnings;

my $height = 103;
my $width = 101;

open my $fh, '<', '14/14.txt' or die $!;

sub displayRobots {
  my $robots_ref = $_[0];
  my @robots = @{$robots_ref};
  for my $robot (@robots) {
    my ($px, $py, $vx, $vy) = @$robot;
    print "px: $px, py: $py, vx: $vx, vy: $vy\n";
  }
}

sub moveRobots {
  my @robots = @{$_[0]};
  for my $robot (@robots) {
    my ($px, $py, $vx, $vy) = @$robot;
    $px += $vx;
    $py += $vy;
    if($px < 0){
      $px += $width;
    }
    if($px >= $width){
      $px -= $width;
    }
    if($py < 0){
      $py += $height;
    }
    if($py >= $height){
      $py -= $height;
    }
    @$robot = ($px, $py, $vx, $vy);
    $robot = [$px, $py, $vx, $vy];
  }
  return @robots;
}

sub safetyFactor {
  my @robots = @{$_[0]};
  my ($sf1, $sf2, $sf3, $sf4) = (0, 0, 0, 0);
  my $midx = ($width-1) / 2;
  my $midy = ($height-1) / 2;
  for my $robot (@robots) {
    my ($px, $py, $vx, $vy) = @$robot;
    if($px < $midx && $py < $midy){
      $sf1++;
    }
    if($px > $midx && $py < $midy){
      $sf2++;
    }
    if($px < $midx && $py > $midy){
      $sf3++;
    }
    if($px > $midx && $py > $midy){
      $sf4++;
    }
  }
  return $sf1*$sf2*$sf3*$sf4;
}

my @robots;

while (<$fh>) {
    chomp;
    my ($px, $py, $vx, $vy) = /p=(\d+),(\d+) v=(-?\d+),(-?\d+)/;
    push @robots, [$px, $py, $vx, $vy];
}

moveRobots(\@robots) for 1..100;
print safetyFactor(\@robots);
# displayRobots(\@robots);