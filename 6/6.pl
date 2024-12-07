use strict;
use warnings;
use Switch;

open my $fh, '<', '6/6testdemi.txt' or die $!;

my @posX;

while (<$fh>) {
    chomp;
    my @chars = split //;
    push @posX, \@chars;
}

sub changeShape {
    my $shape = shift;
    switch ($shape) {
        case '^' { return '>'; }
        case '>' { return 'v'; }
        case 'v' { return '<'; }
        case '<' { return '^'; }
        else     { die $!;}
    }
}

sub move {
    my $shape = shift;
    my $x = shift;
    my $y = shift;
    switch ($shape) {
        case '^' { return ($x - 1, $y); }
        case '>' { return ($x, $y + 1); }
        case 'v' { return ($x + 1, $y); }
        case '<' { return ($x, $y - 1); }
        else     { die $!;}
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

sub findCoordinates {
    my $array = shift;
    for my $i (0 .. $#$array) {
        for my $j (0 .. $#{$array->[$i]}) {
            if ($array->[$i][$j] =~ m/\^|v|<|>/) {
                return ($i, $j);
            }
        }
    }
    return -255;
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

# print "Initial state:\n";
# printArray(\@posX);
# print "\n";
# print join ', ', findCoordinates(\@posX);*

while(1){
    my ($x, $y) = findCoordinates(\@posX); # ça c'est bien de la merde hein
    my ($newX, $newY) = move($posX[$x][$y], $x, $y);
    if($newX < 0 || $newY < 0 || $newX > $#posX || $newY > $#{$posX[$newX]}) {
        $posX[$x][$y] = 'X';
        print "Finished\n";
        last;
    } elsif ($posX[$newX][$newY] eq '.' or $posX[$newX][$newY] eq 'X') {
        $posX[$newX][$newY] = $posX[$x][$y];
        $posX[$x][$y] = 'X';
    } elsif ($posX[$newX][$newY] eq '#' ){
        $posX[$x][$y] = changeShape($posX[$x][$y]);
    } else {
        die $!;
    }
}

print "Final state:\n";
printArray(\@posX);
print countX(\@posX);
