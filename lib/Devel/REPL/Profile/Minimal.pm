package Devel::REPL::Profile::Minimal;

use Moo;
use namespace::sweep;

with 'Devel::REPL::Profile';

sub plugins {
  qw(History LexEnv DDS Packages Commands MultiLine::PPI);
}

sub apply_profile {
  my ($self, $repl) = @_;
  $repl->load_plugin($_) for $self->plugins;
}

1;
