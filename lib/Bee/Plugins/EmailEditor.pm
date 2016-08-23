package Bee::Plugins::EmailEditor;

use Dancer::Syntax;
use Dancer::Plugin;

use Bee::Controllers::EmailEditor;
use Bee::Config;

register 'token_manager' => sub {
    my $config = Bee::Config->new->config;

    return Bee::Controllers::EmailEditor->new(
        client_id     => $config->{bee}->{client_id},
        client_secret => $config->{bee}->{client_secret},
        base_url      => $config->{bee}->{base_url},
    );
};


register 'bee_manager' => sub {
    return Bee::Controllers::EmailEditor->new();
};

register_plugin;

true;
