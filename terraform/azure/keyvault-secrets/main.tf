

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "vault" {
  name                = var.kv_name
  resource_group_name = data.azurerm_resource_group.rg.name
}


resource "azurerm_key_vault_secret" "secrets" {
  count        = length(var.secret_map)
  name         = keys(var.secret_map)[count.index]
  value        = values(var.secret_map)[count.index]
  key_vault_id = data.azurerm_key_vault.vault.id

}