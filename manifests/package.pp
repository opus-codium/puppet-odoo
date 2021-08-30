# @summary Manage odoo package
#
# @api private
class odoo::package {
  assert_private()

  if $odoo::manage_package {
    package { $odoo::package_name:
      ensure        => $odoo::package_ensure,
      mark          => $odoo::package_mark,
      allow_virtual => true,
    }
  }
}
