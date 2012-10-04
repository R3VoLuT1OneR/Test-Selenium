package Test::Selenium;
use Moose;
with 'MooseX::SimpleConfig';
with 'MooseX::Getopt';

use Selenium::Remote::Driver;

has remote_server_addr => (
    is             => 'ro',
    isa            => 'Str',
    default        => 'localhost',
    documentation  => 'IP or FQDN of the RC server machine',
);

has browser_name   => (
    is             => 'ro',
    isa            => 'Str',
    default        => 'firefox',
);

has version        => (
    is             => 'ro',
    isa            => 'Str',
    default        => '',
);

has platform       => (
    is             => 'ro',
    isa            => 'Str',
    default        => 'ANY',
);

has javascript     => (
    is             => 'ro',
    isa            => 'Bool',
    default        => 1,
);

has accept_ssl_certs => (
    is             => 'ro',
    isa            => 'Bool',
    default        => 1,
);

has auto_close     => (
    is             => 'ro',
    isa            => 'Bool',
    default        => 1,
);

has extra_capabilities => (
    is             => 'ro',
    isa            => 'HashRef',
);

has proxy          => (
    is             => 'ro',
    isa            => 'HashRef',
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
        remote_server_addr => $self->remote_server_addr,
        browser_name       => $self->browser_name,
        version            => $self->version,
        platform           => $self->platform,
        javascript         => $self->javascript,
        accept_ssl_certs   => $self->accept_ssl_certs,
        auto_close         => $self->auto_close,
        extra_capabilities => $self->extra_capabilities,
        proxy              => $self->proxy,
    );
}

=cut
'browser_name' - <string> - desired browser string:
{iphone|firefox|internet explorer|htmlunit|iphone|chrome}
'version' - <string> - desired browser version number
'platform' - <string> - desired platform:
{WINDOWS|XP|VISTA|MAC|LINUX|UNIX|ANY}
'javascript' - <boolean> - whether javascript should be supported
'accept_ssl_certs' - <boolean> - whether SSL certs should be accepted, default is true.
'auto_close' - <boolean> - whether driver should end session on remote
server on close.
'extra_capabilities' - HASH of extra capabilities
'proxy' - HASH - Proxy configuration with the following keys:
'proxyType' - <string> - REQUIRED, Possible values are:
direct - A direct connection - no proxy in use,
manual - Manual proxy settings configured, e.g. setting a proxy for HTTP, a proxy for FTP, etc,
pac - Proxy autoconfiguration from a URL,
autodetect - proxy autodetection, probably with WPAD,
system - Use system settings
'proxyAutoconfigUrl' - <string> - REQUIRED if proxyType is 'pac', ignored otherwise. Expected format: http://hostname.com:1234/pacfile.
'ftpProxy' - <string> - OPTIONAL, ignored if proxyType is not 'manual'. Expected format: hostname.com:1234
'httpProxy' - <string> - OPTIONAL, ignored if proxyType is not 'manual'. Expected format: hostname.com:1234
'sslProxy' - <string> - OPTIONAL, ignored if proxyType is not 'manual'. Expected format: hostname.com:1234
=cut

no Moose;
__PACKAGE__->meta->make_immutable;
1;
