use inc::Module::Install;

RTx 'RTFM-Extension-ArticleTemplates';
license 'GPL Version 2';
all_from 'lib/RTFM/Extension/ArticleTemplates.pm';
author   'Kevin Falcone <falcone@bestpractical.com>';

build_requires 'Test::More';
requires('RT::FM' => 2.2.2);

auto_install;

WriteAll;

