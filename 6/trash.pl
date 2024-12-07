use strict;
use warnings;
use Time::HiRes qw(tv_interval gettimeofday);
use Clone::PP qw(clone);

open my $fh, '<', '6/6testdemi.txt' or die $!;

my @posX;
while (<$fh>) {
    chomp;
    my @chars = split //;
    push @posX, \@chars;
}



sub findStart {
    my @posX = @{$_[0]};
    for my $i (0 .. $#posX) {
        for my $j (0 .. $#{$posX[$i]}) {
            if ($posX[$i][$j] =~ m/\^|v|<|>/) {
                return ($i, $j);
            }
        }
    }
    return (4, 6);
}

my %shape_change = (
    '^' => '>',
    '>' => 'v',
    'v' => '<',
    '<' => '^',
);

sub changeShape {
    my $shape = shift;
    return $shape_change{$shape} // die $!;
}

sub move {
    my ($shape, $x, $y) = @_;
    if ($shape eq '^') {
        return ($x - 1, $y);
    } elsif ($shape eq '>') {
        return ($x, $y + 1);
    } elsif ($shape eq 'v') {
        return ($x + 1, $y);
    } elsif ($shape eq '<') {
        return ($x, $y - 1);
    } else {
        print "Shape: $shape\n";
        die $!;
    }
}

sub printArray {
    my $array = shift;
    for my $i (0 .. $#$array) {
        for my $j (0 .. $#{$array->[$i]}) {
            print $array->[$i][$j];
        }
        print "\n";
    }
}

sub countX {
    my $array = shift;
    my $count = 0;
    for my $i (0 .. $#$array) {
        for my $j (0 .. $#{$array->[$i]}) {
            if ($array->[$i][$j] eq 'X') {
                $count++;
            }
        }
    }
    return $count;
}


sub checkPossible {
    my @posX = @{$_[0]};
    my $time = [gettimeofday];
    my @shapes_positions;
    push @shapes_positions, [findStart(\@posX)];
    while (@shapes_positions) {
        my ($x, $y) = @{shift @shapes_positions};

        my ($newX, $newY) = move($posX[$x][$y], $x, $y);
        if ($newX < 0 || $newY < 0 || $newX > $#posX || $newY > $#{$posX[$newX]}) {
            $posX[$x][$y] = 'X';
            return 0;
        }
        elsif ($posX[$newX][$newY] eq '.') {
            $posX[$newX][$newY] = $posX[$x][$y];
            $posX[$x][$y] = 'X';
            push @shapes_positions, [$newX, $newY];
        } elsif ($posX[$newX][$newY] eq '#' || $posX[$newX][$newY] eq 'O') {
            $posX[$x][$y] = changeShape($posX[$x][$y]);
            push @shapes_positions, [$x, $y];
        } elsif($posX[$newX][$newY] eq 'X') {
            return 1;
        } else {
            die $!;
        }
    }
}



my $res = 0;

for my $i (0 .. $#posX) {
    for my $j (0 .. $#{$posX[0]}) {
        if ($posX[$i][$j] eq 'X' && !($posX[$i][$j] eq '^')) {
            my @copyTable = @{clone(\@posX)};
            $copyTable[$i][$j] = 'O';
            if (checkPossible(\@copyTable)) {
                printArray(\@copyTable), print "\n";
                $res++;   
            }
        }
    }
}

print $res;