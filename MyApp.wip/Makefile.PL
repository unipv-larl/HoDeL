# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'MyApp';
all_from 'lib/MyApp.pm';

requires 'Catalyst::Runtime' => '5.90075';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';

requires 'Catalyst::ScriptRunner';
requires 'Moose';

requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
#catalyst_par_core();   # Include modules that are also included
                       # in the standard Perl distribution,
                       # this is optional but highly suggested

#catalyst_par();        # Generate a PAR as soon as the blib
                       # directory is ready

catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
