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

| Composants | Coog               | Celery             | Cron               | Libroconv |
| :--------- | :----------------- | :----------------- | :----------------- | :-------- |
| Coog       |                    | :heavy_check_mark: | :heavy_check_mark: |           |
| Celery     | :heavy_check_mark: |                    | :heavy_check_mark: |           |
| Cron       | :heavy_check_mark: | :heavy_check_mark: |                    |           |
| Libroconv  | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |           |

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

## Mode RabbitMQ : `legacy` vs `operator`

Le chart supporte deux modes de déploiement RabbitMQ via le toggle `rabbitmq.mode` :

| Mode | Déploiement | Sources des resources RabbitMQ (vhost/user/permissions) |
|---|---|---|
| `legacy` (défaut) | Subchart Bitnami `rabbitmq` v12.4.2 déployé dans le namespace tenant | Externes (Terraform `cyrilgdn/rabbitmq` ou autre outillage) |
| `operator` | Aucun broker déployé par le chart — connexion à un `RabbitmqCluster` externe géré par le RabbitMQ Cluster Operator | CRDs `Vhost`, `User`, `Permission` posées par le chart, réconciliées par le Messaging Topology Operator |

Le mode `operator` cible un `RabbitmqCluster` déployé hors-bande et accessible via DNS interne `<cluster>.<namespace>.svc.cluster.local`.

### Prérequis du mode `operator`

- Un `RabbitmqCluster` opérationnel sur le cluster (Cluster Operator + Topology Operator + CRDs `rabbitmq.com` installés).
- L'annotation `rabbitmq.com/topology-allowed-namespaces` posée sur le `RabbitmqCluster` CR (pas sur le namespace) avec une valeur incluant le namespace tenant ou `*`. Le Topology Operator ne lit cette annotation que sur le CR.
- Le namespace tenant a Istio activé en mode compatible (`STRICT` ou `PERMISSIVE`) si le namespace du cluster RabbitMQ enforce mTLS — sinon l'auth AMQP côté broker rejette les pods tenant.

### Activation côté values

```yaml
rabbitmq:
  mode: operator
  isManaged: false        # OBLIGATOIRE en mode operator (désactive le subchart Bitnami)
  operator:
    cluster:
      name: rabbitmq-production       # défaut
      namespace: rabbitmq-system      # défaut
    vhost: "<nom-du-vhost>"           # nom du vhost à créer sur le cluster
    user:
      tags:
        - management
    permissions:
      configure: ".*"
      write: ".*"
      read: ".*"
  auth:
    username: "<user-tenant>"
    password: "<password-random>"
```

Le password est posé dans un Secret K8s `<release>-rabbitmq-credentials` du namespace tenant et importé par le `User` CRD via `importCredentialsSecret` — le Topology Operator l'applique au user créé sur `rabbitmq-production`.

### Cutover d'un tenant existant `legacy` → `operator`

1. **Côté values** : ajouter `mode: operator`, `isManaged: false`, et `operator.vhost: "<même-valeur-que-rabbitmq.vhost>"`.

Pendant ~10-30s entre la création des CRDs et leur réconciliation par le Topology Operator, les pods qui rolling-restart peuvent voir des `ACCESS_REFUSED` transitoires. Les clients AMQP retentent automatiquement.

### Pièges connus

- **`rabbitmq.vhost` legacy ignoré en mode operator** : le helper `coog.rabbitmq.vhost` n'utilise que `rabbitmq.operator.vhost` en mode operator. Si tu mets `rabbitmq.vhost: "foo"` mais oublies `rabbitmq.operator.vhost`, le chart utilise le défaut `/<release-name>` au lieu de `foo` — vhost créé sous un nom inattendu, queues à recréer côté apps.
- **`isManaged: true` + `mode: operator`** : combinaison invalide. Un guard fail-fast dans `_helpers.tpl` rejette le rendu — corriger en passant `isManaged: false`.
- **Annotation `topology-allowed-namespaces` mal posée** : si elle est uniquement sur le namespace `rabbitmq-system` (ancien comportement) au lieu du `RabbitmqCluster` CR, les CRDs Topology restent en `Ready: False` avec `resource is not allowed to reference defined cluster reference`.

### Rollback `operator` → `legacy`

```yaml
rabbitmq:
  mode: legacy
  isManaged: true
  # retirer le bloc rabbitmq.operator
```
