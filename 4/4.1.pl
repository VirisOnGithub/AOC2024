use strict;
use warnings;
use feature qw(switch);

open my $fh, '<', '4/4.txt' or die $!;

my @lines;

while(<$fh>){
    my @line = split //, $_;
    push @lines, \@line;
}

sub countX_MAS {
    my $sum = 0;
    my @tab = @{$_[0]};
    for my $i (0..$#tab){
        for my $j (0..$#{$tab[$i]}){
            if($tab[$i][$j] eq "A"){
                if($i > 0 && $j > 0 && $i < $#tab && $j < $#tab){
                    if(($tab[$i-1][$j-1] eq "M" && $tab[$i+1][$j-1] eq "M" && $tab[$i+1][$j+1] eq "S" && $tab[$i-1][$j+1] eq "S")
                        || ($tab[$i-1][$j-1] eq "M" && $tab[$i+1][$j-1] eq "S" && $tab[$i+1][$j+1] eq "S" && $tab[$i-1][$j+1] eq "M")
                        || ($tab[$i-1][$j-1] eq "S" && $tab[$i+1][$j-1] eq "S" && $tab[$i+1][$j+1] eq "M" && $tab[$i-1][$j+1] eq "M")
                        || ($tab[$i-1][$j-1] eq "S" && $tab[$i+1][$j-1] eq "M" && $tab[$i+1][$j+1] eq "M" && $tab[$i-1][$j+1] eq "S")
                    ){
                        $sum++;
                    }
                }
            }
        }
    }
    return $sum;
}

print countX_MAS(\@lines);