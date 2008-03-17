package Lift::Command;
use strict;
use warnings;

our $VERSION = '0.1.' . (qw$Rev: 0$)[1];

my %commands = (
    Config  => 'config',
    Help    => 'help',
);

while (my ($pack, $command) = each %commands) {
    my $sub = sub {
        my $class = shift;
        $class .= '::' . $pack;
        (my $mod = "$class.pm") =~ s{::|'}{/}g;
        require $mod;
        unshift @_, $class;
        goto $class->can('run');
    };
    $method = "COMMAND_command";
    no strict 'refs';   ## no critic
    *$method = $sub;
}

sub run {
    my $class = shift;
    my @config_spec = $class->config_spec(@_);
    Getopt::Long::Configure('gnu_getopt');
    my $config = {};
    my $ret = Getopt::Long::GetOptionsFromArray(\@_, $config, @config_spec);
    return $class->execute($config);
}

sub config_spec {
    my $class = shift;
    return ();
}

sub execute;

1;

__END__

=head1

Perl::Module - A Perl Module

=cut

