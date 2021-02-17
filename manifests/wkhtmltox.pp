# @summary Manage wkhtmltox
#
# @api private
class odoo::wkhtmltox {
  include odoo

  assert_private()

  $wkhtmltox_version = '0.12.5'
  $wkhtmltox_url = "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/${wkhtmltox_version}/wkhtmltox_${wkhtmltox_version}-1.${facts.get('os.distro.codename')}_${facts.get('architecture')}.deb"

  $wkhtmltox_dependencies = $facts.get('os.name') ? {
    'Debian' => [
      'fontconfig',
      'libjpeg62-turbo',
      'libxrender1',
      'xfonts-75dpi',
      'xfonts-base',
    ],
    'Ubuntu' => [
      'fontconfig',
      'libjpeg-turbo8',
      'libxrender1',
      'xfonts-75dpi',
      'xfonts-base',
    ],
  }

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
