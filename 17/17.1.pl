#!/usr/bin/perl
use strict;
use warnings;
use Syntax::Keyword::Match;

open my $fh, '<', '17/17test.txt' or die "Cannot open file: $!\n";

my %registers;
my @program;
my @output;

while (<$fh>) {
    chomp;
    if (/^Register (\w): (\w+)$/) {
        $registers{$1} = $2;
    } elsif (/^Program: ([,\d]+)/) {
        @program = split /,/, $1;
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

my $registerAValue = 0;

while (1) {
    @output = ();
    my $caseChecker = 0;
    $registers{'A'} = $registerAValue;
    my $i = 0;
    while ($i < @program) {
        my ($first, $second) = @program[$i, $i + 1];
        match ($first : ==) {
            case(0) {
                $registers{'A'} = int($registers{'A'} / 2**combo($second));
            }
            case(1) {
                $registers{'B'} = $registers{'B'} ^ $second;
            }
            case(2) {
                $registers{'B'} = combo($second) % 8;
            }
            case(3) {
                if ($registers{'A'} != 0) {
                    $i = $second;
                    next;
                }
            }
            case(4) {
                $registers{'B'} = $registers{'B'} ^ $registers{'C'};
            }
            case(5) {
                push @output, combo($second) % 8;
                last if ($output[$caseChecker] != $program[$caseChecker]);
                $caseChecker++;
            }
            case(6) {
                $registers{'B'} = int($registers{'A'} / 2**combo($second));
            }
            case(7) {
                $registers{'C'} = int($registers{'A'} / 2**combo($second));
            }
        }
        $i += 2;
    }
    if (join(',', @output) eq join(',', @program)) {
        print "Register A: $registerAValue\n";
        last;
    }
    $registerAValue++;
}
