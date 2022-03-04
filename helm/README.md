## Prerequisites
  - Helm installed on your machine
  - Helm repo add:
    - bitnami -> https://charts.bitnami.com/bitnami 
    - ingress-nginx -> https://kubernetes.github.io/ingress-nginx
    - elastic --> 	https://helm.elastic.co 
    - fluent --> https://fluent.github.io/helm-charts

## Deployment
Once the terraform and kubespray finish making the cluster we can start deploy our application in the following order. 

Deploying the monitoring (Elastic, Kibana, fluentd):
  > cd ./logging && kubectl create -f persistent-volume.yaml \
  > helm install elasticsearch elastic/elasticsearch -f values-elasticsearch.yaml \
  > helm install kibana elastic/kibana \
  > helm install fluent fluent/fluentd

Deploying the application:
  > cd ../custom && helm install app .

Deploying Ingress:
  > cd ../ingress && kubectl create ns ingress-nginx \
  > helm install myingress ingress-nginx/ingress-nginx -n ingress-nginx --values deploy.yaml

Create TLS for Ingress:
  > openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=${YOUR_DOMAIN_NAME}" \
  > kubectl create secret tls ${YOUR_SECRET_NAME_MUST_MATCH_WITH_INGRESS} --cert=./tls.crt --key=./tls.key 
