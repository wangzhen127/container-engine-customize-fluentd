PROJECT=$(gcloud config get-value project)
ZONE=$(gcloud config get-value compute/zone)

gcloud container clusters create gke-audit \
    --service-account=cluster-service-account@${PROJECT}.iam.gserviceaccount.com \
    --no-enable-cloud-logging \
    --tags=gke-audit

kubectl config use-context gke_${PROJECT}_${ZONE}_gke-audit

kubectl apply -f kubernetes/fluentd-configmap-audit.yaml

kubectl apply -f kubernetes/fluentd-daemonset-audit.yaml

kubectl apply -f kubernetes/test-logger.yaml
