use utf8;
package MyApp::Schema::Result::Verbargument;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Verbargument

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

=head1 TABLE: C<VerbArgument>

=cut

__PACKAGE__->table("VerbArgument");

=head1 ACCESSORS

=head2 root_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 arg_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 coord_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 mn

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 mx

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 relation

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 rcase

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 lemma

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 prep

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 conj

  data_type: 'char'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "root_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "arg_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "coord_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "mn",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "mx",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "relation",
  { data_type => "char", is_nullable => 1, size => 10 },
  "rcase",
  { data_type => "char", is_nullable => 1, size => 10 },
  "lemma",
  { data_type => "char", is_nullable => 1, size => 20 },
  "prep",
  { data_type => "char", is_nullable => 1, size => 20 },
  "conj",
  { data_type => "char", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</root_id>

=item * L</arg_id>

=back

=cut

__PACKAGE__->set_primary_key("root_id", "arg_id");

=head1 RELATIONS

=head2 root_id

Type: belongs_to

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->belongs_to("root_id", "MyApp::Schema::Result::Forma", { id => "root_id" });


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-10-29 09:33:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:C7sT3ipAXnTQe2fE419esQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
