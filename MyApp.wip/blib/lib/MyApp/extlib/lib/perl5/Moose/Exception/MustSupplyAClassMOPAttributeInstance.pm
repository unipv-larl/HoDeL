package Moose::Exception::MustSupplyAClassMOPAttributeInstance;
$Moose::Exception::MustSupplyAClassMOPAttributeInstance::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::ParamsHash';

has 'class' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

sub _build_message {
    "You must supply an attribute which is a 'Class::MOP::Attribute' instance";
}

1;
