package MyApp::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

=begin comment
__PACKAGE__->config(
    schema_class => 'MyApp::Schema',
    connect_info => [
        'dbi:mysql:hodel_test',
        'root',
        'hodel_db_PaSsWoRd',
        { AutoCommit => 1 },
        
    ],
);
=end comment
=cut

__PACKAGE__->config(
    schema_class => 'MyApp::Schema',
 connect_info => {
     dsn               => 'dbi:mysql:hodel_test',
     user              => 'root',
     password          => 'hodel_db_PaSsWoRd',
     AutoCommit        => 1,
     RaiseError        => 1,
     mysql_enable_utf8 => 1,
     on_connect_do     => [
             'SET NAMES utf8',
     ],      
 }
);

=head1 NAME

MyApp::Model::DB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<MyApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<MyApp::Schema>

=head1 AUTHOR

Paolo Ruffolo

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
