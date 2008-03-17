package Lift::Command::Help;
use strict;
use warnings;

our $VERSION = '0.1.' . (qw$Rev: 0$)[1];

use Lift::Command;
our @ISA = qw(Lift::Command);

sub execute {
    my $class = shift;
    my $config = shift;
    if ($config->{verbose}) {
        print "verbose\n";
    }
    print "stuff\n";
}

sub config_spec {
    my $class = shift;
    my @spec = qw(
        verbose
    );
    return (@spec, $class->SUPER::config_spec);
}

1;

__END__

=head1

Perl::Module - A Perl Module

=cut

