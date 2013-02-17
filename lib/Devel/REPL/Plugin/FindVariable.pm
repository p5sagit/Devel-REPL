package Devel::REPL::Plugin::FindVariable;

use Devel::REPL::Plugin;
use namespace::sweep;
use Package::Stash;

sub find_variable {
    my ($self, $name) = @_;

    return \$self if $name eq '$_REPL';

    # XXX: this code needs to live in LexEnv
    if ($self->can('lexical_environment')) {
        return \( $self->lexical_environment->get_context('_')->{$name} )
            if exists $self->lexical_environment->get_context('_')->{$name};
    }

    my $sigil = $name =~ s/^([\$\@\%\&\*])// ? $1 : '';

    my $default_package = $self->can('current_package')
                        ? $self->current_package
                        : 'main';
    my $package = $name =~ s/^(.*)(::|')// ? $1 : $default_package;

    my $meta = Package::Stash->new($package);

    # Package::Stash::has_symbol method *requires* a sigil
    return unless length($sigil) and $meta->has_symbol("$sigil$name");
    $meta->get_symbol("$sigil$name");
}

1;

__END__

=head1 NAME

Devel::REPL::Plugin::FindVariable - Finds variables by name

=head1 AUTHOR

Shawn M Moore, C<< <sartak at gmail dot com> >>

=cut

