variable "azurerm_resource_group" {
  description = "The name of the resource group"
  type        = string
}

variable "azurerm_region" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "azurerm_stgaccount" {
  description = "The name of the strg account"
  type        = string 
}

variable "azurerm_containername" {
  description = "The name of the strg account"
  type        = string 
}

variable "azurerm_keyvault" {
  description = "The name of the vault"
  type        = string
}

variable "node_count" {
  description = "The name of the vault"
  type        = number
}

variable "os" {
    description = "OS image to deploy"
    type = object({
        publisher = string
        offer = string
        sku = string
        version = string
  })
} 


