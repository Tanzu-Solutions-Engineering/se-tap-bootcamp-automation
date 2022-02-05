# Terraform a new Azure Kubernetes Cluster

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#example-usage).


Assumes:

* Azure credentials are passed as environment variables
  * See `ARM_*` arguments [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference)


## Local testing

### Copy sample configuration

```
cp terraform.tfvars.sample terraform.tfvars
```

### Edit `terraform.tfvars`

Amend the values for

* `resource_group_name`
* `suffix`
* `aks_nodes`
* `aks_node_type`
* `aks_node_disk_size`
* `environment`


### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create cluster

```
./create-cluster.sh
```

### List available clusters

```
./list-clusters.sh
```

### Update kubeconfig

Use the name and location of the cluster you just created to update `kubeconfig` and set the current context for `kubectl`

```
./set-kubectl-context.sh {AKS_CLUSTER_NAME} {RESOURCE_GROUP_NAME}
```

### Teardown the cluster

```
./destroy-cluster.sh
```

### Copying kubeconfig to bastion

For example

```
scp -i ~/.ssh/toolset-vm_rsa /home/cphillipson/.kube/aks-9f-config ubuntu@13.78.140.12:/home/ubuntu
ssh -i ~/.ssh/toolset-vm_rsa ubuntu@13.78.140.12
## Now that you're on the bastion you need set KUBECONFIG environment variable to connect
export KUBECONFIG=/home/ubuntu/aks-9f-config
kubectl get nodes -o wide
kubectl get po -A -o wide
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-k8s-cluster.yml](../../../.github/workflows/azure-k8s-cluster.yml)


## Troubleshooting

* [Adjusting VM Quota Limits](https://docs.microsoft.com/en-us/azure/azure-supportability/per-vm-quota-requests)


## Elsewhere

* [tf4k8s](https://github.com/pacphi/tf4k8s/tree/master/modules/cluster/aks)
