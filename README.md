# coog-helm-charts


## Prérequis :
- Créer un compte sur https://hub.docker.com/ et demander des accès aux conteneurs à Coopengo
- Kubernetes en version 1.15
- Installer helm 2 : voir sur https://helm.sh/
- Installer un Controller Ingress :
   - Nginx Ingress Controller est conseillé : https://kubernetes.github.io/ingress-nginx/deploy/
- Configurer des PersistentVolumes pour la persistence des données (indispensable en production)
   - https://kubernetes.io/fr/docs/concepts/storage/persistent-volumes/

## INJECTER LES SECRETS POUR LOADER LES IMAGES DE DOCKERHUB (login/password)

```bash
kubectl create secret docker-registry docker-registry --docker-server="https://index.docker.io/v1/" --docker-username=login --docker-password=password --docker-email=email
```
ou

```bash
kubectl apply -f docker-registry.yml
```

Exemple de fichiers docker-registry.yml

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

La valeur de monsecretenbase64 doit correspondre au résultat de la commande.

A consulter : https://kubernetes.io/fr/docs/tasks/configure-pod-container/pull-image-private-registry/#registry-secret-existing-credentials

```bash
echo '{"auths": {"docker.io": { "auth": "login:pass ==> base64" }}}'|base64
```

## OPTIONNEL : CONFIGURATION SPECIFIQUE CLIENTS
Il faut créer un fichier client_values.yml (standard helm) si l'on souhaite apporter des configurations spécifiques liées à l'environnement.

## INSTALLATION DE COOG

```bash
helm repo add coopengo https://raw.githubusercontent.com/coopengo/coog-helm-charts/master
helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml
```

## INSTALLATION DE NGINX INGRESS VIA HELM

```bash
helm install stable/nginx-ingress
```

## Mise à jour des version des Charts

```bash
helm3 repo update
helm3 package flower && helm3 repo index .
# git add . && git commit -m 'Flower packaging' && git push
helm3 repo update
helm3 dependency update coog
helm3 package coog && helm3 repo index .
# git add . && git commit -m 'Coog packaging' && git push 
```


## Initialisation de la base de donnée 
```yaml
command: ['sh', '-c', 'ep admin -d {{ .Values.coog.postgres.database }} -u ir res']
```

## Sécurité

Sur Nginx, penser à configurer ```server_tokens off``` pour cacher les informations serveurs.

## Router les erreurs vers sentry

  Il faut ajouter la variable d'environnement au niveau du conteneur coog :

  TRYTOND_SENTRY_DSN : The dsn to a sentry instance that can be used to handle errors
