package Devel::REPL::Profile::Default;

use Moose;
use namespace::autoclean;

# for backcompat only - Default was renamed to Standard

extends 'Devel::REPL::Profile::Standard';

1;
