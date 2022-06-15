use utf8;
package MyApp::Schema::Result::Argscatorder;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Argscatorder

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

=head1 TABLE: C<ArgsCatOrder>

=cut

__PACKAGE__->table("ArgsCatOrder");

=head1 ACCESSORS

=head2 root_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 argsorder

  data_type: 'char'
  is_nullable: 1
  size: 255

=head2 argsorder_sb

  data_type: 'char'
  is_nullable: 1
  size: 30

=head2 argsorder_obj

  data_type: 'char'
  is_nullable: 1
  size: 30

=head2 argsorder_ocomp

  data_type: 'char'
  is_nullable: 1
  size: 30

=head2 argsorder_pnom

  data_type: 'char'
  is_nullable: 1
  size: 30

=cut

__PACKAGE__->add_columns(
  "root_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "argsorder",
  { data_type => "char", is_nullable => 1, size => 255 },
  "argsorder_sb",
  { data_type => "char", is_nullable => 1, size => 30 },
  "argsorder_obj",
  { data_type => "char", is_nullable => 1, size => 30 },
  "argsorder_ocomp",
  { data_type => "char", is_nullable => 1, size => 30 },
  "argsorder_pnom",
  { data_type => "char", is_nullable => 1, size => 30 },
);

=head1 PRIMARY KEY

=over 4

=item * L</root_id>

=back

=cut

__PACKAGE__->set_primary_key("root_id");

=head1 RELATIONS

=head2 root_id

Type: belongs_to

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->belongs_to("root_id", "MyApp::Schema::Result::Forma", { id => "root_id" });


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-10-29 09:33:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KmVeThM27GNseOsX1Eq4kw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
