# @summary Configure Odoo
#
# @param version The version of odoo to install
# @param manage_repo Manage the odoo reposiroty
# @param manage_package Manage the odoo package
# @param package_ensure Ensure value for the odoo package
# @param package_mark Mark value for the odoo package
#
# @param admin_passwd Password that allows database operations
# @param csv_internal_sep Legacy (now unused)
# @param reportgz Legacy (now unused)
#
# @param without_demo Disable loading demo data for modules to be installed (comma-separated, use \"all\" for all modules).
# @param import_partial Use this for big data importation, if it crashes you will be able to continue at the current state. Provide a filename to store intermediate importation states.
# @param pidfile File where the server pid will be stored
# @param addons_path Additional addons paths
# @param upgrades_paths Additional upgrades path
# @param server_wide_modules List of server-wide modules
# @param data_dir Directory where to store Odoo data
#
# @param http_interface Listen interface address for HTTP services
# @param http_port Listen port for the main HTTP service
# @param longpolling_port Listen port for the longpolling HTTP service
# @param http_enable Disable the HTTP and Longpolling services entirely
# @param proxy_mode Activate reverse proxy WSGI wrappers
#
# @param dbfilter Regular expressions for filtering available databases for Web UI
#
# @param test_enable Enable unit tests
# @param test_file Launch a python test file
# @param test_tags List of spec to filter which tests to execute
# @param screencasts Screencasts will go in $screencasts/<db_name>/screencasts
# @param screenshots Screenshots will go in $screenshots/<db_name>/screenshots
#
# @param logfile File where the server log will be stored
# @param syslog Send the log to the syslog server
# @param log_handler Setup a handler of PREFIX:LEVEL
# @param log_db Logging database
# @param log_db_level Logging database level
# @param log_level Level of the logging
#
# @param email_from SMTP email address for sending email
# @param smtp_server SMTP server for sending email
# @param smtp_port SMTP port
# @param smtp_ssl Encrypt SMTP connections with StARTTLS
# @param smtp_user SMTP username for sending email
# @param smtp_password SMTP password for sending email
#
# @param db_name Database name
# @param db_user Database user name
# @param db_password Database password
# @param pg_path PostgreSQL executable path
# @param db_host Database host
# @param db_port Database port
# @param db_sslmode Database ssl connection mode
# @param db_maxconn Maximum number of physical connections to PostgreSQL
# @param db_template Custom database template to create a new database
#
# @param language Language of the translation file
# @param translate_out Export all sentences to be translated to a CSV file, a PO file or a TGZ archive and exit
# @param translate_in Import a CSV or a PO file with translations and exit
# @param overwrite_existing_translations Overwrites existing translation terms on updating a module or importing a CSV or a PO file
# @param translate_modules Modules to export
#
# @param list_db Disable the ability to obtain or view the list of databases
#
# @param osv_memory_count_limit Force a limit on the maximum number of records kept in the virtual osv_memory tables
# @param osv_memory_age_limit Force a limit on the maximum age of records kept in the virtual osv_memory
# @param max_cron_threads Maximum number of threads processing concurrently cron jobs
# @param unaccent Use the unaccent function provided by the database when available
# @param geoip_database Absolute path to the GeoIP database file
#
# @param workers Number of workers
# @param limit_memory_soft Maximum allowed virtual memory per worker, when reached the worker be reset after the current request
# @param limit_memory_hard Maximum allowed virtual memory per worker, when reached, any memory allocation will fail
# @param limit_time_cpu Maximum allowed CPU time per request
# @param limit_time_real Maximum allowed Real time per request
# @param limit_time_real_cron Maximum allowed Real time per cron job
# @param limit_request Maximum number of request to be processed per worker
class odoo (
  Enum['10.0', '11.0', '12.0', '13.0', '14.0'] $version,

  Boolean $manage_repo    = true,
  Boolean $manage_package = true,

  String                         $package_ensure = 'present',
  Optional[Enum['hold', 'none']] $package_mark   = undef,

  Optional[Sensitive]                      $admin_passwd           = undef,
  Optional[String]                         $csv_internal_sep       = undef,
  Optional[String]                         $reportgz               = undef,

  # Common options
  Optional[Variant[Array[String],Boolean]] $without_demo           = undef,
  Optional[String]                         $import_partial         = undef,
  Optional[Stdlib::Absolutepath]           $pidfile                = undef,
  Optional[Array[String]]                  $addons_path            = undef,
  Optional[Array[String]]                  $upgrades_paths         = undef,
  Optional[Array[String]]                  $server_wide_modules    = undef,
  Optional[String]                         $data_dir               = undef,

  # HTTP Service Configuration
  Optional[String]                         $http_interface   = undef,
  Optional[Integer]                        $http_port        = undef,
  Optional[Integer]                        $longpolling_port = undef,
  Optional[Boolean]                        $http_enable      = undef,
  Optional[Boolean]                        $proxy_mode       = undef,

  # Web interface Configuration
  Optional[String]                         $dbfilter = undef,

  # Testing Configuration
  Optional[Boolean]                        $test_enable = undef,
  Optional[String]                         $test_file   = undef,
  Optional[Array[String]]                  $test_tags   = undef,
  Optional[String]                         $screencasts = undef,
  Optional[String]                         $screenshots = undef,

  # Logging Configuration
  Optional[Stdlib::Absolutepath]           $logfile      = undef,
  Optional[Boolean]                        $syslog       = undef,
  Optional[String]                         $log_handler  = undef,
  Optional[String]                         $log_db       = undef,
  Optional[String]                         $log_db_level = undef,
  Optional[Enum[
      'info',
      'debug_rpc',
      'warn',
      'test',
      'critical',
      'debug_sql',
      'error',
      'debug',
      'debug_rpc_answer',
      'notset',
  ]]                                       $log_level    = undef,

  # SMTP Configuration
  Optional[String]                         $email_from    = undef,
  Optional[String]                         $smtp_server   = undef,
  Optional[Integer]                        $smtp_port     = undef,
  Optional[Boolean]                        $smtp_ssl      = undef,
  Optional[String]                         $smtp_user     = undef,
  Optional[Sensitive]                      $smtp_password = undef,

  # Database related options
  Optional[String]                         $db_name     = undef,
  String[1]                                $db_user     = 'odoo',
  Variant[Boolean[false],Sensitive]        $db_password = false,
  Optional[String]                         $pg_path     = undef,
  Variant[Boolean[false],String]           $db_host     = false,
  Variant[Boolean[false],Integer]          $db_port     = false,
  Optional[Enum[
      'disable',
      'allow',
      'prefer',
      'require',
      'verify-ca',
      'verify-full',
  ]]                                       $db_sslmode  = undef,
  Optional[Integer]                        $db_maxconn  = undef,
  Optional[String]                         $db_template = undef,

  # Internationalisation options
  Optional[String]                         $language                        = undef,
  Optional[Boolean]                        $translate_out                   = undef,
  Optional[Boolean]                        $translate_in                    = undef,
  Optional[Boolean]                        $overwrite_existing_translations = undef,
  Optional[Array[String]]                  $translate_modules               = undef,

  # Security-related options
  Optional[Boolean]                        $list_db = undef,

  # Advanced options
  Optional[Integer]                        $osv_memory_count_limit = undef,
  Optional[Float]                          $osv_memory_age_limit   = undef,
  Optional[Integer]                        $max_cron_threads       = undef,
  Optional[Boolean]                        $unaccent               = undef,
  Optional[Stdlib::Absolutepath]           $geoip_database         = undef,

  # Multiprocessing options
  Optional[Integer]                        $workers              = undef,
  Optional[Integer]                        $limit_memory_soft    = undef,
  Optional[Integer]                        $limit_memory_hard    = undef,
  Optional[Integer]                        $limit_request        = undef,
  Optional[Integer]                        $limit_time_cpu       = undef,
  Optional[Integer]                        $limit_time_real      = undef,
  Optional[Integer]                        $limit_time_real_cron = undef,
) {
  $odoo_supported_versions = {
    'Debian' => {
      '9'  => ['11.0', '12.0', '13.0', '14.0'],
      '10' => ['11.0', '12.0', '13.0', '14.0'],
      '11' => ['11.0', '12.0', '13.0', '14.0'],
    },
    'Ubuntu' => {
      '16.04' => ['10.0', '11.0', '12.0', '13.0', '14.0'],
      '18.04' => ['11.0', '12.0', '13.0', '14.0'],
      '20.04' => ['11.0', '12.0', '13.0', '14.0'],
    },
  }

  unless $odoo_supported_versions.dig($facts.get('os.name'), $facts.get('os.release.major')).member($version) {
    fail("Odoo ${version} cannot be installed on ${facts.get('os.name')} ${facts.get('os.release.major')}")
  }

  contain odoo::wkhtmltox

  if versioncmp($version, '11.0') >= 0 {
    $pip_provider = 'pip3'
    $pip_package  = 'python3-pip'

    $http_enable_setting    = 'http_enable'
    $http_interface_setting = 'http_interface'
    $http_port_setting      = 'http_port'
  } else {
    $pip_provider = 'pip'
    $pip_package  = 'python-pip'

    $http_enable_setting    = 'xmlrpc'
    $http_interface_setting = 'xmlrpc_interface'
    $http_port_setting      = 'xmlrpc_port'
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
