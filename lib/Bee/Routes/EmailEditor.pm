package Bee::Routes::EmailEditor;

use Dancer ':syntax';
use Dancer::Exception;

use Bee::Plugins::EmailEditor;

set serializer => 'JSON';

get '/bee' => sub {
    template 'bee';
};

get '/bee/client_config' => sub {
    my $config;

    try {
        my $bee_manager = bee_manager();
           $config = $bee_manager->get_config;
    } catch {
        send_error("Failed to get config", 500);
    };

    return $config;
};

get '/bee/load_template/:template_name' => sub {
    my $template_name = param 'template_name' || '';

    send_error("Failed to load template", 500) unless defined $template_name;

    my $template;
    try {
        my $bee_manager = bee_manager();
           $template = $bee_manager->get_saved_template($template_name);
    } catch {
        send_error("Failed to load template", 500);
    };

    return $template;
};

post '/bee/save_email' => sub {
    my $params = params || {};

    foreach my $required (qw(json_file html_form template_name)) {
        send_error("Failed to save template", 500) unless defined $params->{$required};
    }

    my $status;
    try {
        my $bee_manager = bee_manager();
           $status = $bee_manager->save_email($params);
    } catch {
        error $_;
        $status = {
            reason => 'Failed to save email',
            status => 'failed',
        };
    };

    return $status;
};

post '/bee/save_template' => sub {
    my $params = params || {};

    foreach my $required (qw(json_file template_name)) {
        send_error("Failed to save template", 500)
          unless defined $params->{$required};
    }

    my $status;
    try {
        my $bee_manager = bee_manager();
           $status = $bee_manager->save_template($params);
    } catch {
        error $_;
        $status = {
             reason => 'Failed to save template',
             status => 'failed',
        };
    };

    return $status;
};

post '/bee/test_email' => sub {
    my $params = params || {};

    send_error("No email provided", 500) unless defined $params->{to};

    my $status;
    try {
        my $bee_manager = bee_manager();
           $status = $bee_manager->email($params);
    } catch {
        error $_;
        $status = {
            message => 'Failed to send email',
            status  => 'failed',
        };
    };

    return $status;       
};

post '/bee/autosave' => sub {
    my $params = params || {};

    send_error("Failed to autosave template", 500) unless defined $params->{json_file};

    my $status;
    try {
        my $bee_manager = bee_manager();
           $status = $bee_manager->autosave($params);
    } catch {
        error $_;
        $status = {
            message => 'Failed to autosave',
            status  => 'failed',
        };
    };

    return $status;
};

get '/bee/token' => sub {
    my $token_manager = token_manager();
    return $token_manager->get_token;
};

true;
