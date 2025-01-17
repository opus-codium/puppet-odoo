# frozen_string_literal: true

require 'spec_helper_acceptance'

def odoo_supported_versions
  {
    'Debian' => {
      '11' => ['14.0', '15.0', '16.0', 'system'],
      '12' => ['14.0', '15.0', '16.0', '17.0'],
    },
    'Ubuntu' => {
      '20.04' => ['11.0', '12.0', '13.0', '14.0', '15.0', '16.0'],
      '22.04' => ['14.0', '15.0', '16.0', '17.0'],
    },
  }[fact('os.name')][fact('os.release.major')]
end

describe 'odoo class' do
  odoo_supported_versions.each do |version|
    context "when using odoo version=#{version.inspect}" do
      let(:version) { version }

      it 'works idempotently with no errors' do
        # Normally we should just purge the package between tests but this
        # somewhat fails on Ubuntu so we explicitely terminate the service and
        # delete the user account to have a working environment.  No thank you
        # Ubuntu.
        shell('systemctl stop odoo || true')
        shell('apt-get purge -y odoo || true')
        shell('userdel odoo || true')

        pp = if version == 'system'
               <<~MANIFEST
                 class { 'apt':
                   purge => {
                     'sources.list.d' => true,
                   },
                 }

                 class { 'odoo':
                   version     => '#{version}',
                   wkhtmltopdf => 'wkhtmltox',
                 }
               MANIFEST
             else
               # FIXME: We should not tweak anything here, the odoo class should be self-contained
               <<~MANIFEST
                 class { 'apt':
                   purge => {
                     'sources.list.d' => true,
                   },
                 }

                 if $facts.get('os.name') == 'debian' and versioncmp($facts.get('os.release.full'), '12') >= 0 {
                   apt::source { 'debian':
                     location => 'http://deb.debian.org/debian',
                   }
                 }

                 if $facts.get('os.name') == 'ubuntu' {
                   apt::source { 'ubuntu-universe':
                     location => 'http://archive.ubuntu.com/ubuntu',
                     repos    => 'universe',
                   }
                 }

                 class { 'odoo':
                   version     => '#{version}',
                   wkhtmltopdf => 'wkhtmltox',
                 }

                 Class['apt::update']
                 -> Class['odoo::dependencies']
               MANIFEST
             end

        apply_manifest(pp, catch_failures: true)
        shell('journalctl -u odoo')
        apply_manifest(pp, catch_changes: true)
      end
    end
  end
end
