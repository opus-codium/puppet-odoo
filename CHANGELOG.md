# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v5.1.0](https://github.com/opus-codium/puppet-odoo/tree/v5.1.0) (2025-05-21)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v5.0.1...v5.1.0)

**Implemented enhancements:**

- Allow puppetlabs-apt 10.x [\#94](https://github.com/opus-codium/puppet-odoo/pull/94) ([smortex](https://github.com/smortex))

## [v5.0.1](https://github.com/opus-codium/puppet-odoo/tree/v5.0.1) (2025-01-28)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v5.0.0...v5.0.1)

**Fixed bugs:**

- Fix regular expression escaping [\#91](https://github.com/opus-codium/puppet-odoo/pull/91) ([smortex](https://github.com/smortex))

## [v5.0.0](https://github.com/opus-codium/puppet-odoo/tree/v5.0.0) (2025-01-27)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v4.1.0...v5.0.0)

**Breaking changes:**

- Switch to another source for wkhtmltopdf [\#89](https://github.com/opus-codium/puppet-odoo/pull/89) ([smortex](https://github.com/smortex))
- Drop support for Debian 10 and Ubuntu 18.04 \(EOL\) [\#87](https://github.com/opus-codium/puppet-odoo/pull/87) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add support for odoo 18.0 [\#88](https://github.com/opus-codium/puppet-odoo/pull/88) ([NeatNerdPrime](https://github.com/NeatNerdPrime))
- Add support for Ubuntu 24.04 [\#81](https://github.com/opus-codium/puppet-odoo/pull/81) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Add python3-pdfminer dependency [\#86](https://github.com/opus-codium/puppet-odoo/pull/86) ([smortex](https://github.com/smortex))

## [v4.1.0](https://github.com/opus-codium/puppet-odoo/tree/v4.1.0) (2024-06-06)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- Add support for Ubuntu 22.04 [\#80](https://github.com/opus-codium/puppet-odoo/pull/80) ([smortex](https://github.com/smortex))
- Add support for odoo 17.0 [\#79](https://github.com/opus-codium/puppet-odoo/pull/79) ([smortex](https://github.com/smortex))
- Add support for Debian 12 [\#77](https://github.com/opus-codium/puppet-odoo/pull/77) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix Debian 10 support [\#78](https://github.com/opus-codium/puppet-odoo/pull/78) ([smortex](https://github.com/smortex))

## [v4.0.0](https://github.com/opus-codium/puppet-odoo/tree/v4.0.0) (2024-04-12)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v3.0.2...v4.0.0)

**Breaking changes:**

- Namespace ensure\_packages\(\) [\#75](https://github.com/opus-codium/puppet-odoo/pull/75) ([smortex](https://github.com/smortex))

## [v3.0.2](https://github.com/opus-codium/puppet-odoo/tree/v3.0.2) (2023-12-11)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v3.0.1...v3.0.2)

**Fixed bugs:**

- Fix `odoo::database_restore` [\#73](https://github.com/opus-codium/puppet-odoo/pull/73) ([smortex](https://github.com/smortex))

## [v3.0.1](https://github.com/opus-codium/puppet-odoo/tree/v3.0.1) (2023-07-07)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v3.0.0...v3.0.1)

**Fixed bugs:**

- Fix `odoo` fact with odoo 16.0 [\#69](https://github.com/opus-codium/puppet-odoo/pull/69) ([smortex](https://github.com/smortex))

## [v3.0.0](https://github.com/opus-codium/puppet-odoo/tree/v3.0.0) (2023-07-04)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v2.2.0...v3.0.0)

**Breaking changes:**

- Drop Puppet 6 \(EOL\) [\#65](https://github.com/opus-codium/puppet-odoo/pull/65) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add support for Puppet 8 [\#67](https://github.com/opus-codium/puppet-odoo/pull/67) ([smortex](https://github.com/smortex))
- Relax dependencie's version requirements [\#63](https://github.com/opus-codium/puppet-odoo/pull/63) ([smortex](https://github.com/smortex))
- Add support for odoo 16.0 [\#60](https://github.com/opus-codium/puppet-odoo/pull/60) ([smortex](https://github.com/smortex))

## [v2.2.0](https://github.com/opus-codium/puppet-odoo/tree/v2.2.0) (2023-02-17)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/v2.1.0...v2.2.0)

**Implemented enhancements:**

- Allow latest version of apt [\#55](https://github.com/opus-codium/puppet-odoo/pull/55) ([smortex](https://github.com/smortex))
- Add Bolt tasks to initialize / update odoo databases [\#54](https://github.com/opus-codium/puppet-odoo/pull/54) ([smortex](https://github.com/smortex))

**Merged pull requests:**

- Fix legacy fact [\#56](https://github.com/opus-codium/puppet-odoo/pull/56) ([smortex](https://github.com/smortex))

## [v2.1.0](https://github.com/opus-codium/puppet-odoo/tree/v2.1.0) (2021-12-02)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/2.0.1...v2.1.0)

**Implemented enhancements:**

- Add support for odoo 14.0 and 15.0 on Debian Bullseye [\#51](https://github.com/opus-codium/puppet-odoo/pull/51) ([smortex](https://github.com/smortex))
- Add support for odoo 15.0 [\#49](https://github.com/opus-codium/puppet-odoo/pull/49) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix supported versions [\#52](https://github.com/opus-codium/puppet-odoo/pull/52) ([smortex](https://github.com/smortex))

## [2.0.1](https://github.com/opus-codium/puppet-odoo/tree/2.0.1) (2021-09-15)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/2.0.0...2.0.1)

**Fixed bugs:**

- Fix fact resolution with Debian system package [\#47](https://github.com/opus-codium/puppet-odoo/pull/47) ([smortex](https://github.com/smortex))

## [2.0.0](https://github.com/opus-codium/puppet-odoo/tree/2.0.0) (2021-09-15)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.2.1...2.0.0)

**Breaking changes:**

- Drop support for Debian 9 \(EOL\) [\#44](https://github.com/opus-codium/puppet-odoo/pull/44) ([smortex](https://github.com/smortex))
- Drop support for Ubuntu 16.04 \(EOL\) [\#41](https://github.com/opus-codium/puppet-odoo/pull/41) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Make wkhtmltox package management optional [\#45](https://github.com/opus-codium/puppet-odoo/pull/45) ([smortex](https://github.com/smortex))
- Allow to install Debian 11's odoo-14 package [\#43](https://github.com/opus-codium/puppet-odoo/pull/43) ([smortex](https://github.com/smortex))
- Add support for Debian 11 [\#40](https://github.com/opus-codium/puppet-odoo/pull/40) ([smortex](https://github.com/smortex))

**Merged pull requests:**

- Allow up-to-date dependencies [\#42](https://github.com/opus-codium/puppet-odoo/pull/42) ([smortex](https://github.com/smortex))

## [1.2.1](https://github.com/opus-codium/puppet-odoo/tree/1.2.1) (2021-05-14)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.2.0...1.2.1)

**Fixed bugs:**

- Fix odoo::database\_restore [\#37](https://github.com/opus-codium/puppet-odoo/pull/37) ([smortex](https://github.com/smortex))

## [1.2.0](https://github.com/opus-codium/puppet-odoo/tree/1.2.0) (2021-05-04)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.1.0...1.2.0)

**Implemented enhancements:**

- Extend the odoo fact with a list of databases and installed addons [\#36](https://github.com/opus-codium/puppet-odoo/pull/36) ([smortex](https://github.com/smortex))
- Update dependencies [\#35](https://github.com/opus-codium/puppet-odoo/pull/35) ([smortex](https://github.com/smortex))

## [1.1.0](https://github.com/opus-codium/puppet-odoo/tree/1.1.0) (2021-02-18)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.0.2...1.1.0)

**Implemented enhancements:**

- Add support for Ubuntu 20.04 [\#33](https://github.com/opus-codium/puppet-odoo/pull/33) ([smortex](https://github.com/smortex))
- Report incompatible Odoo and OS versions [\#31](https://github.com/opus-codium/puppet-odoo/pull/31) ([smortex](https://github.com/smortex))
- Add support for Odoo 14.0 [\#29](https://github.com/opus-codium/puppet-odoo/pull/29) ([smortex](https://github.com/smortex))
- Add support for Debian [\#28](https://github.com/opus-codium/puppet-odoo/pull/28) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix installation of wkhtmltopdf [\#32](https://github.com/opus-codium/puppet-odoo/pull/32) ([smortex](https://github.com/smortex))
- Fix module dependencies [\#30](https://github.com/opus-codium/puppet-odoo/pull/30) ([smortex](https://github.com/smortex))

## [1.0.2](https://github.com/opus-codium/puppet-odoo/tree/1.0.2) (2021-02-10)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.0.1...1.0.2)

**Fixed bugs:**

- Fix advertised OS support [\#26](https://github.com/opus-codium/puppet-odoo/pull/26) ([smortex](https://github.com/smortex))
- Remove explicit data\_provider from metadata.json [\#24](https://github.com/opus-codium/puppet-odoo/pull/24) ([smortex](https://github.com/smortex))

## [1.0.1](https://github.com/opus-codium/puppet-odoo/tree/1.0.1) (2021-01-13)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/1.0.0...1.0.1)

**Implemented enhancements:**

- Add REFERENCE.md [\#20](https://github.com/opus-codium/puppet-odoo/pull/20) ([neomilium](https://github.com/neomilium))
- Add a task to change an user password [\#18](https://github.com/opus-codium/puppet-odoo/pull/18) ([smortex](https://github.com/smortex))
- Add a task to list users [\#17](https://github.com/opus-codium/puppet-odoo/pull/17) ([smortex](https://github.com/smortex))
- Report database.uuid in odoo::databases\_list task [\#16](https://github.com/opus-codium/puppet-odoo/pull/16) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix `odoo::database_backup` [\#22](https://github.com/opus-codium/puppet-odoo/pull/22) ([smortex](https://github.com/smortex))

## [1.0.0](https://github.com/opus-codium/puppet-odoo/tree/1.0.0) (2020-12-21)

[Full Changelog](https://github.com/opus-codium/puppet-odoo/compare/34c23a29889f00493305ed69d32dc28b04f58e91...1.0.0)

**Implemented enhancements:**

- Rework module tasks [\#12](https://github.com/opus-codium/puppet-odoo/pull/12) ([smortex](https://github.com/smortex))
- Improve databases listing [\#10](https://github.com/opus-codium/puppet-odoo/pull/10) ([smortex](https://github.com/smortex))
- Add tasks for databases management [\#5](https://github.com/opus-codium/puppet-odoo/pull/5) ([smortex](https://github.com/smortex))
- Use wkhtmltox 0.12.5 with Odoo 13 [\#3](https://github.com/opus-codium/puppet-odoo/pull/3) ([smortex](https://github.com/smortex))
- Rely on package mark released with Puppet 6.13.0 [\#2](https://github.com/opus-codium/puppet-odoo/pull/2) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix database creation [\#9](https://github.com/opus-codium/puppet-odoo/pull/9) ([smortex](https://github.com/smortex))
- Fix show\_diff [\#4](https://github.com/opus-codium/puppet-odoo/pull/4) ([smortex](https://github.com/smortex))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
