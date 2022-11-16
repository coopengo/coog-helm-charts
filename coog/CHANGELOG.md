## [22.36.2236] - 2022-09-09

### Changed

- Rework chart:
  - Add dependencies between components
  - Ingress Configuration has been done for nginx reverse proxy
  - Update default variables values
  - Add global configuration for:
    - replicaCount
    - strategy.type
    - securityContext.runAsUser
    - image.repository
    - image.tag
    - image.pullPolicy
    - ingress.host
    - ingress.thisTls.enabled
    - ingress.thisTls.letsencrypt
    - ingress.thisTls.configuration
    - ingress.annotations
    - ingress.nginx.whiteList.trustedCidr
    - ingress.nginx.whiteList.publicCidr
    - startupProbe
    - livenessProbe
    - readinessProbe
    - nodeSelector
    - tolerations
    - affinity
    - dnsPolicy
    - dnsConfig
  - maintenanceMode behavior is correctly integrated with the whitelist IP management
  - Move environment variables in configmap and secret (reduce complexity for new variables)
  - Reduce the number of duplicated variable setup in different dependencies
  - Documentation of External dependencies (postgres, rabbitmq & mongodb) used to setup variables and avoid duplicated configuration
  - Flower has been removed
  - Api-b2b-config has been removed
  - Paybox has been removed
  - Fix issue with the image registry credentials
  - Add annotations to update pods when secrets / configmaps are updated
  - Add initContainer on celery and cron to wait coog container
