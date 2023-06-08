# NAME

Catalyst::Plugin::DetachIfNotModified - Short-circuit requests with If-Modified-Since headers

# VERSION

version v0.3.0

# SYNOPSIS

In your Catalyst class:

```perl
use Catalyst qw/
    DetachIfNotModified
  /;
```

In a controller method:

```perl
my $item = ...

$c->detach_if_not_modified_since( $item->timestamp );

# Do some CPU-intensive stuff or generate response body here.
```

# DESCRIPTION

This plugin will allow your [Catalyst](https://metacpan.org/pod/Catalyst) app to handle requests with
`If-Modified-Since` headers.

If the content of a web page has not been modified since a given date,
you can quickly bail out and avoid generating a web page that you do
not need to.

This can improve the performance of your website.

This should be used with [Plack::Middleware::ConditionalGET](https://metacpan.org/pod/Plack%3A%3AMiddleware%3A%3AConditionalGET).

# METHODS

## detach\_if\_not\_modified\_since

```
$c->detach_if_not_modified_since( @timestamps );
```

This sets the `Last-Modified` header in the response to the
maximum timestamp, and checks if the request contains a
`If-Modified-Since` header that not less than the maximum timestamp.  If it
does, then it will set the response status code to `304` (Not
Modified) and detach.

The `@timestamps` is a list of unix epochs or objects with an `epoch`
method, such as a [DateTime](https://metacpan.org/pod/DateTime) object.

This should only be used with GET or HEAD requests.

If you later need to reset the `Last-Modified` header after calling
this method, you can use

```
$c->res->headers->remove_header('Last-Modified');
```

# CAVEATS

Be careful when aggregating a collection of objects into a single
timestamp, e.g. the maximum timestamp from a list.  If a member is
removed from that collection, then the maximum timestamp won't be
affected, and the result is that an outdated web page may be cached by
user agents.

# SUPPORT FOR OLDER PERL VERSIONS

Since v0.3.0, the this module requires Perl v5.14 or later.

Future releases may only support Perl versions released in the last ten years.

If you need this module on earlier Perls, please use one of the v0.2.x
versions of this module.  Significant bug or security fixes may be
backported to those versions.

# SEE ALSO

[Catalyst](https://metacpan.org/pod/Catalyst)

[Catalyst::Plugin::Cache::HTTP::Preempt](https://metacpan.org/pod/Catalyst%3A%3APlugin%3A%3ACache%3A%3AHTTP%3A%3APreempt)

[Plack::Middleware::ConditionalGET](https://metacpan.org/pod/Plack%3A%3AMiddleware%3A%3AConditionalGET)

[RFC 7232 Section 3.3](https://tools.ietf.org/html/rfc7232#section-3.3)

# SOURCE

The development version is on github at [https://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified](https://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified)
and may be cloned from [git://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified.git](git://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified.git)

# BUGS

Please report any bugs or feature requests on the bugtracker website
[https://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified/issues](https://github.com/robrwo/Catalyst-Plugin-DetachIfNotModified/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Robert Rothenberg <rrwo@cpan.org>

This module is based on code created for Science Photo Library
[https://www.sciencephoto.com](https://www.sciencephoto.com).

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2020-2023 by Robert Rothenberg.

This is free software, licensed under:

```
The Artistic License 2.0 (GPL Compatible)
```
