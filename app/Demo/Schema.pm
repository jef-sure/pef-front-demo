use utf8;
package Demo::Schema;

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;

our $s;

sub connect {
	$s = shift->SUPER::connect(@_);
}

1;
