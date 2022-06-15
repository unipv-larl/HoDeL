package Moose::Exception::MustPassAHashOfOptions;
$Moose::Exception::MustPassAHashOfOptions::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::ParamsHash';

has 'class' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);

sub _build_message {
    "You must pass a hash of options";
}

1;
