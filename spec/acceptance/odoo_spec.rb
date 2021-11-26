require 'spec_helper_acceptance'

def package_supported_versions
  {
    'Debian' => {
      '9'  => ['11.0', '12.0', '13.0', '14.0', '15.0'],
      '10' => ['11.0', '12.0', '13.0', '14.0', '15.0'],
      '11' => ['system'],
    },
    'Ubuntu' => {
      '18.04' => ['11.0', '12.0', '13.0', '14.0', '15.0'],
      '20.04' => ['11.0', '12.0', '13.0', '14.0', '15.0'],
    },
  }[fact('os.name')][fact('os.release.major')]
end

def vcsrepo_supported_versions
  {
    'Debian' => {
      '10' => ['14.0', '15.0'],
      '11' => ['14.0', '15.0'],
    },
    'Ubuntu' => {
      '18.04' => [],
      '20.04' => ['14.0', '15.0'],
    },
  }[fact('os.name')][fact('os.release.major')]
end

describe 'odoo class' do
  vcsrepo_supported_versions.each do |version|
    context "when installing odoo #{version} from git" do
      it 'works idempotently with no errors' do
        pp = <<~MANIFEST
          package { ['git', 'postgresql']:
            ensure => installed
          }
          -> class { 'python':
            version => '3',
            dev     => 'present',
          }
          -> class { 'odoo':
            version      => '#{version}',
            install_from => 'vcsrepo',
          }
        MANIFEST

        apply_manifest(pp, catch_failures: true)
        apply_manifest(pp, catch_changes: true)
      end

      describe service('odoo') do
        it { is_expected.to be_enabled }
        it { is_expected.to be_running }
      end

      describe port(8069) do
        it { is_expected.to be_listening }
      end
    end
  end

  package_supported_versions.each do |version|
    context "when using odoo version=#{version.inspect} from packages" do
      let(:version) { version }

      if version == 'system'
        it 'works idempotently with no errors' do
          pp = <<~MANIFEST
            class { 'apt':
              purge => {
                'sources.list.d' => true,
              },
            }

            class { 'odoo':
              version => '#{version}'
            }
          MANIFEST

          apply_manifest(pp, catch_failures: true)
          apply_manifest(pp, catch_changes: true)
        end
      else
        it 'works idempotently with no errors' do
          # FIXME: We should not tweak anything here, the odoo class should be self-contained
          pp = <<~MANIFEST
            class { 'apt':
              purge => {
                'sources.list.d' => true,
              },
            }

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
end
