# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.4.2](https://github.com/csipiemonte/consul/compare/v1.4.1...v1.4.2) - 2019-09-30

### Changed
- Upd Gemfile
- Fixed logout SPID session (staging)

## [1.4.1](https://github.com/csipiemonte/consul/compare/v1.4.0...v1.4.1) - 2019-07-31

### Added

- **Admin:** New settings `feature.remote_census`
## [1.4.0](https://github.com/csipiemonte/consul/compare/v1.3.3...v1.4.0) - 2019-07-26

### Added
- **Admin:** Add document uploads from admin sectio
- **Admin:** Improve Admin settings section
- **Admin:** Add download's dashboard
- **Dashboard:** Add proposal's dashboard
- **Milestones:** Add progress bars to milestones public view

### Changed
- Privacy and census_terms moved to DB

## [1.3.3](https://github.com/csipiemonte/consul/compare/v1.3.2...v1.3.3) - 2018-12-14

### Added
- New settings `hot_score_period_in_days`, `feature.featured_proposals`
- Enhancements to admin backoffice

## [1.3.2](https://github.com/csipiemonte/consul/compare/v1.3.1...v1.3.2) - 2018-12-04

### Changed
- Privacy and conditions pages

## [1.3.1](https://github.com/csipiemonte/consul/compare/v1.3.0...v1.3.1) - 2018-11-16

### Added
- New setting `feature.help_page`
- Node.js to compile assets

### Removed
- Proposal guide

## [1.3.0](https://github.com/csipiemonte/consul/compare/v1.2.5...v1.3.0) - 2018-08-31

### Added
- Homepage: cards, header and cards seeds; customization of homepage from admin section
- Recommendations: Debates and proposals recommendations for users
- Configuration: Added setting on admin to skip user verification
- Admin newsletter emails
- New setting `feature.allow_images` to allow upload and show images for both (proposals and budget investment projects)
- Related Content feature. Now Debates & Proposals can be related

## [1.2.5](https://github.com/csipiemonte/consul/compare/v1.2.4...v1.2.5) - 2018-07-09

### Changed
- Votes to legislation proposals not only for verified users

## [1.2.4](https://github.com/csipiemonte/consul/compare/v1.2.3...v1.2.4) - 2018-07-02

### Changed
- Summary of Subway line 2 card 

## [1.2.3](https://github.com/csipiemonte/consul/compare/v1.2.2...v1.2.3) - 2018-07-02

### Changed
- Subway line 2 in home page
- Comments to legislation processes not only for verified users
- Footer

## [1.2.2](https://github.com/csipiemonte/consul/compare/v1.2.1...v1.2.2) - 2018-04-12

### Changed
- Logout SPID sessions

## [1.2.1](https://github.com/csipiemonte/consul/compare/v1.2.0...v1.2.1) - 2018-02-13

### Changed
- Home, FAQ, conditions, more info page

## [1.2.0](https://github.com/csipiemonte/consul/compare/v1.1.0...v1.2.0) - 2018-02-09

### Changed
- Home page slots
- Labels text
- FAQ, more info page
- Delayed Job disabled for production env

## [1.1.0](https://github.com/csipiemonte/consul/compare/v1.0.1...v1.1.0) - 2018-01-23

### Added
- SPID authentication
- Symlink to data/public/system (docs and images)
- Symlink to data/tmp

### Changed
- Log file path

## [1.0.1](https://github.com/csipiemonte/consul/compare/v1.0.0...v1.0.1) - 2017-12-05

### Changed
- Welcome page CSS

## [1.0.0](https://github.com/csipiemonte/consul/compare/v0.10...v1.0.0) - 2017-12-04

CSI Piemonte initial version.

## [0.10](https://github.com/consul/consul/compare/v0.9...v0.10) - 2017-07-05
### Added
- Milestones on Budget Investment's
- Feature flag to enable/disable Legislative Processes
- Locale site pages customization
- Incompatible investments

### Changed
- Localization files reorganization. Check migration instruction at https://github.com/consul/consul/releases/tag/v0.10
- Rails 4.2.9

## [0.9.0](https://github.com/consul/consul/compare/v0.8...v0.9) - 2017-06-15
### Added
- Budgets
- Basic polls
- Collaborative legistlation
- Custom pages
- GraphQL API
- Improved admin section

### Changed
- Improved admin section
- Rails 4.2.8
- Ruby 2.3.2

### Deprecated
- SpendingProposals are deprecated now in favor of Budgets

### Fixed
- CKEditor locale compilation fixed
- Fixed bugs in mobile layouts

## [0.8.0](https://github.com/consul/consul/compare/v0.7...v0.8)- 2016-07-21
### Added
- Support for customization schema, vía specific custom files, assets and folders

### Changed
- Rails 4.2.7
- Ruby 2.3.1

### Fixed
- Fixed bug causing errors on user deletion

## [0.7.0] - 2016-04-25
### Added
- Debates
- Proposals
- Basic Spending Proposals

### Changed
- Rails 4.2.6
- Ruby 2.2.3

[Unreleased]: https://github.com/consul/consul/compare/v0.10...consul:master
[0.10.0]: https://github.com/consul/consul/compare/v0.9...v0.10
[0.9.0]: https://github.com/consul/consul/compare/v0.8...v0.9
[0.8.0]: https://github.com/consul/consul/compare/v0.7...v0.8
