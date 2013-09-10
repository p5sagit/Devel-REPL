use strict;
use warnings;

use Test::More;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';

use_ok('Devel::REPL');
use_ok('Devel::REPL::Script');
use_ok('Devel::REPL::Plugin::Colors');
use_ok('Devel::REPL::Plugin::Commands');

SKIP: {
    eval 'use PPI; 1' or skip 'PPI not installed: skipping completion plugins', 6;

    use_ok('Devel::REPL::Plugin::Completion');
    use_ok('Devel::REPL::Plugin::CompletionDriver::Globals');
    use_ok('Devel::REPL::Plugin::CompletionDriver::Methods');

    test_plugin('File::Next', 'CompletionDriver::INC');
    test_plugin('B::Keywords', 'CompletionDriver::Keywords');
    test_plugin('Lexical::Persistence', 'CompletionDriver::LexEnv');
};

test_plugin('Lexical::Persistence', 'LexEnv');

test_plugin('Data::Dump::Concise', 'DDC');

test_plugin('Data::Dump::Streamer', 'DDS');

use_ok('Devel::REPL::Plugin::DumpHistory');
use_ok('Devel::REPL::Plugin::FancyPrompt');
use_ok('Devel::REPL::Plugin::FindVariable');
use_ok('Devel::REPL::Plugin::History');

test_plugin('Sys::SigAction', 'Interrupt');

# use_ok('Devel::REPL::Plugin::Interrupt') unless $^O eq 'MSWin32';

test_plugin('PPI', 'MultiLine::PPI');

test_plugin('App::Nopaste', 'Nopaste');

use_ok('Devel::REPL::Plugin::OutputCache');
use_ok('Devel::REPL::Plugin::Packages');
use_ok('Devel::REPL::Plugin::Peek');

test_plugin('PPI' ,'PPI');

use_ok('Devel::REPL::Plugin::ReadLineHistory');

test_plugin('Module::Refresh', 'Refresh');

use_ok('Devel::REPL::Plugin::ShowClass');
use_ok('Devel::REPL::Plugin::Timing');
use_ok('Devel::REPL::Plugin::Turtles');

sub test_plugin
{
    my ($prereq, $plugin) = @_;

    SKIP: {
        eval "use $prereq; 1"
            or skip "$prereq not installed: skipping $plugin", 1;

        use_ok("Devel::REPL::Plugin::$plugin");
    }
}

done_testing;
