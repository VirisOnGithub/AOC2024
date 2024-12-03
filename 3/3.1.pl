use strict;
use warnings;

open(my $fh, '<', '3/3m2.txt');

my $res = 0;
my $do = 1;

while (<$fh>) {
    chomp;
    if($_ eq "do()") {
        $do = 1;
    }
    elsif($_ eq "don't()") {
        $do = 0;
    }
    else {
        while ($do && $_ =~ /mul\((\d+),(\d+)\)/g) {
            $res += $1*$2;
        }
    }
}

print $res, "\n";