#!/bin/bash 

token=$(gcloud auth print-access-token)
project="bap-emea-apigee-5"
region="europe-west1"
env="default-dev"
github_secret="<your-github-repo-secret>"
apigee_deployment_sa="access-integration@bap-emea-apigee-5.iam.gserviceaccount.com"


# Kakfa Integration Connector creation is not implemented here
# See https://cloud.google.com/integration-connectors/docs/connectors/apachekafka/configure

cd integration

# Deploy Integration
integrationcli integrations apply -p $project -r $region -t $token -f . \
 --skip-connectors --userlabel "cicd" --wait=true

cd ..

# Create KVM and value to store Github secret
apigeecli kvms create --org $project --env $env -t $token --name cl-demos
apigeecli kvms entries create  --org $project --env $env -t $token -m cl-demos \
    -k github-webhook -l $github_secret

# Deploy Proxy
apigeecli  apis create bundle --org $project --env $env -t $token \
    --name cl-githubWebhook \
    --proxy-folder ./apiproxy \
    --sa $apigee_deployment_sa

