# @summary Manage wkhtmltox
#
# @api private
class odoo::wkhtmltox {
  assert_private()

  $wkhtmltox_url = "https://github.com/newinnovations/wkhtml-packaging/releases/download/v${odoo::wkhtmltox_version}/wkhtmltox_${odoo::wkhtmltox_version}-${facts.get('os.distro.codename')}_${facts.get('os.architecture')}.deb"

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

  $wkhtmltox_filename = "/var/cache/wkhtmltox_${odoo::wkhtmltox_version}.${facts.get('os.distro.codename')}_${facts.get('os.architecture')}.deb"

  archive { $wkhtmltox_filename:
    ensure => present,
    user   => 'root',
    group  => 'root',
    source => $wkhtmltox_url,
  }

  stdlib::ensure_packages($wkhtmltox_dependencies, { ensure => installed, require => Class['odoo::dependencies'] })

  package { 'wkhtmltox':
    ensure   => installed,
    provider => 'dpkg',
    source   => $wkhtmltox_filename,
    require  => [
      Archive[$wkhtmltox_filename],
      Package[$wkhtmltox_dependencies],
    ],
  }
}
