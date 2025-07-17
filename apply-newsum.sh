#!/bin/bash

echo "웹앱 ConfigMap 생성"
kubectl apply -f newsum-configmap.yaml

echo "웹앱 Deployment, Service + Ingress 생성"
kubectl apply -f newsum-deployment.yaml
kubectl apply -f newsum-service.yaml
kubectl apply -f newsum-ingress.yaml

echo "----- 모든 리소스가 성공적으로 적용되었습니다 -----"
