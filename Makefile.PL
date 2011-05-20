use inc::Module::Install;

RTx         'RT-Extension-ArticleTemplates';
license     'GPL version 2';
all_from    'lib/RT/Extension/ArticleTemplates.pm';

requires_rt('4.0.0');

build_requires 'Test::More';

sign;

auto_install;

WriteAll;

