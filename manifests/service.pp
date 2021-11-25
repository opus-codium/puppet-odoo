# @summary Manage odoo service
#
# @api private
class odoo::service {
  assert_private()

  if $odoo::install_from == 'vcsrepo' {
    systemd::unit_file { 'odoo.service':
      content => epp('odoo/odoo.service.epp'),
      before  => Service['odoo'],
    }
  }

  service { 'odoo':
    ensure => running,
    enable => true,
  }
}
