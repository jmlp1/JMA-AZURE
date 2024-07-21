data "azurerm_key_vault" "akv" {
  name                = var.azurerm_keyvault
  resource_group_name = var.azure_resource_group
}

data "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "ssh-private-key"
  key_vault_id = data.azurerm_key_vault.akv.id
}

data "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "ssh-public-key"
  key_vault_id = data.azurerm_key_vault.akv.id
}
