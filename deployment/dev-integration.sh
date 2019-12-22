#!/bin/bash

PROJECT_PATH=~/Dropbox/FRI/2_stopnja/1_letnik/1_semester/rso/projekt
SERVICE_NAME=$1

if [ ! -d "$PROJECT_PATH/$SERVICE_NAME" ]
then
    echo "The service does not exist."
    exit 1
fi

cd "$PROJECT_PATH/$SERVICE_NAME"

mvn clean package -U
docker rmi "grmek/$SERVICE_NAME:1.0.0-SNAPSHOT-DEV"
docker build -t "grmek/$SERVICE_NAME:1.0.0-SNAPSHOT-DEV" .
docker push "grmek/$SERVICE_NAME:1.0.0-SNAPSHOT-DEV"
kubectl scale deployment "$SERVICE_NAME-deployment" --replicas=0
kubectl apply -f "../general/deployment/kubernetes/$SERVICE_NAME.yaml"

exit 0
