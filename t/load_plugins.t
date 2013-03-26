use strict;
use warnings;

use Test::More;

use FindBin qw($Bin);
use lib "$Bin/../t/lib";

use_ok('Devel::REPL');

my @plugins = qw/
B::Concise
Colors
Commands
Completion
CompletionDriver::Globals
CompletionDriver::INC
CompletionDriver::Keywords
CompletionDriver::LexEnv
CompletionDriver::Methods
CompletionDriver::Turtles
DDC
DDS
DumpHistory
FancyPrompt
FindVariable
History
Interrupt
LexEnv
MultiLine::PPI
Nopaste
OutputCache
PPI
Packages
Peek
ReadLineHistory
Refresh
ShowClass
Timing
Turtles
/;

for my $plugin_name (@plugins) {
    test_load_plugin($plugin_name);
}

sub test_load_plugin {
    my ($plugin_name) = @_;
    my $repl = Devel::REPL->new;
    my $test_name = "plugin $plugin_name loaded";
    eval "use Devel::REPL::Plugin::$plugin_name";
    unless($@) {
        eval { $repl->load_plugin($plugin_name) };
        ok(!$@, $test_name);
    } else {
        SKIP: {
                skip "could not eval plugin $plugin_name", 1;
        }
    }
}

done_testing;

