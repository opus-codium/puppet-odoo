# @summary Manage odoo package
#
# @api private
class odoo::package {
  assert_private()

  if $odoo::manage_package {
    if $odoo::install_from == 'package' {
      $package_ensure = $odoo::package_ensure
    } else {
      $package_ensure = 'absent'
    }

    package { $odoo::package_name:
      ensure        => $package_ensure,
      mark          => $odoo::package_mark,
      allow_virtual => true,
    }
  }
}
