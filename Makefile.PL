use inc::Module::Install;

RTx         'RT-Extension-ArticleTemplates';
license     'GPL version 2';
all_from    'lib/RT/Extension/ArticleTemplates.pm';
readme_from 'lib/RT/Extension/ArticleTemplates.pm';

requires_rt('4.0.0');

build_requires 'Test::More';

no_index('package' => 'RT::FM::Article');

sign;

auto_install;

WriteAll;

