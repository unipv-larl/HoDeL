package Moose::Exception::CannotAutoDerefWithoutIsa;
$Moose::Exception::CannotAutoDerefWithoutIsa::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::InvalidAttributeOptions';

sub _build_message {
    my $self = shift;
    "You cannot auto-dereference without specifying a type constraint on attribute (".$self->attribute_name.")";
}

1;
