use utf8;

package Demo::Schema::Result::AuthorAuth;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("author_auth");

__PACKAGE__->add_columns(
	"auth"    => {data_type => "text", is_nullable => 0},
	"expires" => {
		data_type     => "timestamp",
		default_value => \"(now() + '30 days'::interval)",
		is_nullable   => 0,
	},
	"id_author" => {data_type => "integer", is_foreign_key => 1, is_nullable => 0},
);
__PACKAGE__->add_unique_constraint("author_auth_auth_key", ["auth"]);
__PACKAGE__->belongs_to(
	"Author",
	"Demo::Schema::Result::Author",
	{id_author     => "id_author"},
	{is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION"},
);

1;
