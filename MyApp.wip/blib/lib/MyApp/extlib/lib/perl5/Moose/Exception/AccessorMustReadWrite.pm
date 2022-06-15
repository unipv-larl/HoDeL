package Moose::Exception::AccessorMustReadWrite;
$Moose::Exception::AccessorMustReadWrite::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::InvalidAttributeOptions';

sub _build_message {
    my $self = shift;
    "Cannot define an accessor name on a read-only attribute, accessors are read/write";
}

1;
