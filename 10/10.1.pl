#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw( sum );
use Time::HiRes qw( time );

open my $fh, '<', '10/10.txt' or die $!;

my @tab;

while (<$fh>) {
    chomp;
    my @fields = split //;
    push @tab, \@fields;
}

sub findZeros {
    my @tab = @{ $_[0] };
    my @zeros;
    for my $i ( 0 .. $#tab ) {
        for my $j ( 0 .. $#{ $tab[$i] } ) {
            if ( $tab[$i][$j] == "0" ) {
                push @zeros, [ $i, $j ];
            }
        }
    }
    return @zeros;
}

sub findHikingPathScore {
    my ( $i, $j ) = @{ $_[0] };
    my @tab = @{ $_[1] };
    my $nines = 0;

    findNext( 0, [ $i, $j ], \@tab, \$nines );

    return $nines;
}

sub findNext {
    my $nb = $_[0];
    my ( $i, $j ) = @{ $_[1] };
    my @tab = @{ $_[2] };
    my $nines_ref = $_[3];

    if($nb == 9) {
      $$nines_ref++;
    }

    my @res;

    if ( $i > 0 && $tab[ $i - 1 ][$j] == $nb + 1 ) {
        findNext( $nb + 1, [ $i - 1, $j ], \@tab, $nines_ref );
    }
    if ( $i < $#tab && $tab[ $i + 1 ][$j] == $nb + 1 ) {
        findNext( $nb + 1, [ $i + 1, $j ], \@tab, $nines_ref );
    }
    if ( $j > 0 && $tab[$i][ $j - 1 ] == $nb + 1 ) {
        findNext( $nb + 1, [ $i, $j - 1 ], \@tab, $nines_ref );
    }
    if ( $j < $#{ $tab[$i] } && $tab[$i][ $j + 1 ] == $nb + 1 ) {
        findNext( $nb + 1, [ $i, $j + 1 ], \@tab, $nines_ref );
    }
}

sub main {
  my $time0 = time();
  print sum( map { findHikingPathScore($_, \@tab) } findZeros(\@tab) );
  my $time1 = time();
  printf("\nExecution time: %.5f\n", $time1 - $time0);
}

main();