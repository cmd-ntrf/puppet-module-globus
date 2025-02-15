# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`globus`](#globus): Manage Globus
* [`globus::cli`](#globuscli): Manage Globus CLI
* [`globus::sdk`](#globussdk): Manage Globus SDK

#### Private Classes

* `globus::config`: Manage globus configs
* `globus::install`: manage Globus install
* `globus::python`: Manage Globus Python dependency
* `globus::repo::deb`: Manage globus repo
* `globus::repo::el`: Manage globus repo
* `globus::service`: Manage Globus service
* `globus::user`: Manage globus user and group

### Resource types

* [`globus_connect_config`](#globus_connect_config): Section/setting name to manage from /etc/globus-connect-server.conf

### Functions

* [`globus::endpoint_setup_args`](#globusendpoint_setup_args)
* [`globus::node_setup_args`](#globusnode_setup_args)

## Classes

### `globus`

Manage Globus

#### Examples

##### Install and setup a Globus v5.4 endpoint

```puppet
class { 'globus':
  display_name  => 'REPLACE My Site Globus',
  client_id     => 'REPLACE-client-id-from-globus',
  client_secret => 'REPLACE-client-id-from-globus',
  owner         => 'REPLACE-user@example.com',
}
```

#### Parameters

The following parameters are available in the `globus` class.

##### `version`

Data type: `Variant[Enum['4','5'],Integer[4,5]]`

Major version of Globus to install. Only needed to install Globus v4

Default value: `'5'`

##### `include_io_server`

Data type: `Boolean`

Setup Globus v4 IO server
Globus v4 only

Default value: ``true``

##### `include_id_server`

Data type: `Boolean`

Setup Globus v4 ID server
Globus v4 only

Default value: ``true``

##### `include_oauth_server`

Data type: `Boolean`

Setup Globus v4 OAuth server
Globus v4 only

Default value: ``false``

##### `release_url`

Data type: `Variant[Stdlib::Httpsurl, Stdlib::Httpurl]`

Release URL of Globus release RPM
Globus v4 & v5

Default value: `'https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'`

##### `toolkit_repo_baseurl`

Data type: `Variant[Stdlib::Httpsurl, Stdlib::Httpurl]`

Globus Toolkit RPM repo baseurl
Globus v4 & v5

Default value: `"https://downloads.globus.org/toolkit/gt6/stable/rpm/el/${facts['os']['release']['major']}/\$basearch/"`

##### `toolkit_repo_testing_baseurl`

Data type: `Variant[Stdlib::Httpsurl, Stdlib::Httpurl]`

Globus Toolkit testing RPM repo baseurl
Globus v4 & v5

Default value: `"https://downloads.globus.org/toolkit/gt6/testing/rpm/el/${facts['os']['release']['major']}/\$basearch/"`

##### `gcs_repo_baseurl`

Data type: `Variant[Stdlib::Httpsurl, Stdlib::Httpurl]`

Globus Connect Server repo baseurl
Globus v4 & v5

Default value: `"https://downloads.globus.org/globus-connect-server/stable/rpm/el/${facts['os']['release']['major']}/\$basearch/"`

##### `gcs_repo_testing_baseurl`

Data type: `Variant[Stdlib::Httpsurl, Stdlib::Httpurl]`

Globus v5 testing repo baseurl
Globus v4 & v5

Default value: `"https://downloads.globus.org/globus-connect-server/testing/rpm/el/${facts['os']['release']['major']}/\$basearch/"`

##### `enable_testing_repos`

Data type: `Boolean`

Boolean that sets if testing repos should be added

Default value: ``false``

##### `extra_gridftp_settings`

Data type: `Array`

Additional settings for GridFTP
Globus v4 & v5

Default value: `[]`

##### `first_gridftp_callback`

Data type: `Optional[String]`

Used when running GridFTP from Globus with OSG, see README.
Globus v4 only

Default value: ``undef``

##### `manage_service`

Data type: `Boolean`

Boolean to set if globus-gridftp-server service is managed
Globus v4 & v5

Default value: ``true``

##### `run_setup_commands`

Data type: `Boolean`

Boolean to set if the commands to setup Globus are run (v4 and v5)
Globus v4 & v5

Default value: ``true``

##### `manage_firewall`

Data type: `Boolean`

Boolean to set if firewall rules are managed by this module
Globus v4 & v5

Default value: ``true``

##### `manage_epel`

Data type: `Boolean`

Boolean to set if EPEL is managed by this repo
Globus v4 & v5

Default value: ``true``

##### `repo_dependencies`

Data type: `Array`

Additional repo dependencies
Globus v4 only

Default value: `['yum-plugin-priorities']`

##### `manage_user`

Data type: `Boolean`

Boolean to set if the gcsweb user and group are managed by this module
Globus v5 only

Default value: ``true``

##### `group_gid`

Data type: `Optional[Integer]`

The gcsweb group GID
Globus v5 only

Default value: ``undef``

##### `user_uid`

Data type: `Optional[Integer]`

The gcsweb user UID
Globus v5 only

Default value: ``undef``

##### `package_name`

Data type: `String`

Globus v5 package name

Default value: `'globus-connect-server54'`

##### `display_name`

Data type: `Optional[String]`

Display name to use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `client_id`

Data type: `Optional[String]`

--client-id use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `client_secret`

Data type: `Optional[String]`

--client-secret use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `owner`

Data type: `Optional[String]`

--owner use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `organization`

Data type: `Optional[String]`

--organization use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `deployment_key`

Data type: `Stdlib::Absolutepath`

--deployment-key use when running 'globus-connect-server endpoint setup'
The parent directory of this path must be writable by gcsweb user
Globus v5 only

Default value: `'/var/lib/globus-connect-server/gcs-manager/deployment-key.json'`

##### `keywords`

Data type: `Optional[Array]`

--keywords use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `department`

Data type: `Optional[String]`

--department use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `contact_email`

Data type: `Optional[String]`

--contact-email use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `contact_info`

Data type: `Optional[String]`

--contact-info use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `info_link`

Data type: `Optional[String]`

--info-link use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `description`

Data type: `Optional[String]`

--description use when running 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``undef``

##### `public`

Data type: `Boolean`

When false pass --private flag to 'globus-connect-server endpoint setup'
Globus v5 only

Default value: ``true``

##### `incoming_port_range`

Data type: `Array[Stdlib::Port, 2, 2]`

--incoming-port-range use when running 'globus-connect-server node setup'
Globus v5 only

Default value: `[50000, 51000]`

##### `outgoing_port_range`

Data type: `Optional[Array[Stdlib::Port, 2, 2]]`

--outgoing-port-range use when running 'globus-connect-server node setup'
Globus v5 only

Default value: ``undef``

##### `ip_address`

Data type: `Optional[Stdlib::IP::Address]`

--ip-address use when running 'globus-connect-server node setup'
Globus v5 only

Default value: ``undef``

##### `export_node`

Data type: `Optional[Stdlib::Absolutepath]`

--export-node use when running 'globus-connect-server node setup'
Globus v5 only

Default value: ``undef``

##### `import_node`

Data type: `Optional[Stdlib::Absolutepath]`

--import-node use when running 'globus-connect-server node setup'
Globus v5 only

Default value: ``undef``

##### `globus_user`

Data type: `String`

See globus-connect-server.conf Globus/User
Globus v4 only

Default value: `'%(GLOBUS_USER)s'`

##### `globus_password`

Data type: `String`

See globus-connect-server.conf Globus/Password
Globus v4 only

Default value: `'%(GLOBUS_PASSWORD)s'`

##### `endpoint_name`

Data type: `String`

See globus-connect-server.conf Endpoint/Name
Globus v4 only

Default value: `$::hostname`

##### `endpoint_public`

Data type: `Boolean`

See globus-connect-server.conf Endpoint/Public
Globus v4 only

Default value: ``false``

##### `endpoint_default_directory`

Data type: `String`

See globus-connect-server.conf Endpoint/DefaultDirectory
Globus v4 only

Default value: `'/~/'`

##### `security_fetch_credentials_from_relay`

Data type: `Boolean`

See globus-connect-server.conf Security/FetchCredentialFromRelay
Globus v4 only

Default value: ``true``

##### `security_certificate_file`

Data type: `Stdlib::Absolutepath`

See globus-connect-server.conf Security/CertificateFile
Globus v4 only

Default value: `'/var/lib/globus-connect-server/grid-security/hostcert.pem'`

##### `security_key_file`

Data type: `Stdlib::Absolutepath`

See globus-connect-server.conf Security/KeyFile
Globus v4 only

Default value: `'/var/lib/globus-connect-server/grid-security/hostkey.pem'`

##### `security_trusted_certificate_directory`

Data type: `Stdlib::Absolutepath`

See globus-connect-server.conf Security/TrustedCertificateDirectory
Globus v4 only

Default value: `'/var/lib/globus-connect-server/grid-security/certificates/'`

##### `security_identity_method`

Data type: `Enum['MyProxy', 'OAuth', 'CILogon']`

See globus-connect-server.conf Security/IdentityMethod
Globus v4 only

Default value: `'MyProxy'`

##### `security_authorization_method`

Data type: `Optional[Enum['MyProxyGridmapCallout','CILogon','Gridmap']]`

See globus-connect-server.conf Security/AuthorizationMethod
Globus v4 only

Default value: ``undef``

##### `security_gridmap`

Data type: `Optional[Stdlib::Absolutepath]`

See globus-connect-server.conf Security/Gridmap
Globus v4 only

Default value: ``undef``

##### `security_cilogon_identity_provider`

Data type: `Optional[String]`

See globus-connect-server.conf Security/IdentityProvider
Globus v4 only

Default value: ``undef``

##### `gridftp_server`

Data type: `Optional[String]`

See globus-connect-server.conf GridFTP/Server
Globus v4 only

Default value: ``undef``

##### `gridftp_server_port`

Data type: `Stdlib::Port`

See globus-connect-server.conf GridFTP/ServerPort
Globus v4

Default value: `2811`

##### `gridftp_server_behind_nat`

Data type: `Boolean`

See globus-connect-server.conf GridFTP/ServerBehindNat
Globus v4 only

Default value: ``false``

##### `gridftp_incoming_port_range`

Data type: `Array[Stdlib::Port, 2, 2]`

See globus-connect-server.conf GridFTP/IncomingPortRange
Globus v4 only

Default value: `[50000, 51000]`

##### `gridftp_outgoing_port_range`

Data type: `Optional[Array[Stdlib::Port, 2, 2]]`

See globus-connect-server.conf GridFTP/OutgoingPortRange
Globus v4 only

Default value: ``undef``

##### `gridftp_data_interface`

Data type: `Optional[String]`

See globus-connect-server.conf GridFTP/DataInterface
Globus v4 only

Default value: ``undef``

##### `gridftp_restrict_paths`

Data type: `Array`

See globus-connect-server.conf GridFTP/RestrictPaths
Globus v4 only

Default value: `['RW~', 'N~/.*']`

##### `gridftp_sharing`

Data type: `Boolean`

See globus-connect-server.conf GridFTP/Sharing
Globus v4 only

Default value: ``false``

##### `gridftp_sharing_restrict_paths`

Data type: `Optional[Array]`

See globus-connect-server.conf GridFTP/SharingRestrictPaths
Globus v4 only

Default value: ``undef``

##### `gridftp_sharing_state_dir`

Data type: `String`

See globus-connect-server.conf GridFTP/SharingStateDir
Globus v4 only

Default value: `'$HOME/.globus/sharing'`

##### `gridftp_sharing_users_allow`

Data type: `Optional[Array]`

See globus-connect-server.conf GridFTP/UsersAllow
Globus v4 only

Default value: ``undef``

##### `gridftp_sharing_groups_allow`

Data type: `Optional[Array]`

See globus-connect-server.conf GridFTP/GroupsAllow
Globus v4 only

Default value: ``undef``

##### `gridftp_sharing_users_deny`

Data type: `Optional[Array]`

See globus-connect-server.conf GridFTP/UsersDeny
Globus v4 only

Default value: ``undef``

##### `gridftp_sharing_groups_deny`

Data type: `Optional[Array]`

See globus-connect-server.conf GridFTP/GroupsDeny
Globus v4 only

Default value: ``undef``

##### `myproxy_server`

Data type: `Optional[String]`

See globus-connect-server.conf MyProxy/Server
Globus v4 only

Default value: ``undef``

##### `myproxy_server_port`

Data type: `Stdlib::Port`

See globus-connect-server.conf MyProxy/ServerPort
Globus v4 only

Default value: `7512`

##### `myproxy_server_behind_nat`

Data type: `Boolean`

See globus-connect-server.conf MyProxy/ServerBehindNAT
Globus v4 only

Default value: ``false``

##### `myproxy_ca_directory`

Data type: `Stdlib::Absolutepath`

See globus-connect-server.conf MyProxy/CADirectory
Globus v4 only

Default value: `'/var/lib/globus-connect-server/myproxy-ca'`

##### `myproxy_config_file`

Data type: `Stdlib::Absolutepath`

See globus-connect-server.conf MyProxy/ConfigFile
Globus v4 only

Default value: `'/var/lib/globus-connect-server/myproxy-server.conf'`

##### `myproxy_ca_subject_dn`

Data type: `Optional[String]`

See globus-connect-server.conf MyProxy/CaSubjectDN
Globus v4 only

Default value: ``undef``

##### `myproxy_firewall_sources`

Data type: `Array`

Sources to open in firewall for MyProxy
Globus v4 only

Default value: `['174.129.226.69', '54.237.254.192/29']`

##### `oauth_server`

Data type: `Optional[String]`

See globus-connect-server.conf OAuth/Server
Globus v4 only

Default value: ``undef``

##### `oauth_server_behind_firewall`

Data type: `Boolean`

See globus-connect-server.conf OAuth/ServerBehindFirewall
Globus v4 only

Default value: ``false``

##### `oauth_stylesheet`

Data type: `Optional[String]`

See globus-connect-server.conf OAuth/Stylesheet
Globus v4 only

Default value: ``undef``

##### `oauth_logo`

Data type: `Optional[String]`

See globus-connect-server.conf OAuth/Logo
Globus v4 only

Default value: ``undef``

### `globus::cli`

Manage Globus CLI

#### Examples

##### 

```puppet
include ::globus::cli
```

#### Parameters

The following parameters are available in the `globus::cli` class.

##### `ensure`

Data type: `String[1]`

The ensure parameter for PIP installed CLI

Default value: `'present'`

##### `install_path`

Data type: `Stdlib::Absolutepath`

Path to install Globus CLI virtualenv

Default value: `'/opt/globus-cli'`

##### `manage_python`

Data type: `Boolean`

Boolean to set if Python is managed by this class

Default value: ``true``

##### `timer_ensure`

Data type: `String[1]`

Set globus-timer-cli ensure value

Default value: `'absent'`

### `globus::sdk`

Manage Globus SDK

#### Examples

##### 

```puppet
include globus::sdk
```

#### Parameters

The following parameters are available in the `globus::sdk` class.

##### `ensure`

Data type: `String[1]`

The ensure parameter for PIP installed SDK

Default value: `'present'`

##### `install_path`

Data type: `Stdlib::Absolutepath`

Path to install Globus CLI virtualenv

Default value: `'/opt/globus-sdk'`

##### `manage_python`

Data type: `Boolean`

Boolean to set if Python is managed by this class

Default value: ``true``

## Resource types

### `globus_connect_config`

Section/setting name to manage from /etc/globus-connect-server.conf

#### Properties

The following properties are available in the `globus_connect_config` type.

##### `ensure`

Valid values: `present`, `absent`

The basic property that the resource should be in.

Default value: `present`

##### `value`

Valid values: `%r{^[\S ]*$}`

The value of the setting to be defined.

#### Parameters

The following parameters are available in the `globus_connect_config` type.

##### `name`

namevar

Section/setting name to manage from /etc/globus-connect-server.conf

##### `provider`

The specific backend to use for this `globus_connect_config` resource. You will seldom need to specify this --- Puppet
will usually discover the appropriate provider for your platform.

##### `secret`

Valid values: ``true``, ``false``

Whether to hide the value from Puppet logs. Defaults to `false`.

Default value: ``false``

## Functions

### `globus::endpoint_setup_args`

Type: Ruby 4.x API

The globus::endpoint_setup_args function.

#### `globus::endpoint_setup_args(Hash $values)`

The globus::endpoint_setup_args function.

Returns: `Any`

##### `values`

Data type: `Hash`



### `globus::node_setup_args`

Type: Ruby 4.x API

The globus::node_setup_args function.

#### `globus::node_setup_args(Hash $values)`

The globus::node_setup_args function.

Returns: `Any`

##### `values`

Data type: `Hash`



