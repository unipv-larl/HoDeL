use utf8;
package MyApp::Schema::Result::Forma;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyApp::Schema::Result::Forma

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

=head1 TABLE: C<Forma>

=cut

__PACKAGE__->table("Forma");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 forma

  data_type: 'char'
  is_nullable: 0
  size: 30

=head2 lemma

  data_type: 'char'
  is_nullable: 0
  size: 30

=head2 posagdt

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 pers

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 num

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 tense

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 mood

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 voice

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 gend

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 case

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 degree

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 afun

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 rank

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 gov

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 frase

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "forma",
  { data_type => "char", is_nullable => 0, size => 30 },
  "lemma",
  { data_type => "char", is_nullable => 0, size => 30 },
  "posagdt",
  { data_type => "char", is_nullable => 0, size => 1 },
  "pers",
  { data_type => "char", is_nullable => 0, size => 1 },
  "num",
  { data_type => "char", is_nullable => 0, size => 1 },
  "tense",
  { data_type => "char", is_nullable => 0, size => 1 },
  "mood",
  { data_type => "char", is_nullable => 0, size => 1 },
  "voice",
  { data_type => "char", is_nullable => 0, size => 1 },
  "gend",
  { data_type => "char", is_nullable => 0, size => 1 },
  "case",
  { data_type => "char", is_nullable => 0, size => 1 },
  "degree",
  { data_type => "char", is_nullable => 0, size => 1 },
  "afun",
  { data_type => "char", is_nullable => 0, size => 10 },
  "rank",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "gov",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 0 },
  "frase",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<frase>

=over 4

=item * L</frase>

=item * L</rank>

=back

=cut

__PACKAGE__->add_unique_constraint("frase", ["frase", "rank"]);

=head1 RELATIONS

=head2 argscatorders

Type: has_many

Related object: L<MyApp::Schema::Result::Argscatorder>

=cut

__PACKAGE__->has_many(
  "argscatorders",
  "MyApp::Schema::Result::Argscatorder",
  { "foreign.root_id" => "self.id" },
  undef,
);

=head2 argscats

Type: has_many

Related object: L<MyApp::Schema::Result::Argscat>

=cut

__PACKAGE__->has_many(
  "argscats",
  "MyApp::Schema::Result::Argscat",
  { "foreign.root_id" => "self.id" },
  undef,
);

=head2 diatesicats

Type: has_many

Related object: L<MyApp::Schema::Result::Diatesicat>

=cut

__PACKAGE__->has_many(
  "diatesicats",
  "MyApp::Schema::Result::Diatesicat",
  { "foreign.root_id" => "self.id" },
  undef,
);

=head2 frase

Type: belongs_to

Related object: L<MyApp::Schema::Result::Sentence>

=cut

__PACKAGE__->belongs_to("frase", "MyApp::Schema::Result::Sentence", { id => "frase" });

=head2 path_parent_ids

Type: has_many

Related object: L<MyApp::Schema::Result::Path>

=cut

__PACKAGE__->has_many(
  "path_parent_ids",
  "MyApp::Schema::Result::Path",
  { "foreign.parent_id" => "self.id" },
  undef,
);

=head2 path_root_ids

Type: has_many

Related object: L<MyApp::Schema::Result::Path>

=cut

__PACKAGE__->has_many(
  "path_root_ids",
  "MyApp::Schema::Result::Path",
  { "foreign.root_id" => "self.id" },
  undef,
);

=head2 path_target_ids

Type: has_many

Related object: L<MyApp::Schema::Result::Path>

=cut

__PACKAGE__->has_many(
  "path_target_ids",
  "MyApp::Schema::Result::Path",
  { "foreign.target_id" => "self.id" },
  undef,
);

=head2 verbarguments

Type: has_many

Related object: L<MyApp::Schema::Result::Verbargument>

=cut

__PACKAGE__->has_many(
  "verbarguments",
  "MyApp::Schema::Result::Verbargument",
  { "foreign.root_id" => "self.id" },
  undef,
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2017-10-29 09:37:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6Fm9of+04VX0QQzVzOCc+w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
