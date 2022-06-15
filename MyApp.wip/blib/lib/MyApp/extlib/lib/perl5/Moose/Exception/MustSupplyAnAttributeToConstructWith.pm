package Moose::Exception::MustSupplyAnAttributeToConstructWith;
$Moose::Exception::MustSupplyAnAttributeToConstructWith::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::ParamsHash';

has 'class' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

sub _build_message {
    "You must supply an attribute to construct with";
}

1;
