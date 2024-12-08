use strict;
use warnings;

open my $fh, '<', '8/8.txt' or die $!;

my @table;
my %antennas;

# Lecture du fichier

while (<$fh>) {
    chomp;
    my @line = split //;
    push @table, \@line;
}

# On remplit la hashmap des antennes 

for my $i (0..$#table) {
    for my $j (0..$#{$table[$i]}) {
        if (!($table[$i][$j] eq '.')) {
            if(exists $antennas{$table[$i][$j]}){
                push @{$antennas{$table[$i][$j]}}, [$i, $j];
            } else {
                $antennas{$table[$i][$j]} = [[$i, $j]];
            }
        }
    }
}

print "Affichage des antennes\n";

for my $antenna (sort keys %antennas) {
    print "$antenna: ";
    for my $i (0..$#{$antennas{$antenna}}) {
        print "($antennas{$antenna}[$i][0],$antennas{$antenna}[$i][1])";
    }
    print "\n";
}

my %antinodes;

while (my ($antenna, $coords) = each %antennas) {
    for my $i (0..$#{$coords}){
        my ($rA, $cA) = @{$coords->[$i]};
        print "Antenne $antenna: ($coords->[$i][0],$coords->[$i][1])\n";
        for my $j ($i+1..$#{$coords}){
            my ($rB, $cB) = @{$coords->[$j]};
            print "Antenne $antenna: ($coords->[$j][0],$coords->[$j][1])\n";

            # Calcul des antinodes
            my $rAntinode1 = 2 * $rB - $rA;
            my $cAntinode1 = 2 * $cB - $cA;
            my $rAntinode2 = 2 * $rA - $rB;
            my $cAntinode2 = 2 * $cA - $cB;

            # Vérification de la position des antinodes

            if ($rAntinode1 >= 0 && $rAntinode1 <= $#table && $cAntinode1 >= 0 && $cAntinode1 <= $#{$table[0]}) {
                print "Antinode $antenna: ($rAntinode1,$cAntinode1)\n\n";
                if(!(exists $antinodes{"$rAntinode1,$cAntinode1"})){
                    $antinodes{"$rAntinode1,$cAntinode1"}++;
                }
            }
            if ($rAntinode2 >= 0 && $rAntinode2 <= $#table && $cAntinode2 >= 0 && $cAntinode2 <= $#{$table[0]}) {
                print "Antinode $antenna: ($rAntinode2,$cAntinode2)\n\n";
                if(!(exists $antinodes{"$rAntinode2,$cAntinode2"})){
                    $antinodes{"$rAntinode2,$cAntinode2"}++;
                }
            }
        }
    }
}

# Affichage du nombre d'antinodes

# for my $antinode (keys %antinodes) {
#     print "$antinode\n";
# }

my $nbAntinodes = scalar keys %antinodes;

print "Nombre d'antinodes: $nbAntinodes\n";
