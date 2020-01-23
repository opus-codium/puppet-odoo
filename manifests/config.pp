# @summary Manage odoo configuration
#
# @api private
class odoo::config {
  assert_private()

  [
    'admin_passwd',
    'csv_internal_sep',
    'reportgz',
    'without_demo',
    'import_partial',
    'pidfile',
    'addons_path',
    'upgrades_paths',
    'server_wide_modules',
    'data_dir',
    'http_interface',
    'http_port',
    'longpolling_port',
    'http_enable',
    'proxy_mode',
    'dbfilter',
    'test_enable',
    'test_file',
    'test_tags',
    'screencasts',
    'screenshots',
    'logfile',
    'syslog',
    'log_handler',
    'log_db',
    'log_db_level',
    'log_level',
    'email_from',
    'smtp_server',
    'smtp_port',
    'smtp_ssl',
    'smtp_user',
    'smtp_password',
    'db_name',
    'db_user',
    'db_password',
    'pg_path',
    'db_host',
    'db_port',
    'db_sslmode',
    'db_maxconn',
    'db_template',
    'language',
    'translate_out',
    'translate_in',
    'overwrite_existing_translations',
    'translate_modules',
    'list_db',
    'osv_memory_count_limit',
    'osv_memory_age_limit',
    'max_cron_threads',
    'unaccent',
    'geoip_database',
    'workers',
    'limit_memory_soft',
    'limit_memory_hard',
    'limit_time_cpu',
    'limit_time_real',
    'limit_time_real_cron',
    'limit_request',
  ].each |$raw_param| {
    $raw_value = getvar("odoo::${raw_param}")

    if $raw_value != undef {
      $param = $raw_param ? {
        'http_enable'    => $odoo::http_enable_setting,
        'http_interface' => $odoo::http_interface_setting,
        'http_port'      => $odoo::http_port_setting,
        default          => $raw_param,
      }

      $value = $raw_value ? {
        Array[String] => $raw_value.join(','),
        Boolean       => String($raw_value, '%T'),
        Sensitive     => $raw_value.unwrap(),
        default       => $raw_value,
      }

      $show_diff = $raw_value ? {
        Sensitive => true,
        default   => false,
      }

      odoo_config { $param:
        ensure    => present,
        value     => $value,
        show_diff => $show_diff,
      }
    }
  }
}
