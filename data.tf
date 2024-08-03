data "azurerm_key_vault" "akv" {
  name                = var.azurerm_keyvault
  resource_group_name = var.azurerm_resource_group
}

data "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ssh-private-key"
  key_vault_id = data.azurerm_key_vault.akv.id
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  key_vault_id = data.azurerm_key_vault.akv.id
}

data "azurerm_resource_group" "arg" {
  name = var.azurerm_resource_group
}

output "id" {
  value = data.azurerm_resource_group.arg.id
}
