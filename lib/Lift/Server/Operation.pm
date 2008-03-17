package Lift::Server::Operation;
use strict;
use warnings;

our $VERSION = '0.1.1';

use Carp;
use Lift::Server::Handler;
use Template;

sub import {
    my $class = shift;
    for (@_) {
        if ($_ eq ':preload') {
            $class->preload;
        }
    }
    return 1;
}

sub preload {
    require Lift::Server::Operation::Home;
    # load all submodules
}

sub get {
    my $op = shift;
    if ($op =~ /\W/) {
        croak "Invalid operation '$op'!";
    }
    my $class = "Lift::Server::Operation::$op";
    (my $module = "$class.pm") =~ s{::|'}{/}g;
    if (eval {require $module; 1}) {
        return $class;
    }
    croak "Invalid operation '$op'!";
}

sub new {
    my $class = shift;
    my $server = shift;
    my $self = bless {server => $server}, $class;
    return $self;
}

sub call {
    my $self = shift;
    my $data = $self->process;
    $self->process_template($data);
    return Lift::Server::Handler::RESPONSE_OK;
}

sub process {
    return {};
}

sub process_template {
    my $self = shift;
    my $data = shift;
    my $processor = Template->new({
        INCLUDE_PATH    => [
            $self->server->{config}{templatedir},
        ],
    });
    my $template = $self->template;
    $self->handler->content_type($self->content_type);
    $processor->process($template, $data, $self->handler->io);
}

sub content_type {
    my $self = shift;
    if ($_[0]) {
        return $self->{content_type} = shift;
    }
    return $self->{content_type} || 'text/html';
}

sub param {
    return shift->{server}->handler->param(@_);
}
sub handler {
    return shift->{server}->handler;
}
sub server {
    return shift->{server};
}
sub dbh {
    return shift->{server}->dbh;
}

1;

__END__

=head1

Perl::Module - A Perl Module

=cut

