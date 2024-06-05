# @summary Manage odoo dependencies
#
# @api private
class odoo::dependencies {
  assert_private()

  unless $odoo::version == 'system' {
    stdlib::ensure_packages($odoo::pip_package)

    if versioncmp($odoo::version, '13.0') < 0 {
      # These dependencies are only listed on the Odoo 11 and Odoo 12 setup pages:
      # https://www.odoo.com/documentation/11.0/setup/install.html
      # https://www.odoo.com/documentation/12.0/setup/install.html

      case $facts.get('os.name') {
        'debian': {
          case $facts.get('os.release.major') {
            '10', '11': {
              $odoo_dependencies = [
                'python3-qrcode',
                'python3-phonenumbers',
                'python3-pyldap',
                'python3-vobject',
              ]
              $odoo_pip_packages = {
                'num2words' => { ensure => '0.5.10' },
              }
            }
            '12': {
              $odoo_dependencies = [
                'python3-qrcode',
                'python3-phonenumbers',
                'python3-pyldap',
                'python3-vobject',
                'python3-num2words',
              ]
              $odoo_pip_packages = {}
            }
            default: {
              warning("Please contribute support for ubuntu ${facts.get('os.release.full')}")
              $odoo_dependencies = []
              $odoo_pip_packages = {}
            }
          }
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

              $odoo_pip_packages = {
                'num2words' => { ensure => '0.5.10' },
              }
            }
            default: {
              warning("Please contribute support for ubuntu ${facts.get('os.release.full')}")
              $odoo_dependencies = []
              $odoo_pip_packages = {}
            }
          }
        }
        default: {
          warning("Please contribute support for ${facts.get('os.name')}")
          $odoo_dependencies = []
          $odoo_pip_packages = {}
        }
      }

      package { $odoo_dependencies:
        ensure => installed,
      }

      $odoo_pip_packages.each |$name, $options| {
        package { $name:
          provider => $odoo::pip_provider,
          require  => Package[$odoo::pip_package],
          *        => $options,
        }
      }
    }

    if versioncmp($odoo::version, '11.0') >= 0 {
      # These dependencies are only listed on the Odoo 13 page:
      # https://www.odoo.com/documentation/13.0/setup/install.html
      # Odoo 10.0 depends on the python-xlwt package (old version), so install
      # the pip module on Odoo 11 and better.
      unless fact('os.name') == 'debian' and versioncmp(fact('os.release.full'), '12.0') >= 0 {
        package { 'xlwt':
          ensure   => '1.3.0',
          provider => $odoo::pip_provider,
          require  => Package[$odoo::pip_package],
          notify   => Class['odoo::service'],
        }
      }
    }
  }
}
