#!/bin/sh

# dependencies
sudo apt install python3-pip
pip install mlflow 
pip install kubernetes 

#install gcloud §from https://cloud.google.com/storage/docs/gsutil_install
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
gcloud init

#add named gke_hv-gcp-trycatalog_us-central1-c_magikarp-cluster [MAGIKARP] context 
gcloud container clusters get-credentials \
magikarp-cluster \
--zone us-central1-c \
--project hv-gcp-trycatalog

# build base image
docker build -t     us.gcr.io/hv-gcp-trycatalog/mlaas/AutoDEPPA2/AutoDEPPA2-base -f Dockerfile .

# push to google registry
docker push         us.gcr.io/hv-gcp-trycatalog/mlaas/AutoDEPPA2/AutoDEPPA2-base

# build & push mlflow project image
# create & run job
mlflow run .        --backend kubernetes --backend-config kubernetes_config.json -P alpha=0.5
