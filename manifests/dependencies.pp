# @summary Manage odoo dependencies
#
# @api private
class odoo::dependencies {
  assert_private()

  case $odoo::install_from {
    'package': {
      unless $odoo::version == 'system' {
        package { 'num2words':
          ensure   => '0.5.10',
          provider => $odoo::pip_provider,
        }

        if versioncmp($odoo::version, '13.0') < 0 {
          # These dependencies are only listed on the Odoo 11 and Odoo 12 setup pages:
          # https://www.odoo.com/documentation/11.0/setup/install.html
          # https://www.odoo.com/documentation/12.0/setup/install.html

          case $facts.get('os.name') {
            'debian': {
              $odoo_dependencies = [
                'python3-qrcode',
                'python3-phonenumbers',
                'python3-pyldap',
                'python3-vobject',
              ]
              $odoo_pip_packages = []
            }
            'ubuntu': {
              case $facts.get('os.release.full') {
                '18.04': {
                  $odoo_dependencies = [
                    'python3-qrcode',
                    'python3-phonenumbers',
                    'python3-pyldap',
                    'python3-vobject',
                  ]

                  $odoo_pip_packages = []
                }
                default: {
                  warning("Please contribute support for ubuntu ${facts.get('os.release.full')}")
                  $odoo_dependencies = []
                  $odoo_pip_packages = []
                }
              }
            }
            default: {
              warning("Please contribute support for ${facts.get('os.name')}")
              $odoo_dependencies = []
              $odoo_pip_packages = []
            }
          }

          package { $odoo_dependencies:
            ensure => installed,
          }

          package { $odoo_pip_packages:
            ensure   => installed,
            provider => $odoo::pip_provider,
            require  => Package[$odoo_dependencies],
          }
        }

        if versioncmp($odoo::version, '11.0') >= 0 {
          # These dependencies are only listed on the Odoo 13 page:
          # https://www.odoo.com/documentation/13.0/setup/install.html
          # Odoo 10.0 depends on the python-xlwt package (old version), so install
          # the pip module on Odoo 11 and better.
          package { 'xlwt':
            ensure   => '1.3.0',
            provider => $odoo::pip_provider,
            notify   => Class['odoo::service'],
          }
        }
      }
    }
    'vcsrepo': {
      $build_dependencies = [
        'libldap2-dev',
        'libpq-dev',
        'libsasl2-dev',
        'libxslt1-dev',
      ]

      ensure_packages($build_dependencies, ensure => installed)
    }
    default: {
      fail("I don't know how to manage dependenciens when installing from ${odoo::install_from}")
    }
  }
}
