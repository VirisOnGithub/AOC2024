use strict;
use warnings;

open(my $f1, '<', '3/3.txt');
open(my $f2, '>', '3/3m.txt');

while (<$f1>) {
    chomp;
    my @champs = split /do\(\)/;
    foreach my $champ (@champs) {
        print $f2 "$champ\n";
        if($champ ne $champs[-1]){
            print $f2 "do()\n";
        }
    }
}

close $f1;
close $f2;

open( $f2, '<', '3/3m.txt');
open( my $f3, '>', '3/3m2.txt');

while (<$f2>) {
    chomp;
    if($_ ne "do()") {
        my @champs = split /don\'t\(\)/;
        foreach my $champ (@champs) {
            print $f3 "$champ\n";
            if($champ ne $champs[-1]){
                print $f3 "don\'t()\n";
            }
        }
    } else {
        print $f3 "do()\n";
    }
}