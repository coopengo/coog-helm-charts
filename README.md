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
echo '{"auths": {"docker.io": { "auth": "login:pass ==>   enbase64" }}}'|base64
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
helm3 package coog flower && helm3 repo index .
```


## Initialisation de la base de donnée 
```yaml
command: ['sh', '-c', 'ep admin -d {{ .Values.coog.postgres.database }} -u ir res']
```