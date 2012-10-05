package Test::Selenium;
use Moose;
use Selenium::Remote::Driver;
with 'MooseX::Getopt';
with 'MooseX::SimpleConfig';

has remote_server_addr => (
    is             => 'ro',
    isa            => 'Str',
    predicate      => 'has_remote_server_addr',
    documentation  => 'IP or FQDN of the RC server machine',
);

has browser_name   => (
    is             => 'ro',
    isa            => 'Str',
    predicate      => 'has_browser_name',
    documentation  => 'desired browser string: {iphone|firefox|internet explorer|htmlunit|iphone|chrome}',
);

has version        => (
    is             => 'ro',
    isa            => 'Str',
    predicate      => 'has_version',
    documentation  => 'desired browser version number',
);

has platform       => (
    is             => 'ro',
    isa            => 'Str',
    predicate      => 'has_platform',
    documentation  => 'desired platform: {WINDOWS|XP|VISTA|MAC|LINUX|UNIX|ANY}',
);

has javascript     => (
    is             => 'ro',
    isa            => 'Bool',
    predicate      => 'has_javascript',
    documentation  => 'whether javascript should be supported',
);

has accept_ssl_certs => (
    is             => 'ro',
    isa            => 'Bool',
    predicate      => 'has_accept_ssl_certs',
    documentation  => 'whether SSL certs should be accepted, default is true',
);

has auto_close     => (
    is             => 'ro',
    isa            => 'Bool',
    predicate      => 'has_auto_close',
    documentation  => 'whether driver should end session on remote server on close',
);

has extra_capabilities => (
    is             => 'ro',
    isa            => 'HashRef',
    predicate      => 'has_extra_capabilities',
    documentation  => 'HASH of extra capabilities',
);

has proxy          => (
    is             => 'ro',
    isa            => 'HashRef',
    predicate      => 'has_proxy',
    documentation  => 'HASH of Selenium::Remote::Driver proxy configuration',
);

has web_driver     => (
    is             => 'ro',
    isa            => 'Selenium::Remote::Driver',
    handles        => [ qw(
        get
        get_sessions
        status
        get_alert_text
        send_keys_to_active_element
        send_keys_to_alert
        send_keys_to_prompt
        accept_alert
        dismiss_alert
        mouse_move_to_location
        move_to
        get_capabilities
        set_async_script_timeout
        set_implicit_wait_timeout
        close
        quit
        get_current_window_handle
        get_window_handles
        get_window_size
        get_window_position
        get_current_url
        navigate
        get
        get_title
        go_back
        go_forward
        refresh
        execute_async_script
        execute_script
        screenshot
        available_engines
        switch_to_frame
        switch_to_window
        get_speed
        set_speed
        set_window_position
        set_window_size
        get_all_cookies
        add_cookie
        delete_all_cookies
        delete_cookie_named
        get_page_source
        find_element
        find_elements
        find_child_element
        find_child_elements
        get_active_element
        send_modifier
        compare_elements
        click
        double_click
        button_down
        button_up
    ) ],
    lazy_build     => 1,
);

sub _build_web_driver {
    my $self = shift;

    Selenium::Remote::Driver->new(
        ( $self->has_remote_server_addr ) ? ( remote_server_addr => $self->remote_server_addr ) : (),
        ( $self->has_browser_name       ) ? ( browser_name       => $self->browser_name ) : (),
        ( $self->has_version            ) ? ( version            => $self->version ) : (),
        ( $self->has_platform           ) ? ( platform           => $self->platform ) : (),
        ( $self->has_javascript         ) ? ( javascript         => $self->javascript ) : (),
        ( $self->has_accept_ssl_certs   ) ? ( accept_ssl_certs   => $self->accept_ssl_certs ) : (),
        ( $self->has_auto_close         ) ? ( auto_close         => $self->auto_close ) : (),
        ( $self->has_extra_capabilities ) ? ( extra_capabilities => $self->extra_capabilities ) : (),
        ( $self->has_proxy              ) ? ( proxy              => $self->proxy ) : (),
    );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
