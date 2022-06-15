use utf8;
package MyApp::Schema::Result::Path;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Path

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

=head1 TABLE: C<Path>

=cut

__PACKAGE__->table("Path");

=head1 ACCESSORS

=head2 root_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 target_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 parent_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 depth

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

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
  "target_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "parent_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "depth",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</root_id>

=item * L</target_id>

=item * L</parent_id>

=back

=cut

__PACKAGE__->set_primary_key("root_id", "target_id", "parent_id");

=head1 RELATIONS

=head2 parent_id

Type: belongs_to

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->belongs_to(
  "parent_id",
  "MyApp::Schema::Result::Forma",
  { id => "parent_id" },
);

=head2 root_id

Type: belongs_to

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->belongs_to("root_id", "MyApp::Schema::Result::Forma", { id => "root_id" });

=head2 target_id

Type: belongs_to

Related object: L<MyApp::Schema::Result::Forma>

=cut

__PACKAGE__->belongs_to(
  "target_id",
  "MyApp::Schema::Result::Forma",
  { id => "target_id" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-10-29 09:33:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UhId2vbQljPxSuJHlxUL4Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
