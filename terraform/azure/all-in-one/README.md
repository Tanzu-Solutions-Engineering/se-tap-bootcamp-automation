# Terraform a Complete Environment targeting Azure

> [ Proof of concept ] still under development

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

* `region`
* `resource_group_name`
* `main_resource_group_name`
* `vm_name`
* `base_domain`
* `domain_prefix`
* `aks_node`
* `aks_node_type`
* `registry_name`

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Setup

```
./create-all.sh
```

### Teardown

```
./destroy-all.sh
```
