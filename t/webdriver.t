#!/usr/bin/perl
use warnings;
use strict;

use Test::Selenium;

{
    package Test::Selenium::Cart::DataProvider;
    use Moose;
    use Getopt::Long qw(:config pass_through);
    with 'MooseX::Getopt' => { pass_through => 1 };
    with 'MooseX::SimpleConfig';

    has product_id => (
        is => 'ro',
        isa => 'Int',
        required => 1,
    );
}

my $driver = Test::Selenium->new_with_options;
my $data   = Test::Selenium::Cart::DataProvider->new_with_options;
