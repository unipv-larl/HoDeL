package Moose::Exception::EnumValuesMustBeString;
$Moose::Exception::EnumValuesMustBeString::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::ParamsHash';

has 'class' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

has 'value' => (
    is       => 'ro',
    isa      => 'Any',
    required => 1
);

sub _build_message {
    my $self = shift;
    "Enum values must be strings, not ".( defined $self->value ? "'".$self->value."'" : "undef" );
}

1;
