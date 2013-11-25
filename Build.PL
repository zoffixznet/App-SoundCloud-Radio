use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'App::Soundcloud::Radio',
    license             => 'Artistic_2_0',
    dist_author         => q{Zoffix Znet <zoffix@cpan.org>},
    dist_version_from   => 'lib/App/Soundcloud/Radio.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    add_to_cleanup     => [ 'App-Soundcloud-Radio-*' ],
    create_makefile_pl => 'traditional',
);

if ( $ENV{RELEASE_TESTING} ) {
    system('pod2text lib/App/Soundcloud/Radio.pm > README');
}


$builder->create_build_script();
