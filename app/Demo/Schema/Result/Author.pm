use utf8;

package Demo::Schema::Result::Author;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("author");
__PACKAGE__->add_columns(
	"id_author" => {
		data_type         => "integer",
		is_auto_increment => 1,
		is_nullable       => 0,
		sequence          => "author_id_author_seq",
	},
	"name"     => {data_type => "text", is_nullable => 0},
	"login"    => {data_type => "text", is_nullable => 0},
	"password" => {data_type => "text", is_nullable => 0},
);

__PACKAGE__->set_primary_key("id_author");
__PACKAGE__->add_unique_constraint("author_login_key", ["login"]);
__PACKAGE__->add_unique_constraint("author_name_key",  ["name"]);
__PACKAGE__->has_many(
	"articles",
	"Demo::Schema::Result::Article",
	{"foreign.id_author" => "self.id_author"},
	{cascade_copy        => 0, cascade_delete => 0},
);
__PACKAGE__->has_many(
	"author_auths",
	"Demo::Schema::Result::AuthorAuth",
	{"foreign.id_author" => "self.id_author"},
	{cascade_copy        => 0, cascade_delete => 0},
);

1;
