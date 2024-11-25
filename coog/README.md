# coog

![Version: 24.41.2447](https://img.shields.io/badge/Version-24.41.2447-informational?style=flat-square) ![AppVersion: coog-master](https://img.shields.io/badge/AppVersion-coog--master-informational?style=flat-square)

A Helm chart for Coog

**Homepage:** <https://github.com/coopengo/coog-helm-charts>

## Source Code

* <https://github.com/coopengo/coog-helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mongodb | 14.2.5 |
| https://charts.bitnami.com/bitnami | postgresql | 13.1.5 |
| https://charts.bitnami.com/bitnami | rabbitmq | 12.4.2 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment. It can be customized for each component |
| apiB2c | object | `{"extraEnvVar":{},"image":{"name":"coog-api-b2c"},"resources":{"limits":{"cpu":"50m","memory":"50Mi"},"requests":{"cpu":"50m","memory":"40Mi"}},"securityContext":{},"strategy":{"type":""}}` | Is enable if one off following front component is enable : - b2c - customerBackend - customerFrontend |
| apiB2c.extraEnvVar | object | `{}` | Configure environement variables for this component |
| apiB2c.image.name | string | `"coog-api-b2c"` | apiB2c image repository |
| apiB2c.resources | object | `{"limits":{"cpu":"50m","memory":"50Mi"},"requests":{"cpu":"50m","memory":"40Mi"}}` | apiB2c containers' resource requests and limits |
| apiReferential.enabled | bool | `false` | Deploy apiReferential container(s) |
| apiReferential.extraEnvVar | object | `{}` | Configure environement variables for this component |
| apiReferential.image.name | string | `"coog-api-referential"` | apiReferential image repository |
| apiReferential.resources | object | `{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}` | apiReferential containers' resource requests and limits |
| apiReferential.securityContext | object | `{}` |  |
| apiReferential.strategy.type | string | `""` |  |
| b2b.enabled | bool | `false` |  |
| b2b.image.name | string | `"coog-b2b"` | b2b image repository |
| b2b.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| b2b.ingress.defaultPaths | list | `["/portal(/|$)(.*)"]` | Default host for the ingress resource for gateway containers |
| b2b.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| b2b.ingress.nginx.whiteList.publicCidr | list | `[]` |  |
| b2b.resources | object | `{"limits":{"cpu":"250m","memory":"50Mi"},"requests":{"cpu":"125m","memory":"25Mi"}}` | b2b containers' resource requests and limits |
| b2b.securityContext | object | `{}` |  |
| b2b.strategy.type | string | `""` |  |
| b2c.enabled | bool | `false` | Deploy b2c + apiB2c container(s) |
| b2c.image.name | string | `"coog-app-b2c"` | b2c image repository |
| b2c.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| b2c.ingress.defaultPaths | list | `["/customers/myspace(/|$)(.*)"]` | Default host for the ingress resource for gateway containers |
| b2c.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| b2c.ingress.nginx.whiteList.publicCidr | list | `[]` |  |
| b2c.resources | object | `{"limits":{"cpu":"50m","memory":"50Mi"},"requests":{"cpu":"25m","memory":"25Mi"}}` | b2c containers' resource requests and limits |
| b2c.securityContext | object | `{}` |  |
| b2c.strategy.type | string | `""` |  |
| backCore | object | `{"celery":{"coogCeleryModule":"coog_async.coog_celery","extraEnvVar":{"TRYTOND_BATCH__ENABLE_CELERY_AUTO_SCALING":"1","TRYTOND_BATCH__ROOT_DIR":"/workspace/io/batch"},"resources":{"limits":{"cpu":"400m","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"500Mi"}},"workers":{"maximumMemory":512000,"number":""}},"coog":{"extraEnvVar":{},"ingress":{"annotations":{"nginx.ingress.kubernetes.io/use-proxy-protocol":true},"defaultPaths":["/"],"hosts":[],"nginx":{"whiteList":{"cors":[],"publicCidr":[]}}},"initContainers":{"resources":{"limits":{"cpu":"1500m","memory":"1750Mi"},"requests":{"cpu":"750m","memory":"875Mi"}}},"resources":{"limits":{"cpu":"1500m","memory":"1750Mi"},"requests":{"cpu":"750m","memory":"875Mi"}},"workers":{"number":""}},"cron":{"extraEnvVar":{"LOG_LEVEL":"WARNING"},"livenessProbe":{"failureThreshold":2,"initialDelaySeconds":0,"periodSeconds":120,"successThreshold":1,"timeoutSeconds":30},"resources":{"limits":{"cpu":"400m","memory":"800Mi"},"requests":{"cpu":"200m","memory":"400Mi"}},"startupProbe":{"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":30}},"extraDatabases":[],"extraEnvVar":{"COOG_IWC":"1","COOG_TIMEOUT":"3600","LOG_LEVEL":"WARNING","TRYTOND_ACCOUNT_PAYMENT_SEPA__FILESTORE":true,"TRYTOND_ACCOUNT_PAYMENT_SEPA__STORE_PREFIX":"sepa_message","TRYTOND_CACHE__CLEAN_TIMEOUT":"0","TRYTOND_CACHE__MODEL":"400","TRYTOND_CACHE__RECORD":"50000","TRYTOND_DATABASE__LANGUAGE":"fr","TRYTOND_DATABASE__PATH":"/workspace/io/edm","TRYTOND_DEBUG__VIEWS":false,"TRYTOND_EMAIL__FROM":"changeme","TRYTOND_OPTIONS__TABLE_DIMENSION":"changeme","TRYTOND_REPORT__EXPORT_ROOT_DIR":"/workspace/io/batch/report","TRYTOND_SEPA_PAYMENT__OUT_DIR":"/workspace/io/batch/sepa/sepa_out","TRYTOND_TZ":"Europe/Paris"},"image":{"name":"coog"},"initDatabase":true,"migrator":{"enabled":false,"extraEnvVar":{"TRYTOND_MIGRATION__DATABASE":"","TRYTOND_MIGRATION__SCHEMA":"","TRYTOND_MIGRATION__SSLMODE":""}},"persistentVolume":{"accessModes":["ReadWriteMany"],"customPersistentVolume":{},"customStorageClass":{},"enabled":true,"existingClaim":"","existingPersistentVolumeName":"","name":"workspace-io","size":"50Gi","storageClass":""},"securityContext":{"runAsGroup":1000,"runAsUser":1000},"static":{"image":{"name":"coog-static"},"ingress":{"defaultPaths":["/sao","/bench","/doc"],"hosts":[],"nginx":{"whiteList":{"publicCidr":[]}}},"resources":{"limits":{"cpu":"50m","memory":"80Mi"},"requests":{"cpu":"25m","memory":"40Mi"}},"securityContext":{},"strategy":{"type":""}},"strategy":{"type":""},"workers":{"number":1}}` | Configuration for coog, celery and cron |
| backCore.celery.extraEnvVar | object | `{"TRYTOND_BATCH__ENABLE_CELERY_AUTO_SCALING":"1","TRYTOND_BATCH__ROOT_DIR":"/workspace/io/batch"}` | Configure environement variables for this component |
| backCore.celery.resources | object | `{"limits":{"cpu":"400m","memory":"1000Mi"},"requests":{"cpu":"200m","memory":"500Mi"}}` | celery containers' resource requests and limits |
| backCore.celery.workers.number | string | `""` | Number of celery workers to run |
| backCore.coog.extraEnvVar | object | `{}` | Configure environement variables for this component Each value can be modified without override all or delete other parameters |
| backCore.coog.ingress.defaultPaths | list | `["/"]` | Default host for the ingress resource for coog containers' |
| backCore.coog.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     paths:       - /   - host: test2.example.com |
| backCore.coog.ingress.nginx.whiteList.cors | list | `[]` | Add cors (TRYTOND_WEB_CORS variable) to defaults values defined default values :   - https://<.Values.ingress.host> E.g. cors:   - https://test1.example.com   - https://test2.example.com |
| backCore.coog.resources | object | `{"limits":{"cpu":"1500m","memory":"1750Mi"},"requests":{"cpu":"750m","memory":"875Mi"}}` | coog containers' resource requests and limits |
| backCore.coog.workers | object | `{"number":""}` | coog, celery and batch configuration for number of workers |
| backCore.cron.extraEnvVar | object | `{"LOG_LEVEL":"WARNING"}` | Dynamic ConfigMap variables for cron |
| backCore.cron.livenessProbe | object | `{"failureThreshold":2,"initialDelaySeconds":0,"periodSeconds":120,"successThreshold":1,"timeoutSeconds":30}` | Configure options applied to cron deployment, liveness, readiness and startup probes ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes initialDelaySeconds: Initial delay seconds e periodSeconds: Period seconds timeoutSeconds: Timeout seconds failureThreshold: Failure threshold successThreshold: Success threshold  With this configuration, the kubelet will attempt to open a socket to your container on the specified port. If it can establish a connection, the container is considered healthy, if it can't it is considered a failure |
| backCore.cron.resources | object | `{"limits":{"cpu":"400m","memory":"800Mi"},"requests":{"cpu":"200m","memory":"400Mi"}}` | cron containers' resource requests and limits |
| backCore.cron.startupProbe | object | `{"failureThreshold":3,"initialDelaySeconds":30,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":30}` | additional startup time on their first initialization |
| backCore.extraDatabases | list | `[]` | append default database on TRYTOND_DATABASE_NAMES's variable |
| backCore.extraEnvVar | object | `{"COOG_IWC":"1","COOG_TIMEOUT":"3600","LOG_LEVEL":"WARNING","TRYTOND_ACCOUNT_PAYMENT_SEPA__FILESTORE":true,"TRYTOND_ACCOUNT_PAYMENT_SEPA__STORE_PREFIX":"sepa_message","TRYTOND_CACHE__CLEAN_TIMEOUT":"0","TRYTOND_CACHE__MODEL":"400","TRYTOND_CACHE__RECORD":"50000","TRYTOND_DATABASE__LANGUAGE":"fr","TRYTOND_DATABASE__PATH":"/workspace/io/edm","TRYTOND_DEBUG__VIEWS":false,"TRYTOND_EMAIL__FROM":"changeme","TRYTOND_OPTIONS__TABLE_DIMENSION":"changeme","TRYTOND_REPORT__EXPORT_ROOT_DIR":"/workspace/io/batch/report","TRYTOND_SEPA_PAYMENT__OUT_DIR":"/workspace/io/batch/sepa/sepa_out","TRYTOND_TZ":"Europe/Paris"}` | Configure environement variables for backCore components (coog, celery, cron (except static : doesn't need configuration)) Each value can be modified without override all or delete other parameters Ref: https://github.com/coopengo/coog/blob/master/bin/conf/trytond.conf ex: [web] listen = localhost:8000  convert to variable : TRYTOND_WEB__LISTEN: localhost:8000 |
| backCore.image.name | string | `"coog"` | Image repository to run coog, celery & cron |
| backCore.initDatabase | bool | `true` | Create Postgres Database for coog by default, the script create a database defined in postgresql.auth.database |
| backCore.persistentVolume.accessModes | list | `["ReadWriteMany"]` | PVC Access Mode for BackCore Requires persistentVolume.enabled: true If defined, and no customStorageClass is defined, then PVC must be created manually before volume will be bound |
| backCore.persistentVolume.customPersistentVolume | object | `{}` | Create a custom persistent volume Requires persistentVolume.enabled: true Requires persistentVolume.size: XXGi Requires persistentVolume.accessModes: ["XXXX"] capacity.storage is configured with persistentVolume.size accessModes is configured with persistentVolume.access.Modes ref: https://kubernetes.io/docs/concepts/storage/persistent-volumes/ E.g. for AWS-EFS-CSI-DRIVER volumeMode: Filesystem persistentVolumeReclaimPolicy: Retain csi:   driver: efs.csi.aws.com   volumeHandle: fs-ae66151a                # Must be the ID of the EFS volume created manually   volumeAttributes:       encryptInTransit: false              # By default, this value is true (encrypt network traffic) |
| backCore.persistentVolume.customStorageClass | object | `{}` | Create a custom storage class Requires persistentVolume.enabled: true Requires persistentVolume.storageClass: name ref: https://kubernetes.io/docs/concepts/storage/storage-classes/ E.g. for AWS-EFS-CSI-DRIVER provisioner: efs.csi.aws.com parameters:   provisioningMode: efs-ap          # Must be `efs-ap` to enable dynamic provisioning   fileSystemId: fs-12345678         # Must be the ID of the EFS volume created manually   directoryPerms: "777"             # Default permission of the root directory of the volume   gidRangeStart: "1000"             # optional - Set the range of POSIX Group IDs (GIDs) that are used to set the GID of the AWS access point. If not specified, the default range is 50000-7000000. Each provisioned volume, and thus AWS access point, is assigned a unique GID from this range.   gidRangeEnd: "2000"               # optional - Set the range of POSIX Group IDs (GIDs) that are used to set the GID of the AWS access point. If not specified, the default range is 50000-7000000. Each provisioned volume, and thus AWS access point, is assigned a unique GID from this range.   basePath: "/dynamic_provisioning" # optional - Directory on the EFS volume that is used to create dynamically provisioned volumes. In this case, a PV is provisioned as “/dynamic_provisioning/<random uuid>” on the EFS volume. Only the subdirectory is mounted to pods that use the PV. mountOptions:   - tls reclaimPolicy: Retain allowVolumeExpansion: true volumeBindingMode: Immediate |
| backCore.persistentVolume.enabled | bool | `true` | Enable BackCore data persistence using PVC |
| backCore.persistentVolume.existingClaim | string | `""` | Provide an existing `PersistentVolumeClaim` Requires persistentVolume.enabled: true If defined, PVC must be created manually before volume will be bound |
| backCore.persistentVolume.existingPersistentVolumeName | string | `""` | Link to an existing persistent volume size parameter must be equal to existing volume. E.g. backCore:   persistentVolume:     existingPersistentVolumeName: "my-existing-persistent-volume" |
| backCore.persistentVolume.size | string | `"50Gi"` | PVC Storage Request for BackCoog |
| backCore.persistentVolume.storageClass | string | `""` | Storage Class & PVC for BackCore data volume If defined, storageClassName: <storageClass> If set to "-", storageClassName: "", which disables dynamic provisioning If undefined (the default) or set to null, no storageClassName spec is set, choosing the default provisioner. |
| backCore.securityContext | object | `{"runAsGroup":1000,"runAsUser":1000}` | coog, celery and cron security Context. |
| backCore.static.image.name | string | `"coog-static"` | static image name |
| backCore.static.ingress.defaultPaths | list | `["/sao","/bench","/doc"]` | Default host for the ingress resource for static containers' |
| backCore.static.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| backCore.static.resources | object | `{"limits":{"cpu":"50m","memory":"80Mi"},"requests":{"cpu":"25m","memory":"40Mi"}}` | static containers' resource requests and limits |
| backCore.static.strategy.type | string | `""` | static redeployment strategy type |
| backCore.strategy | object | `{"type":""}` | coog, celery and cron strategy type. values: Recreate or RollingUpdate |
| backCore.workers | object | `{"number":1}` | coog, celery and cron configuration for number of workers. It can be customized for each component |
| clusterDomain | string | `"cluster.local"` |  |
| customerBackend.database | object | `{"name":""}` | Database configuration for the component |
| customerBackend.database.name | string | `""` | Default : strapi-{{ .Release.Name }} |
| customerBackend.enabled | bool | `false` | Deploy b2b container(s) |
| customerBackend.extraEnvVar | object | `{}` | Configure environement variables for this component |
| customerBackend.image.name | string | `"coog-customer-backend"` | b2b image repository |
| customerBackend.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| customerBackend.ingress.defaultPaths | list | `["/v1/customer(/|$)(.*)"]` | Default host for the ingress resource for gateway containers |
| customerBackend.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| customerBackend.ingress.nginx.whiteList.publicCidr | list | `[]` |  |
| customerBackend.initContainers.resources.limits.cpu | string | `"400m"` |  |
| customerBackend.initContainers.resources.limits.memory | string | `"500Mi"` |  |
| customerBackend.initContainers.resources.requests.cpu | string | `"200m"` |  |
| customerBackend.initContainers.resources.requests.memory | string | `"250Mi"` |  |
| customerBackend.resources | object | `{"limits":{"cpu":"400m","memory":"300Mi"},"requests":{"cpu":"200m","memory":"150Mi"}}` | b2b containers' resource requests and limits |
| customerBackend.securityContext | object | `{}` |  |
| customerBackend.strategy.type | string | `""` |  |
| customerFrontend.enabled | bool | `false` | Deploy customerFrontend container(s) |
| customerFrontend.extraEnvVar | object | `{"GATSBY_API_URL":"/v1/customer"}` | Configure environement variables for this component |
| customerFrontend.image.name | string | `"coog-customer-frontend"` | customerFrontend image repository |
| customerFrontend.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$2"` |  |
| customerFrontend.ingress.defaultPaths | list | `["/customer(/|$)(.*)"]` | Default host for the ingress resource for gateway containers |
| customerFrontend.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| customerFrontend.ingress.nginx.whiteList.publicCidr | list | `[]` |  |
| customerFrontend.initContainers.resources.limits.cpu | string | `"400m"` |  |
| customerFrontend.initContainers.resources.limits.memory | string | `"2000Mi"` |  |
| customerFrontend.initContainers.resources.requests.cpu | string | `"200m"` |  |
| customerFrontend.initContainers.resources.requests.memory | string | `"1000Mi"` |  |
| customerFrontend.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}` | customerFrontend containers' resource requests and limits |
| customerFrontend.securityContext | object | `{}` |  |
| customerFrontend.strategy.type | string | `""` |  |
| dnsConfig | object | `{}` | dnsConfig for pod assignment. It can be customized for each component |
| dnsPolicy | string | `""` | dnsPolicy for pod assignment. It can be customized for each component |
| extraEnvVar | object | `{}` | Setup variables shared to all components. |
| frontCore | object | `{"api":{"extraEnvVar":{},"image":{"name":"coog-api"},"resources":{"limits":{"cpu":"500m","memory":"100Mi"},"requests":{"cpu":"250m","memory":"50Mi"}},"securityContext":{},"strategy":{"type":""}},"apiIdentityManager":{"extraEnvVar":{},"image":{"name":"coog-api-identity-manager"},"resources":{"limits":{"cpu":"50m","memory":"70Mi"},"requests":{"cpu":"25m","memory":"35Mi"}},"securityContext":{},"strategy":{"type":""}},"enabled":false,"extraEnvVar":{},"gateway":{"extraEnvVar":{"BASE_PATH":"/gateway","COOG_GATEWAY_BASE_PATH":"/gateway","COOG_GATEWAY_PORT":8000,"COOG_MODULE":true,"COOG_TOKEN_MODULE":true,"FACEBOOK_MODULE":false,"GOOGLE_MODULE":false,"JWT_EXPIRATION":3600},"image":{"name":"coog-gateway"},"ingress":{"annotations":{"nginx.ingress.kubernetes.io/rewrite-target":"/$2"},"defaultPaths":["/gateway(/|$)(.*)"],"hosts":[],"nginx":{"whiteList":{"cors":[],"publicCidr":[]}}},"resources":{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"50m","memory":"50Mi"}},"securityContext":{},"strategy":{"type":""}}}` | FrontCore # If one frontend component is enabled: true, it will enable by default the frontCore components (gateway, api & api-identity-manager) List of front components : - gateway - api - apiIdentityManager - apiB2c - apiReferential - b2c - b2b - customerBackend - customerFrontend  If you enable one front component, you must set mongodb.isManaged: true |
| frontCore.api.extraEnvVar | object | `{}` | Configure environement variables for this component |
| frontCore.api.image.name | string | `"coog-api"` | api-v2 image repository |
| frontCore.api.resources | object | `{"limits":{"cpu":"500m","memory":"100Mi"},"requests":{"cpu":"250m","memory":"50Mi"}}` | api containers resource requests and limits |
| frontCore.apiIdentityManager.extraEnvVar | object | `{}` | Configure environement variables for this component |
| frontCore.apiIdentityManager.image.name | string | `"coog-api-identity-manager"` | api-identity-manager image repository |
| frontCore.apiIdentityManager.resources | object | `{"limits":{"cpu":"50m","memory":"70Mi"},"requests":{"cpu":"25m","memory":"35Mi"}}` | apiIdentityManager containers' resource requests and limits |
| frontCore.gateway.extraEnvVar | object | `{"BASE_PATH":"/gateway","COOG_GATEWAY_BASE_PATH":"/gateway","COOG_GATEWAY_PORT":8000,"COOG_MODULE":true,"COOG_TOKEN_MODULE":true,"FACEBOOK_MODULE":false,"GOOGLE_MODULE":false,"JWT_EXPIRATION":3600}` | Configure environement variables for this component |
| frontCore.gateway.image.name | string | `"coog-gateway"` | gateway image repository |
| frontCore.gateway.ingress.defaultPaths | list | `["/gateway(/|$)(.*)"]` | Default host for the ingress resource for gateway containers |
| frontCore.gateway.ingress.hosts | list | `[]` | additionals hosts & paths host : required path : optionnal e.g: hosts:   - host: test1.example.com     path: /   - host: test2.example.com |
| frontCore.gateway.ingress.nginx.whiteList.cors | list | `[]` | Add cors (WHITELIST variable) to defaults values defined default values :   - http://localhost:4000   - https://<.Values.ingress.host> E.g. cors:   - https://test1.example.com   - https://test2.example.com |
| frontCore.gateway.resources | object | `{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}` | gateway containers resource requests and limits |
| image.pullPolicy | string | `"Always"` | Image Pull Policy applied for all components. It can be customized for each component. e.g: coog:   image:     pullPolicy: Always |
| image.repository | string | `"cooghub"` | Tag applied for all components. It can be customized for each component. e.g: coog:   image:     repository: cooghub |
| image.tag | string | `"changeme"` | Tag applied for all components. It can be customized for each component. e.g: coog:   image:     tag: coog-master-latest |
| ingress.annotations | object | `{"nginx.ingress.kubernetes.io/client-body-buffer-size":"100m","nginx.ingress.kubernetes.io/proxy-body-size":"100m","nginx.ingress.kubernetes.io/proxy-connect-timeout":3600,"nginx.ingress.kubernetes.io/proxy-read-timeout":3600,"nginx.ingress.kubernetes.io/proxy-send-timeout":3600,"nginx.ingress.kubernetes.io/send-timeout":3600}` | Default annotations applied to all ingress. It can be customized for each component e.g: coog:   ingress:     annotations:       key: value |
| ingress.className | list | `["nginx"]` | Define ingressClassName (default: nginx) Ref : https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/ |
| ingress.host | string | `"coog.local"` | Default host for the ingress record applied for all ingress. It can be customized for each component. e.g: coog:   ingress:     hosts:       - host: coog.local         path: / |
| ingress.nginx | object | `{"whiteList":{"managementMode":"append","publicCidr":[],"trustedCidr":["127.0.0.1/32"]}}` | IP Whitelist behavior : trustedCidr : Ip list which are always allowed. maintenanceMode allow these IPs publicCidr (global + per component) : External IP to allow. We can append this list for each component. These IPs are not allowed when maintenanceMode is enable |
| ingress.nginx.whiteList.managementMode | string | `"append"` | managementMode define behavior for publicCidr parameter. It can be customized for each component e.g: coog:   ingress:     nginx:       whiteList:         managementMode: append  possible values : append or replace append: group trustedCidr + global publicCidr + component publicCidr replace: if publicCidr's component is not empty, it's replace the content of the global public Cidr |
| ingress.thisTls.configuration | list | `[]` | TLS configuration for additional hostname(s) to be covered with this ingress record ref: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls e.g: configuration: - hosts:     - coog.local   secretName: coog.local-tls  |
| ingress.thisTls.enabled | bool | `true` | Enable TLS configuration for the host defined at `ingress.host` parameter TLS certificates will be retrieved from a TLS secret with name: `{{- default (printf "%s-tls" .Values.ingress.host) .Values.ingress.thisTls.externalCertificate.name }}` You can:   - Create a secret with your own certificates.   - Rely on cert-manager to create it by setting the corresponding annotations  |
| ingress.thisTls.externalCertificate | object | `{"enabled":false,"name":""}` | Use certificates manually created in a secret. - Create a secret with your own certificates with the secret name in format `{{- default (printf "%s-tls" .Values.ingress.host) .Values.ingress.thisTls.externalCertificate.name }}`   e.g:   apiVersion: v1   kind: Secret   metadata:     name: coog.local-tls   type: kubernetes.io/tls   data:     server.crt: |          <crt contents here>     server.key: |          <private key contents here> |
| ingress.thisTls.externalCertificate.name | string | `""` | If your host is "coog.local" you have to create a secret in the same namespace called "coog.local-tls" You can customize the secret name by editing this value |
| ingress.thisTls.letsencrypt | bool | `true` |  |
| libroconv.enabled | bool | `false` | Deploy libroconv container(s) |
| libroconv.image.name | string | `"coog-libroconv"` | libroconv image repository |
| libroconv.livenessProbe.failureThreshold | int | `2` |  |
| libroconv.livenessProbe.initialDelaySeconds | int | `0` |  |
| libroconv.livenessProbe.periodSeconds | int | `60` |  |
| libroconv.livenessProbe.successThreshold | int | `1` |  |
| libroconv.livenessProbe.timeoutSeconds | int | `30` |  |
| libroconv.readinessProbe.failureThreshold | int | `3` |  |
| libroconv.readinessProbe.initialDelaySeconds | int | `0` |  |
| libroconv.readinessProbe.periodSeconds | int | `30` |  |
| libroconv.readinessProbe.successThreshold | int | `1` |  |
| libroconv.readinessProbe.timeoutSeconds | int | `30` |  |
| libroconv.resources | object | `{"limits":{"cpu":"300m","memory":"300Mi"},"requests":{"cpu":"150m","memory":"150Mi"}}` | libroconv containers' resource requests and limits |
| libroconv.securityContext | object | `{}` |  |
| libroconv.strategy.type | string | `""` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `5` |  |
| livenessProbe.periodSeconds | int | `30` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `30` |  |
| maintenanceMode | object | `{"enabled":false,"extraEnvVar":{},"image":{"name":"nginx-custom-error-pages","tag":"latest"},"ingress":{"annotations":{},"nginx":{"customhttperrors":403}},"resources":{"limits":{"cpu":"100m","memory":"100Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}}` | Create a container to receive unauthorized traffic. Allow only "TrustedCIDR" to access to the environment (for tests & confirm that everything work) Ref: https://gitlab.com/coopengo/devops/nginx-custom-error-pages |
| mongodb | object | `{"architecture":"standalone","hosts":[],"image":{"tag":"5.0.10-debian-11-r3"},"initdbScripts":{"coog_init_script.sh":"#!/bin/sh\necho \"Create data in ${MONGODB_EXTRA_DATABASES%%,*}...\"\nmongo --port ${MONGODB_PORT_NUMBER} -u ${MONGODB_ROOT_USER} -p ${MONGODB_ROOT_PASSWORD} --authenticationDatabase admin <<EOF\nuse ${MONGODB_EXTRA_DATABASES%%,*};\ndb.salesroutes.insert({});\nEOF\n"},"isManaged":false,"livenessProbe":{"periodSeconds":30,"timeoutSeconds":30},"persistence":{"accessModes":["ReadWriteOnce"],"customPersistentVolume":{},"enabled":true,"size":"5Gi","storageClass":""},"readinessProbe":{"periodSeconds":30,"timeoutSeconds":30},"replicaCount":2,"replicaSetName":"rs0","resources":{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"200Mi"}},"service":{"ports":{"mongodb":27017}},"updateStrategy":{"type":"Recreate"},"uriOptions":[],"volumePermissions":{"enabled":true,"resources":{"limits":{"cpu":"200m","memory":"400Mi"},"requests":{"cpu":"100m","memory":"200Mi"}}}}` | Mongodb dependency parameters. Ref: https://artifacthub.io/packages/helm/bitnami/mongodb/12.1.31 Current Ref is the last chart version available with mongodb 5. Mongodb is mandatory if we have front / api components enable |
| mongodb.architecture | string | `"standalone"` | Enable architecture type Should not been changed after first installation ! Possibles values: standalone / replicaset |
| mongodb.hosts | list | `[]` | Mandatory if isManaged is false and frontCore enabled else 'hosts' is automatically added Use an external mongodb server (Database not managed by this chart) if set, replace default URI default : mongodb://(.Values.mongodb.auth.usernames[0]):(.Values.mongodb.auth.passwords[0])@(.Release.Name)-mongodb:(.Values.mongodb.service.ports.mongodb)/(.Values.mongodb.auth.databases[0]) default for replicaset : mongodb://(.Values.mongodb.auth.usernames[0]):(.Values.mongodb.auth.passwords[0])@(.Release.Name)-mongodb-0.(.Release.Name)-mongodb-headless.svc.cluster.local:(.Values.mongodb.service.ports.mongodb)/(.Values.mongodb.auth.databases[0]) E.g: hosts:   - test0.com:27017   - test1.com:27017   - test2.com:27018 |
| mongodb.isManaged | bool | `false` | Enable to install mongodb on Kubernetes This is a coog parameter not mongodb |
| mongodb.persistence.customPersistentVolume | object | `{}` | Create a custom persistent volume This is a coog parameter not mongodb Requires mongodb.persistence.enabled: true Requires mongodb.persistence.size: XXGi Requires mongodb.persistence.accessModes: ["XXXX"] capacity.storage is configured with persistentVolume.size accessModes is configured with mongodb.persistence.accessModes ref: https://kubernetes.io/docs/concepts/storage/persistent-volumes/ E.g. for AWS-EFS-CSI-DRIVER volumeMode: Filesystem persistentVolumeReclaimPolicy: Retain csi:   driver: efs.csi.aws.com   volumeHandle: fs-ae66151a                # Must be the ID of the EFS volume created manually   volumeAttributes:       encryptInTransit: false              # By default, this value is true (encrypt network traffic) |
| mongodb.replicaCount | int | `2` | Define number of mongodb replicaSet to create only when `architecture=replicaset` |
| nodeSelector | object | `{}` | Node labels for pod assignment. It can be customized for each component |
| postgresql | object | `{"host":"","image":{"tag":"14.9.0-debian-11-r58"},"isManaged":true,"service":{"ports":{"postgresql":""}}}` | Default database used by backCore Ref: https://artifacthub.io/packages/helm/bitnami/postgresql/13.1.5 |
| postgresql.host | string | `""` | Mandatory if isManaged is false else 'host' is automatically added Use an external postgresql server (Database not managed by this chart) |
| quota | object | `{"enabled":false,"hard":{"limits":{"cpu":8,"memory":"6Gi"},"requests":{"cpu":6,"memory":"4Gi"}}}` | Limite total Resource usage Ref: https://kubernetes.io/docs/concepts/policy/resource-quotas/ |
| rabbitmq | object | `{"extraConfiguration":"consumer_timeout = 172800000\nloopback_users.guest = false","livenessProbe":{"initialDelaySeconds":240},"memoryHighWatermark":{"enabled":true,"type":"relative","value":0.8},"persistence":{"enabled":false},"resources":{"limits":{"cpu":"600m","memory":"400Mi"},"requests":{"cpu":"300m","memory":"200Mi"}},"service":{"port":5672},"updateStrategyType":"RollingUpdate"}` | Default message service used by backCore Ref: https://artifacthub.io/packages/helm/bitnami/rabbitmq/12.3.0 |
| readinessProbe | object | `{"failureThreshold":3,"initialDelaySeconds":5,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":30}` | Sometimes, applications are temporarily unable to serve traffic. For example, an application might need to load large data or configuration files during startup, or depend on external services after startup. In such cases, you don't want to kill the application, but you don't want to send it requests either |
| replicaCount | int | `1` | Number of pod for all components. It can be customized for each component. e.g: coog:   replicaCount: 1 |
| securityContext | object | `{"runAsUser":1000}` | Configure Container Security Context. It can be customized for each component. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod @param securityContext.runAsUser Set components containers' Security Context runAsUser |
| startupProbe | object | `{"failureThreshold":3,"initialDelaySeconds":2,"periodSeconds":30,"successThreshold":1,"timeoutSeconds":30}` | additional startup time on their first initialization |
| strategy | object | `{"type":"Recreate"}` | Strategy used to replace old pods with newest. It can be customized for each component. e.g: coog:   strategy:     type: Recreate  ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy values: Recreate or RollingUpdate Note: it's not apply on dependencies |
| tolerations | list | `[]` | Tolerations for pod assignment. It can be customized for each component |

