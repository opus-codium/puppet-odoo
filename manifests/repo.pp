# @summary Manage odoo repository
#
# @api private
class odoo::repo {
  assert_private()

  if $odoo::manage_repo {
    case $facts.get('os.family') {
      'debian': {
        apt::source { 'odoo':
          location => "http://nightly.odoo.com/${odoo::version}/nightly/deb/",
          release  => '',
          repos    => './',
          key      => {
            id => '5D134C924CB06330DCEFE2A1DEF2A2198183CBB5',
          },
          include  => {
            src => false,
            deb => true,
          },
        }

        Apt::Source['odoo'] -> Class['odoo::package']
        Class['apt::update'] -> Class['odoo::package']
      }
      'redhat': {
        yumrepo { 'odoo':
          ensure  => present,
          descr   => 'Odoo',
          baseurl => "http://nightly.odoo.com/${odoo::version}/nightly/rpm/",
          enabled => '1',
        }
      }
      default: {
        fail("No repo to manage on ${facts.get('os.family')}")
      }
    }
  }
}
