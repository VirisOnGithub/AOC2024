package Block;
use strict;
use warnings;

# use Exporter;

# our @ISA = qw(Exporter);
# our @EXPORT = qw();

sub new {
    my ( $class, $posStart, $size, $value ) = @_;
    my $self = {
        posStart => $posStart,
        size     => $size,
        value    => $value,
    };
    bless $self, $class;
    return $self;
}

sub print {
    my ($self) = @_;
    print
"posStart: $self->{posStart}, size: $self->{size}, value: $self->{value}\n";
}

sub getPosStart {
    my ($self) = @_;
    return $self->{posStart};
}

sub getSize {
    my ($self) = @_;
    return $self->{size};
}

sub getValue {
    my ($self) = @_;
    return $self->{value};
}

sub setPosStart {
    my ( $self, $posStart ) = @_;
    $self->{posStart} = $posStart;
}

sub setSize {
    my ( $self, $size ) = @_;
    $self->{size} = $size;
}

sub setValue {
    my ( $self, $value ) = @_;
    $self->{value} = $value;
}

1;
