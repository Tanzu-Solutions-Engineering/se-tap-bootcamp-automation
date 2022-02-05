# Terraform a new Azure DNS Zone (for main domain management)

Based on the following Terraform [example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone#example-usage).


This will create a "main" dns zone in a resource group in azure. this expects that you have a domain registrar that is hosting the `base_domain` and it will create a zone in azure with `domain_prefix.base_domain` you can then add the NS records from the output to your domain registrar. All DNS after this will be handled via azure.

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

// TODO add bulleted list of variable names

### Specify environment variables

```
export ARM_CLIENT_ID=xxx
export ARM_CLIENT_SECRET=xxx
export ARM_SUBSCRIPTION_ID=xxx
export ARM_TENANT_ID=xxx
```
> Replace occurrences of `xxx` above with appropriate values

### Create zone

```
./create-zone.sh
```

### Teardown the zone

```
./destroy-zone.sh
```


## Github Action

This action is workflow dispatched [with inputs](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#onworkflow_dispatchinputs).

See [azure-main-dns.yml](../../../.github/workflows/azure-main-dns.yml)
