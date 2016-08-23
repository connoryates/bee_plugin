package Bee::Controllers::EmailEditor;
use Moo;

use Furl;
use URI;

has 'client_id'     => ( is => 'rw' );
has 'client_secret' => ( is => 'rw' );
has 'base_url'      => ( is => 'rw' );

sub get_token {
    my $self = shift; 
    my $furl = Furl->new;
    my $uri  = URI->new($self->base_url);

    foreach my $required (qw(client_id client_secret base_url)) {
        return undef unless defined $self->$required;
    }

    my $resp = $furl->post(
        $uri,
        [],
        [
            grant_type    => 'password',
            client_id     => $self->client_id,
            client_secret => $self->client_secret,
        ],
    );

    # The token is considered the entire JSON structure, not just the access_token key
    my $token = $resp->content;
    return $token || {};
}

sub email {
    my ($self, $params) = @_;
    # Email logic goes here
    return;
}

sub get_client_config {
    my $self = shift;
    # Load client config from wherever you store it
    return;
}

sub get_saved_template {
    my ($self, $template_name) = @_;
    # Load template by name from wherever they are saved
    return;
}

sub save_email {
    my ($self, $params) = @_;
    # Save the HTML and JSON files
    return;
}

sub save_template {
    my ($self, $params) = @_;
    # Save just the JSON file
    return;
}

sub autosave {
    my ($self, $params) = @_;
    # Logic for autosave feature
    return;
}

__PACKAGE__->meta->make_immutable;
