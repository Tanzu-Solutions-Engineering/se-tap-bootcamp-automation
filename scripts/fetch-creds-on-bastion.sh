#!/usr/bin/env bash

set -e

az login --identity

#pull down kubeconfig into home dir
kv=$(az keyvault list | jq -r '.[0].name')
az keyvault secret show --name base64-kubeconfig --vault-name $kv | jq -r .value | base64 -d -w 0 > /home/ubuntu/aks-kubeconfig.yml
chown ubuntu:ubuntu /home/ubuntu/aks-kubeconfig.yml
chown 600 /home/ubuntu/aks-kubeconfig.yml
mkdir -p /home/ubuntu/.kube
chown -R ubuntu:ubuntu /home/ubuntu/.kube/
cp /home/ubuntu/aks-kubeconfig.yml /home/ubuntu/.kube/config
chown 600 /home/ubuntu/.kube/config

#pull down acr creds
az keyvault secret show --name acr-user --vault-name $kv | jq -r .value  > /home/ubuntu/acr-user
az keyvault secret show --name acr-password --vault-name $kv | jq -r .value  > /home/ubuntu/acr-password
chown ubuntu:ubuntu /home/ubuntu/acr-user
chown ubuntu:ubuntu /home/ubuntu/acr-password