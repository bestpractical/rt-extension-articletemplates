use strict;
use warnings;

package RT::Extension::ArticleTemplates;

our $VERSION = '0.04';

=head1 NAME

RT::Extension::ArticleTemplates - turns articles into dynamic templates

=head1 DESCRIPTION

When this extension is installed RTFM parses content of articles as
a template using L<Text::Template> module. Using this extension you can
make your articles dynamic. L<Text::Template> module is used to parse
RT's Templates as well and its syntax is pretty simple - you can consult
RT docs/wiki or module's documentation.

=head1 VERY IMPORTANT

It's a B<SECURITY RISK> to install this extension on systems where
articles can be changed by not trusted users. You're warned!

Your articles may contain some text that looks like a template and
will be parsed after installation when it's actually is not valid
template.

=head1 INSTALLATION

This extension requires RT 4.0.0 or higher.

To install it run the following commands:

    perl Makefile.PL
    make
    make install

You'll also need to add RT::Extension::ArticleTemplates to your @Plugins
config line.

=head1 AUTHOR

Kevin Falcone E<lt>falcone@bestpractical.comE<gt>
Ruslan Zakirov E<lt>ruz@bestpractical.comE<gt>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008-2011, Best Practical Solutions, LLC.  All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the terms of version 2 of the GNU General Public License.

=cut

package RT::Article;
use strict;
no warnings qw/redefine/;

=head2 ParseTemplate $CONTENT, %TEMPLATE_ARGS

Parses $CONTENT string as a template (L<Text::Template>).
$Article and other arguments from %TEMPLATE_ARGS are
available in code of the template as perl variables.

=cut

sub ParseTemplate {
    my $self = shift;
    my $content = shift;
    my %args = (
        Ticket => undef,
        @_
    );

    return ($content) unless defined $content && length $content;

    $args{'Article'} = $self;
    $args{'rtname'}  = $RT::rtname;
    if ( $args{'Ticket'} ) {
        my $t = $args{'Ticket'}; # avoid memory leak
        $args{'loc'} = sub { $t->loc(@_) };
    } else {
        $args{'loc'} = sub { $self->loc(@_) };
    }

    foreach my $key ( keys %args ) {
        next unless ref $args{ $key };
        next if ref $args{ $key } =~ /^(ARRAY|HASH|SCALAR|CODE)$/;
        my $val = $args{ $key };
        $args{ $key } = \$val;
    }

    # We need to untaint the content of the template, since we'll be working
    # with it
    $content =~ s/^(.*)$/$1/;
    my $template = Text::Template->new(
        TYPE   => 'STRING',
        SOURCE => $content
    );

    my $is_broken = 0;
    my $retval = $template->fill_in(
        HASH => \%args,
        BROKEN => sub {
            my (%args) = @_;
            $RT::Logger->error("Article parsing error: $args{error}")
                unless $args{error} =~ /^Died at /; # ignore intentional die()
            $is_broken++;
            return undef;
        },
    );
    return ( undef, $self->loc('Article parsing error') ) if $is_broken;

    return ($retval);
}

1;
