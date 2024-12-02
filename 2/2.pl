use strict;
use warnings;

open my $fh, '<', '2/2.txt' or die "Can't open file: $!";

sub check {
    my $p = shift;
    my @array = @$p;
    return 0 if $array[0] == 0;
    my $incr = $array[0] > 0 ? 1 : 0;
    foreach my $i (@array) {
        if ($incr == 1) {
            if ($i < 1 or $i > 3) {
                return 0;
            }
        } else {
            if ($i > -1 or $i < -3) {
                return 0;
            }
        }
    }
    return 1;
}

my $res;

foreach (<$fh>) {
    chomp;
    my @champs = split / /;
    my @diffs;
    for (my $i = 0; $i < @champs - 1; $i++) {
        push @diffs, $champs[$i] - $champs[$i + 1];
    }
    $res += check(\@diffs);
}

print $res;