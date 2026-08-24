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
- **`rabbitmq.auth.password` est bootstrap-only — `helm upgrade` ne rotate PAS le password** : voir la section ci-dessous.

### Rotation du password user (mode operator)

Le Topology Operator lit `spec.importCredentialsSecret` du `User` CRD **uniquement** à la création initiale, c'est-à-dire tant que `status.credentials.name` est vide. Une fois ce statut renseigné (premier reconcile), le Secret auto-généré `<user-cr>-user-credentials` devient la **source de vérité** et le Secret d'entrée que rend le chart (`<release>-rabbitmq-credentials`) n'est plus jamais relu.

Conséquence : modifier `rabbitmq.auth.password` dans les values puis `helm upgrade` met bien à jour le Secret d'entrée côté Kubernetes, mais **n'a aucun effet côté broker** ni sur le Secret de sortie consommé par les apps. Le broker continue d'accepter l'ancien password.

C'est documenté upstream et assumé par les mainteneurs :

> *« The Operator does not monitor either the provided secret object or the generated secret object, and updating either secret object won't update the credentials. As a workaround, add a label or annotation to `users.rabbitmq.com` object to trigger the Operator to reconcile. »*
> — [doc officielle « Using the Topology Operator »](https://www.rabbitmq.com/kubernetes/operator/using-topology-operator)

Voir aussi l'[issue #571](https://github.com/rabbitmq/messaging-topology-operator/issues/571) (fermée par une simple [MAJ de doc](https://github.com/rabbitmq/messaging-topology-operator/pull/589), pas de fix code).

#### Procédure officielle de rotation

1. Mettre à jour le password côté values + `helm upgrade` :
   ```bash
   helm upgrade <release> coopengo/coog \
     --namespace <ns> --reuse-values \
     --set rabbitmq.auth.password='<nouveau-password>'
   ```
   Cela met à jour le Secret d'entrée `<release>-rabbitmq-credentials` (étape nécessaire mais insuffisante seule).

2. Lancer le helper fourni par le chart :
   ```bash
   ./coog/scripts/rotate-rabbitmq-user.sh \
     --release <release> --namespace <ns>
   ```
   Le script :
   - lit le nouveau password depuis le Secret d'entrée (pas d'argument shell, pas de leak via `ps`),
   - patch le Secret de sortie `<release>-coog-rabbitmq-user-user-credentials`,
   - annote le `User` CR avec un timestamp pour déclencher un reconcile,
   - valide via `rabbitmqctl authenticate_user` côté broker,
   - liste les `Deployment`s qui consomment le Secret de sortie et qui sont à `kubectl rollout restart` manuellement.

3. Rollout des consommateurs identifiés :
   ```bash
   kubectl -n <ns> rollout restart deploy/<name>
   ```

⚠️ Pendant la fenêtre entre l'étape 2 et le rollout des consommateurs, les nouvelles connexions AMQP avec l'ancien password sont rejetées. Les connexions ouvertes restent valides (auth à la connexion). Pour une rotation sans coupure utilisateur, planifier sur une fenêtre de maintenance.

### Rollback `operator` → `legacy`

```yaml
rabbitmq:
  mode: legacy
  isManaged: true
  # retirer le bloc rabbitmq.operator
```
