#!/bin/bash 

token=$(gcloud auth print-access-token)
project="bap-emea-apigee-5"
region="europe-west1"

integrationcli integrations scaffold -p $project -r $region  -t $token -n cl-webhoookToKafka -s 12

