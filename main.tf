provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "arg" {
  name     = var.azurerm_resource_group
  location = var.azurerm_region
}

resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.arg.location
  resource_group_name = azurerm_resource_group.arg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.arg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count                 = "${var.node_count}"
  name                  = "vmnic-${format("%02d", count.index+1)}"  
  location              = var.azurerm_region
  resource_group_name   = azurerm_resource_group.arg.name
  
  ip_configuration {
    name                          = "vmintip-${format("%02d", count.index+1)}"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count = "${var.node_count}"
  name                  = "vm-${format("%02d", count.index+1)}"
  location              = var.azurerm_region
  resource_group_name   = azurerm_resource_group.arg.name
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id,count.index)}"]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "OSvm-${format("%02d", count.index)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"  
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = var.os.publisher
    offer     = var.os.offer
    sku       = var.os.sku
    version   = var.os.version
  }

  os_profile {
    computer_name  =  azurerm_virtual_machine.vm[count.index]
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = data.azurerm_key_vault_secret.ssh_public_key.value
    }
  }
}
