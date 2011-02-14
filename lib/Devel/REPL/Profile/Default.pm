package Devel::REPL::Profile::Default;

use Moose;
use namespace::clean -except => [ 'meta' ];

with 'Devel::REPL::Profile';

sub plugins { qw(
  Colors
  Completion
  CompletionDriver::INC
  CompletionDriver::LexEnv
  CompletionDriver::Keywords
  CompletionDriver::Methods
  History
  LexEnv
  DDS
  Packages
  Commands
  MultiLine::PPI
  ReadLineHistory
);}

sub apply_profile {
  my ($self, $repl) = @_;
  $repl->load_plugin($_) for $self->plugins;
}

1;
