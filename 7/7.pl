use strict;
use warnings;
use Clone::PP qw(clone);

open my $fh, '<', '7/7.txt' or die $!;

my $res = 0;

while (<$fh>) {
    chomp;
    if(/(\d+): ([\d ]+)/){
        my $arr2 = [split / /, $2];
        if(testNumber($1, $arr2)>0){
            $res+=$1;
        }
    }
}

print $res;

sub testNumber {
    my ($num, $arrref) = @_;
    my @arr = @$arrref;
    if(scalar @arr == 1){
        if($arr[0] == $num){
            return 1;
        } else {
            return 0;
        }
    } else {
        my @clone1 = @{ clone(\@arr) };
        my @clone2 = @{ clone(\@arr) };
        my $first = shift @clone1;
        shift @clone2;
        $clone1[0] = $clone1[0] + $first;
        $clone2[0] = $clone2[0] * $first;
        return testNumber($num, \@clone1) + testNumber($num, \@clone2);
    }
}