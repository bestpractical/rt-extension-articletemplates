use inc::Module::Install;

RTx         'RTFM-Extension-ArticleTemplates';
license     'GPL version 2';
all_from    'lib/RTFM/Extension/ArticleTemplates.pm';

build_requires 'Test::More';
# XXX: This should be reported by M::I::RTx
my ($lib_path) = $INC{'RT.pm'} =~ /^(.*)[\\\/]/;
my $local_lib_path = "$RT::LocalPath/lib";

unshift @INC, $local_lib_path, $lib_path;
# XXX: Cannot depend on RT::FM with new plugins subsystem
#requires('RT::FM' => '2.2.2');

auto_install;

WriteAll;

