use strict;
use warnings;
use PDL;
use PDL::LinearAlgebra;

# File path
my $file = "13/13test.txt";
open my $fh, '<', $file or die "Could not open file '$file': $!";

# Variables
my ($a, $b, $c);
my $res = 0;

sub is_int {
    my $n = shift;
    return $n == int($n);
}

while (<$fh>) {
    chomp;
    if (/Button A: X\+(\d+), Y\+(\d+)/) {
        $a = pdl([$1, $2]);
    } elsif (/Button B: X\+(\d+), Y\+(\d+)/) {
        $b = pdl([$1, $2]);
    } elsif (/Prize: X=(\d+), Y=(\d+)/) {
        $c = pdl([$1, $2]);
    } else {
        next unless ($a && $b && $c); # Ensure all components are defined

        my $A = pdl([$a->list], [$b->list]); # Construct matrix
        my $b = $c->transpose;              # RHS as column vector
        my $x = inv($A) x $b;               # Solve Ax = b

        # Extract results
        my ($nbA, $nbB) = $x->list;
        if (is_int($nbA) && is_int($nbB) && $nbA >= 0 && $nbB >= 0) {
            $res += $nbA * 3 + $nbB;
        }
    }
}

close $fh;
print $res, "\n";
