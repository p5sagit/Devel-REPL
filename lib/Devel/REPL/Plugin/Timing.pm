use strict;
use warnings;
package Devel::REPL::Plugin::Timing;

our $VERSION = '1.003027';

use Devel::REPL::Plugin;
use Time::HiRes 'time';
use namespace::autoclean;

around 'eval' => sub {
    my $orig = shift;
    my ($self, $line) = @_;

    my @ret;
    my $start = time;

    if (wantarray) {
        @ret = $self->$orig($line);
    }
    else {
        $ret[0] = $self->$orig($line);
    }

    $self->print("Took " . (time - $start) . " seconds.\n");
    return @ret;
};

1;

__END__

=head1 NAME

Devel::REPL::Plugin::Timing - display execution times

=head1 SYNOPSIS

 # in your re.pl file:
 use Devel::REPL;
 my $repl = Devel::REPL->new;
 $repl->load_plugin('Timing');

 # after you run re.pl:
 $ sum map $_*100, 1..100000;
 Took 0.0830280780792236 seconds.
 500005000000

 $

=head1 AUTHOR

Shawn M Moore, C<< <sartak at gmail dot com> >>

=cut

