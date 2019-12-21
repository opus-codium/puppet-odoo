class odoo::package {
  if $odoo::manage_package {
    package { 'odoo':
      ensure => $odoo::package_ensure,
    }
  }
}
