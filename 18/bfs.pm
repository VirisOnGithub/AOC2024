# bfs.pl
package bfs;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(bfs);

# Directions for moving in the grid (right, down, left, up)
my @directions = ([0, 1], [1, 0], [0, -1], [-1, 0]);

# BFS function to find the shortest path and color it
sub bfs {
    my ($grid, $start_x, $start_y, $end_x, $end_y) = @_;
    my @queue = ([$start_x, $start_y, 0, []]); # (x, y, distance, path)
    my %visited = ("$start_x,$start_y" => 1);

    while (@queue) {
        my ($x, $y, $dist, $path) = @{shift @queue};

        # Check if we reached the end
        if ($x == $end_x && $y == $end_y) {
            # Color the path
            for my $pos (@$path) {
                my ($px, $py) = @$pos;
                $grid->[$px][$py] = 2; # Mark the path with a different value (e.g., 2)
            }
            $grid->[$end_x][$end_y] = 2; # Mark the end position
            return $dist;
        }

        # Explore neighbors
        for my $dir (@directions) {
            my ($new_x, $new_y) = ($x + $dir->[0], $y + $dir->[1]);

            # Check if the new position is within bounds and not visited
            if ($new_x >= 0 && $new_x < @$grid && $new_y >= 0 && $new_y < @{$grid->[0]} && $grid->[$new_x][$new_y] == 1 && !$visited{"$new_x,$new_y"}) {
                push @queue, [$new_x, $new_y, $dist + 1, [@$path, [$x, $y]]];
                $visited{"$new_x,$new_y"} = 1;
            }
        }
    }

    return -1; # No path found
}

1; # End of module