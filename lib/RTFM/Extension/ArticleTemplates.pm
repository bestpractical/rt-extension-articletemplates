package RTFM::Extension::ArticleTemplates;

our $VERSION = '0.01';

use strict;
use warnings;

=head1 NAME

RTFM::Extension::ArticleTemplates - turns articles' custom fields into templates.

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

This extension requires RTFM 2.2.2 at least. To install it run the following
commands:

    perl Makefile.PL
    make
    make install

=head1 AUTHOR

Kevin Falcone  C<< <falcone@bestpractical.com> >>
Ruslan Zakirov C<< <ruz@bestpractical.com> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Best Practical Solutions, LLC.  All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the terms of version 2 of the GNU General Public License.

=cut

1;
