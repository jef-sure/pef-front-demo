package Demo::Common;
use Demo::Schema;
use base 'Exporter';
our @EXPORT = qw{
	get_author_from_auth
};

sub get_author_from_auth {
	my $auth = $_[0];
	$Demo::Schema::s->resultset('AuthorAuth')->search({expires => {'<', \"now()"}})->delete_all;
	my $author_auth = $Demo::Schema::s->resultset('AuthorAuth')->search({auth => $auth})->first;
	return if not $author_auth;
	$author_auth->Author;
}

1;
