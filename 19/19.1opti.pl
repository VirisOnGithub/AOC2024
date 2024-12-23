#!/usr/bin/perl
use strict;
use warnings;
use threads;
use Thread::Queue;
use threads::shared;

# Open the file and read the patterns
open my $fh, '<', '19/19.txt' or die "Cannot open file: $!";

my @patterns;
while (<$fh>) {
    chomp;
    last if $_ eq '';
    @patterns = split /, /, $_;
}

# Read the rest of the lines
my @lines = <$fh>;
close $fh;

# Shared result variable
my $result :shared = 0;

# Number of threads
my $num_threads = 12; # Adjust based on your CPU cores
my $work_queue = Thread::Queue->new(@lines);

# Worker subroutine
sub worker {
    while (defined(my $line = $work_queue->dequeue_nb)) {
        chomp $line;
        my @count = (0) x (length($line) + 1);

        foreach my $pattern (@patterns) {
            if (index($line, $pattern) == 0) {
                $count[length($pattern)]++;
            }
        }

        for my $i (0 .. $#count) {
            if ($count[$i] > 0) {
                foreach my $pattern (@patterns) {
                    if (index($line, $pattern, $i) == $i) {
                        $count[$i + length($pattern)] += $count[$i];
                    }
                }
            }
        }

        # Aggregate the result in a thread-safe manner
        {
            lock($result);
            $result += $count[-1];
        }
    }
}

# Create and run threads
my @threads;
for (1 .. $num_threads) {
    push @threads, threads->create(\&worker);
}

# Wait for all threads to finish
$_->join for @threads;

# Print the final result
print $result, "\n";
