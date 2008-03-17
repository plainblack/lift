#!/usr/bin/env perl
use strict;
use warnings;

our $VERSION = '0.1.' . (qw$Rev: 0$)[1];

use Lift::CLI;
use Carp;

my $command = lc shift @ARGV;
$command ||= 'help';

my $method = "COMMAND_$command";
if (!Lift::CLI->can($method)) {
    carp "Invalid command '$command'!\n";
    $method = "COMMAND_help";
}
Lift::CLI->$method(@ARGV);

__END__

use Getopt::Long qw();
use Pod::Usage qw();

Getopt::Long::Configure(qw(gnu_getopt));
Getopt::Long::GetOptions(
    'h|?|help'      => \(my $opt_help),
    'man'           => \(my $opt_man),
    'V|ver|version' => \(my $opt_version),
) || pod2usage(2);
if ($opt_help) {
    pod2usage(1);
}
elsif ($opt_man) {
    pod2usage(-verbose => 2);
}
elsif ($opt_ver) {
    print "lift_settings.pl - version $VERSION\n";
    exit;
}

__END__

=head1

lift_settings.pl - Control settings for Lift upgrade system

=cut

