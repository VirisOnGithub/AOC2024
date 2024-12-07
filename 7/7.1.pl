use strict;
use warnings;

open my $fh, '<', '7/7.txt' or die $!;

my $res = 0;

while (<$fh>) {
    chomp;
    if (/(\d+): ([\d ]+)/) {
        my $num = $1;
        my @arr = split / /, $2;
        if (testNumber($num, \@arr) > 0) {
            $res += $num;
        }
    }
}

print $res;

sub testNumber {
    my ($num, $arrref) = @_;
    my @stack = ([$arrref->[0], 1]);
    
    while (@stack) {
        my ($current_value, $index, $operation) = @{pop @stack};
        
        if ($index == @$arrref) {
            return 1 if $current_value == $num;
            next;
        }
        
        my $next_value = $arrref->[$index];
        
        push @stack, [$current_value + $next_value, $index + 1];
        push @stack, [$current_value * $next_value, $index + 1];
        push @stack, [$current_value . $next_value, $index + 1];
    }
    
    return 0;
}