class odoo::service {
  assert_private()

  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
