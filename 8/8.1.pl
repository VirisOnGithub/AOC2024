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
            addAntinodes($rA, $cA, $rB, $cB);
        }
    }
}

sub addAntinodes {
    my ($rA, $cA, $rB, $cB) = @_;
    
    # Calcul des directions
    my $dr = $rB - $rA;
    my $dc = $cB - $cA;

    $antinodes{"$rA,$cA"}++;

    # Calcul des antinodes

    # Dans le sens de la direction

    my ($raCopy, $caCopy) = ($rA, $cA);
    while (1){
        $raCopy += $dr;
        $caCopy += $dc;
        last if ($raCopy < 0 || $raCopy > $#table || $caCopy < 0 || $caCopy > $#{$table[0]});
        $antinodes{"$raCopy,$caCopy"}++;
    }

    # Dans le sens opposé

    ($raCopy, $caCopy) = ($rA, $cA);
    while (1){
        $raCopy -= $dr;
        $caCopy -= $dc;
        last if ($raCopy < 0 || $raCopy > $#table || $caCopy < 0 || $caCopy > $#{$table[0]});
        $antinodes{"$raCopy,$caCopy"}++;
    }
}

# Affichage des antinodes

for my $antinode (keys %antinodes) {
    print "$antinode\n";
}


# Affichage du nombre d'antinodes
my $nbAntinodes = scalar keys %antinodes;

print "Nombre d'antinodes: $nbAntinodes\n";