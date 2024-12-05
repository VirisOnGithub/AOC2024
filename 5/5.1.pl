use strict;
use warnings;

open my $fh, '<', '5/5.txt' or die $!;

my %orderPages;
my @pagesGroup;

while(<$fh>){
    last if $_ eq "\n";
    chomp;
    $orderPages{$_} = 1;
}
while(<$fh>){
    chomp;
    push @pagesGroup, $_;
}

my $res = 0;

foreach my $pages (@pagesGroup){
    if(checkCorrectPages($pages)){
        $res += permuteIncorrectPages($pages);
    }
}

print $res;

sub checkCorrectPages {
    my $commaPages = shift;
    my @pages = split ',', $commaPages; # 34, 56, 75, 35, 45
    for my $j (0..$#pages){
        for my $k ($j+1..$#pages){
            if($orderPages{$pages[$k]."|".$pages[$j]}){
                # print $pages[$k]."|".$pages[$j], " : ", $pagesGroup[$i], "\n";
                return 1;
            }
        }
    }
    return 0;
}

sub permuteIncorrectPages {
    my $commaPages = shift;
    my @pages = split ',', $commaPages;
    my $res = 0;
    for my $j (0..$#pages){
        for my $k ($j+1..$#pages){
            if($orderPages{$pages[$k]."|".$pages[$j]}){
                ($pages[$j], $pages[$k]) = ($pages[$k], $pages[$j]);
                return permuteIncorrectPages(join(',', @pages));
            }
        }
    }
    $pages[$#pages/2];
}