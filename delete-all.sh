#!/bin/bash

echo "CronJob 삭제"
kubectl delete -f cronjob.yaml --ignore-not-found

echo "CronJob용 Secret 삭제"
kubectl delete -f secret.yaml --ignore-not-found

echo "웹앱 리소스 삭제 (HPA, Service, Deployment, ConfigMap)"
kubectl delete -f newsum-ingress.yaml --ignore-not-found
kubectl delete -f newsum-service.yaml --ignore-not-found
kubectl delete -f newsum-deployment.yaml --ignore-not-found
kubectl delete -f newsum-configmap.yaml --ignore-not-found

echo "----- 모든 리소스가 성공적으로 삭제되었습니다 -----"
