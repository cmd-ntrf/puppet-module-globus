# @summary Manage Globus
#
# @example Install and configure a Globus IO endpoint that uses OAuth.  This example assumes host cert/key will not be provided by Globus.
#    class { 'globus':
#      include_id_server => false,
#      globus_user => 'myusername',
#      globus_password => 'password',
#      endpoint_name => 'myorg',
#      endpoint_public => true,
#      myproxy_server => 'myproxy.example.com:7512',
#      oauth_server => 'myproxy.example.com',
#      security_identity_method => 'OAuth',
#      security_fetch_credentials_from_relay => false,
#      security_certificate_file => '/etc/grid-security/hostcert.pem',
#      security_key_file => '/etc/grid-security/hostkey.pem',
#      gridftp_server => $::fqdn,
#      gridftp_restrict_paths => ['RW~','N~/.*','RW/project'],
#      # Example of extra settings
#      extra_gridftp_settings => [
#        'log_level ALL',
#        'log_single /var/log/gridftp-auth.log',
#        'log_transfer /var/log/gridftp-transfer.log',
#      ],
#    }
#
# @param include_io_server
# @param include_id_server
# @param include_oauth_server
# @param release_url
# @param repo_descr
# @param repo_baseurl
# @param remove_cilogon_cron
# @param extra_gridftp_settings
# @param first_gridftp_callback
# @param manage_service
# @param run_setup_commands
# @param manage_firewall
# @param manage_epel
# @param globus_user
# @param globus_password
# @param endpoint_name
# @param endpoint_public
# @param endpoint_default_directory
# @param security_fetch_credentials_from_relay
# @param security_certificate_file
# @param security_key_file
# @param security_trusted_certificate_directory
# @param security_identity_method
# @param security_authorization_method
# @param security_gridmap
# @param security_cilogon_identity_provider
# @param gridftp_server
# @param gridftp_server_port
# @param gridftp_server_behind_nat
# @param gridftp_incoming_port_range
# @param gridftp_outgoing_port_range
# @param gridftp_data_interface
# @param gridftp_restrict_paths
# @param gridftp_sharing
# @param gridftp_sharing_restrict_paths
# @param gridftp_sharing_state_dir
# @param gridftp_sharing_users_allow
# @param gridftp_sharing_groups_allow
# @param gridftp_sharing_users_deny
# @param gridftp_sharing_groups_deny
# @param myproxy_server
# @param myproxy_server_port
# @param myproxy_server_behind_nat
# @param myproxy_ca_directory
# @param myproxy_config_file
# @param myproxy_ca_subject_dn
# @param myproxy_firewall_sources
# @param oauth_server
# @param oauth_server_behind_firewall
# @param oauth_stylesheet
# @param oauth_logo
#
class globus (
  Boolean $include_io_server = true,
  Boolean $include_id_server = true,
  Boolean $include_oauth_server = false,
  Variant[Stdlib::Httpsurl, Stdlib::Httpurl] $release_url = $globus::params::release_url,
  String $repo_descr = $globus::params::repo_descr,
  Variant[Stdlib::Httpsurl, Stdlib::Httpurl] $repo_baseurl = $globus::params::repo_baseurl,
  Boolean $remove_cilogon_cron = false,
  Array $extra_gridftp_settings = [],
  Optional[String] $first_gridftp_callback = undef,
  Boolean $manage_service = true,
  Boolean $run_setup_commands = true,
  Boolean $manage_firewall = true,
  Boolean $manage_epel = true,

  # Globus Config
  String $globus_user = '%(GLOBUS_USER)s',
  String $globus_password = '%(GLOBUS_PASSWORD)s',

  # Endpoint Config
  String $endpoint_name = $::hostname,
  Boolean $endpoint_public = false,
  String $endpoint_default_directory = '/~/',

  # Security Config
  Boolean $security_fetch_credentials_from_relay = true,
  Stdlib::Absolutepath $security_certificate_file = '/var/lib/globus-connect-server/grid-security/hostcert.pem',
  Stdlib::Absolutepath $security_key_file = '/var/lib/globus-connect-server/grid-security/hostkey.pem',
  Stdlib::Absolutepath $security_trusted_certificate_directory = '/var/lib/globus-connect-server/grid-security/certificates/',
  Enum['MyProxy', 'OAuth', 'CILogon'] $security_identity_method = 'MyProxy',
  Optional[Enum['MyProxyGridmapCallout','CILogon','Gridmap']] $security_authorization_method = undef,
  Optional[Stdlib::Absolutepath] $security_gridmap = undef,
  Optional[String] $security_cilogon_identity_provider = undef,

  # GridFTP Config
  Optional[String] $gridftp_server = undef,
  Stdlib::Port $gridftp_server_port = 2811,
  Boolean $gridftp_server_behind_nat = false,
  Array $gridftp_incoming_port_range = ['50000', '51000'],
  $gridftp_outgoing_port_range = undef, #'50000-51000',
  Optional[String] $gridftp_data_interface = undef,
  Array $gridftp_restrict_paths = ['RW~', 'N~/.*'],
  Boolean $gridftp_sharing = false,
  Optional[Array] $gridftp_sharing_restrict_paths = undef,
  String $gridftp_sharing_state_dir = '$HOME/.globus/sharing',
  Optional[Array] $gridftp_sharing_users_allow = undef,
  Optional[Array] $gridftp_sharing_groups_allow = undef,
  Optional[Array] $gridftp_sharing_users_deny = undef,
  Optional[Array] $gridftp_sharing_groups_deny = undef,

  # MyProxy Config
  Optional[String] $myproxy_server = undef,
  Stdlib::Port $myproxy_server_port = 7512,
  Boolean $myproxy_server_behind_nat = false,
  Stdlib::Absolutepath $myproxy_ca_directory = '/var/lib/globus-connect-server/myproxy-ca',
  Stdlib::Absolutepath $myproxy_config_file = '/var/lib/globus-connect-server/myproxy-server.conf',
  Optional[String] $myproxy_ca_subject_dn = undef,
  Array $myproxy_firewall_sources = ['174.129.226.69', '54.237.254.192/29'],

  # OAuth Config
  Optional[String] $oauth_server = undef,
  Boolean $oauth_server_behind_firewall = false,
  Optional[String] $oauth_stylesheet = undef,
  Optional[String] $oauth_logo = undef,
) inherits globus::params {

  if $include_io_server {
    $_gridftp_server    = pick($gridftp_server, "${::fqdn}:${gridftp_server_port}")
    $_io_setup_command  = 'globus-connect-server-io-setup'
  } else {
    $_gridftp_server    = $gridftp_server
    $_io_setup_command  = undef
  }

  if $include_id_server {
    $_myproxy_server    = pick($myproxy_server, "${::fqdn}:${myproxy_server_port}")
    $_id_setup_command  = 'globus-connect-server-id-setup'
  } else {
    $_myproxy_server    = $myproxy_server
    $_id_setup_command  = undef
  }

  if $include_oauth_server {
    $_oauth_server        = pick($oauth_server, $::fqdn)
    $_oauth_setup_command = 'globus-connect-server-web-setup'
  } else {
    $_oauth_server        = $oauth_server
    $_oauth_setup_command = undef
  }

  $_setup_commands  = delete_undef_values([$_io_setup_command, $_id_setup_command, $_oauth_setup_command])
  $_setup_command   = join($_setup_commands, ' && ')

  contain globus::install
  contain globus::config
  contain globus::service

  case $::osfamily {
    'RedHat': {
      if $manage_epel {
        include ::epel
        Class['epel'] -> Class['globus::repo::el']
      }
      contain globus::repo::el

      Class['globus::repo::el']
      -> Class['globus::install']
      -> Class['globus::config']
      -> Class['globus::service']
    }
    default: {
      # Do nothing
    }
  }

}
