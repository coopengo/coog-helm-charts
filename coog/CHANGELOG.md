# Changelog
## [2.14.2225] - 2022-06-29

### Added

- Manage apiVersion for Ingress. Depend on Kubernetes Cluster version
- Added mode maintenance to redirect traffic to a maintenance web page

# Changelog

## [2.13.2133] - 2021-08-25

- coog: Fix TRYTOND_CACHE__CLASS
- coog: Disable syntax analysis in init container
- daily: Fix#20143 - Increase number of failed job history

# Changelog

## [2.4.2] - 2021-01-22

### Changed

- celery: Fix health check command to comply with Celery 5.0

# Changelog

## [2.4.1] - 2021-01-19

### Changed

- web: Change database from redis to mongo
- flower: Restore command to run flower service properly

## [2.4.0] - 2021-01-19

### Changed

- trytond database uri variable available.

## [2.3.8] - 2021-01-19

### Changed

- Fix Web extraEnv pattern

## [2.3.7] - 2020-12-30

### Changed

- Fix Celery liveness/readiness arguments

## [2.3.6] - 2020-12-30

### Changed

-  Celery liveness/readiness optimisation
-  Resources configuration available for specificBatchConcurrency

## [2.3.4] - 2020-12-30

### Fix

-  Batch configuration available for celery
-  Update documentation

# Changelog

## [2.3.2] - 2020-12-01

### Fix

-  Unoconv liveness/readiness configuration

## [2.3.1] - 2020-11-29

### Fix

-  Use coopengohub registry + 2.10.2048 default version

## [2.3.0] - 2020-11-29

### Fix

-  Update flower to 0.9.5 + non root mode

## [2.2.2] - 2020-11-17

### Fix

-  Unoconv version to dgw-0.0.1


## [2.2.1] - 2020-11-17

### Fix

-  Fix default value for unoconv liveness/readiness


## [2.2.0] - 2020-11-17

### Added

-  New unoconv realease

## [2.1.4] - 2020-11-12

### Fix

-  Fix redis var for celery_single for version < coog-2.10

## [2.1.3] - 2020-11-12

### Fix

-  coogCeleryModule for celery

## [2.1.2] - 2020-11-12

### Fix

- Revert cache_uri var env for version < coog-2.10

## [2.1.1] - 2020-11-12

### Fix

- Revert redis var env for version < coog-2.10

## [2.1.0] - 2020-11-12

### Fix

- Var for coogCeleryModule (default: coog_async.coog_celery)

## [2.0.5] - 2020-11-05

### Fix

- Remove FORCEDOTCOM varenv

## [2.0.4] - 2020-11-05

### Fix

- Remove pythonpath for celery

## [2.0.3] - 2020-10-20

### Fix

- Remove redis unused var
- Fix rabbitmq default settings

## [2.0.2] - 2020-10-20

### Fix

- Fix celery broker declaration (change broker_celery to coog_celery)

## [2.0.1] - 2020-10-19

### Fix

- Fix rabbitmq enabled configuration

## [2.0.0] - 2020-10-13

### Added

- Add rabbitmq support
- Coog default version : coog-2.10.2042

## [1.6.4] - 2020-09-15

### Added

- Indentation for DATABASE LANGUAGE
- celery: Add max-memory-per-child management

## [1.6.3] - 2020-08-14

### Added

- App version to coog-2.8.16
- DATABASE LANGUAGE to French for celery
- Unoconv version to tfk-coog-0.0.2
