# Terraform a new Azure Key Vault

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault#example-usage).

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
* `bastion_name`

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create key vault

```
./create-vault.sh
```

### Teardown key vault

```
./destroy-vault.sh
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-keyvault.yml](../../../.github/workflows/azure-keyvault.yml)
