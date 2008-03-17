package Lift::Client::Settings;
use strict;
use warnings;

our $VERSION = '0.1.' . (qw$Rev: 0$)[1];

use Carp qw(carp croak);
use Data::Dumper qw();

my $settings_file;
my $singleton;
BEGIN {
    ($settings_file = __PACKAGE__ . ".conf") =~ s{::}{/}g;
}

sub new {
    if $singleton {
        $singleton->read_settings;
        return $singleton
    }
    my $class = shift;
    ref $class && croak __PACKAGE__ . "->new is a class method";
    my $self = $singleton = bless {}, $class;
    $self->read_settings;
    return $self;
}

sub read_settings {
    my $self = shift;
    if (-e $settings_file) {
        open my $fh, '<', $settings_file or croak "Unable to read Lift settings file $settings_file: $!";
        my $file_contents = do {local $/; <$fh>};
        my $settings = eval $file_contents;     ## no critic
        close $fh;
        while (my ($key, $value) = each %$settings) {
            $self->{$key} = $value;
        }
    }
    return 1;
}

sub write_settings {
    my $self = shift;
    open my $fh, '>', $settings_file or croak "Unable to write to Lift settings file $settings_file: $!";
    print {$fh} Data::Dumper::Dumper($self);
    close $fh;
    return 1;
}

1;

__END__

=head1

Perl::Module - A Perl Module

=cut

