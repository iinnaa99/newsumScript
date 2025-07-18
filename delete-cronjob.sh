#!/bin/bash

echo "CronJob 삭제"
kubectl delete -f cronjob-data.yaml --ignore-not-found

echo "CronJob용 Secret 삭제"
kubectl delete -f cronjob-secret.yaml --ignore-not-found

echo "----- 모든 리소스가 성공적으로 삭제되었습니다 -----"
