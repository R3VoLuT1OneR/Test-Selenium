use strict;
use warnings;
use Test::More;
use Test::Deep;
use t::lib::TempFile;

{
    package Selenium::Test;
    use Moose;
    extends 'Test::Selenium';
    with 'Test::Selenium::Role::DataProvider';
}

my $datafile_yaml_1 = t::lib::TempFile->new(SUFFIX=>'.yaml')->write_to_file("test: 'yo'\n");
my $datafile_yaml_2 = t::lib::TempFile->new(SUFFIX=>'.yaml')->write_to_file("test2: 'yo2'\n");
my $datafile_json_1 = t::lib::TempFile->new(SUFFIX=>'.json')->write_to_file('{"testj":"yoj"}');

plan tests => 3;

    cmp_deeply(
        Selenium::Test->new(datafile => [$datafile_yaml_1->filename])->data,
        { test => 'yo' },
        'Reading 1 YAML file',
    );

    cmp_deeply(
        Selenium::Test->new(datafile => [$datafile_json_1->filename])->data,
        { testj => 'yoj' },
        'Reading 1 JSON file',
    );

    cmp_deeply(
        Selenium::Test->new(
            datafile => [$datafile_yaml_1->filename,$datafile_yaml_2->filename]
        )->data,
        { test => 'yo', 'test2' => 'yo2' },
        'Reading 2 YAML files',
    );

done_testing;
