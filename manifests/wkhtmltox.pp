# @summary Manage wkhtmltox
#
# @api private
class odoo::wkhtmltox {
  assert_private()

  $wkhtmltox_version = '0.12.1.4'
  $wkhtmltox_dependencies = [
    'xfonts-75dpi',
    'xfonts-base',
  ]

  archive { "/var/cache/wkhtmltox_${wkhtmltox_version}.deb":
    ensure => present,
    user   => 'root',
    group  => 'root',
    source => "https://builds.wkhtmltopdf.org/${wkhtmltox_version}/wkhtmltox_${wkhtmltox_version}-1.${facts.get('os.distro.codename')}_${facts.get('architecture')}.deb",
  }

  package { $wkhtmltox_dependencies:
    ensure => installed,
  }

  package { 'wkhtmltox':
    ensure   => installed,
    provider => 'dpkg',
    source   => "/var/cache/wkhtmltox_${wkhtmltox_version}.deb",
    require  => [
      Archive["/var/cache/wkhtmltox_${wkhtmltox_version}.deb"],
      Package[$wkhtmltox_dependencies],
    ],
  }
}
