package Lift;

use strict;
use warnings;

our $VERSION = '0.1.0';

use Class::InsideOut qw(private public register id);

sub new {
    my $class = shift;
    croak __PACKAGE__ . "->new is a class method, not an instance method" if ref $class;
    my $self = register($class);
    return $self;
}

1;

__END__

=head1 NAME

Lift - A patching update system

=head1 SYNOPSIS

Check for available updates

  lift.pl updates

=head1 DESCRIPTION

Installs updates

=head1 AUTHOR

Graham Knop <graham@plainblack.com>

=head1 COPYRIGHT

Copyright (c) 2008 Plain Black Corp.  All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the terms of the GPL version 2.

=cut

