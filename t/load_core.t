use strict;
use warnings;

use Test::More;
use Test::Warnings;

use_ok('Devel::REPL');
use_ok('Devel::REPL::Script');
use_ok('Devel::REPL::Plugin::Colors');
use_ok('Devel::REPL::Plugin::Commands');

eval 'use PPI; 1'
    and use_ok('Devel::REPL::Plugin::Completion');

eval 'use File::Next; 1'
    and use_ok('Devel::REPL::Plugin::CompletionDriver::INC');

eval 'use B::Keywords; 1'
    and use_ok('Devel::REPL::Plugin::CompletionDriver::Keywords');

eval 'use Lexical::Persistence; 1'
    and use_ok('Devel::REPL::Plugin::CompletionDriver::LexEnv')
    and use_ok('Devel::REPL::Plugin::LexEnv');

use_ok('Devel::REPL::Plugin::CompletionDriver::Globals');
use_ok('Devel::REPL::Plugin::CompletionDriver::Methods');

eval 'use Data::Dump::Concise; 1'
    and use_ok('Devel::REPL::Plugin::DDC');

eval 'use Data::Dump::Streamer; 1'
    and use_ok('Devel::REPL::Plugin::DDS');

use_ok('Devel::REPL::Plugin::DumpHistory');
use_ok('Devel::REPL::Plugin::FancyPrompt');
use_ok('Devel::REPL::Plugin::FindVariable');
use_ok('Devel::REPL::Plugin::History');

eval 'use Sys::SigAction; 1'
    and use_ok('Devel::REPL::Plugin::Interrupt');

# use_ok('Devel::REPL::Plugin::Interrupt') unless $^O eq 'MSWin32';

eval 'use PPI; 1'
    and use_ok('Devel::REPL::Plugin::MultiLine::PPI');

eval 'use App::Nopaste; 1'
    and use_ok('Devel::REPL::Plugin::Nopaste');

use_ok('Devel::REPL::Plugin::OutputCache');
use_ok('Devel::REPL::Plugin::Packages');
use_ok('Devel::REPL::Plugin::Peek');

eval 'use PPI; 1'
    and use_ok('Devel::REPL::Plugin::PPI');

use_ok('Devel::REPL::Plugin::ReadLineHistory');

eval 'use Module::Refresh; 1'
    and use_ok('Devel::REPL::Plugin::Refresh');

use_ok('Devel::REPL::Plugin::ShowClass');
use_ok('Devel::REPL::Plugin::Timing');
use_ok('Devel::REPL::Plugin::Turtles');

done_testing;
