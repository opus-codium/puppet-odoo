require 'spec_helper_acceptance'

describe 'odoo class' do
  ['10.0', '11.0', '12.0', '13.0'].each do |version|
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

      package { 'python-pip':
        ensure => installed,
      }

      package { 'python3-pip':
        ensure => installed,
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
