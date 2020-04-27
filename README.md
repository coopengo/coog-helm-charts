# coog-helm-charts

# Mise à jour des version des Charts 
    helm3 package coog && helm3 repo index .

##INJECTER LES SECRETS POUR LOADER LES IMAGES DE DOCKERHUB (login/password)
    kubectl apply -f docker-client-secret.yml
######################################
    apiVersion: v1
    data:
      .dockerconfigjson: monsecretenbase64
    kind: Secret
    metadata:
      name: dockerhub-client
      namespace: coog-client
    type: kubernetes.io/dockerconfigjson
#####################################

##IMPORTANT 
    .dockerconfigjson = {"auths": {"docker.io": { "auth": "login:pass ==>   enbase64" }}}

# INSTALLATION DE COOG
    helm repo add coopengo https://raw.githubusercontent.com/coopengo/coog-helm-charts/master
    helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml

#INSTALLATION DE NINX INGRESS
    helm install stable/nginx-ingress
