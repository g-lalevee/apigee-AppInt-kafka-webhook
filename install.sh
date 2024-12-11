#!/bin/bash 

token=$(gcloud auth print-access-token)
project="bap-emea-apigee-5"
region="europe-west1"
env="default-dev"

cd integration

integrationcli integrations apply -p $project -r $region -t $token -f . \
 --skip-connectors --userlabel "cicd" --wait=true

cd ..

apigeecli  apis create bundle --org $project --env $env -t $token \
    --name cl-githubWebhook \
    --proxy-folder ./apiproxy \
    --sa access-integration@bap-emea-apigee-5.iam.gserviceaccount.com

