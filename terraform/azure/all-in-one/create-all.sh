#!/bin/bash

## To mitigate against

##│ Error: Module module.registry contains provider configuration
##│ Providers cannot be configured within modules using count, for_each or depends_on.

TF_MODULES=( "bastion" "child-dns" "cluster" "main-dns" "registry" "resource-group" "virtual-network" )

cd ..
# @see https://www.cyberciti.biz/faq/bash-for-loop-array/
for i in "${TF_MODULES[@]}"
do
  cd "$i"
  if [ -f "providers.tf" ]; then
    mv providers.tf providers.tf.bak
  fi
  if [ -f "versions.tf" ]; then
    mv versions.tf versions.tf.bak
  fi
  cd ..
done
cd all-in-one

terraform init
terraform validate
terraform plan -out terraform.plan
terraform apply -auto-approve -state terraform.tfstate terraform.plan
