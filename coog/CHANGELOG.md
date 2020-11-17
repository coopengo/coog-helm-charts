# Changelog

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
