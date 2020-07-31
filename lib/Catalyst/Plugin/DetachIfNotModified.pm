package Catalyst::Plugin::DetachIfNotModified;

# ABSTRACT: Short-circuit requests with If-Modified-Since headers

use Moose::Role;

use HTTP::Headers 5.18;
use HTTP::Status qw/ HTTP_NOT_MODIFIED /;
use Ref::Util qw/ is_blessed_ref /;

# RECOMMEND PREREQ: Plack::Middleware::ConditionalGET
# RECOMMEND PREREQ: Ref::Util::XS

use namespace::autoclean;

our $VERSION = 'v0.1.1';

=head1 SYNOPSIS

In your Catalyst class:

  use Catalyst qw/
      DetachIfNotModified
    /;

In a controller method:

  my $item = ...

  $c->detach_if_not_modified_since( $item->timestamp );

  # Do some CPU-intensive stuff or generate response body here.

=head1 DESCRIPTION

This plugin will allow your L<Catalyst> app to handle requests with
C<If-Modified-Since> headers.

If the content of a web page has not been modified since a given date,
you can quickly bail out and avoid generating a web page that you do
not need to.

This can improve the performance of your website.

This should be used with L<Plack::Middleware::ConditionalGET>.

=method detach_if_not_modified_since

  $c->detach_if_not_modified_since( $timestamp );

This sets the C<Last-Modified> header in the response to the
C<$timestamp>, and checks if the request contains a
C<If-Modified-Since> header that not less than the timestamp.  If it
does, then it will set the response status code to C<304> (Not
Modified) and detach.

The C<$timestamp> may be a unix epoch, or an object with an C<epoch>
method, such as a L<DateTime> object.

This should only be used with GET or HEAD requests.

=cut

sub detach_if_not_modified_since {
    my ($c, $date) = @_;

    my $time = is_blessed_ref($date) ? $date->epoch : $date;
    my $res  = $c->res;
    $res->headers->last_modified( $time );

    my $hdr = $c->req->headers;
    if (my $since = $hdr->if_modified_since) {
        if ($since >= $time) {
            $res->code(HTTP_NOT_MODIFIED);
            $c->detach;
        }
    }
}

=head1 CAVEATS

Be careful when aggregating a collection of objects into a single
timestamp, e.g. the maximum timestamp from a list.  If a member is
removed from that collection, then the maximum timestamp won't be
affected, and the result is that an outdated web page may be cached by
user agents.

=head1 SEE ALSO

L<Catalyst>

L<Catalyst::Plugin::Cache::HTTP::Preempt>

L<Plack::Middleware::ConditionalGET>

L<RFC 7232 Section 3.3|https://tools.ietf.org/html/rfc7232#section-3.3>

=head1 append:AUTHOR

This module is based on code created for Science Photo Library
L<https://www.sciencephoto.com>.

=cut

1;
