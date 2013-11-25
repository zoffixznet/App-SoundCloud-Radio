package App::Soundcloud::Radio;

use 5.006;
use strict;
use warnings FATAL => 'all';
our $VERSION = '0.001';

use Data::Dumper;
use WebService::Soundcloud;
use Moo;

has client_id => (
    is          => 'ro',
    required    => 1,
    init_arg    => 'client_id',
);

has client_secret => (
    is => 'ro',
    required => 1,
    init_arg => 'client_secret',
);

has _cloud        => ( is => 'lazy', );

sub _build__cloud {
    my $self = shift;
    my $cloud = WebService::Soundcloud->new(
        $self->client_id,
        $self->client_secret,
        {
            redirect_uri
            => 'http://metacpan.org/pod/App::Soundcloud::Radio',
        },
    );
    print 'Click on this link and login to SoundCloud: '
        . $cloud->get_authorization_url . "\n";

    print 'Copy/paste the `code` query parameter from the URL'
        . q{ you're redirected to, then press ENTER key when you've}
        . " done so\n";

    chomp( my $code = readline STDIN );

    $cloud->get_access_token( $code );
    # Get Access Token
#     my $access_token = $cloud->get_access_token( $code );
#
#     # Save access_token and refresh_token, expires_in, scope for future use
#     my $oauth_token = $access_token->{access_token};
#
#     # OAuth Dance is completed :-) Have fun now.



    return $cloud;
}

sub play_tag {
    my ( $self, $tag ) = @_;

    my $res = $self->_cloud->get('http://soundcloud.com/forss/flickermood');
    my ( $track_id ) = $res->content =~ /"track_id":(\d+)/;
    $self->_cloud->get(
        '/tracks/' . $track_id . '/stream',
    );

    open my $fh, '>', 'out.mp3' or die $!;
    print "Printing the stream into the filehandle\n";
    print $fh     $self->_cloud->get(
        '/tracks/' . $track_id . '/stream',
    )->content;
    print "Done saving the stream\n";


#     print "Playing tag $tag\n";
}



1;
__END__

=head1 NAME

App::Soundcloud::Radio - a command-line app for using Soundcloud.com as a radio

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use App::Soundcloud::Radio;

    my $foo = App::Soundcloud::Radio->new();
    ...

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>


=head1 GIT

This module has a GIT repository:
L<https://github.com/zoffixznet/App-SoundCloud-Radio>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-app-soundcloud-radio at rt.cpan.org>, or through
the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-Soundcloud-Radio>.
I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::Soundcloud::Radio

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-Soundcloud-Radio>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-Soundcloud-Radio>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-Soundcloud-Radio>

=item * Search CPAN

L<http://search.cpan.org/dist/App-Soundcloud-Radio/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Zoffix Znet.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut