use utf8;
package HTMXmas::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07051 @ 2023-11-29 14:06:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gP9vVjJQ1l64n06owsKzCA

sub get_schema {
  __PACKAGE__->connect('dbi:SQLite:./htmxmas.db') or die;
}


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;
