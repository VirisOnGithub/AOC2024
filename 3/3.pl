use strict;
use warnings;

open(my $fh, '<', '3/3.txt');

my $res = 0;

while (<$fh>) {
    chomp;
    while ($_ =~ /mul\((\d+),(\d+)\)/g) {
        $res += $1*$2;
    }
}

print $res, "\n";