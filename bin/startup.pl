#!/usr/bin/perl

use lib qw'app /home/pef/pef-front-psgi-dist/lib /home/pef/dbix-struct/lib';

use Demo::AppFrontConfig;
use PEF::Front::Connector;
use PEF::Front::Preload;
use Demo::Schema;
my $schema = Demo::Schema->connect([sub {db_connect->dbh}]);

use PEF::Front::Route (
	'/'               => ['/index', 'R'],
	qr'/index(.*)'    => '/appIndex$1',
	qr'/article/(.*)' => '/appArticle/$1',
	'/add'            => '/appAddArticle',
	qr'/edit/(.*)'    => '/appEditArticle/$1'
);

PEF::Front::Route->to_app();
