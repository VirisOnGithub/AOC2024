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

my %hashsecond;

foreach my $second (@second) {
    $hashsecond{$second}++;
}

my $res = 0;

foreach my $first (@first) {
    if (exists $hashsecond{$first}) {
        $res += $first * $hashsecond{$first};
    }
}

print $res, "\n";