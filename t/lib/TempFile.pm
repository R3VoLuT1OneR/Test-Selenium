package t::lib::TempFile;
use Moose;
use File::Temp;

has tempfile_args => (
    is            => 'ro',
    isa           => 'HashRef',
    predicate     => 'has_tempfile_args',
);

has tempfile      => (
    is            => 'ro',
    isa           => 'File::Temp',
    handles       => [qw(
        filename
    )],
    lazy_build    => 1,
);

sub _build_tempfile {
    my $self = shift;

    File::Temp->new(
       ( $self->has_tempfile_args ? %{ $self->tempfile_args } : () ),
       CLEANUP => 1,
   );
}

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;

    return $class->$orig( tempfile_args => { @_ } ) if ( scalar @_  % 2 == 0 );

    $class->$orig(@_);
};

sub write_to_file {
    my $self = shift;
    my $text = shift;
    my $file = $self->filename;

    open TEMPFILE_FH, ">", $file or die "Can't write to file $file";
    print TEMPFILE_FH $text;
    close TEMPFILE_FH;

    $self;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
