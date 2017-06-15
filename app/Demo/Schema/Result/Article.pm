use utf8;

package Demo::Schema::Result::Article;

=head1 NAME

Demo::Schema::Result::Article

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<article>

=cut

__PACKAGE__->table("article");

__PACKAGE__->add_columns(
	"id_article" => {
		data_type         => "integer",
		is_auto_increment => 1,
		is_nullable       => 0,
		sequence          => "article_id_article_seq",
	},
	"title"    => {data_type => "text", is_nullable => 0},
	"content"  => {data_type => "text", is_nullable => 0},
	"pub_date" => {
		data_type     => "timestamp",
		default_value => \"current_timestamp",
		is_nullable   => 0,
		original      => {default_value => \"now()"},
	},
	"id_author" => {data_type => "integer", is_foreign_key => 1, is_nullable => 0},
);
__PACKAGE__->set_primary_key("id_article");
__PACKAGE__->has_many(
	"comments",
	"Demo::Schema::Result::Comment",
	{"foreign.id_article" => "self.id_article"},
	{cascade_copy         => 0, cascade_delete => 0},
);

__PACKAGE__->belongs_to(
	"Author",
	"Demo::Schema::Result::Author",
	{id_author     => "id_author"},
	{is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION"},
);

1;
