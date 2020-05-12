# coog-helm-charts


## Prérequis :
- Kubernetes en version 1.15
- Installer helm 2 : voir sur https://helm.sh/
- Installer un Controller Ingress :
   - Nginx Ingress Controller est conseillé : https://kubernetes.github.io/ingress-nginx/deploy/
- Configurer des PersistentVolumes pour la persistence des données (indispensable en production)
   - https://kubernetes.io/fr/docs/concepts/storage/persistent-volumes/

## Mise à jour des version des Charts

```bash
    helm3 package coog && helm3 repo index .
```

## INJECTER LES SECRETS POUR LOADER LES IMAGES DE DOCKERHUB (login/password)

```bash
    kubectl apply -f docker-client-secret.yml
```

Exemple de fichiers docker-client-secret.yml

```yaml
    apiVersion: v1
    data:
      .dockerconfigjson: monsecretenbase64
    kind: Secret
    metadata:
      name: dockerhub-client
      namespace: coog-client
    type: kubernetes.io/dockerconfigjson
```

La valeur de monsecretenbase64 doit correspondre au résultat de la commande

```bash
    echo '{"auths": {"docker.io": { "auth": "login:pass ==>   enbase64" }}}'|base64
```

## INSTALLATION DE COOG

```bash
    helm repo add coopengo https://raw.githubusercontent.com/coopengo/coog-helm-charts/master
    helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml
```

## INSTALLATION DE NGINX INGRESS VIA HELM

```bash
    helm install stable/nginx-ingress
```
