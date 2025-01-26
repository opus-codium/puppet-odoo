# @summary Manage odoo repository
#
# @api private
class odoo::repo {
  assert_private()

  unless $odoo::version == 'system' {
    case $facts.get('os.family') {
      'debian': {
        apt::source { 'odoo':
          location => "https://nightly.odoo.com/${odoo::version}/nightly/deb/",
          release  => '',
          repos    => './',
          key      => {
            name   => 'odoo.key',
            source => 'https://nightly.odoo.com/odoo.key',
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
