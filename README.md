# coog-helm-charts

:warning: : **A new version has been introduced, starting with version 23.45.2345. This new version is incompatible with configurations of versions lower than 2345.** :warning:

## Prérequis

- Un compte sur [DockerHub](https://hub.docker.com/)
- Cluster Kubernetes en version 1.21+, et 1.34+ pour les ressources au niveau pod (activées par défaut, voir [Ressources au niveau pod](#ressources-au-niveau-pod-podlevelresources)) — sinon `podLevelResources: false`
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

## Ressources au niveau pod (`podLevelResources`)

Option **opt-out** : activée par défaut. Les `resources` de chaque composant sont posées sur le pod (`spec.template.spec.resources` du Deployment / DaemonSet), plus aucune sur ses conteneurs. Les conteneurs du pod partagent cette enveloppe.

Valeur du pod, pour chaque ressource (cpu, mémoire, requests et limits séparément) : le **max** des valeurs des conteneurs du pod.

| Composant | Valeurs prises en compte |
| :-- | :-- |
| coog | `backCore.coog.resources`, `backCore.coog.initContainers.resources` |
| celery | `backCore.celery.worker.resources` |
| customerBackend, customerFrontend | `resources`, `initContainers.resources` |
| cron | `backCore.cron.resources`, `backCore.bus.resources` (bus activé et `resources` non vide) |
| autres composants | `resources` |
| tous, si `istio.enabled` | `istio.proxy.resources` (sidecar `istio-proxy`) |

- **Prérequis** : Kubernetes 1.34+ (feature gate `PodLevelResources`, beta et activée par défaut, encore beta en 1.36), nœuds en cgroup v2.
- **Istio** : istiod injecte `istio-proxy` avec ses propres ressources (`global.proxy.resources` des values istiod), et l'API refuse un pod dont les requests sont inférieures à celles du sidecar. `istio.proxy.resources` doit donc reprendre les values istiod de la plateforme (défaut : 50m/128Mi en requests, 100m/256Mi en limits).
- Seules `cpu` et `memory` sont acceptées : toute autre ressource fait échouer le rendu.
- Une requête absente prend la valeur de la limite. Si un conteneur n'a pas de limite pour une ressource, le pod n'en a pas non plus.
- Les sous-charts Bitnami (postgresql, rabbitmq, mongodb) ne changent pas : ressources au niveau conteneur.

### Passage d'un tenant

Les pods sont recréés. Un pod à plusieurs conteneurs reçoit le max de leurs valeurs, partagé par tous : pour celery, `max(worker, sidecar)` pour les trois conteneurs (le conteneur de maintenance n'a pas de valeur propre). Vérifier que les valeurs celery des tenants couvrent ce partage avant le passage.

### Revenir aux ressources par conteneur

```yaml
podLevelResources: false
```

Le rendu est alors identique à celui des versions précédentes du chart.

## Bus Tryton (`backCore.bus`)

Option **opt-in**, désactivée par défaut. Le bus Tryton pousse les notifications vers Sao (long polling). Il tourne dans un conteneur `bus` (`ep bus`) du pod cron et n'est joignable que par la gateway, sous `/gateway/coog/<db>/bus` : c'est le seul chemin sous lequel le navigateur envoie le cookie de session, que la gateway réécrit en `Path=/gateway/coog/<db>`.

```text
Sao servie par la gateway (/gateway/sao/)
       │ POST /gateway/coog/<db>/bus + cookie
       ▼
┌─────────────┐  TLS      ┌───────────────────┐  /gateway/  ┌───────────────┐
│ NLB AWS     ├──────────►│ ingressgateway    ├────────────►│ gateway       │
│ TCP, 350 s  │           │ Istio             │             │ /coog/:db/bus │
└─────────────┘           └───────────────────┘             └───────┬───────┘
       ┌──────────── COOG_BUS_URL = http://<short>-bus ─────────────┘
       ▼
┌─────────────┐  port 80  ┌───────────────────┐
│ Service     ├──────────►│ pod cron : bus    │
│ <short>-bus │           │ ep bus, port 8001 │
└─────────────┘           └─────────┬─────────┘
       ┌─ LISTEN sur le canal bus ──┘
       ▼
PostgreSQL du tenant (NOTIFY : coog, celery, cron)
```

Si le bus ne répond pas (redéploiement, panne), Sao réessaie seule avec un délai croissant, jusqu'à 10 min entre deux essais.

```yaml
backCore:
  bus:
    enabled: true
    longPollingTimeout: 50            # secondes, défaut
    resources: {}                     # défaut : partage l'enveloppe du pod cron
secrets:
  jwt_encryption: "<clé>"             # obligatoire : le bus active la gateway
```

| Objet | Ce que l'option rend |
| :-- | :-- |
| pod cron | conteneur `coog-cron-bus` : `ep bus`, `TRYTOND_WEB__LISTEN=0.0.0.0:8001`, `TRYTOND_WEB__CORS=http://<short>-bus` (l'origine vers laquelle la gateway réécrit l'en-tête `Origin`, comme pour coog), `TRYTOND_BUS__ALLOW_SUBSCRIBE=1`, `TRYTOND_BUS__LONG_POLLING_TIMEOUT`, `TRYTOND_DATABASE_NAMES` vide (pas de préchargement du pool : `ep bus` délie les modules coog), sondes `tcpSocket` |
| Service `<short>-bus` | ClusterIP, port 80 vers le port `bus` des pods cron |
| configmap coog | `TRYTOND_BUS__ALLOW_SUBSCRIBE=1`, `TRYTOND_BUS__URL_HOST=https://<hôte>/gateway/coog/` |
| configmap gateway | `COOG_BUS_URL=http://<short>-bus` |
| gateway | déployée même sans portail : deployment, service, configmaps et secrets qu'elle lit, route `/gateway/` du VirtualService |

- **Prérequis** : coog ≥ 26.28 (le login annonce l'URL du bus et Sao la suit), une gateway (coog-portal-api) qui a la route `/coog/:db/bus`, `secrets.jwt_encryption`, et Sao ouverte par la gateway (`/gateway/sao/`).
- **Sao servie par coog (`/`)** : non supportée. `TRYTOND_BUS__URL_HOST` n'est posé que sur coog, qui refuse donc lui-même les appels au bus (401) : aucun long polling n'occupe un worker coog. Il n'est jamais posé sur le bus, qui répondrait alors 401 à tout.
- **Attente** : 50 s par défaut, loin sous le premier délai qui coupe sur le chemin, l'inactivité TCP du NLB AWS (350 s). Envoy n'a pas de délai d'inactivité et la route `/gateway/` suit `istio.gateway.routing.timeout`. Attention : un `istio.gateway.routing.retry.perTryTimeout` inférieur à l'attente coupe chaque requête du bus, puis la rejoue.
- **Ressources** : sans `resources` propres, le bus partage l'enveloppe du pod cron (`backCore.cron.resources`) et la limite mémoire avec le cron, qui charge tout le pool. Mesurer la RAM du bus (`kubectl top pod --containers`) avant de relever `backCore.cron.resources` ou de donner des `resources` au bus.
- **Plusieurs pods cron** : chaque bus reçoit toutes les notifications de la base (LISTEN/NOTIFY), aucune affinité n'est nécessaire.

### Mise en service

1. Déployer une gateway qui a la route du bus, puis le chart avec `backCore.bus.enabled: true`.
2. Ouvrir Sao par `https://<hôte>/gateway/sao/` : un `POST /gateway/coog/<db>/bus` reste en attente, puis répond 200 au bout de `longPollingTimeout`.
3. Lancer l'action « Message global » : la notification arrive dans les sessions ouvertes.
4. Logs du conteneur `coog-cron-bus` : dans `get bus messages … from <user>@<adresse>`, l'adresse est celle du poste client (`TRYTOND_WEB__NUM_PROXIES=1`).

### Retour arrière

```yaml
backCore:
  bus:
    enabled: false
```

Le conteneur, le Service et les variables de coog et de la gateway disparaissent. La gateway n'est retirée que si aucun portail ne l'utilise.

## Gateway en edge (`frontCore.gateway.edge`)

Option **opt-in**, désactivée par défaut, Istio et `portalV2` uniquement. La gateway devient le point d'entrée par défaut du tenant : le VirtualService lui envoie `/`, sans réécriture, à la place de coog. Elle sert Sao à `/`, son portail API sous `COOG_GATEWAY_BASE_PATH` (`/gateway`), et relaie le reste vers coog (RPC de Sao, callbacks, `/doc`). Les routes des portails b2c, b2b, customer-backend et customer-frontend, et les redirections `/sao` et `/gateway`, ne changent pas.

```text
NLB AWS
         │ TLS terminé par Istio
         ▼
┌────────────────┐                   ┌───────────────────┐                   ┌──────┐
│ ingressgateway │  /                │ gateway           │  RPC, callbacks,  │ coog │
│ Istio          ├──────────────────►│ Sao à /           ├──────────────────►│      │
│                │  sans réécriture  │ API sous /gateway │  /doc, /liveness  │      │
└────────────────┘                   └───────────────────┘                   └──────┘
```

L'ingressgateway garde ses routes directes vers les portails b2c, b2b et customer-*, et ses redirections `/sao` et `/gateway`.

```yaml
portalV2: true
istio:
  enabled: true
frontCore:
  gateway:
    edge: true
```

| Objet | Ce que l'option change |
| :-- | :-- |
| VirtualService | route `gateway-edge` : `/` vers `<short>-gateway`, sans réécriture, à la place de la route `coog`. Retirées : la route `/gateway/`, la redirection `/doc` vers `/doc/`, les callbacks `/docusign`, `/cryptolog`, `/paybox` et la route `/doc`, que la gateway relaie. Gardées : les portails, les redirections `/sao`, `/sao/` et `/gateway` |
| configmap gateway | `ROOT_PATH_GATEWAY` = `COOG_GATEWAY_BASE_PATH` sans `/` final. Une valeur posée dans `frontCore.gateway.extraEnvVar.ROOT_PATH_GATEWAY` l'emporte |
| AuthorizationPolicy gateway | deux règles DENY par chemin : `COOG_GATEWAY_BASE_PATH` et ce qu'il contient gardent la liste blanche de la gateway (`frontCore.gateway.istio.whiteList.publicCidr`), le reste prend celle de coog (`backCore.coog.istio.whiteList.publicCidr`) |

- **Prérequis** : `istio.enabled`, `portalV2: true`, une gateway activée (frontCore, un portail ou le bus) et un `COOG_GATEWAY_BASE_PATH` autre que `/`, sinon le rendu échoue. Une image `coog-portal-gateway` qui lit `ROOT_PATH_GATEWAY` (version minimale à préciser, PINTE-30243).
- **Inchangés** : `BASE_PATH`, `COOG_GATEWAY_BASE_PATH`, `COOG_GATEWAY_URL`, et l'URL du bus annoncée par coog (`https://<hôte>/gateway/coog/`).
- **AuthorizationPolicy de coog** : inchangée. Derrière la gateway, le filtrage par IP client se fait sur la gateway.
- **Sonde `httpProbe`** : `https://<hôte>/liveness` traverse la gateway, puis coog.

### Mise en service

1. Déployer une gateway qui lit `ROOT_PATH_GATEWAY`, puis le chart avec `frontCore.gateway.edge: true`.
2. Ouvrir Sao par `https://<hôte>/` : connexion, appels RPC et bus fonctionnent.
3. `https://<hôte>/gateway/` sert le portail API, `/gateway` répond 301, `/sao` répond 307.

### Retour arrière

```yaml
frontCore:
  gateway:
    edge: false
```

Le VirtualService, la configmap et l'AuthorizationPolicy de la gateway reviennent à leur rendu précédent.

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
    queueLimit:                       # défaut : actif, 100 000 messages par file
      enabled: true
      maxLength: 100000
  auth:
    username: "<user-tenant>"
    password: "<password-random>"
```

### Plafond de messages par file (`rabbitmq.operator.queueLimit`)

Le chart pose une `Policy` `queue-limit` sur le vhost du tenant : chaque file garde au plus `maxLength` messages prêts (`max-length`), et au-delà le broker refuse les nouveaux messages de ce vhost seulement (`overflow: reject-publish`). Coog passe alors les publications refusées en `enqueue_failed` et les republie plus tard (cron `resend_failed_tasks_to_enqueue`), au lieu qu'une file qui s'emballe remplisse la mémoire du broker partagé jusqu'à son alarme, qui bloque les publications de tous les tenants (PINTE-30188).

- Choisir `maxLength` au-dessus du plus gros run légitime du tenant : un run publie un message par job, dans la file de son batch.
- Une seule `Policy` s'applique à une file (la plus prioritaire) : une autre `Policy` posée sur le vhost avec une priorité supérieure à 0 remplacerait ce plafond.
- **Mise en service** : actif par défaut en mode operator : à la mise à jour du chart, chaque tenant reçoit la `Policy`. Avant, vérifier qu'aucune file légitime n'approche `maxLength` (pic des 30 derniers jours par file : `max_over_time(max by (vhost, queue) (rabbitmq_detailed_queue_messages_ready{...})[30d:5m])`), et ajuster `maxLength` dans les values d'un tenant dont un run légitime dépasse le plafond. Vérifier ensuite que la `Policy` est `Ready` (`kubectl -n <tenant> get policies.rabbitmq.com`) et posée sur le broker (`rabbitmqctl list_policies -p <vhost>`).
- **Retour arrière** : `enabled: false` puis `helm upgrade` : la `Policy` est supprimée et le Topology Operator retire la policy du broker. Les messages déjà en file ne sont pas touchés.

Le password est posé dans un Secret K8s `<release>-rabbitmq-credentials` du namespace tenant et importé par le `User` CRD via `importCredentialsSecret` — le Topology Operator l'applique au user créé sur `rabbitmq-production`.

### Cutover d'un tenant existant `legacy` → `operator`

1. **Côté values** : ajouter `mode: operator`, `isManaged: false`, et `operator.vhost: "<même-valeur-que-rabbitmq.vhost>"`.

Pendant ~10-30s entre la création des CRDs et leur réconciliation par le Topology Operator, les pods qui rolling-restart peuvent voir des `ACCESS_REFUSED` transitoires. Les clients AMQP retentent automatiquement.

### Pièges connus

- **`rabbitmq.vhost` legacy ignoré en mode operator** : le helper `coog.rabbitmq.vhost` n'utilise que `rabbitmq.operator.vhost` en mode operator. Si tu mets `rabbitmq.vhost: "foo"` mais oublies `rabbitmq.operator.vhost`, le chart utilise le défaut `/<release-name>` au lieu de `foo` — vhost créé sous un nom inattendu, queues à recréer côté apps.
- **`isManaged: true` + `mode: operator`** : combinaison invalide. Un guard fail-fast dans `_helpers.tpl` rejette le rendu — corriger en passant `isManaged: false`.
- **Annotation `topology-allowed-namespaces` mal posée** : si elle est uniquement sur le namespace `rabbitmq-system` (ancien comportement) au lieu du `RabbitmqCluster` CR, les CRDs Topology restent en `Ready: False` avec `resource is not allowed to reference defined cluster reference`.
- **`rabbitmq.auth.password` est bootstrap-only avec un Topology Operator < 1.20 — `helm upgrade` ne rotate PAS le password** : voir la section ci-dessous (à partir de 1.20, `helm upgrade` suffit).

### Rotation du password user (mode operator)

#### Topology Operator ≥ 1.20 : `helm upgrade` suffit

Le Secret d'entrée `<release>-rabbitmq-credentials` porte le label `rabbitmq.com/topology-operator: "true"`, que l'opérateur ≥ 1.20 exige sur tout Secret référencé (sans lui, le webhook refuse le `User`). L'opérateur surveille ces Secrets et applique lui-même un changement de `password` côté broker, sans annotation ni script :

```bash
helm upgrade <release> coopengo/coog \
  --namespace <ns> --reuse-values \
  --set rabbitmq.auth.password='<nouveau-password>'
```

Les Deployments coog, celery et cron redémarrent d'eux-mêmes (annotation `checksum/secret-backcore`) avec la nouvelle URL AMQP. Pendant les quelques secondes où l'opérateur applique le password, une connexion peut être refusée : les clients Celery retentent.

Prérequis : le label doit être posé (cette version du chart redéployée) **avant** que le chart `saas` n'installe le Topology Operator 1.20 sur l'env (voir le README de `saas-plateform`).

#### Topology Operator < 1.20 (procédure historique)

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
