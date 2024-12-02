use strict;
use warnings;

open my $fh, '<', '1/1.txt' or die "Can't open file: $!";

my @first;
my @second;
while (<$fh>) {
    chomp;
    my @champs = split /   /;
    push @first, $champs[0];
    push @second, $champs[1];
}
close $fh;

@first = sort @first;
@second = sort @second;

my $n = @first;
my $res;
for (my $i = 0; $i < $n; $i++) {
    $res += abs($first[$i] - $second[$i]);
}

print $res, "\n";