package Moose::Exception::NeitherAttributeNorAttributeNameIsGiven;
$Moose::Exception::NeitherAttributeNorAttributeNameIsGiven::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';

sub _build_message {
    "You need to give attribute or attribute_name or both";
}

1;
