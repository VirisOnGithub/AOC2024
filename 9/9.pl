use strict;
use warnings;

open my $fh, '<', '9/9.txt' or die $!;

sub representSpace {
    my $line = shift;
    my @tabRes;
    my @tabLine = split(//, $line);
    for my $i (0..$#tabLine) {
        # print "$i\n";
        if ($i%2 == 1) {
            for my $j (1..$tabLine[$i]) {
                push @tabRes, '.';
            }
        } else {
            my $val = $i/2;
            for my $j (1..$tabLine[$i]) {
                push @tabRes, $val;
            }
        }
    }
    return @tabRes;
}

sub moveNumbers {
    my @tabLine = @{$_[0]};

    for my $i (0..$#tabLine) {
        if($tabLine[$i] eq '.'){
            for(my $j = $#tabLine; $j > $i; $j--){
                if($tabLine[$j] ne '.'){
                    $tabLine[$i] = $tabLine[$j];
                    $tabLine[$j] = '.';
                    last;
                }
            }
        }
    }

    return @tabLine;
}

sub calculateChecksum {
    my $res = 0;
    my @tabLine = @{$_[0]};
    for my $i (0..$#tabLine) {
        if ($tabLine[$i] ne '.') {
            $res += $i * $tabLine[$i];
        } else {
            return $res;
        }
    }
    return $res;
}

while (my $line = <$fh>) {
    chomp $line;
    my @space = representSpace($line);
    # print scalar @space;
    # print join '', @space;
    # print "\n";
    my @newSpace = moveNumbers(\@space);
    # print join '', @newSpace;
    # print "\n";
    my $checksum = calculateChecksum(\@newSpace);
    print "$checksum\n";
}