#!/usr/bin/env bash

# USAGE:
# ./fetch-ssh-key.sh

set -e

mkdir -p workshop-sshkeys
#get all participant resource groups
groups=$(az group list --query "[?contains(name,'participant-') && managedBy==null].name" | jq -r '.[]')

#loop over each and get the keyvault
for rg in $groups; do
    echo "fetching bastion ip and ssh key in $rg resource group"
    ipaddr=$(az vm show -d -g $rg -n $rg-bastion --query publicIps | jq -r)
    kv=$(az keyvault list -g $rg | jq -r '.[0].name')
    az keyvault secret show --name bastion-b64-private-key --vault-name $kv | jq -r .value | base64 -d > workshop-sshkeys/$rg-bastion.$ipaddr.pem
done
