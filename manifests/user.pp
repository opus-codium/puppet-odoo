# @summary Manage odoo user
#
# @api private
class odoo::user {
  assert_private()

  if $odoo::manage_user {
    user { 'odoo':
      ensure => present,
      home   => '/var/lib/odoo',
      system => true,
      shell  => '/bin/sh',
    }
  }
}
