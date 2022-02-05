# Terraform a new Azure Virtual Network

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network#example-usage).

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
* `vnet_cidr`
* `operator_subnet_cidr`
* `aks_subnet_cidr`

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create network

```
./create-network.sh
```

### Teardown network

```
./destroy-network.sh
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-virtual-network.yml](../../../.github/workflows/azure-virtual-network.yml)


## Elsewhere

* [Enable network policy for an AKS cluster](https://docs.microsoft.com/en-us/azure/aks/use-network-policies#create-an-aks-cluster-and-enable-network-policy)