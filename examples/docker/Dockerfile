FROM continuumio/miniconda:4.5.4
#python:3.7-slim-buster
# continuumio/miniconda3

RUN pip install mlflow>=1.0 \
    && pip install azure-storage-blob==12.3.0 \
    && pip install numpy==1.14.3 \
    && pip install scipy \
    && pip install pandas==0.22.0 \
    && pip install scikit-learn==0.19.1 \
    && pip install cloudpickle
RUN apt-get update && apt-get install g++ -y --fix-missing 
RUN pip install urlparse4




# required for minio
RUN pip install boto3
RUN pip install urllib3==1.22