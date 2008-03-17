package Lift::Server::Handler::Apache2;
use strict;
use warnings;

our $VERSION = '0.1.1';

use base qw(Lift::Server::Handler);

use Apache2::RequestRec;
use Apache2::RequestIO;
use Apache2::RequestUtil;
use Apache2::Response;
use Apache2::Const -compile => qw(:common);
use Apache2::Request;

use Lift::Server;

use Carp qw(croak);

my %response_mapping = (
    Lift::Server::Handler::RESPONSE_OK      => Apache2::Const::OK,
    Lift::Server::Handler::RESPONSE_ERROR   => Apache2::Const::SERVER_ERROR,
    Lift::Server::Handler::RESPONSE_SKIP    => Apache2::Const::DECLINED,
);

sub handler : method {
    my $class = shift;
    my $request = Apache2::Request->new(shift);
    my $self = $class->new($request);
    my $server = Lift::Server->new;
    my $config = $request->dir_config('lift_config');
    $server->load_config($config);
    my $result = $server->process_request($self);
    if (exists $response_mapping{$result}) {
        return $response_mapping{$result};
    }
    return Apache2::Const::SERVER_ERROR;
}

sub new {
    my $class = shift;
    my $request = shift;
    my $self = bless {
        request => $request,
    }, $class;
    return $self;
}

sub param {
    my $self = shift;
    my $param = shift;
    return $self->{request}->param($param);
}

sub file {
    my $self = shift;
    my $file = shift;
    return $self->{request}->upload($file);
}

sub header {
    my $self = shift;
    my $header = shift;
    my $value = shift;
    croak "Not yet implemented";
}

sub io {
    my $self = shift;
    return $self->{request};
}

sub redirect {
    my $self = shift;
    croak "Not yet implemented";
}
sub content_type {
    my $self = shift;
    return $self->{request}->content_type(@_);
}

sub print {
    my $self = shift;
    $self->{request}->print(@_);
    return 1;
}

1;

__END__

=head1

Lift::Server::Apache2 - Apache2 Handler for Lift

=cut

