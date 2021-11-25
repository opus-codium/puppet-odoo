# @summary Manage odoo git repository
#
# @api private
class odoo::vcsrepo {
  assert_private()

  if $odoo::manage_vcsrepo {
    if $odoo::install_from == 'vcsrepo' {
      $vcsrepo_ensure = 'present'
    } else {
      $vcsrepo_ensure = 'absent'
    }

    vcsrepo { $odoo::vcsrepo_path:
      ensure   => $vcsrepo_ensure,
      provider => 'git',
      owner    => 'odoo',
      source   => 'https://github.com/odoo/odoo',
      revision => $odoo::version,
      depth    => $odoo::vcsrepo_depth,
    }
  }
}
