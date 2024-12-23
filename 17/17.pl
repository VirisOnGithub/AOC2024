#!/usr/bin/perl
use strict;
use warnings;
use Syntax::Keyword::Match;

open my $fh , '<', '17/17test.txt' or die "Cannot open file: $!\n";

my %registers;
my @program;
my @output;

while (<$fh>) {
    chomp;
    if (/^Register (\w): (\w+)$/){
        $registers{$1} = $2;
        next;
    }
    if (/^Program: ([,\d]+)/){
        @program = split /,/, $1;
        next;
    }
}

sub combo {
    my $a = shift;
    match ($a : ==) {
        case(0), case(1), case(2), case(3) {
            return $a;
        }
        case(4) {
            return $registers{'A'};
        }
        case(5) {
            return $registers{'B'};
        }
        case(6) {
            return $registers{'C'};
        }
        default {
            die "Invalid combo: $a\n";
        }
    }
}

my $i = 0;
while($i < @program){
    my ($first, $second) = @program[$i, $i+1];
    match ($first : ==) {
        case(0){
            $registers{'A'} = int($registers{'A'} / 2**combo($second));
        }
        case(1){
            $registers{'B'} = $registers{'B'} ^ $second;
        }
        case(2){
            $registers{'B'} = combo($second) % 8;
        }
        case(3){
            if($registers{'A'} != 0){
                $i = $second;
                next;
            }
        }
        case(4){
            $registers{'B'} = $registers{'B'} ^ $registers{'C'};
        }
        case(5){
            push @output, combo($second)%8;
        }
        case(6){
            $registers{'B'} = int($registers{'A'}/2**combo($second));
        }
        case(7){
            $registers{'C'} = int($registers{'A'}/2**combo($second));
        }
    }

    # Debug
    # print "Loop i: $i\n";
    # print "First: $first, Second: $second\n";
    # print "Registers: A: $registers{'A'}, B: $registers{'B'}, C: $registers{'C'}\n";
    # print "Output: @output\n";


    $i += 2;
}

print join ',', @output;