# coog

![Version: 22.41.2333](https://img.shields.io/badge/Version-22.41.2333-informational?style=flat-square) ![AppVersion: master](https://img.shields.io/badge/AppVersion-master-informational?style=flat-square)

A Helm chart for Coog

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 7.14.8 |
| https://charts.bitnami.com/bitnami | postgresql | 10.16.1 |
| https://charts.bitnami.com/bitnami | rabbitmq | 8.26.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api.affinity | object | `{}` | Affinity for pod assignment |
| api.enabled | bool | `true` | Deploy api container(s) |
| api.fullnameOverride | string | `""` |  |
| api.image.pullPolicy | string | `"Always"` | api image pull policy |
| api.image.repository | string | `"coopengohub/api"` | api image repository |
| api.image.tag | string | `"coog-2.10.2048"` | api image tag |
| api.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| api.mongodb.api_database | string | `""` | variable MONGO_IDENTITY_DB_NAME If not empty, Override default value from api.mongodb.database  |
| api.mongodb.database | string | `"coog-api-v2"` |  |
| api.nameOverride | string | `""` |  |
| api.nodeSelector | object | `{}` | Node labels for pod assignment |
| api.replicaCount | int | `1` | Number of api Pods to run |
| api.resources | object | `{"limits":{"cpu":"500m","memory":"100Mi"},"requests":{"cpu":"400m","memory":"80Mi"}}` | api containers' resource requests and limits |
| api.service.port | int | `80` |  |
| api.service.type | string | `"ClusterIP"` |  |
| api.tolerations | list | `[]` | Tolerations for pod assignment |
| api_b2b_config.affinity | object | `{}` | Affinity for pod assignment |
| api_b2b_config.enabled | bool | `false` | Deploy api_b2b_config container(s) |
| api_b2b_config.fullnameOverride | string | `""` |  |
| api_b2b_config.image.pullPolicy | string | `"Always"` | api_b2b_config image pull policy |
| api_b2b_config.image.repository | string | `"coopengohub/api-b2b-config"` | api_b2b_config image repository |
| api_b2b_config.image.tag | string | `"coog-2.10.2048"` | api_b2b_config image tag |
| api_b2b_config.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| api_b2b_config.nameOverride | string | `""` |  |
| api_b2b_config.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_b2b_config.replicaCount | int | `1` | Number of api_b2b_config Pods to run |
| api_b2b_config.resources | object | `{"limits":{"cpu":"50m","memory":"80Mi"},"requests":{"cpu":"40m","memory":"64Mi"}}` | api_b2b_config containers' resource requests and limits |
| api_b2b_config.service.port | int | `80` |  |
| api_b2b_config.service.type | string | `"ClusterIP"` |  |
| api_b2b_config.tolerations | list | `[]` | Tolerations for pod assignment |
| api_b2c.affinity | object | `{}` | Affinity for pod assignment |
| api_b2c.enabled | bool | `false` | Deploy api_b2c container(s) |
| api_b2c.fullnameOverride | string | `""` |  |
| api_b2c.image.pullPolicy | string | `"Always"` | api_b2c image pull policy |
| api_b2c.image.repository | string | `"coopengohub/api-b2c"` | api_b2c image repository |
| api_b2c.image.tag | string | `"coog-2.10.2048"` | api_b2c image tag |
| api_b2c.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| api_b2c.nameOverride | string | `""` |  |
| api_b2c.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_b2c.replicaCount | int | `1` | Number of api_b2c Pods to run |
| api_b2c.resources | object | `{"limits":{"cpu":"50m","memory":"50Mi"},"requests":{"cpu":"40m","memory":"40Mi"}}` | api_b2c containers' resource requests and limits |
| api_b2c.service.port | int | `80` |  |
| api_b2c.service.type | string | `"ClusterIP"` |  |
| api_b2c.tolerations | list | `[]` | Tolerations for pod assignment |
| api_identity_manager.affinity | object | `{}` | Affinity for pod assignment |
| api_identity_manager.enabled | bool | `true` | Deploy api_identity_manager container(s) |
| api_identity_manager.fullnameOverride | string | `""` |  |
| api_identity_manager.image.pullPolicy | string | `"Always"` | api-identity-manager image pull policy |
| api_identity_manager.image.repository | string | `"coopengohub/api-identity-manager"` | api-identity-manager image repository |
| api_identity_manager.image.tag | string | `"coog-2.10.2048"` | api-identity-manager image tag |
| api_identity_manager.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| api_identity_manager.nameOverride | string | `""` |  |
| api_identity_manager.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_identity_manager.replicaCount | int | `1` | Number of api_identity_manager Pods to run |
| api_identity_manager.resources | object | `{"limits":{"cpu":"50m","memory":"70Mi"},"requests":{"cpu":"40m","memory":"56Mi"}}` | api_identity_manager containers' resource requests and limits |
| api_identity_manager.service.port | int | `80` |  |
| api_identity_manager.service.type | string | `"ClusterIP"` |  |
| api_identity_manager.tolerations | list | `[]` | Tolerations for pod assignment |
| api_referential.affinity | object | `{}` | Affinity for pod assignment |
| api_referential.enabled | bool | `false` | Deploy api_referential container(s) |
| api_referential.fullnameOverride | string | `""` |  |
| api_referential.image.pullPolicy | string | `"Always"` | api_referential image pull policy |
| api_referential.image.repository | string | `"coopengohub/api-referential"` | api_referential image repository |
| api_referential.image.tag | string | `"coog-2.10.2048"` | api_referential image tag |
| api_referential.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| api_referential.nameOverride | string | `""` |  |
| api_referential.nodeSelector | object | `{}` | Node labels for pod assignment |
| api_referential.replicaCount | int | `1` | Number of api_referential Pods to run |
| api_referential.resources | object | `{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"160m","memory":"320Mi"}}` | api_referential containers' resource requests and limits |
| api_referential.service.port | int | `80` |  |
| api_referential.service.type | string | `"ClusterIP"` |  |
| api_referential.tolerations | list | `[]` | Tolerations for pod assignment |
| app_b2c.affinity | object | `{}` | Affinity for pod assignment |
| app_b2c.enabled | bool | `false` | Deploy app_b2c container(s) |
| app_b2c.fullnameOverride | string | `""` |  |
| app_b2c.image.pullPolicy | string | `"Always"` | app_b2c image pull policy |
| app_b2c.image.repository | string | `"coopengohub/app-b2c"` | app_b2c image repository |
| app_b2c.image.tag | string | `"coog-2.10.2048"` | app_b2c image tag |
| app_b2c.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| app_b2c.ingress.annotations | object | `{}` | Ingress annotations for app_b2c containers' |
| app_b2c.ingress.enabled | bool | `false` | Enable ingress controller resource for app_b2c containers' |
| app_b2c.ingress.hosts | list | `[{"host":"app-b2c.local","paths":[]}]` | Default host for the ingress resource for app_b2c containers' |
| app_b2c.ingress.tls | list | `[]` | TLS configuration for app_b2c containers' |
| app_b2c.nameOverride | string | `""` |  |
| app_b2c.nodeSelector | object | `{}` | Node labels for pod assignment |
| app_b2c.replicaCount | int | `1` | Number of app_b2c Pods to run |
| app_b2c.resources | object | `{"limits":{"cpu":"50m","memory":"50Mi"},"requests":{"cpu":"40m","memory":"40Mi"}}` | app_b2c containers' resource requests and limits |
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
| batch.migquottosr.resources.requests.cpu | string | `"160m"` |  |
| batch.migquottosr.resources.requests.memory | string | `"80Mi"` |  |
| batch.migquottosr.schedule | string | `"0 20 * * *"` |  |
| celery.affinity | object | `{}` | Affinity for pod assignment |
| celery.batch | object | `{"workDays":4,"workDaysConf":"french_work_days"}` | batch configuration |
| celery.batch.workDays | int | `4` | Configure batch workDays |
| celery.batch.workDaysConf | string | `"french_work_days"` | Configure batch workDaysConf |
| celery.cron.backend_configuration | bool | `true` | celery cron job containers' resource requests and limits |
| celery.cron.resources.limits.cpu | string | `"200m"` |  |
| celery.cron.resources.limits.memory | string | `"300Mi"` |  |
| celery.cron.resources.requests.cpu | string | `"160m"` |  |
| celery.cron.resources.requests.memory | string | `"240Mi"` |  |
| celery.enabled | bool | `false` | Deploy celery container(s) |
| celery.livenessProbe.initialDelaySeconds | int | `30` |  |
| celery.livenessProbe.periodSeconds | int | `120` |  |
| celery.livenessProbe.timeoutSeconds | int | `10` |  |
| celery.nodeSelector | object | `{}` | Node labels for pod assignment |
| celery.replicaCount | int | `1` | Number of celery Pods to run |
| celery.resources | object | `{"limits":{"cpu":"400m","memory":"1000Mi"},"requests":{"cpu":"320m","memory":"800Mi"}}` | celery containers' resource requests and limits |
| celery.specificBatchConcurrency.affinity | object | `{}` | Affinity for pod assignment |
| celery.specificBatchConcurrency.enabled | bool | `false` |  |
| celery.specificBatchConcurrency.livenessProbe.initialDelaySeconds | int | `30` |  |
| celery.specificBatchConcurrency.livenessProbe.periodSeconds | int | `120` |  |
| celery.specificBatchConcurrency.livenessProbe.timeoutSeconds | int | `10` |  |
| celery.specificBatchConcurrency.nodeSelector | object | `{}` | Node labels for pod assignment |
| celery.specificBatchConcurrency.resources.limits.cpu | string | `"200m"` |  |
| celery.specificBatchConcurrency.resources.limits.memory | string | `"700Mi"` |  |
| celery.specificBatchConcurrency.resources.requests.cpu | string | `"160m"` |  |
| celery.specificBatchConcurrency.resources.requests.memory | string | `"560Mi"` |  |
| celery.specificBatchConcurrency.tolerations | list | `[]` | Tolerations for pod assignment |
| celery.tolerations | list | `[]` | Tolerations for pod assignment |
| celery.workers | int | `1` | Number of celery workers to run |
| coog.affinity | object | `{}` | Affinity for pod assignment |
| coog.cache_record | int | `50000` |  |
| coog.configurationFiles."batch.conf" | string | `""` |  |
| coog.configurationFiles."coog.conf" | string | `""` |  |
| coog.enabled | bool | `true` | Deploy coog container(s) |
| coog.external_postgres.enabled | bool | `false` |  |
| coog.extraEnv.TRYTOND_TZ | string | `"Europe/Paris"` |  |
| coog.fullnameOverride | string | `""` |  |
| coog.image.pullPolicy | string | `"Always"` | coog image pull policy |
| coog.image.repository | string | `"coopengohub/coog"` | coog image repository |
| coog.image.tag | string | `"coog-2.10.2048"` | coog image tag |
| coog.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| coog.ingress.annotations | object | `{}` | Ingress annotations for coog containers' |
| coog.ingress.enabled | bool | `false` | Enable ingress controller resource for coog containers' |
| coog.ingress.hosts | list | `[{"host":"coog.local","paths":[]}]` | Default host for the ingress resource for coog containers' |
| coog.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| coog.ingress.tls | list | `[]` | TLS configuration for coog containers' |
| coog.initContainers.resources.limits.cpu | string | `"500m"` |  |
| coog.initContainers.resources.limits.memory | string | `"800Mi"` |  |
| coog.initContainers.resources.requests.cpu | string | `"400m"` |  |
| coog.initContainers.resources.requests.memory | string | `"640Mi"` |  |
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
| coog.readinessProbe.periodSeconds | int | `30` |  |
| coog.readinessProbe.timeoutSeconds | int | `30` |  |
| coog.replicaCount | int | `1` | Number of coog Pods to run |
| coog.resources | object | `{"limits":{"cpu":"1500m","memory":"1750Mi"},"requests":{"cpu":"1200m","memory":"1400Mi"}}` | coog containers' resource requests and limits |
| coog.root_dir | string | `"/workspace/io"` |  |
| coog.securityContext.runAsUser | int | `1000` |  |
| coog.service.port | int | `80` |  |
| coog.service.type | string | `"ClusterIP"` |  |
| coog.timeout | int | `3600` |  |
| coog.tolerations | list | `[]` | Tolerations for pod assignment |
| coog.workers | int | `2` | Number of coog workers to run |
| cron.affinity | object | `{}` |  |
| cron.coogCeleryModule | string | `"coog_async.coog_celery"` |  |
| cron.enabled | bool | `true` | Deploy cron container(s) |
| cron.livenessProbe.failureThreshold | int | `2` |  |
| cron.livenessProbe.initialDelaySeconds | int | `30` |  |
| cron.livenessProbe.periodSeconds | int | `120` |  |
| cron.livenessProbe.successThreshold | int | `1` |  |
| cron.livenessProbe.timeoutSeconds | int | `10` |  |
| cron.nodeSelector | object | `{}` | Node labels for pod assignment |
| cron.resources | object | `{"limits":{"cpu":"200m","memory":"500Mi"},"requests":{"cpu":"160m","memory":"400Mi"}}` | cron containers' resource requests and limits |
| cron.startupProbe.failureThreshold | int | `2` |  |
| cron.startupProbe.initialDelaySeconds | int | `30` |  |
| cron.startupProbe.periodSeconds | int | `120` |  |
| cron.startupProbe.successThreshold | int | `1` |  |
| cron.startupProbe.timeoutSeconds | int | `10` |  |
| cron.tolerations | list | `[]` | Tolerations for pod assignment |
| customer_backend.affinity | object | `{}` | Affinity for pod assignment |
| customer_backend.enabled | bool | `false` | Deploy portal container(s) |
| customer_backend.fullnameOverride | string | `""` |  |
| customer_backend.image.pullPolicy | string | `"Always"` | portal image pull policy |
| customer_backend.image.repository | string | `"coopengohub/coog-customer-backend"` | portal image repository |
| customer_backend.image.tag | string | `"coog-2.13.2137"` | portal image tag |
| customer_backend.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| customer_backend.ingress.annotations | object | `{}` | Ingress annotations for portal containers' |
| customer_backend.ingress.enabled | bool | `true` | Enable ingress controller resource for portal containers' |
| customer_backend.ingress.hosts | list | `[{"host":"v1.customer.local","paths":[]}]` | Default host for the ingress resource for portal containers' |
| customer_backend.ingress.tls | list | `[]` | TLS configuration for portal containers' |
| customer_backend.initContainers.resources.limits.cpu | string | `"400m"` |  |
| customer_backend.initContainers.resources.limits.memory | string | `"500Mi"` |  |
| customer_backend.initContainers.resources.requests.cpu | string | `"320m"` |  |
| customer_backend.initContainers.resources.requests.memory | string | `"400Mi"` |  |
| customer_backend.nameOverride | string | `""` |  |
| customer_backend.nodeSelector | object | `{}` | Node labels for pod assignment |
| customer_backend.postgres_db | string | `"strapi"` |  |
| customer_backend.replicaCount | int | `1` | Number of portal Pods to run |
| customer_backend.resources | object | `{"limits":{"cpu":"400m","memory":"300Mi"},"requests":{"cpu":"320m","memory":"240Mi"}}` | portal containers' resource requests and limits |
| customer_backend.service.port | int | `80` |  |
| customer_backend.service.type | string | `"ClusterIP"` |  |
| customer_backend.tolerations | list | `[]` | Tolerations for pod assignment |
| customer_frontend.affinity | object | `{}` | Affinity for pod assignment |
| customer_frontend.enabled | bool | `false` | Deploy portal container(s) |
| customer_frontend.fullnameOverride | string | `""` |  |
| customer_frontend.image.pullPolicy | string | `"Always"` | portal image pull policy |
| customer_frontend.image.repository | string | `"coopengohub/coog-customer-frontend"` | portal image repository |
| customer_frontend.image.tag | string | `"coog-2.13.2137"` | portal image tag |
| customer_frontend.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| customer_frontend.ingress.annotations | object | `{}` | Ingress annotations for portal containers' |
| customer_frontend.ingress.enabled | bool | `true` | Enable ingress controller resource for portal containers' |
| customer_frontend.ingress.hosts | list | `[{"host":"customer.local","paths":[]}]` | Default host for the ingress resource for portal containers' |
| customer_frontend.ingress.tls | list | `[]` | TLS configuration for portal containers' |
| customer_frontend.initContainers.resources.limits.cpu | string | `"400m"` |  |
| customer_frontend.initContainers.resources.limits.memory | string | `"2000Mi"` |  |
| customer_frontend.initContainers.resources.requests.cpu | string | `"320m"` |  |
| customer_frontend.initContainers.resources.requests.memory | string | `"1600Mi"` |  |
| customer_frontend.nameOverride | string | `""` |  |
| customer_frontend.nodeSelector | object | `{}` | Node labels for pod assignment |
| customer_frontend.replicaCount | int | `1` | Number of portal Pods to run |
| customer_frontend.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"80m","memory":"80Mi"}}` | portal containers' resource requests and limits |
| customer_frontend.service.port | int | `80` |  |
| customer_frontend.service.type | string | `"ClusterIP"` |  |
| customer_frontend.tolerations | list | `[]` | Tolerations for pod assignment |
| gateway.affinity | object | `{}` | Affinity for pod assignment |
| gateway.enabled | bool | `true` | Deploy gateway container(s) |
| gateway.entrypoint | string | `"/gateway"` |  |
| gateway.external_mongodb.enabled | bool | `false` |  |
| gateway.extraEnv.COOG_TOKEN_MODULE | string | `"false"` |  |
| gateway.fullnameOverride | string | `""` |  |
| gateway.gateway_url | string | `"coog.local"` |  |
| gateway.image.pullPolicy | string | `"Always"` | gateway image pull policy |
| gateway.image.repository | string | `"coopengohub/gateway"` | gateway image repository |
| gateway.image.tag | string | `"coog-2.10.2048"` | gateway image tag |
| gateway.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| gateway.ingress.annotations | object | `{}` | Ingress annotations for gateway containers' |
| gateway.ingress.enabled | bool | `false` | Enable ingress controller resource for gateway containers' |
| gateway.ingress.hosts | list | `[{"host":"coog.local","paths":[]}]` | Default host for the ingress resource for gateway containers' |
| gateway.ingress.nginx.rewritetarget | string | `"/$2"` |  |
| gateway.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| gateway.ingress.tls | list | `[]` | TLS configuration for gateway containers' |
| gateway.jwt.encryption | string | `"secret"` |  |
| gateway.jwt.expiration | int | `3600` |  |
| gateway.mongodb.database | string | `"coog-gateway"` |  |
| gateway.nameOverride | string | `""` |  |
| gateway.nodeSelector | object | `{}` | Node labels for pod assignment |
| gateway.portal_url | string | `"coog.local"` |  |
| gateway.replicaCount | int | `1` | Number of gateway Pods to run |
| gateway.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"80m","memory":"80Mi"}}` | gateway containers' resource requests and limits |
| gateway.service.port | int | `80` |  |
| gateway.service.type | string | `"ClusterIP"` |  |
| gateway.tolerations | list | `[]` | Tolerations for pod assignment |
| gateway.whitelist | string | `nil` |  |
| jwt.internal.encryption | string | `"changeme"` |  |
| maintenance_mode.enabled | bool | `false` |  |
| maintenance_mode.image.pullPolicy | string | `"Always"` |  |
| maintenance_mode.image.repository | string | `"cooghub/nginx-custom-error-pages"` |  |
| maintenance_mode.image.tag | string | `"latest"` |  |
| maintenance_mode.imagePullSecrets[0].name | string | `"docker-registry"` |  |
| maintenance_mode.ingress.annotations | object | `{}` |  |
| maintenance_mode.ingress.nginx.customhttperrors | string | `"403"` |  |
| maintenance_mode.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| maintenance_mode.nodeSelector | object | `{}` |  |
| maintenance_mode.resources.limits.cpu | string | `"100m"` |  |
| maintenance_mode.resources.limits.memory | string | `"100Mi"` |  |
| maintenance_mode.resources.requests.cpu | string | `"80m"` |  |
| maintenance_mode.resources.requests.memory | string | `"80Mi"` |  |
| mongodb.enabled | bool | `true` |  |
| mongodb.image.tag | string | `"4.4.12"` |  |
| mongodb.mongodbDatabase | string | `"coog-gateway"` |  |
| mongodb.replicaSet.enabled | bool | `false` |  |
| mongodb.resources.limits.cpu | string | `"100m"` |  |
| mongodb.resources.limits.memory | string | `"300Mi"` |  |
| mongodb.resources.requests.cpu | string | `"80m"` |  |
| mongodb.resources.requests.memory | string | `"240Mi"` |  |
| mongodb.strategyType | string | `"Recreate"` |  |
| mongodb.usePassword | bool | `true` |  |
| mongodb.volumePermissions.enabled | bool | `true` |  |
| mongodb.volumePermissions.resources.limits.cpu | string | `"100m"` |  |
| mongodb.volumePermissions.resources.limits.memory | string | `"300Mi"` |  |
| mongodb.volumePermissions.resources.requests.cpu | string | `"80m"` |  |
| mongodb.volumePermissions.resources.requests.memory | string | `"240Mi"` |  |
| paybox.affinity | object | `{}` | Affinity for pod assignment |
| paybox.enabled | bool | `false` | Deploy paybox container(s) |
| paybox.fullnameOverride | string | `""` |  |
| paybox.image.pullPolicy | string | `"Always"` | paybox image pull policy |
| paybox.image.repository | string | `"coopengohub/paybox"` | paybox image repository |
| paybox.image.tag | string | `"coog-2.10.2048"` | paybox image tag |
| paybox.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| paybox.ingress.annotations | object | `{}` | Ingress annotations for paybox containers' |
| paybox.ingress.enabled | bool | `false` | Enable ingress controller resource for paybox containers' |
| paybox.ingress.hosts | list | `[{"host":"paybox.local","paths":[]}]` | Default host for the ingress resource for paybox containers' |
| paybox.ingress.tls | list | `[]` | TLS configuration for paybox containers' |
| paybox.nameOverride | string | `""` |  |
| paybox.nodeSelector | object | `{}` | Node labels for pod assignment |
| paybox.replicaCount | int | `1` | Number of paybox Pods to run |
| paybox.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"80m","memory":"80Mi"}}` | paybox containers' resource requests and limits |
| paybox.service.port | int | `80` |  |
| paybox.service.type | string | `"ClusterIP"` |  |
| paybox.tolerations | list | `[]` | Tolerations for pod assignment |
| portal.affinity | object | `{}` | Affinity for pod assignment |
| portal.enabled | bool | `false` | Deploy portal container(s) |
| portal.fullnameOverride | string | `""` |  |
| portal.image.pullPolicy | string | `"Always"` | portal image pull policy |
| portal.image.repository | string | `"coopengohub/portal"` | portal image repository |
| portal.image.tag | string | `"coog-2.10.2048"` | portal image tag |
| portal.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| portal.ingress.annotations | object | `{}` | Ingress annotations for portal containers' |
| portal.ingress.enabled | bool | `false` | Enable ingress controller resource for portal containers' |
| portal.ingress.hosts | list | `[{"host":"portal.local","paths":[]}]` | Default host for the ingress resource for portal containers' |
| portal.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| portal.ingress.tls | list | `[]` | TLS configuration for portal containers' |
| portal.nameOverride | string | `""` |  |
| portal.nodeSelector | object | `{}` | Node labels for pod assignment |
| portal.replicaCount | int | `1` | Number of portal Pods to run |
| portal.resources | object | `{"limits":{"cpu":"250m","memory":"50Mi"},"requests":{"cpu":"200m","memory":"40Mi"}}` | portal containers' resource requests and limits |
| portal.service.port | int | `80` |  |
| portal.service.type | string | `"ClusterIP"` |  |
| portal.tolerations | list | `[]` | Tolerations for pod assignment |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.debug | bool | `true` |  |
| postgresql.initdbScripts."db-init.sql" | string | `"CREATE ROLE coog WITH LOGIN PASSWORD 'coog';\n"` |  |
| postgresql.persistence.enabled | bool | `false` |  |
| postgresql.postgresqlDatabase | string | `"coog"` |  |
| postgresql.updateStrategy.type | string | `"Recreate"` |  |
| quota.enabled | bool | `false` |  |
| quota.rolling_update | bool | `false` |  |
| rabbitmq.enabled | bool | `true` |  |
| rabbitmq.extraConfiguration | string | `"consumer_timeout = 172800000\nloopback_users.guest = false"` |  |
| rabbitmq.livenessProbe.initialDelaySeconds | int | `240` |  |
| rabbitmq.persistence.enabled | bool | `false` |  |
| rabbitmq.resources.limits.cpu | string | `"600m"` |  |
| rabbitmq.resources.limits.memory | string | `"400Mi"` |  |
| rabbitmq.resources.requests.cpu | string | `"480m"` |  |
| rabbitmq.resources.requests.memory | string | `"320Mi"` |  |
| rabbitmq.updateStrategyType | string | `"RollingUpdate"` |  |
| static.affinity | object | `{}` | Affinity for pod assignment |
| static.enabled | bool | `true` | Deploy static container(s) |
| static.fullnameOverride | string | `""` |  |
| static.image.pullPolicy | string | `"Always"` | static image pull policy |
| static.image.repository | string | `"coopengohub/static"` | static image repository |
| static.image.tag | string | `"coog-2.10.2048"` | static image tag |
| static.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| static.ingress.annotations | object | `{}` | Ingress annotations for static containers' |
| static.ingress.enabled | bool | `false` | Enable ingress controller resource for static containers' |
| static.ingress.hosts | list | `[{"host":"static.local","paths":[]}]` | Default host for the ingress resource for static containers' |
| static.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| static.ingress.tls | list | `[]` | TLS configuration for static containers' |
| static.nameOverride | string | `""` |  |
| static.nodeSelector | object | `{}` | Node labels for pod assignment |
| static.replicaCount | int | `1` | Number of static Pods to run |
| static.resources | object | `{"limits":{"cpu":"50m","memory":"80Mi"},"requests":{"cpu":"40m","memory":"64Mi"}}` | static containers' resource requests and limits |
| static.service.port | int | `80` |  |
| static.service.type | string | `"ClusterIP"` |  |
| static.tolerations | list | `[]` | Tolerations for pod assignment |
| unoconv.affinity | object | `{}` | Affinity for pod assignment |
| unoconv.enabled | bool | `true` | Deploy unoconv container(s) |
| unoconv.fullnameOverride | string | `""` |  |
| unoconv.image.pullPolicy | string | `"Always"` | unoconv image pull policy |
| unoconv.image.repository | string | `"coopengohub/unoconv"` | unoconv image repository |
| unoconv.image.tag | string | `"dgw-0.0.1"` | unoconv image tag |
| unoconv.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
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
| unoconv.replicaCount | int | `1` | Number of unoconv Pods to run |
| unoconv.resources | object | `{"limits":{"cpu":"300m","memory":"300Mi"},"requests":{"cpu":"240m","memory":"240Mi"}}` | unoconv containers' resource requests and limits |
| unoconv.service.port | int | `5000` |  |
| unoconv.service.type | string | `"ClusterIP"` |  |
| unoconv.tolerations | list | `[]` | Tolerations for pod assignment |
| web.affinity | object | `{}` | Affinity for pod assignment |
| web.enabled | bool | `true` | Deploy web container(s) |
| web.fullnameOverride | string | `""` |  |
| web.image.pullPolicy | string | `"Always"` | web image pull policy |
| web.image.repository | string | `"coopengohub/web"` | web image repository |
| web.image.tag | string | `"coog-2.10.2048"` | web image tag |
| web.imagePullSecrets | list | `[{"name":"docker-registry"}]` | Specify docker-registry secret names as an array |
| web.ingress.annotations | object | `{}` | Ingress annotations for web containers' |
| web.ingress.enabled | bool | `false` | Enable ingress controller resource for web containers' |
| web.ingress.hosts | list | `[{"host":"web.local","paths":[]}]` | Default host for the ingress resource for web containers' |
| web.ingress.nginx.rewritetarget | string | `"/$2"` |  |
| web.ingress.nginx.whitelistsourcerange | string | `"127.0.0.1/32"` |  |
| web.ingress.tls | list | `[]` | TLS configuration for web containers' |
| web.livenessProbe.periodSeconds | int | `60` |  |
| web.livenessProbe.timeoutSeconds | int | `30` |  |
| web.nameOverride | string | `""` |  |
| web.nodeSelector | object | `{}` | Node labels for pod assignment |
| web.replicaCount | int | `1` | Number of web Pods to run |
| web.resources | object | `{"limits":{"cpu":"500m","memory":"200Mi"},"requests":{"cpu":"400m","memory":"160Mi"}}` | web containers' resource requests and limits |
| web.service.port | int | `80` |  |
| web.service.type | string | `"ClusterIP"` |  |
| web.tolerations | list | `[]` | Tolerations for pod assignment |
