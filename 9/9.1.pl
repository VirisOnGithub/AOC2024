use strict;
use warnings;
use List::Util qw( max sum );
# use lib '9';
# use Block;

open my $fh, '<', '9/9.txt' or die $!;

while ( my $line = <$fh> ) {
  chomp $line;
  my @tabLine = split //, $line;
  my @spaces;
  my %file_sizes;
  my $file_id = 0;

  # Construction de la liste

  for ( my $i = 0 ; $i < scalar @tabLine ; $i += 2 ) {
    my $size = $tabLine[$i];
    $file_sizes{$file_id} = $size;
    # insertion des chiffres
    for ( my $j = 0 ; $j < $size ; $j++ ) {
      push @spaces, $file_id;
    }
    # insertion des points
    $file_id++;
    if ( $i + 1 < scalar @tabLine ) {
      push @spaces, (-1) x $tabLine[ $i + 1 ];
    }
  }

  for (my $curId = max(keys %file_sizes) ; $curId >= 0 ; $curId-- ) {
    if( $file_sizes{$curId} == 0) {
      next;
    }
    my $curSize = $file_sizes{$curId};

    my $file_start = -1;
    for my $i ( 0 .. $#spaces ) {
      if( $spaces[$i] == $curId ) {
        $file_start = $i;
        last;
      }
    }

    my $space_count = 0;
    my $best_pos = -1;
    for my $i ( 0 .. $#spaces ) {
      if( $spaces[$i] == -1 ) {
        $space_count++;
        if ($space_count >= $curSize) {
          $best_pos = $i - $curSize + 1;
          last;
        }
      }
      else {
        $space_count = 0;
      }
    }

    if( $best_pos != -1 && $best_pos < $file_start ) {

      # On efface les chiffres à l'ancienne position
      for my $i ( $file_start .. $file_start + $curSize - 1 ) {
        $spaces[$i] = -1;
      }

      # On insère les chiffres à la nouvelle position
      for my $i ( $best_pos .. $best_pos + $curSize - 1 ) {
        $spaces[$i] = $curId;
      }
    }
  }

  # On affiche le résultat
  # for my $i ( 0 .. $#spaces ) {
  #   print $spaces[$i] >= 0 ? $spaces[$i] : '.';
  # }
  # print "\n";

  # On calcule la checksum


  my $checksum = sum( map { $spaces[$_] >= 0 ? $_ * $spaces[$_] : 0 } 0 .. scalar @spaces - 1 );
  print "Checksum: $checksum\n";
}
