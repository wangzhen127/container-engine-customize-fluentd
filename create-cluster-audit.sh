gcloud container clusters create gke-audit \
    --service-account=cluster-service-account@$(gcloud config get-value project).iam.gserviceaccount.com \
    --no-enable-cloud-logging \
    --scopes=logging-write,monitoring \
    --tags=gke-cluster-with-customized-fluentd

kubectl apply -f kubernetes/fluentd-configmap-audit.yaml

kubectl apply -f kubernetes/fluentd-daemonset-audit.yaml
