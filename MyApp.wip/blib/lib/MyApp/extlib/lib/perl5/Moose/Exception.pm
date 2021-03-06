package Moose::Exception;
$Moose::Exception::VERSION = '2.1213';
use Moose;
use Devel::StackTrace 1.33;

has 'trace' => (
    is            => 'ro',
    isa           => 'Devel::StackTrace',
    builder       => '_build_trace',
    lazy          => 1,
    documentation => "This attribute is read-only and isa L<Devel::StackTrace>. ".
                     'It is lazy & dependent on $exception->message.'
);

has 'message' => (
    is            => 'ro',
    isa           => 'Str',
    builder       => '_build_message',
    lazy          => 1,
    documentation => "This attribute is read-only and isa Str. ".
                     "It is lazy and has a default value 'Error'."
);

use overload
    '""' => sub {
        my $self = shift;
        return $self->trace->as_string,
    },
    fallback => 1,
;

sub _build_trace {
    my $self = shift;

    # skip frames that are method calls on the exception object, which include
    # the object itself in the arguments (but Devel::LeakTrace really ought to
    # be weakening all references in its frames)
    my $skip = 0;
    while (my @c = caller(++$skip)) {
        last if $c[3] =~ /^(.*)::new$/ && $self->isa($1);
    }
    $skip++;

    Devel::StackTrace->new(
        message => $self->message,
        indent  => 1,
        skip_frames => $skip,
    );
}

sub _build_message {
    "Error";
}

sub BUILD {
    my $self = shift;
    $self->trace;
}

1;

# ABSTRACT: Superclass for Moose internal exceptions

__END__

=pod

=encoding UTF-8

=head1 NAME

Moose::Exception - Superclass for Moose internal exceptions

=head1 VERSION

version 2.1213

=head1 DESCRIPTION

This class contains attributes which are common to all Moose internal
exception classes.

=head1 WARNING WARNING WARNING

If you're writing your own exception classes, you should instead prefer
the L<Throwable> role or the L<Throwable::Error> superclass - this is
effectively a cut-down internal fork of the latter, and not designed
for use in user code.

Of course if you're writing metaclass traits, it would then make sense to
subclass the relevant Moose exceptions - but only then.

=head1 ATTRIBUTES

=over 4

=item B<< $exception->trace >>

This attribute contains the stack trace for the given exception. It
is read-only and isa L<Devel::StackTrace>. It is lazy & dependent
on $exception->message.

=item B<< $exception->message >>

This attribute contains the exception message. It is read-only and isa Str.
It is lazy and has a default value 'Error'. Every subclass of L<Moose::Exception>
is expected to override _build_message method.

=back

=head1 SEE ALSO

=over 4

=item * L<Moose::Manual::Exceptions>

=back

=head1 AUTHORS

=over 4

=item *

Stevan Little <stevan.little@iinteractive.com>

=item *

Dave Rolsky <autarch@urth.org>

=item *

Jesse Luehrs <doy@tozt.net>

=item *

Shawn M Moore <code@sartak.org>

=item *

???????? ??????'???? (Yuval Kogman) <nothingmuch@woobling.org>

=item *

Karen Etheridge <ether@cpan.org>

=item *

Florian Ragwitz <rafl@debian.org>

=item *

Hans Dieter Pearcey <hdp@weftsoar.net>

=item *

Chris Prather <chris@prather.org>

=item *

Matt S Trout <mst@shadowcat.co.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2006 by Infinity Interactive, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
