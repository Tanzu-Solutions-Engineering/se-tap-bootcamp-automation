#!/bin/bash

terraform destroy -auto-approve
rm -Rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup terraform.log terraform.plan

## Restore individual module providers.tf

TF_MODULES=( "bastion" "child-dns" "cluster" "main-dns" "registry" "resource-group" "virtual-network" )

cd ..
# @see https://www.cyberciti.biz/faq/bash-for-loop-array/
for i in "${TF_MODULES[@]}"
do
  cd "$i"
  if [ -f "providers.tf.bak" ]; then
    mv providers.tf.bak providers.tf
  fi
  if [ -f "versions.tf.bak" ]; then
    mv versions.tf.bak versions.tf
  fi
  cd ..
done
cd all-in-one
