package Moose::Exception::CannotAugmentIfLocalMethodPresent;
$Moose::Exception::CannotAugmentIfLocalMethodPresent::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';
with 'Moose::Exception::Role::Class', 'Moose::Exception::Role::Method';

sub _build_message {
    "Cannot add an augment method if a local method is already present";
}

1;
