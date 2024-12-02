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

sub damner {
    my $p = shift;
    my @arr = @$p;
    for (my $j = 0; $j < @arr; $j++) {
        my @arrayrem = @arr;
        splice(@arrayrem, $j, 1);
        my @diffs2;
        for (my $i = 0; $i < @arrayrem - 1; $i++) {
            push @diffs2, $arrayrem[$i] - $arrayrem[$i + 1];
        }
        if (check(\@diffs2)) {
            return 1;
        }
    }
    return 0;
}

my $res = 0;
foreach (<$fh>) {
    chomp;
    my @champs = split / /;
    $res += damner(\@champs);
}

print $res;
close $fh;