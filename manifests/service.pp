class odoo::service {
  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
