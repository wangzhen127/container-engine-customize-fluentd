PROJECT=$(gcloud config get-value project)
ZONE=$(gcloud config get-value compute/zone)

gcloud container clusters create gke-no-audit \
    --service-account=cluster-service-account@${PROJECT}.iam.gserviceaccount.com \
    --no-enable-cloud-logging \
    --tags=gke-no-audit

kubectl config use-context gke_${PROJECT}_${ZONE}_gke-no-audit

kubectl apply -f kubernetes/fluentd-configmap.yaml

kubectl apply -f kubernetes/fluentd-daemonset.yaml

kubectl apply -f kubernetes/test-logger.yaml
