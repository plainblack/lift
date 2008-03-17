package inc::Lift::Build;
use strict;
use warnings;

sub import {
    use lib qw(inc);
}

package Lift::Build;
use Module::Build;
our @ISA = qw(Module::Build);

sub new {
    my $class = shift;
    my %config = @_;
    $config{test_types}{author} ||= '.at';
    return $class->SUPER::new(%config);
        
}

sub ACTION_testauthor {
    my $self = shift;
    $self->generic_test(type => 'author');
}

1;

