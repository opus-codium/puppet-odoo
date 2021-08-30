# @summary Manage wkhtmltox
#
# @api private
class odoo::wkhtmltox {
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

  $wkhtmltox_filename = "/var/cache/wkhtmltox_${wkhtmltox_version}.${facts.get('os.distro.codename')}_${facts.get('architecture')}.deb"

  archive { $wkhtmltox_filename:
    ensure => present,
    user   => 'root',
    group  => 'root',
    source => $wkhtmltox_url,
  }

  ensure_packages($wkhtmltox_dependencies, { ensure => installed })

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
