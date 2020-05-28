# @summary Manage wkhtmltox
#
# @api private
class odoo::wkhtmltox {
  include odoo

  assert_private()

  $wkhtmltox_version = $odoo::version ? {
    '13.0'  => '0.12.5',
    default => '0.12.1.4',
  }

  $wkhtmltox_url = $odoo::version ? {
    '13.0'  => "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${wkhtmltox_version}/wkhtmltox_${wkhtmltox_version}-1.${facts.get('os.distro.codename')}_${facts.get('architecture')}.deb",
    default => "https://builds.wkhtmltopdf.org/${wkhtmltox_version}/wkhtmltox_${wkhtmltox_version}-1.${facts.get('os.distro.codename')}_${facts.get('architecture')}.deb",
  }

  $wkhtmltox_dependencies = [
    'xfonts-75dpi',
    'xfonts-base',
  ]

  archive { "/var/cache/wkhtmltox_${wkhtmltox_version}.deb":
    ensure => present,
    user   => 'root',
    group  => 'root',
    source => $wkhtmltox_url,
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
