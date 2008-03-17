package Lift::Server;
use strict;
use warnings;

our $VERSION = '0.1.1';

use Template;
use Carp qw(croak);
use Lift::Server::Handler;
use Lift::Server::Operation qw(:preload);
BEGIN {
    no strict;
    if (eval { require YAML::XS; 1 }) {
        *from_yaml = \&YAML::XS::Load;
    }
    elsif (eval { require YAML::Syck; 1 }) {
        *from_yaml = \&YAML::Syck::Load;
    }
    elsif (eval { require YAML; 1 }) {
        *from_yaml = \&YAML::Load;
    }
    else {
        croak "Unable to load any YAML module!";
    }
}

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

sub load_config {
    my $self = shift;
    my $config = shift;
    if (!-f $config || !-r _) {
        croak "Config file '$config' doesn't exist or is not readable!";
    }
    open my $fh, '<', $config or croak "Unable to open config file: $!";
    my $config_data = do { local $/; <$fh> }; # slurp file
    close $fh;
    if (!eval {
        $self->{config} = from_yaml($config_data);
        return 1;
    }) {
        croak "Config file not readable as YAML: $@";
    }
}

sub process_request {
    my $self = shift;
    my $handler = shift;
    $self->handler($handler)
        if $handler;
    my $op_param = $handler->param('op');
    my $op;
    if ($op_param) {
        $op = eval { Lift::Server::Operation::get($op_param) };
    }
    if (!$op) {
        $op = 'Lift::Server::Operation::Home';
    }
    my $operation = $op->new($self);
    return $operation->call;
}

sub handler {
    my $self = shift;
    if ($_[0]) {
        return $self->{handler} = shift;
    }
    return $self->{handler};
}

sub dbh {
    my $self = shift;
    return $self->{dbh}
        if $self->{dbh};
    my $db_config = $self->{config}{database};
    $self->{dbh} = DBI->connect($db_config->{dsn}, $db_config->{username}, $db_config->{username});
    return $self->{dbh};
}

1;

__END__

=head1

Lift::Server - A Perl Module

=cut

