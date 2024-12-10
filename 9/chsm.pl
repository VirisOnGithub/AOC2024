use strict;
use warnings;
use List::Util qw(sum);

my $line = "00992111777.44.333....5555.6666.....8888..";

my @tabLine = split //, $line;

my $res = 0;

for ( my $i = 0 ; $i < scalar @tabLine ; $i ++ ) {
  my $nb = $tabLine[$i];
  if ($nb ne '.') {
    $res += $nb*$i;
  }
}

print $res, "\n";

print sum( map { $_ ne '.' ? $_ * $tabLine[$_] : 0 } 0 .. $#tabLine );