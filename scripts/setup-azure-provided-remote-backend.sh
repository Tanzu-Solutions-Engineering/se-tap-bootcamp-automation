#!/usr/bin/env bash

# USAGE:
# export AZURE_RESOURCE_GROUP=<name_for_resource_group>
# export AZURE_REGION=<region_name>
# export AZURE_STORAGE_ACCOUNT_NAME=<storage_account_name>
# export AZURE_STORAGE_CONTAINER_NAME=<storage_container_name>
#
# scripts/setup-azure-provided-remote-backend.sh

set -e

if [ -z "$AZURE_RESOURCE_GROUP" ] || [ -z "$AZURE_REGION" ] || [ -z "$AZURE_STORAGE_ACCOUNT_NAME" ] || [ -z "$AZURE_STORAGE_CONTAINER_NAME" ]; then
    echo -e "One or more variables are not defined. required environment variables are:\nAZURE_RESOURCE_GROUP\nAZURE_REGION\nAZURE_STORAGE_ACCOUNT_NAME\nAZURE_STORAGE_CONTAINER_NAME"
    exit 1

fi

echo "------------"
echo "Creating Azure resource group for Terraform state management"
# Create Resource Group for TF backend
az group create -n $AZURE_RESOURCE_GROUP -l $AZURE_REGION


echo "------------"
echo "Creating Azure storage account"
# Create Storage Account
az storage account create -n $AZURE_STORAGE_ACCOUNT_NAME -g $AZURE_RESOURCE_GROUP -l "$AZURE_REGION" --sku Standard_LRS


echo "------------"
echo "Creating Azure storage account container"
# Create Storage Account Container
export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string --resource-group $AZURE_RESOURCE_GROUP  --name $AZURE_STORAGE_ACCOUNT_NAME --query connectionString -o json)
az storage container create -n $AZURE_STORAGE_CONTAINER_NAME


echo "------------"
echo "Enable versioning on storage account"
 az storage account blob-service-properties update --enable-versioning -n $AZURE_STORAGE_ACCOUNT_NAME -g $AZURE_RESOURCE_GROUP
