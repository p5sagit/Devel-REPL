# NAME

Devel::REPL - a modern perl interactive shell

# VERSION

version 1.003026

# SYNOPSIS

    my $repl = Devel::REPL->new;
    $repl->load_plugin($_) for qw(History LexEnv);
    $repl->run

Alternatively, use the 're.pl' script installed with the distribution

    system$ re.pl

# DESCRIPTION

This is an interactive shell for Perl, commonly known as a REPL - Read,
Evaluate, Print, Loop. The shell provides for rapid development or testing
of code without the need to create a temporary source code file.

Through a plugin system, many features are available on demand. You can also
tailor the environment through the use of profiles and run control files, for
example to pre-load certain Perl modules when working on a particular project.

# USAGE

To start a shell, follow one of the examples in the ["SYNOPSIS"](#synopsis) above.

Once running, the shell accepts and will attempt to execute any code given. If
the code executes successfully you'll be shown the result, otherwise an error
message will be returned. Here are a few examples:

    $_ print "Hello, world!\n"
    Hello, world!
    1
    $_ nosuchfunction
    Compile error: Bareword "nosuchfunction" not allowed while "strict subs" in use at (eval 130) line 5.

    $_

In the first example above you see the output of the command (`Hello,
world!`), if any, and then the return value of the statement (`1`). Following
that example, an error is returned when the execution of some code fails.

Note that the lack of semicolon on the end is not a mistake - the code is
run inside a Block structure (to protect the REPL in case the code blows up),
which means a single statement doesn't require the semicolon. You can add one
if you like, though.

If you followed the first example in the ["SYNOPSIS"](#synopsis) above, you'll have the
[History](https://metacpan.org/pod/Devel::REPL::Plugin::History) and [LexEnv](https://metacpan.org/pod/Devel::REPL::Plugin::LexEnv)
plugins loaded (and there are many more available).
Although the shell might support "up-arrow" history, the History plugin adds
"bang" history to that so you can re-execute chosen commands (with e.g.
`!53`). The LexEnv plugin ensures that lexical variables declared with the
`my` keyword will automatically persist between statements executed in the
REPL shell.

When you `use` any Perl module, the `import()` will work as expected - the
exported functions from that module are available for immediate use:

    $_ carp "I'm dieeeing!\n"
    String found where operator expected at (eval 129) line 5, near "carp "I'm dieeeing!\n""
            (Do you need to predeclare carp?)
    Compile error: syntax error at (eval 129) line 5, near "carp "I'm dieeeing!\n""
    BEGIN not safe after errors--compilation aborted at (eval 129) line 5.

    $_ use Carp

    $_ carp "I'm dieeeing!\n"
    I'm dieeeing!
     at /usr/share/perl5/Lexical/Persistence.pm line 327
    1
    $_

To quit from the shell, hit `Ctrl+D` or `Ctrl+C`.

    MSWin32 NOTE: control keys won't work if TERM=dumb
    because readline functionality will be disabled.

## Run Control Files

For particular projects you might well end up running the same commands each
time the REPL shell starts up - loading Perl modules, setting configuration,
and so on. A run control file lets you have this done automatically, and you
can have multiple files for different projects.

By default the `re.pl` program looks for `$HOME/.re.pl/repl.rc`, and
runs whatever code is in there as if you had entered it at the REPL shell
yourself.

To set a new run control file that's also in that directory, pass it as a
filename like so:

    system$ re.pl --rcfile myproject.pc

If the filename happens to contain a forward slash, then it's used absolutely,
or realive to the current working directory:

    system$ re.pl --rcfile /path/to/my/project/repl.rc

Within the run control file you might want to load plugins. This is covered in
["The REPL shell object"](#the-repl-shell-object) section, below.

## Profiles

To allow for the sharing of run control files, you can fashion them into a
Perl module for distribution (perhaps via the CPAN). For more information on
this feature, please see the [Devel::REPL::Profile](https://metacpan.org/pod/Devel::REPL::Profile) manual page.

A `Standard` profile ships with `Devel::REPL`; it loads the following plugins
(note that some of these require optional features -- or you can also use the
`Minimal` profile):

- [Devel::REPL::Plugin::History](https://metacpan.org/pod/Devel::REPL::Plugin::History)
- [Devel::REPL::Plugin::LexEnv](https://metacpan.org/pod/Devel::REPL::Plugin::LexEnv)
- [Devel::REPL::Plugin::DDS](https://metacpan.org/pod/Devel::REPL::Plugin::DDS)
- [Devel::REPL::Plugin::Packages](https://metacpan.org/pod/Devel::REPL::Plugin::Packages)
- [Devel::REPL::Plugin::Commands](https://metacpan.org/pod/Devel::REPL::Plugin::Commands)
- [Devel::REPL::Plugin::MultiLine::PPI](https://metacpan.org/pod/Devel::REPL::Plugin::MultiLine::PPI)
- [Devel::REPL::Plugin::Colors](https://metacpan.org/pod/Devel::REPL::Plugin::Colors)
- [Devel::REPL::Plugin::Completion](https://metacpan.org/pod/Devel::REPL::Plugin::Completion)
- [Devel::REPL::Plugin::CompletionDriver::INC](https://metacpan.org/pod/Devel::REPL::Plugin::CompletionDriver::INC)
- [Devel::REPL::Plugin::CompletionDriver::LexEnv](https://metacpan.org/pod/Devel::REPL::Plugin::CompletionDriver::LexEnv)
- [Devel::REPL::Plugin::CompletionDriver::Keywords](https://metacpan.org/pod/Devel::REPL::Plugin::CompletionDriver::Keywords)
- [Devel::REPL::Plugin::CompletionDriver::Methods](https://metacpan.org/pod/Devel::REPL::Plugin::CompletionDriver::Methods)
- [Devel::REPL::Plugin::ReadlineHistory](https://metacpan.org/pod/Devel::REPL::Plugin::ReadlineHistory)

## Plugins

Plugins are a way to add functionality to the REPL shell, and take advantage of
`Devel::REPL` being based on the [Moose](https://metacpan.org/pod/Moose) object system for Perl 5. This
means it's simple to 'hook into' many steps of the R-E-P-L process. Plugins
can change the way commands are interpreted, or the way their results are
output, or even add commands to the shell environment.

A number of plugins ship with `Devel::REPL`, and more are available on the
CPAN. Some of the shipped plugins are loaded in the default profile, mentioned
above.  These plugins can be loaded in your ` $HOME/.re.pl/repl.rc ` like:

    load_plugin qw( CompletionDriver::Global DumpHistory );

Writing your own plugins is not difficult, and is discussed in the
[Devel::REPL::Plugin](https://metacpan.org/pod/Devel::REPL::Plugin) manual page, along with links to the manual pages of
all the plugins shipped with `Devel::REPL`.

## The REPL shell object

From time to time you'll want to interact with or manipulate the
`Devel::REPL` shell object itself; that is, the instance of the shell you're
currently running.

The object is always available through the `$_REPL` variable. One common
requirement is to load an additional plugin, after your profile and run
control files have already been executed:

    $_ $_REPL->load_plugin('Timing');
    1
    $_ print "Hello again, world!\n"
    Hello again, world!
    Took 0.00148296356201172 seconds.
    1
    $_

# OPTIONAL FEATURES

In addition to the prerequisites declared in this distribution, which should be automatically installed by your [CPAN](https://metacpan.org/pod/CPAN) client, there are a number of optional features, used by
additional plugins. You can install any of these features by installing this
distribution interactively (e.g. `cpanm --interactive Devel::REPL`).

- Completion plugin - extensible tab completion
- DDS plugin - better format results with Data::Dump::Streamer
- DDC plugin - even better format results with Data::Dumper::Concise
- INC completion driver - tab complete module names in use and require
- Interrupt plugin - traps SIGINT to kill long-running lines
- Keywords completion driver - tab complete Perl keywords and operators
- LexEnv plugin - variables declared with "my" persist between statements
- MultiLine::PPI plugin - continue reading lines until all blocks are closed
- Nopaste plugin - upload a session\\'s input and output to a Pastebin
- PPI plugin - PPI dumping of Perl code
- Refresh plugin - automatically reload libraries with Module::Refresh

# AUTHOR

Matt S Trout - mst (at) shadowcatsystems.co.uk ([http://www.shadowcatsystems.co.uk/](http://www.shadowcatsystems.co.uk/))

# CONTRIBUTORS

- Stevan Little - stevan (at) iinteractive.com
- Alexis Sukrieh - sukria+perl (at) sukria.net
- epitaph
- mgrimes - mgrimes (at) cpan dot org
- Shawn M Moore - sartak (at) gmail.com
- Oliver Gorwits - oliver on irc.perl.org
- Andrew Moore - `<amoore@cpan.org>`
- Norbert Buchmuller `<norbi@nix.hu>`
- Dave Houston `<dhouston@cpan.org>`
- Chris Marshall
- Karen Etheridge `<ether@cpan.org>`

# LICENSE

This library is free software under the same terms as perl itself
