package Test::Selenium::Role::DataProvider::File;
use Moose::Role;
use Config::Any;

has datafile      => (
    is            => 'ro',
    isa           => 'ArrayRef',
    required      => 1,
    documentation => 'config file for dataprovider ( can be many files )',
);

has data          => (
    is            => 'ro',
    isa           => 'Any',
    traits        => [ 'NoGetopt' ],
    lazy_build    => 1,
);

sub _build_data {
    my $self       = shift;
    my %all_data   = ();
    my $config_any = Config::Any->load_files({
        files           => $self->datafile,
        use_ext         => 1,
        flatten_to_hash => 1,
    });

    foreach my $configfile ( @{$self->datafile} ) {
        unless ( exists $config_any->{$configfile} ) {
            warn "Configfile '$configfile' doesn't exist, is empty or not readable";
            next;
        };

        my $data = $config_any->{$configfile};

        unless ( $data && ref $data && ref $data eq 'HASH' ) {
            warn "Configfile '$configfile' must represent a hash structure";
            next;
        }

        %all_data = ( %all_data, %$data );
    };

    \%all_data;
}

no Moose;
1;
