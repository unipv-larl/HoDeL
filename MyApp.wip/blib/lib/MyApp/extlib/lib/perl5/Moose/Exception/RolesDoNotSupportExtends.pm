package Moose::Exception::RolesDoNotSupportExtends;
$Moose::Exception::RolesDoNotSupportExtends::VERSION = '2.1213';
use Moose;
extends 'Moose::Exception';

sub _build_message {
    "Roles do not support 'extends' (you can use 'with' to specialize a role)";
}

1;
