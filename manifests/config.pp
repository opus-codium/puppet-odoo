class odoo::config {
  odoo_config { 'addons_path':
    ensure => bool2str($odoo::addons_path != undef, 'present', 'absent'),
    value  => $odoo::addons_path,
  }

  odoo_config { 'admin_passwd':
    ensure    => bool2str($odoo::admin_passwd != undef, 'present', 'absent'),
    value     => $odoo::admin_passwd.unwrap,
    show_diff => false,
  }

  odoo_config { 'dbfilter':
    ensure => bool2str($odoo::dbfilter != undef, 'present', 'absent'),
    value  => $odoo::dbfilter,
  }

  odoo_config { 'db_maxconn':
    ensure => bool2str($odoo::db_maxconn != undef, 'present', 'absent'),
    value  => $odoo::db_maxconn,
  }

  odoo_config { 'list_db':
    ensure => bool2str($odoo::list_db != undef, 'present', 'absent'),
    value  => $odoo::list_db,
  }

  odoo_config { 'listen_address':
    ensure => bool2str($odoo::listen_address != undef, 'present', 'absent'),
    name   => $odoo::listen_address_setting,
    value  => $odoo::listen_address,
  }

  odoo_config { 'listen_port':
    ensure => bool2str($odoo::listen_port != undef, 'present', 'absent'),
    value  => $odoo::listen_port,
  }

  odoo_config { 'proxy_mode':
    ensure => bool2str($odoo::proxy_mode != undef, 'present', 'absent'),
    value  => $odoo::proxy_mode,
  }

  odoo_config { 'pg_path':
    ensure => bool2str($odoo::pg_path != undef, 'present', 'absent'),
    value  => $odoo::pg_path,
  }
}
