#!/bin/sh
sudo apt install python3-pip
pip3 install mlflow #kinda self-nexplanatory
pip3 install kubernetes #mlflow run --backend kubernetes requirement
docker run -p 5000:5000 registry & #can be replaced with gcloud registry
git clone https://github.com/NunoMaga/mlflow #personal fork

docker build -t localhost:5000/docker-example-base -f Dockerfile . #base image dependency build, we need to update the image to have our conda env
docker push localhost:5000/docker-example-base #push to localhost. very much unnecessary
#mlflow run . -P alpha=0.5  //docker run example
mlflow run . --backend kubernetes --backend-config kubernetes_config.json -P alpha=0.5
