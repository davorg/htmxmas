use utf8;
package HTMXmas::Schema::Result::Present;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

HTMXmas::Schema::Result::Present

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<present>

=cut

__PACKAGE__->table("present");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 notes

  data_type: 'text'
  is_nullable: 1

=head2 child_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 bought

  data_type: 'boolean'
  default_value: 0
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "notes",
  { data_type => "text", is_nullable => 1 },
  "child_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "bought",
  { data_type => "boolean", default_value => 0, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 child

Type: belongs_to

Related object: L<HTMXmas::Schema::Result::Child>

=cut

__PACKAGE__->belongs_to(
  "child",
  "HTMXmas::Schema::Result::Child",
  { id => "child_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-11-29 14:06:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9GR++enO4JjFdQRieapIZg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
