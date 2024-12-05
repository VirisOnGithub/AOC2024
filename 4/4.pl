use strict;
use warnings;
use feature qw(switch);

open my $fh, '<', '4/4.txt' or die $!;

my @lines;

while(<$fh>){
    my @line = split //, $_;
    push @lines, \@line;
}

sub countXMAS {
    my $sum = 0;
    my @tab = @{$_[0]};
    for my $i (0..$#tab){
        for my $j (0..$#{$tab[$i]}){
            if($tab[$i][$j] eq "X"){
                if($i <= $#tab - 3){
                    if($tab[$i+1][$j] eq "M" && $tab[$i+2][$j] eq "A" && $tab[$i+3][$j] eq "S"){
                        $sum++;
                    }
                }
                if($j <= $#tab - 3){
                    if($tab[$i][$j+1] eq "M" && $tab[$i][$j+2] eq "A" && $tab[$i][$j+3] eq "S"){
                        $sum++;
                    }
                }
                if($i <= $#tab - 3 && $j <= $#tab - 3){
                    if($tab[$i+1][$j+1] eq "M" && $tab[$i+2][$j+2] eq "A" && $tab[$i+3][$j+3] eq "S"){
                        $sum++;
                    }
                }
                if($i <= $#tab - 3 && $j >= 3){
                    if($tab[$i+1][$j-1] eq "M" && $tab[$i+2][$j-2] eq "A" && $tab[$i+3][$j-3] eq "S"){
                        $sum++;
                    }
                }
                if($i >= 3){
                    if($tab[$i-1][$j] eq "M" && $tab[$i-2][$j] eq "A" && $tab[$i-3][$j] eq "S"){
                        $sum++;
                    }
                }
                if($j >= 3){
                    if($tab[$i][$j-1] eq "M" && $tab[$i][$j-2] eq "A" && $tab[$i][$j-3] eq "S"){
                        $sum++;
                    }
                }
                if($i >= 3 && $j >= 3){
                    if($tab[$i-1][$j-1] eq "M" && $tab[$i-2][$j-2] eq "A" && $tab[$i-3][$j-3] eq "S"){
                        $sum++;
                    }
                }
                if($i >= 3 && $j <= $#tab - 3){
                    if($tab[$i-1][$j+1] eq "M" && $tab[$i-2][$j+2] eq "A" && $tab[$i-3][$j+3] eq "S"){
                        $sum++;
                    }
                }
            }
        }
    }
    return $sum;
}

print countXMAS(\@lines);