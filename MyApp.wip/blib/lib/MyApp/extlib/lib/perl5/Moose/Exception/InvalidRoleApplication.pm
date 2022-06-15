package Moose::Exception::InvalidRoleApplication;
$Moose::Exception::InvalidRoleApplication::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::Class';

has 'application' => (
    is       => 'ro',
    isa      => "Any",
    required => 1,
);

sub _build_message {
    "Role applications must be instances of Moose::Meta::Role::Application::ToClass";
}

1;
