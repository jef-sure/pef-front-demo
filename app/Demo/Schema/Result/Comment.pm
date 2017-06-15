use utf8;

package Demo::Schema::Result::Comment;

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->table("comment");
__PACKAGE__->add_columns(
	"id_comment" => {
		data_type         => "integer",
		is_auto_increment => 1,
		is_nullable       => 0,
		sequence          => "comment_id_comment_seq",
	},
	"id_comment_parent" => {data_type => "integer", is_foreign_key => 1, is_nullable => 1},
	"id_article"        => {data_type => "integer", is_foreign_key => 1, is_nullable => 0},
	"pub_date"          => {
		data_type     => "timestamp",
		default_value => \"current_timestamp",
		is_nullable   => 0,
		original      => {default_value => \"now()"},
	},
	"comment" => {data_type => "text", is_nullable => 0},
	"author"  => {data_type => "text", is_nullable => 0},
);

__PACKAGE__->set_primary_key("id_comment");
__PACKAGE__->has_many(
	"comments",
	"Demo::Schema::Result::Comment",
	{"foreign.id_comment_parent" => "self.id_comment"},
	{cascade_copy                => 0, cascade_delete => 0},
);
__PACKAGE__->belongs_to(
	"Article",
	"Demo::Schema::Result::Article",
	{id_article    => "id_article"},
	{is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION"},
);
__PACKAGE__->belongs_to(
	"CommentParent",
	"Demo::Schema::Result::Comment",
	{id_comment => "id_comment_parent"},
	{   is_deferrable => 0,
		join_type     => "LEFT",
		on_delete     => "CASCADE",
		on_update     => "NO ACTION",
	},
);
1;
