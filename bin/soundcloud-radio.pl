#!perl

use strict;
use warnings;
use lib qw(lib  ../lib);
use App::Soundcloud::Radio;
use Data::Dumper;

my $client_id     = '207b7984193776fd94ee05d06c746790';
my $client_secret = '7c2907c3e28e011a6160be5f1f39b661';

my $radio = App::Soundcloud::Radio->new(
    client_id     => $client_id,
    client_secret => $client_secret,
);
$radio->play_tag('dubstep');