# coog-helm-charts


## Prérequis :
- Créer un compte sur [DockerHub](https://hub.docker.com/) et demander des accès aux conteneurs à Coopengo
- Kubernetes en version 1.21+ (1.25 non supportée)
- Installer [helm 3](https://helm.sh/)
- Installer un Controller Ingress :
   - [Nginx Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/) (recommandé)
   - [Traefik](https://doc.traefik.io/traefik/getting-started/install-traefik/)
- Configurer des [PersistentVolumes](https://kubernetes.io/fr/docs/concepts/storage/persistent-volumes/) pour la persistence des données - Indispensable en production


## Injecter les secrets pour loader les images de dockerhub (login/password)

En ligne de commande :

```bash
kubectl create secret docker-registry docker-registry --docker-server="https://index.docker.io/v1/" --docker-username=login --docker-password=password --docker-email=email
```

Dans un fichier de configuration au format YAML (recommandé) :

1. Mettre en forme les identifiants ainsi que le json au format base64
```bash
$ echo "<login>:<password>" | base64
PGxvZ2luPjo8cGFzc3dvcmQ+Cg==

$ echo '{"auths": {"docker.io": { "auth": "PGxvZ2luPjo8cGFzc3dvcmQ+Cg==" }}}' | base64
eyJhdXRocyI6IHsiZG9ja2VyLmlvIjogeyAiYXV0aCI6ICJQR3h2WjJsdVBqbzhjR0Z6YzNkdmNt
UStDZz09IiB9fX0K # Résultat de la commande à mettre à la place de "monsecretenbase64" dans le bloc suivant.
```


2. Récupérer le résultat de la derniere ligne de commande de l'étape précente pour la mettre à la place de "monsecretenbase64"
```yaml
apiVersion: v1
data:
  .dockerconfigjson: monsecretenbase64
kind: Secret
metadata:
  name: docker-registry
  # namespace: coog-client
type: kubernetes.io/dockerconfigjson
```


3. Appliquer la configuration dans Kubernetes
```bash
kubectl apply -f docker-registry.yml
```

Vous pourrez trouver plus d'informations sur [la documentation Kubernetes](https://kubernetes.io/fr/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials).


## optionnel : Configuration specifique clients
Il faut créer un fichier client_values.yml (standard helm) si l'on souhaite apporter des configurations spécifiques liées à l'environnement.


## Installation de Coog

```bash
helm repo add coopengo https://gitlab.com/api/v4/projects/35933718/packages/helm/stable
helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml
```

## Installation de nginx ingress via helm

```bash
helm install stable/nginx-ingress
```


## Router les erreurs vers sentry

  Il faut ajouter la variable d'environnement au niveau du conteneur coog :

  TRYTOND_SENTRY_DSN : The dsn to a sentry instance that can be used to handle errors
