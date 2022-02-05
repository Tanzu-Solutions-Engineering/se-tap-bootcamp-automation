# Terraform a new Azure Container Registry

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#example-usage).

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

* `registry_name`
  * restricted to alpha-numeric characters
* `resource_group_name`
* `region`

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create container registry

```
./create-container-registry.sh
```

### Teardown container registry

```
./destroy-container-registry.sh
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-container-registry.yml](../../../.github/workflows/azure-container-registry.yml)


## Elsewhere

* [tf4k8s](https://github.com/pacphi/tf4k8s/tree/master/modules/registry/acr)
