# coog-helm-charts

:warning: : **A new version has been introduced, starting with version 23.45.2345. This new version is incompatible with configurations of versions lower than 2345.** :warning:

## Prérequis

- Un compte sur [DockerHub](https://hub.docker.com/)
- Cluster Kubernetes en version 1.21+
- Installer [helm 3.10+](https://helm.sh/)
- Installer [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)
- Configurer des [volumes persistants](https://kubernetes.io/fr/docs/concepts/storage/persistent-volumes/) pour la persistence des données - Indispensable en production

## Dépendances

### Backend

PostgreSQL est installé par defaut pour cette partie

| Composants | Coog               | Celery             | Cron               | Static             | Libroconv |
| :--------- | :----------------- | :----------------- | :----------------- | :----------------- | :-------- |
| Coog       |                    | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |           |
| Celery     | :heavy_check_mark: |                    | :heavy_check_mark: | :heavy_check_mark: |           |
| Cron       | :heavy_check_mark: | :heavy_check_mark: |                    | :heavy_check_mark: |           |
| Static     | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |                    |           |
| Libroconv  | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |           |

### Frontend - B2B

La valeur `mongodb.isManaged` doit être à `true` pour installer MongoDB par le chart, laisser à `false` si vous avez un serveur MongoDB externe.

| Composants           | API                | API-identity-manager | Gateway            | API-referential    | B2B | Web |
| :------------------- | :----------------- | :------------------- | :----------------- | :----------------- | :-- | :-- |
| API                  |                    | :heavy_check_mark:   | :heavy_check_mark: |                    |     |     |
| API-identity-manager | :heavy_check_mark: |                      | :heavy_check_mark: |                    |     |     |
| Gateway              | :heavy_check_mark: | :heavy_check_mark:   |                    |                    |     |     |
| API-referential      | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |                    |     |     |
| B2B                  | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |                    |     |     |
| Web                  | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: | :heavy_check_mark: |     |     |

### Frontend- B2C

La valeur `mongodb.isManaged` doit être à true pour installer MongoDB par le chart, laisser à false si vous avez un serveur MongoDB externe.

| Composants           | API                | API-identity-manager | Gateway            | API-B2C | Customer-backend   | Customer-frontend  | B2C |
| :------------------- | :----------------- | :------------------- | :----------------- | :------ | :----------------- | :----------------- | :-- |
| API                  |                    | :heavy_check_mark:   | :heavy_check_mark: |         |                    |                    |     |
| API-identity-manager | :heavy_check_mark: |                      | :heavy_check_mark: |         |                    |                    |     |
| Gateway              | :heavy_check_mark: | :heavy_check_mark:   |                    |         |                    |                    |     |
| API-B2C              | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |         | :heavy_check_mark: | :heavy_check_mark: |     |
| Customer-backend     | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |         |                    | :heavy_check_mark: |     |
| Customer-frontend    | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |         |                    |                    |     |
| B2C                  | :heavy_check_mark: | :heavy_check_mark:   | :heavy_check_mark: |         |                    |                    |     |

## Configurer l'accès à la registry (DockerHub, GitLab Package Registry, etc...)

Dans votre fichier de configuration des valeurs (exemple : client_values.yml) :

```yaml
imageCredentials:
  registry: docker.io
  username: user-1234
  password: password-1234
  email: my-email@my-company.com
```

## Installer Coog

```bash
helm repo add coopengo https://gitlab.com/api/v4/projects/35933718/packages/helm/stable
helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml
```

## Configurer des volumes persistants

Dans votre fichier de configuration des valeurs (exemple : client_values.yml) :

### Exemple AWS avec des EFS

Les EFS doivent être crée manuellement à l'avance.

Volume principal pour coog:

```yaml
backCore:
  persistentVolume:
    enabled: true
    storageClass: "efs-sc"
    size: 10Gi
    customPersistentVolume:
      mountOptions:
        - "tls"
      persistentVolumeReclaimPolicy: "Retain"
      csi:
        driver: "efs.csi.aws.com"
        volumeHandle: "fs-123456789"
```

Si composants Front activés :

```yaml
mongodb:
  persistence:
    storageClass: "efs-sc"
    size: 10Gi
    customPersistentVolume:
      mountOptions:
        - "tls"
      persistentVolumeReclaimPolicy: "Retain"
      csi:
        driver: "efs.csi.aws.com"
        volumeHandle: "fs-987654321"
```
