package Moose::Exception::ClassDoesNotHaveInitMeta;
$Moose::Exception::ClassDoesNotHaveInitMeta::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::Class';

has 'traits' => (
    is       => 'ro',
    isa      => 'ArrayRef',
    required => 1
);

sub _build_message {
    my $self = shift;
    my $class = $self->class_name;

    return "Cannot provide traits when $class does not have an init_meta() method";
}

1;
