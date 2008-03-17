package Lift::Server::Operation::Package;
use strict;
use warnings;

our $VERSION = '0.1.1';

use base qw(Lift::Server::Operation);

sub template { 'available' };

sub process {
    my $self = shift;
    my @params = $self->param;
    my %all_products;
    my $sth = $self->dbh->prepare("SELECT id, name FROM product");
    $sth->execute;
    while (my ($id, $name) = $sth->fetch) {
        $all_products{$id} = $name;
    }
    my %products;
    for my $param (@params) {
        if ($param =~ m/^product-(\d+)/) {
            $products{$1} - $self->param($param);
        }
    }
    

}

1;

__END__

=head1


=cut

