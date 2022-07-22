# flower

![Version: 2.12.2229](https://img.shields.io/badge/Version-2.12.2229-informational?style=flat-square) ![AppVersion: 0.9.5](https://img.shields.io/badge/AppVersion-0.9.5-informational?style=flat-square)

Flower Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| args | list | `[]` |  |
| celeryBrokerUrl | string | `"redis://redis:6379/1"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"mher/flower"` |  |
| image.tag | string | `"0.9.5"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `true` |  |
| ingress.hosts[0].host | string | `"flower.local"` |  |
| ingress.hosts[0].paths[0] | string | `"/flower"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.privileged | bool | `false` |  |
| securityContext.procMount | string | `"Default"` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.externalPort | int | `5555` |  |
| service.internalPort | int | `5555` |  |
| service.port | int | `5555` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `nil` |  |
| tolerations | list | `[]` |  |
| urlPrefix | string | `"flower"` |  |

