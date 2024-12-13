use strict;
use warnings;
use Math::Matrix;

# Button A: X+94, Y+34
# Button B: X+22, Y+67
# Prize: X=8400, Y=5400

open my $fh, '<', "13/13.txt";

srand(time);


my $Mat;
my (@a, @b, @c);
my $res = 0;

sub is_int {
    my $n = shift;
    return $n =~ /^\d+$/ || $n =~ /^\d+\.?[09]*[91]$/;
}

while(<$fh>){
  chomp;
  if(/Button A: X\+(\d+), Y\+(\d+)/){
    @a = ($1, $2);
  } elsif(/Button B: X\+(\d+), Y\+(\d+)/){
    @b = ($1, $2);
  } elsif(/Prize: X=(\d+), Y=(\d+)/){
    @c = ($1+10000000000000, $2+10000000000000);
  } else {
    $Mat = Math::Matrix->new(\@a, \@b) -> transpose;
    my $MatC = Math::Matrix->new(\@c)->transpose;

    my $s = $Mat->inv() * $MatC;
    
    my ($nbA, $nbB) = ($s->[0][0], $s->[1][0]);
    if(is_int($nbA) && is_int($nbB) && $nbA >= 0 && $nbB >= 0){
       $res += $s->[0][0]*3 + $s->[1][0];
    }
  }
}

print $res;