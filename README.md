# coog-helm-charts

## Mise à jour des version des Charts

```bash
    helm3 package coog && helm3 repo index .
```

## INJECTER LES SECRETS POUR LOADER LES IMAGES DE DOCKERHUB (login/password)

```bash
    kubectl apply -f docker-client-secret.yml
```

ex de ficheirs docker-client-secret.yml

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

## INSTALLATION DE NINX INGRESS

```bash
    helm install stable/nginx-ingress
```
