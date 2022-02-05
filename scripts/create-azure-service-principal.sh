#!/usr/bin/env bash

# USAGE:
# export AZURE_SUBSCRIPTION_ID=<your subscription>
# export AZURE_SP_NAME=<name_of_sp_to_create>
# export AZURE_SP_ROLE=<role_to_use>
#
# scripts/create-azure-service-principal.sh

set -e

if [ -z "$AZURE_SUBSCRIPTION_ID" ] || [ -z "$AZURE_SP_NAME" ] || [ -z "$AZURE_SP_ROLE" ]; then
    echo -e "One or more variables are not defined. required environment variables are:\nAZURE_SUBSCRIPTION_ID\nAZURE_SP_NAME\nAZURE_SP_ROLE"
    exit 1

fi

# create a SP with specified role
az account set -s $AZURE_SUBSCRIPTION_ID
#the cli says --sdk-auth is deprecated but doesn't give a new option. this is required for the github action though
az ad sp create-for-rbac --name $AZURE_SP_NAME --role $AZURE_SP_ROLE \
    --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID} \
    --sdk-auth

#get service principal appId
export appId=`az ad app list --display-name $AZURE_SP_NAME | jq -r '.[] | .appId'`

#assign key vault adminstrator role to service principal    
az role assignment create --assignee $appId \
--role "Key Vault Administrator" \
--subscription ${AZURE_SUBSCRIPTION_ID} \
--output none
