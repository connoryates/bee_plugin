package Bee::Config;
use Moo;

use YAML::XS 'LoadFile';
use Carp 'confess';

has 'config' => ( is   => 'lazy' );

sub _build_config {
    my $self = shift;

    # Assuming you're on a UINX based system
    my $config = LoadFile("/home/$ENV{USER}/environments/bee.yml") or confess "Cannot open environment file!";

    return $config;
}

__PACKAGE__->meta->make_immutable;

