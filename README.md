# coog-helm-charts


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






# INSTALLATION
helm repo add coopengo https://raw.githubusercontent.com/coopengo/coog-helm-charts/master/index.yaml

helm upgrade -i coog coopengo/coog --namespace=coog-client -f client_values.yml


