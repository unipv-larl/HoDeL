package Moose::Meta::Method::Accessor::Native::Array::elements;
$Moose::Meta::Method::Accessor::Native::Array::elements::VERSION = '2.1213';
use strict;
use warnings;

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Reader';

sub _maximum_arguments { 0 }

sub _return_value {
    my $self = shift;
    my ($slot_access) = @_;

    return '@{ (' . $slot_access . ') }';
}

no Moose::Role;

1;
