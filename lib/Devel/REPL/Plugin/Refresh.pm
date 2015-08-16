use strict;
use warnings;
package Devel::REPL::Plugin::Refresh;
# ABSTRACT: Reload libraries with Module::Refresh

our $VERSION = '1.003028';

use Devel::REPL::Plugin;
use namespace::autoclean;
use Module::Refresh;

# before evaluating the code, ask Module::Refresh to refresh
# the modules that have changed
around 'eval' => sub {
    my $orig = shift;
    my ($self, $line) = @_;

    # first refresh the changed modules
    Module::Refresh->refresh;

    # the eval the code
    return $self->$orig($line);
};

1;
