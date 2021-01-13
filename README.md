# puppet-odoo

<!-- vim-markdown-toc GFM -->

* [Module description](#module-description)
* [Usage](#usage)
	* [Basic usage](#basic-usage)
	* [Usage with odoo-enterprise](#usage-with-odoo-enterprise)

<!-- vim-markdown-toc -->

## Module description

This Puppet module allows managing odoo with Puppet

## Usage

### Basic usage

Usage in a profile is straightforward, the only mandatory parameter being the version of odoo you want to install:

```puppet
class profile::odoo {
  class { 'odoo':
    version => '13.0',
  }
}
```

### Usage with odoo-enterprise

Odoo-enterprise is a collection of non-free plugins installed on top of odoo which provide extra features.

The easiest way is probably to fork https://github.com/odoo/enterprise in your organization, and add deploy keys for your servers in your copy of the repo.

Then rely on [vcsrepo](https://github.com/puppetlabs/puppetlabs-vcsrepo/) to fetch the proper version of the repository and configure it in your profile:

```puppet
class profile::odoo (
  Enum['10.0', '11.0', '12.0', '13.0'] $version,
) {
  $enterprise_path = '/opt/odoo/enterprise'
  $enterprise_revision = $version ? {
    '10.0' => '123456',
    '11.0' => '234567',
    '12.0' => '345678',
    '13.0' => '456789',
  }

  vcsrepo { $enterprise_path:
    ensure   => present,
    provider => 'git',
    source   => "git@github.com:${organization}/odoo-enterprise.git",
    revision => $enterprise_revision,
    notify   => Class['odoo::service'],
    force    => true,
  }

  class { 'odoo':
    version     => $version,
    addons_path => [
      $enterprise_path,
      '/usr/lib/python3/dist-packages/odoo/addons',
    ],
  }
}
```
