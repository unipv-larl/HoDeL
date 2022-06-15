use utf8;
package MyApp::Schema::Result::Sentence;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Sentence

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Sentence>

=cut

__PACKAGE__->table("Sentence");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 code

  data_type: 'char'
  is_nullable: 0
  size: 100

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "code",
  { data_type => "char", is_nullable => 0, size => 100 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 formas

Type: has_many

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->has_many(
  "formas",
  "MyApp::Schema::Result::Forma",
  { "foreign.frase" => "self.id" },
  undef,
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-10-29 09:33:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Qq+mXB+C6SUT0/UvveaOyw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
