#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw( sum );

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
    my %nines;

    findNext( 0, [ $i, $j ], \@tab, \%nines );

    return scalar keys %nines;
}

sub findNext {
    my $nb = $_[0];
    my ( $i, $j ) = @{ $_[1] };
    my @tab = @{ $_[2] };
    my $nines_ref = $_[3];

    if($nb == 9) {
      $nines_ref->{$i.",".$j} = 1;
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
  print sum( map { findHikingPathScore($_, \@tab) } findZeros(\@tab) );
}

main();