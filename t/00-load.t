#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'App::Soundcloud::Radio' ) || print "Bail out!\n";
}

diag( "Testing App::Soundcloud::Radio $App::Soundcloud::Radio::VERSION, Perl $], $^X" );
