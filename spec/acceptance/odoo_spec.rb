require 'spec_helper_acceptance'

def odoo_supported_versions
  {
    'Debian' => {
      '9'  => ['11.0', '12.0', '13.0', '14.0'],
      '10' => ['11.0', '12.0', '13.0', '14.0'],
    },
    'Ubuntu' => {
      '18.04' => ['11.0', '12.0', '13.0', '14.0'],
      '20.04' => ['11.0', '12.0', '13.0', '14.0'],
    },
  }[fact('os.name')][fact('os.release.major')]
end

describe 'odoo class' do
  odoo_supported_versions.each do |version|
    context "when using odoo #{version}" do
      let(:version) { version }

      it 'works idempotently with no errors' do
        # FIXME: We should not tweak anything here, the odoo class should be self-contained
        pp = <<~MANIFEST
          if $facts.get('os.name') == 'debian' {
            class { 'apt::backports':
            }
          }
          if $facts.get('os.name') == 'ubuntu' {
            apt::source { 'ubuntu-universe':
              location => 'http://archive.ubuntu.com/ubuntu',
              repos    => 'universe',
            }
          }

          if '#{version}' == '10.0' {
            package { 'python-pip':
              ensure => installed,
            }
          } else {
            package { 'python3-pip':
              ensure => installed,
            }
          }

          class { 'odoo':
            version => '#{version}'
          }

          Class['apt::update']
          -> Class['odoo::dependencies']
        MANIFEST

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end
    end
  end
end
