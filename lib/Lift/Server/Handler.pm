package Lift::Server::Handler;
use strict;
use warnings;

our $VERSION = '0.1.1';

use constant {
    RESPONSE_OK     => 1,
    RESPONSE_ERROR  => 2,
    RESPONSE_SKIP   => 3,
};

sub new;
sub param;
sub print;
sub header;


1;

__END__

=head1

Perl::Module - A Perl Module

=cut

