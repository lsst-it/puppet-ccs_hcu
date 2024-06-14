# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v3.5.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.5.0) (2024-06-14)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.4.2...v3.5.0)

**Implemented enhancements:**

- Add support for Dracal USB PTH450 [\#38](https://github.com/lsst-it/puppet-ccs_hcu/pull/38) ([glennmorris](https://github.com/glennmorris))

## [v3.4.2](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.4.2) (2024-06-11)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.4.1...v3.4.2)

**Implemented enhancements:**

- Version 3.4.2 [\#37](https://github.com/lsst-it/puppet-ccs_hcu/pull/37) ([glennmorris](https://github.com/glennmorris))

**Fixed bugs:**

- \(files/poweroff\) remove quoting that breaks the script [\#36](https://github.com/lsst-it/puppet-ccs_hcu/pull/36) ([glennmorris](https://github.com/glennmorris))

## [v3.4.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.4.1) (2024-06-05)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.3.1...v3.4.1)

**Implemented enhancements:**

- Version 3.4.1 [\#35](https://github.com/lsst-it/puppet-ccs_hcu/pull/35) ([glennmorris](https://github.com/glennmorris))
- Add option to install aiousb [\#34](https://github.com/lsst-it/puppet-ccs_hcu/pull/34) ([glennmorris](https://github.com/glennmorris))

## [v3.3.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.3.1) (2024-05-30)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.2.1...v3.3.1)

**Implemented enhancements:**

- Version 3.3.1 [\#33](https://github.com/lsst-it/puppet-ccs_hcu/pull/33) ([glennmorris](https://github.com/glennmorris))
- Add option to install shutter utilities [\#32](https://github.com/lsst-it/puppet-ccs_hcu/pull/32) ([glennmorris](https://github.com/glennmorris))

## [v3.2.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.2.1) (2024-05-21)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.1.2...v3.2.1)

**Implemented enhancements:**

- Version 3.2.1 [\#31](https://github.com/lsst-it/puppet-ccs_hcu/pull/31) ([glennmorris](https://github.com/glennmorris))
- \(puppet-ccs\_hcu\) add apache license to repo [\#29](https://github.com/lsst-it/puppet-ccs_hcu/pull/29) ([dtapiacl](https://github.com/dtapiacl))

**Fixed bugs:**

- Convert pkgurl\_{user,pass} params to Sensitive [\#30](https://github.com/lsst-it/puppet-ccs_hcu/pull/30) ([glennmorris](https://github.com/glennmorris))

## [v3.1.2](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.1.2) (2024-01-29)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.1.1...v3.1.2)

**Implemented enhancements:**

- Bump version to 3.1.2. [\#28](https://github.com/lsst-it/puppet-ccs_hcu/pull/28) ([glennmorris](https://github.com/glennmorris))
- \(imanager\) tweak parameters of the gpio group [\#27](https://github.com/lsst-it/puppet-ccs_hcu/pull/27) ([glennmorris](https://github.com/glennmorris))

## [v3.1.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.1.1) (2023-11-16)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.1.0...v3.1.1)

**Implemented enhancements:**

- Bump version to 3.1.1 [\#26](https://github.com/lsst-it/puppet-ccs_hcu/pull/26) ([glennmorris](https://github.com/glennmorris))
- \(files/imanager-init\) handle rhel9+, with no /sys/class/gpio [\#25](https://github.com/lsst-it/puppet-ccs_hcu/pull/25) ([glennmorris](https://github.com/glennmorris))

## [v3.1.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.1.0) (2023-08-22)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- allow saz/sudo 8.x [\#23](https://github.com/lsst-it/puppet-ccs_hcu/pull/23) ([jhoblitt](https://github.com/jhoblitt))
- allow stdlib 9.x [\#21](https://github.com/lsst-it/puppet-ccs_hcu/pull/21) ([jhoblitt](https://github.com/jhoblitt))

## [v3.0.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v3.0.0) (2023-06-23)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.3.0...v3.0.0)

**Breaking changes:**

- \(plumbing\) drop support for puppet6 [\#13](https://github.com/lsst-it/puppet-ccs_hcu/pull/13) ([jhoblitt](https://github.com/jhoblitt))

**Implemented enhancements:**

- allow puppet/archive 7.x [\#17](https://github.com/lsst-it/puppet-ccs_hcu/pull/17) ([jhoblitt](https://github.com/jhoblitt))
- add support for puppet8 [\#14](https://github.com/lsst-it/puppet-ccs_hcu/pull/14) ([jhoblitt](https://github.com/jhoblitt))

## [v2.3.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.3.0) (2023-01-31)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.2.2...v2.3.0)

**Implemented enhancements:**

- normalize supported operating systems [\#9](https://github.com/lsst-it/puppet-ccs_hcu/pull/9) ([jhoblitt](https://github.com/jhoblitt))

## [v2.2.2](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.2.2) (2022-08-17)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.2.1...v2.2.2)

**Merged pull requests:**

- release 2.2.2 [\#7](https://github.com/lsst-it/puppet-ccs_hcu/pull/7) ([jhoblitt](https://github.com/jhoblitt))

## [v2.2.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.2.1) (2022-08-17)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.2.0...v2.2.1)

**Merged pull requests:**

- release 2.2.1 [\#6](https://github.com/lsst-it/puppet-ccs_hcu/pull/6) ([jhoblitt](https://github.com/jhoblitt))
- modulesync 5.3.0 [\#5](https://github.com/lsst-it/puppet-ccs_hcu/pull/5) ([jhoblitt](https://github.com/jhoblitt))

## [v2.2.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.2.0) (2022-07-15)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.1.0...v2.2.0)

**Merged pull requests:**

- add EL8 support [\#4](https://github.com/lsst-it/puppet-ccs_hcu/pull/4) ([jhoblitt](https://github.com/jhoblitt))
- Improve treatment of package source [\#3](https://github.com/lsst-it/puppet-ccs_hcu/pull/3) ([glennmorris](https://github.com/glennmorris))

## [v2.1.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.1.0) (2022-07-13)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v2.0.0...v2.1.0)

## [v2.0.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v2.0.0) (2022-02-01)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v0.1.1...v2.0.0)

**Merged pull requests:**

- update to ~ voxpupuli 5.1.0 plumbing [\#2](https://github.com/lsst-it/puppet-ccs_hcu/pull/2) ([jhoblitt](https://github.com/jhoblitt))

## [v0.1.1](https://github.com/lsst-it/puppet-ccs_hcu/tree/v0.1.1) (2021-07-29)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- add pdk mod plumbing [\#1](https://github.com/lsst-it/puppet-ccs_hcu/pull/1) ([jhoblitt](https://github.com/jhoblitt))

## [v0.1.0](https://github.com/lsst-it/puppet-ccs_hcu/tree/v0.1.0) (2020-06-11)

[Full Changelog](https://github.com/lsst-it/puppet-ccs_hcu/compare/ce1d752694fcad2943fe953bae5f392feabbcbeb...v0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
