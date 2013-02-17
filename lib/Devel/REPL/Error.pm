#!/usr/bin/perl

package Devel::REPL::Error;
use Moo;
use MooX::Types::MooseLike::Base qw(Str Object AnyOf);

# FIXME get nothingmuch to refactor and release his useful error object

has type => (
  isa => Str,
  is  => "ro",
  required => 1,
);

has message => (
  isa => AnyOf[Str, Object],
  is  => "ro",
  required => 1,
);

sub stringify {
  my $self = shift;

  sprintf "%s: %s", $self->type, $self->message;
}
__PACKAGE__

__END__
