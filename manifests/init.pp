# @summary Configure Odoo
#
# @param version The version of odoo to install
# @param manage_repo Manage the odoo reposiroty
# @param manage_package Manage the odoo package
# @param package_ensure
# @param listen_address Address on which the HTTP server listens
# @param listen_port Port on which the HTTP server listens
# @param addons_path
# @param admin_passwd
# @param dbfilter Hides databases that do not match the filter
# @param db_maxconn Maximum number of physical connections to PosgreSQL per odoo process
# @param list_db
# @param proxy_mode
# @param pg_path
class odoo (
  Enum['10.0', '11.0', '12.0', '13.0'] $version,

  Boolean $manage_repo    = true,
  Boolean $manage_package = true,

  String  $package_ensure = 'present',

  Optional[String]    $listen_address = undef,
  Optional[Integer]   $listen_port    = undef,
  # Direct mapping
  Optional[String]    $addons_path    = undef,
  Optional[Sensitive] $admin_passwd,
  Optional[String]    $dbfilter       = undef,
  Optional[Integer]   $db_maxconn     = undef,
  Optional[Boolean]   $list_db        = undef,
  Optional[Boolean]   $proxy_mode     = undef,
  Optional[String]    $pg_path        = undef,
) {
  contain odoo::wkhtmltox

  if versioncmp($version, '11.0') >= 0 {
    $pip_provider = 'pip3'
    $pip_package  = 'python3-pip'

    $listen_address_setting = 'http_interface'
  } else {
    $pip_provider = 'pip'
    $pip_package  = 'python-pip'

    $listen_address_setting = 'xmlrpc_interface'
  }
  contain odoo::repo
  contain odoo::dependencies
  contain odoo::package
  contain odoo::config
  contain odoo::service

  Class['odoo::repo']
  -> Class['odoo::dependencies']
  -> Class['odoo::package']
  -> Class['odoo::config']
  ~> Class['odoo::service']
}
