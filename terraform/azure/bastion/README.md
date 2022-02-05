# Terraform a new Azure Linux VM (based upon a base image)

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#example-usage).


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

* `vm_name`
* `ssh_username`
* `vm_resource_group_name`
* `vm_size`
* `toolset_image_name`
* `toolset_image_version`
* `sig_name`
* `sig_resource_group_name`
* `suffix`

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create bastion

```
./create-bastion.sh
```

### Teardown the bastion

```
./destroy-bastion.sh
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-bastion.yml](../../../.github/workflows/azure-bastion.yml)

