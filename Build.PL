use inc::Lift::Build;

my $build = Lift::Build->new(
    module_name         => 'Lift',
    license             => 'gpl',
    build_requires      => {
    },
    recommends          => {
    },
    script_files        => [ glob('script/*') ],
    create_readme       => 1,
    sign                => 1,
);
$build->create_build_script;

