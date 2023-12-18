# [23.51.2351]
- Add configuration management to import data into the Coog database # PINTE-25571

# [23.48.2348-1][23.41.2348-1][23.14.2348-1][22.41.2348-1][22.14.2348-1-v2][2.14.2348-1-v2] - 2023-12-04
- Fix command issue on the initContainer for customer-backend & customer-frontend

# [23.41.2343] - 2023-10-26
- Delete the "Web" component, which is no longer supported
- Update RabbitMQ dependency to 12.3.0
- Move variables starting with `TRYTOND_BATCH_` in the celery configuration

# [22.45.2245] - 2022-11-17

## Changed

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
  - Generate some mandatory token parameters if not define in extraEnvVar
  - Add Job on chart installation to setup postgres database (can be disabled)
  - Generate MongoDB URI for standalone and replicaset modes
