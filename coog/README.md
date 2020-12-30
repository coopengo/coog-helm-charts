# coog

![Version: 2.3.2](https://img.shields.io/badge/Version-2.3.2-informational?style=flat-square) ![AppVersion: coog-2.10.2048](https://img.shields.io/badge/AppVersion-coog--2.10.2048-informational?style=flat-square)

A Helm chart for Coog

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 7.14.1 |
| https://charts.bitnami.com/bitnami | postgresql | 8.9.6 |
| https://charts.bitnami.com/bitnami | rabbitmq | 7.6.8 |
| https://kubernetes-charts.storage.googleapis.com/ | redis | 10.5.0 |
| https://raw.githubusercontent.com/coopengo/coog-helm-charts/master | flower | 0.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.affinity | object | `{}` | Affinity for pod assignment |
| api.enabled | bool | `true` | Deploy api container(s) |
| api.fullnameOverride | string | `""` |  |
| api.image.pullPolicy | string | `"Always"` |  |
| api.image.repository | string | `"coopengohub/api"` |  |
| api.image.tag | string | `"coog-2.10.2048"` |  |
| api.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| api.mongodb.database | string | `"coog-api-v2"` |  |
| api.nameOverride | string | `""` |  |
| api.nodeSelector | object | `{}` | Node labels for pod assignment |
| api.replicaCount | int | `1` |  |
| api.resources | object | `{"limits":{"cpu":"700m","memory":"300Mi"},"requests":{"cpu":"200m","memory":"150Mi"}}` | api containers' resource requests and limits |
| api.service.port | int | `80` |  |
| api.service.type | string | `"ClusterIP"` |  |
| api.tolerations | list | `[]` | Tolerations for pod assignment |
| api_b2b_config.affinity | object | `{}` | Affinity for pod assignment |
| api_b2b_config.enabled | bool | `false` | Deploy api_b2b_config container(s) |
| api_b2b_config.fullnameOverride | string | `""` |  |
| api_b2b_config.image.pullPolicy | string | `"Always"` |  |
| api_b2b_config.image.repository | string | `"coopengohub/api-b2b-config"` |  |
| api_b2b_config.image.tag | string | `"coog-2.10.2048"` |  |
| api_b2b_config.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| api_b2b_config.nameOverride | string | `""` |  |
| api_b2b_config.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_b2b_config.replicaCount | int | `1` |  |
| api_b2b_config.resources | object | `{"limits":{"cpu":"200m","memory":"250Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}` | api_b2b_config containers' resource requests and limits |
| api_b2b_config.service.port | int | `80` |  |
| api_b2b_config.service.type | string | `"ClusterIP"` |  |
| api_b2b_config.tolerations | list | `[]` | Tolerations for pod assignment |
| api_b2c.affinity | object | `{}` | Affinity for pod assignment |
| api_b2c.enabled | bool | `false` | Deploy api_b2c container(s) |
| api_b2c.fullnameOverride | string | `""` |  |
| api_b2c.image.pullPolicy | string | `"Always"` |  |
| api_b2c.image.repository | string | `"coopengohub/api-b2c"` |  |
| api_b2c.image.tag | string | `"coog-2.10.2048"` |  |
| api_b2c.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| api_b2c.nameOverride | string | `""` |  |
| api_b2c.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_b2c.replicaCount | int | `1` |  |
| api_b2c.resources | object | `{"limits":{"cpu":"200m","memory":"250Mi"},"requests":{"cpu":"100m","memory":"250Mi"}}` | api_b2c containers' resource requests and limits |
| api_b2c.service.port | int | `80` |  |
| api_b2c.service.type | string | `"ClusterIP"` |  |
| api_b2c.tolerations | list | `[]` | Tolerations for pod assignment |
| api_identity_manager.affinity | object | `{}` | Affinity for pod assignment |
| api_identity_manager.enabled | bool | `true` | Deploy api_identity_manager container(s) |
| api_identity_manager.fullnameOverride | string | `""` |  |
| api_identity_manager.image.pullPolicy | string | `"Always"` |  |
| api_identity_manager.image.repository | string | `"coopengohub/api-identity-manager"` |  |
| api_identity_manager.image.tag | string | `"coog-2.10.2048"` |  |
| api_identity_manager.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| api_identity_manager.nameOverride | string | `""` |  |
| api_identity_manager.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_identity_manager.replicaCount | int | `1` |  |
| api_identity_manager.resources | object | `{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"250Mi"}}` | api_identity_manager containers' resource requests and limits |
| api_identity_manager.service.port | int | `80` |  |
| api_identity_manager.service.type | string | `"ClusterIP"` |  |
| api_identity_manager.tolerations | list | `[]` | Tolerations for pod assignment |
| api_referential.affinity | object | `{}` | Affinity for pod assignment |
| api_referential.enabled | bool | `false` | Deploy api_referential container(s) |
| api_referential.fullnameOverride | string | `""` |  |
| api_referential.image.pullPolicy | string | `"Always"` |  |
| api_referential.image.repository | string | `"coopengohub/api-referential"` |  |
| api_referential.image.tag | string | `"coog-2.10.2048"` |  |
| api_referential.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| api_referential.nameOverride | string | `""` |  |
| api_referential.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_referential.replicaCount | int | `1` |  |
| api_referential.resources | object | `{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"250Mi"}}` | api_referential containers' resource requests and limits |
| api_referential.service.port | int | `80` |  |
| api_referential.service.type | string | `"ClusterIP"` |  |
| api_referential.tolerations | list | `[]` | Tolerations for pod assignment |
| app_b2c.affinity | object | `{}` | Affinity for pod assignment |
| app_b2c.enabled | bool | `false` | Deploy app_b2c container(s) |
| app_b2c.fullnameOverride | string | `""` |  |
| app_b2c.image.pullPolicy | string | `"Always"` |  |
| app_b2c.image.repository | string | `"coopengohub/app-b2c"` |  |
| app_b2c.image.tag | string | `"coog-2.10.2048"` |  |
| app_b2c.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| app_b2c.ingress.annotations | object | `{}` | Ingress annotations for app_b2c containers' |
| app_b2c.ingress.enabled | bool | `false` | Enable ingress controller resource for app_b2c containers' |
| app_b2c.ingress.hosts[0].host | string | `"app-b2c.local"` |  |
| app_b2c.ingress.hosts[0].paths | list | `[]` |  |
| app_b2c.ingress.tls | list | `[]` | TLS configuration for app_b2c containers' |
| app_b2c.nameOverride | string | `""` |  |
| app_b2c.nodeSelector | object | `{}` | Node labels for pod assignment |
| app_b2c.replicaCount | int | `1` |  |
| app_b2c.resources | object | `{"limits":{"cpu":"200m","memory":"250Mi"},"requests":{"cpu":"100m","memory":"75Mi"}}` | app_b2c containers' resource requests and limits |
| app_b2c.service.port | int | `80` |  |
| app_b2c.service.type | string | `"ClusterIP"` |  |
| app_b2c.tolerations | list | `[]` | Tolerations for pod assignment |
| batch.migquottosr.enabled | bool | `false` |  |
| batch.migquottosr.image.pullPolicy | string | `"Always"` |  |
| batch.migquottosr.image.repository | string | `"coopengohub/migquottosr"` |  |
| batch.migquottosr.image.tags | string | `"latest"` |  |
| batch.migquottosr.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| batch.migquottosr.resources.limits.cpu | string | `"200m"` |  |
| batch.migquottosr.resources.limits.memory | string | `"100Mi"` |  |
| batch.migquottosr.resources.requests.cpu | string | `"100m"` |  |
| batch.migquottosr.resources.requests.memory | string | `"50Mi"` |  |
| batch.migquottosr.schedule | string | `"0 20 * * *"` |  |
| celery.affinity | object | `{}` | Affinity for pod assignment |
| celery.cron.resources | object | `{"limits":{"cpu":"200m","memory":"300Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | celery cron job containers' resource requests and limits |
| celery.enabled | bool | `false` | Deploy celery container(s) |
| celery.livenessProbe.initialDelaySeconds | int | `30` |  |
| celery.livenessProbe.periodSeconds | int | `120` |  |
| celery.livenessProbe.timeoutSeconds | int | `10` |  |
| celery.nodeSelector | object | `{}` | Node labels for pod assignment |
| celery.replicaCount | int | `1` |  |
| celery.resources | object | `{"limits":{"cpu":1,"memory":"1000Mi"},"requests":{"cpu":"400m","memory":"300Mi"}}` | celery containers' resource requests and limits |
| celery.specificBatchConcurrency.enabled | bool | `false` |  |
| celery.tolerations | list | `[]` | Tolerations for pod assignment |
| celery.workers | int | `1` |  |
| coog.affinity | object | `{}` | Affinity for pod assignment |
| coog.cache_record | int | `50000` |  |
| coog.configurationFiles."batch.conf" | string | `""` |  |
| coog.configurationFiles."coog.conf" | string | `""` |  |
| coog.enabled | bool | `true` | Deploy coog container(s) |
| coog.external_postgres.enabled | bool | `false` |  |
| coog.fullnameOverride | string | `""` |  |
| coog.image.pullPolicy | string | `"Always"` |  |
| coog.image.repository | string | `"coopengohub/coog"` |  |
| coog.image.tag | string | `"coog-2.10.2048"` |  |
| coog.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| coog.ingress.annotations | object | `{}` | Ingress annotations for coog containers' |
| coog.ingress.enabled | bool | `false` | Enable ingress controller resource for coog containers' |
| coog.ingress.hosts[0].host | string | `"coog.local"` |  |
| coog.ingress.hosts[0].paths | list | `[]` |  |
| coog.ingress.tls | list | `[]` | TLS configuration for coog containers' |
| coog.livenessProbe.periodSeconds | int | `60` |  |
| coog.livenessProbe.timeoutSeconds | int | `30` |  |
| coog.log_level | string | `"INFO"` |  |
| coog.max_worker_memory | int | `0` |  |
| coog.nameOverride | string | `""` |  |
| coog.nodeSelector | object | `{}` | Node labels for pod assignment |
| coog.persistentVolume.claim.name | string | `""` |  |
| coog.persistentVolume.enabled | bool | `true` |  |
| coog.persistentVolume.io | string | `"/workspace/io/"` |  |
| coog.persistentVolume.name | string | `"workspace-io"` |  |
| coog.persistentVolume.size | string | `"10Gi"` |  |
| coog.persistentVolume.storageClass | string | `"nfs-client"` |  |
| coog.postgres.database | string | `"coog"` |  |
| coog.postgres.password | string | `"coog"` |  |
| coog.postgres.user | string | `"coog"` |  |
| coog.readinessProbe.periodSeconds | int | `30` |  |
| coog.readinessProbe.timeoutSeconds | int | `30` |  |
| coog.replicaCount | int | `1` |  |
| coog.resources | object | `{"limits":{"cpu":"700m","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"700Mi"}}` | coog containers' resource requests and limits |
| coog.root_dir | string | `"/workspace/io"` |  |
| coog.securityContext.runAsUser | int | `1000` |  |
| coog.service.port | int | `80` |  |
| coog.service.type | string | `"ClusterIP"` |  |
| coog.timeout | int | `3600` |  |
| coog.tolerations | list | `[]` | Tolerations for pod assignment |
| coog.workers | int | `4` |  |
| cron.affinity | object | `{}` |  |
| cron.coogCeleryModule | string | `"coog_async.coog_celery"` |  |
| cron.enabled | bool | `false` | Deploy cron container(s) |
| cron.livenessProbe.initialDelaySeconds | int | `30` |  |
| cron.livenessProbe.periodSeconds | int | `120` |  |
| cron.livenessProbe.timeoutSeconds | int | `10` |  |
| cron.nodeSelector | object | `{}` | Node labels for pod assignment |
| cron.resources | object | `{"limits":{"cpu":1,"memory":"1000Mi"},"requests":{"cpu":"400m","memory":"300Mi"}}` | cron containers' resource requests and limits |
| cron.tolerations | list | `[]` | Tolerations for pod assignment |
| externalRedis.host | string | `"localhost"` |  |
| externalRedis.port | int | `6379` |  |
| flower.enabled | bool | `false` |  |
| gateway.affinity | object | `{}` | Affinity for pod assignment |
| gateway.coog_web_token | string | `"changeme"` |  |
| gateway.enabled | bool | `true` | Deploy gateway container(s) |
| gateway.entrypoint | string | `"/gateway"` |  |
| gateway.external_mongodb.enabled | bool | `false` |  |
| gateway.extraEnv.COOG_TOKEN_MODULE | string | `"false"` |  |
| gateway.fullnameOverride | string | `""` |  |
| gateway.gateway_url | string | `"coog.local"` |  |
| gateway.image.pullPolicy | string | `"Always"` |  |
| gateway.image.repository | string | `"coopengohub/gateway"` |  |
| gateway.image.tag | string | `"coog-2.10.2048"` |  |
| gateway.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| gateway.ingress.annotations | object | `{}` | Ingress annotations for gateway containers' |
| gateway.ingress.enabled | bool | `false` | Enable ingress controller resource for gateway containers' |
| gateway.ingress.hosts[0].host | string | `"coog.local"` |  |
| gateway.ingress.hosts[0].paths | list | `[]` |  |
| gateway.ingress.tls | list | `[]` | TLS configuration for gateway containers' |
| gateway.jwt.encryption | string | `"secret"` |  |
| gateway.jwt.expiration | int | `3600` |  |
| gateway.mongodb.database | string | `"coog-gateway"` |  |
| gateway.mongodb_root_password | string | `"admin"` |  |
| gateway.mongodb_user | string | `"root"` |  |
| gateway.nameOverride | string | `""` |  |
| gateway.nodeSelector | object | `{}` | Node labels for pod assignment |
| gateway.portal_url | string | `"coog.local"` |  |
| gateway.replicaCount | int | `1` |  |
| gateway.resources | object | `{"limits":{"cpu":"500m","memory":"600Mi"},"requests":{"cpu":"100m","memory":"300Mi"}}` | gateway containers' resource requests and limits |
| gateway.service.port | int | `80` |  |
| gateway.service.type | string | `"ClusterIP"` |  |
| gateway.tolerations | list | `[]` | Tolerations for pod assignment |
| gateway.whitelist | string | `nil` |  |
| jwt.internal.encryption | string | `"changeme"` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.image.tag | string | `"4.0.10-debian-9-r39"` |  |
| mongodb.mongodbDatabase | string | `"coog-gateway"` |  |
| mongodb.mongodbPassword | string | `"admin"` |  |
| mongodb.mongodbRootPassword | string | `"admin"` |  |
| mongodb.mongodbUsername | string | `"root"` |  |
| mongodb.replicaSet.enabled | bool | `false` |  |
| mongodb.resources.limits.cpu | string | `"500m"` |  |
| mongodb.resources.limits.memory | string | `"500Mi"` |  |
| mongodb.resources.requests.cpu | string | `"200m"` |  |
| mongodb.resources.requests.memory | string | `"250Mi"` |  |
| mongodb.usePassword | bool | `true` |  |
| paybox.affinity | object | `{}` | Affinity for pod assignment |
| paybox.enabled | bool | `false` | Deploy paybox container(s) |
| paybox.fullnameOverride | string | `""` |  |
| paybox.image.pullPolicy | string | `"Always"` |  |
| paybox.image.repository | string | `"coopengohub/paybox"` |  |
| paybox.image.tag | string | `"coog-2.10.2048"` |  |
| paybox.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| paybox.ingress.annotations | object | `{}` | Ingress annotations for paybox containers' |
| paybox.ingress.enabled | bool | `false` | Enable ingress controller resource for paybox containers' |
| paybox.ingress.hosts[0].host | string | `"paybox.local"` |  |
| paybox.ingress.hosts[0].paths | list | `[]` |  |
| paybox.ingress.tls | list | `[]` | TLS configuration for paybox containers' |
| paybox.nameOverride | string | `""` |  |
| paybox.nodeSelector | object | `{}` | Node labels for pod assignment |
| paybox.replicaCount | int | `1` |  |
| paybox.resources | object | `{"limits":{"cpu":"300m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | paybox containers' resource requests and limits |
| paybox.service.port | int | `80` |  |
| paybox.service.type | string | `"ClusterIP"` |  |
| paybox.tolerations | list | `[]` | Tolerations for pod assignment |
| portal.affinity | object | `{}` | Affinity for pod assignment |
| portal.enabled | bool | `false` | Deploy portal container(s) |
| portal.fullnameOverride | string | `""` |  |
| portal.image.pullPolicy | string | `"Always"` |  |
| portal.image.repository | string | `"coopengohub/portal"` |  |
| portal.image.tag | string | `"coog-2.10.2048"` |  |
| portal.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| portal.ingress.annotations | object | `{}` | Ingress annotations for portal containers' |
| portal.ingress.enabled | bool | `false` | Enable ingress controller resource for portal containers' |
| portal.ingress.hosts[0].host | string | `"portal.local"` |  |
| portal.ingress.hosts[0].paths | list | `[]` |  |
| portal.ingress.tls | list | `[]` | TLS configuration for portal containers' |
| portal.nameOverride | string | `""` |  |
| portal.nodeSelector | object | `{}` | Node labels for pod assignment |
| portal.replicaCount | int | `1` |  |
| portal.resources | object | `{"limits":{"cpu":"200m","memory":"150Mi"},"requests":{"cpu":"100m","memory":"100Mi"}}` | portal containers' resource requests and limits |
| portal.service.port | int | `80` |  |
| portal.service.type | string | `"ClusterIP"` |  |
| portal.tolerations | list | `[]` | Tolerations for pod assignment |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.debug | bool | `true` |  |
| postgresql.initdbPassword | string | `"coog"` |  |
| postgresql.initdbScripts."db-init.sql" | string | `"CREATE ROLE coog WITH LOGIN PASSWORD 'coog';\n"` |  |
| postgresql.initdbUsername | string | `"coog"` |  |
| postgresql.persistence.enabled | bool | `false` |  |
| postgresql.postgresqlDatabase | string | `"coog"` |  |
| postgresql.postgresqlPassword | string | `"coog"` |  |
| rabbitmq.enabled | bool | `true` |  |
| redis.cluster.enabled | bool | `false` |  |
| redis.enabled | bool | `true` |  |
| redis.master.disableCommands | list | `[]` |  |
| redis.master.persistence.enabled | bool | `false` |  |
| redis.master.resources.limits.cpu | string | `"200m"` |  |
| redis.master.resources.limits.memory | string | `"250Mi"` |  |
| redis.master.resources.requests.cpu | string | `"100m"` |  |
| redis.master.resources.requests.memory | string | `"150Mi"` |  |
| redis.metrics.enabled | bool | `false` |  |
| redis.metrics.prometheusRule.enabled | bool | `false` |  |
| redis.podSecurityPolicy.create | bool | `false` |  |
| redis.port | int | `27017` |  |
| redis.rbac.create | bool | `true` |  |
| redis.usePassword | bool | `false` |  |
| static.affinity | object | `{}` | Affinity for pod assignment |
| static.enabled | bool | `true` | Deploy static container(s) |
| static.fullnameOverride | string | `""` |  |
| static.image.pullPolicy | string | `"Always"` |  |
| static.image.repository | string | `"coopengohub/static"` |  |
| static.image.tag | string | `"coog-2.10.2048"` |  |
| static.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| static.ingress.annotations | object | `{}` | Ingress annotations for static containers' |
| static.ingress.enabled | bool | `false` | Enable ingress controller resource for static containers' |
| static.ingress.hosts[0].host | string | `"static.local"` |  |
| static.ingress.hosts[0].paths | list | `[]` |  |
| static.ingress.tls | list | `[]` | TLS configuration for static containers' |
| static.nameOverride | string | `""` |  |
| static.nodeSelector | object | `{}` | Node labels for pod assignment |
| static.replicaCount | int | `1` |  |
| static.resources | object | `{"limits":{"cpu":"200m","memory":"100Mi"},"requests":{"cpu":"100m","memory":"50Mi"}}` | static containers' resource requests and limits |
| static.service.port | int | `80` |  |
| static.service.type | string | `"ClusterIP"` |  |
| static.tolerations | list | `[]` | Tolerations for pod assignment |
| unoconv.affinity | object | `{}` | Affinity for pod assignment |
| unoconv.enabled | bool | `true` | Deploy unoconv container(s) |
| unoconv.fullnameOverride | string | `""` |  |
| unoconv.image.pullPolicy | string | `"Always"` |  |
| unoconv.image.repository | string | `"coopengohub/unoconv"` |  |
| unoconv.image.tag | string | `"dgw-0.0.1"` |  |
| unoconv.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| unoconv.livenessProbe.failureThreshold | int | `1` |  |
| unoconv.livenessProbe.initialDelaySeconds | int | `0` |  |
| unoconv.livenessProbe.periodSeconds | int | `60` |  |
| unoconv.livenessProbe.successThreshold | int | `1` |  |
| unoconv.livenessProbe.timeoutSeconds | int | `30` |  |
| unoconv.nameOverride | string | `""` |  |
| unoconv.nodeSelector | object | `{}` | Node labels for pod assignment |
| unoconv.readinessProbe.failureThreshold | int | `3` |  |
| unoconv.readinessProbe.initialDelaySeconds | int | `0` |  |
| unoconv.readinessProbe.periodSeconds | int | `30` |  |
| unoconv.readinessProbe.successThreshold | int | `1` |  |
| unoconv.readinessProbe.timeoutSeconds | int | `30` |  |
| unoconv.replicaCount | int | `1` |  |
| unoconv.resources | object | `{"limits":{"cpu":"300m","memory":"500Mi"},"requests":{"cpu":"100m","memory":"350Mi"}}` | unoconv containers' resource requests and limits |
| unoconv.service.port | int | `5000` |  |
| unoconv.service.type | string | `"ClusterIP"` |  |
| unoconv.tolerations | list | `[]` | Tolerations for pod assignment |
| web.affinity | object | `{}` | Affinity for pod assignment |
| web.enabled | bool | `true` | Deploy web container(s) |
| web.fullnameOverride | string | `""` |  |
| web.image.pullPolicy | string | `"Always"` |  |
| web.image.repository | string | `"coopengohub/web"` |  |
| web.image.tag | string | `"coog-2.10.2048"` |  |
| web.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| web.ingress.annotations | object | `{}` | Ingress annotations for web containers' |
| web.ingress.enabled | bool | `false` | Enable ingress controller resource for web containers' |
| web.ingress.hosts[0].host | string | `"web.local"` |  |
| web.ingress.hosts[0].paths | list | `[]` |  |
| web.ingress.tls | list | `[]` | TLS configuration for web containers' |
| web.livenessProbe.periodSeconds | int | `60` |  |
| web.livenessProbe.timeoutSeconds | int | `30` |  |
| web.nameOverride | string | `""` |  |
| web.nodeSelector | object | `{}` | Node labels for pod assignment |
| web.replicaCount | int | `1` |  |
| web.resources | object | `{"limits":{"cpu":"300m","memory":"512Mi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | web containers' resource requests and limits |
| web.service.port | int | `80` |  |
| web.service.type | string | `"ClusterIP"` |  |
| web.tolerations | list | `[]` | Tolerations for pod assignment |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.4.0](https://github.com/norwoodj/helm-docs/releases/v1.4.0)
