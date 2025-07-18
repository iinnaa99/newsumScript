#!/bin/bash

# 설정
NAMESPACE="default"
CRONJOB_NAME="newsum-data"
CHECK_INTERVAL=60  # 초 단위 (60초마다 체크)

echo "[INFO] Fargate CronJob 상태 모니터링 시작 (${CRONJOB_NAME})..."

while true; do
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 상태 점검 중..."

  # 가장 최근 생성된 Job 이름 가져오기
  LATEST_JOB=$(kubectl get jobs -n $NAMESPACE -o jsonpath="{.items[?(@.metadata.ownerReferences[0].name=='$CRONJOB_NAME')].metadata.name}" | tr " " "\n" | tail -n 1)

  if [ -z "$LATEST_JOB" ]; then
    echo "[WARN] 아직 Job이 생성되지 않았습니다."
  else
    # 해당 Job에서 생성된 Pod 이름
    POD_NAME=$(kubectl get pods -n $NAMESPACE -l job-name=$LATEST_JOB -o jsonpath="{.items[0].metadata.name}")

    if [ -z "$POD_NAME" ]; then
      echo "[WARN] Job은 생성되었지만 아직 Pod이 없습니다."
    else
      STATUS=$(kubectl get pod $POD_NAME -n $NAMESPACE -o jsonpath="{.status.phase}")
      echo "[INFO] 현재 Pod 상태: $POD_NAME → $STATUS"

      if [[ "$STATUS" == "Failed" || "$STATUS" == "Pending" ]]; then
        echo "[ALERT] 🚨 이상 상태 감지됨: $STATUS (Pod: $POD_NAME)"
        # 여기에 Slack 또는 Email 알림 연동 가능
      fi
    fi
  fi

  echo "------------------------------------------------------------"
  sleep $CHECK_INTERVAL
done

