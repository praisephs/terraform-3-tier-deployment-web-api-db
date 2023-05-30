
# To retrieve information from the resource group
data "azurerm_resource_group" "my-rg" {
        name = "cohort3-uyi-rg"
}

# Creates virtual network
resource "azurerm_virtual_network" "my-vnet" {
  name                = var.my-vnet
  address_space       = var.my-vnet-address-space
  location            = data.azurerm_resource_group.my-rg.location
  resource_group_name = data.azurerm_resource_group.my-rg.name
  
}

# Creates subnets using the count parameter
resource "azurerm_subnet" "subnet" {
  count                      = length(var.subnet-names)
  name                       = var.subnet-names[count.index]
  resource_group_name        = data.azurerm_resource_group.my-rg.name  
  virtual_network_name       = azurerm_virtual_network.my-vnet.name
  address_prefixes           = [var.subnet-ips[count.index]]
}

# Creates public-ip address
resource "azurerm_public_ip" "my-public-ip" {
  name                    = "my-public-ip"
  location                = data.azurerm_resource_group.my-rg.location
  resource_group_name     = data.azurerm_resource_group.my-rg.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
}

# Creates network interface cards (NICs)
resource "azurerm_network_interface" "my-nic" {
  count               = length(var.subnet-names)
  name                = "${var.subnet-names[count.index]}-nic"
  location            = data.azurerm_resource_group.my-rg.location
  resource_group_name = data.azurerm_resource_group.my-rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Dynamic"

    # Associates the web-subnet with the public-ip
    public_ip_address_id          = var.subnet-ips[count.index] == "10.0.0.0/24" ? azurerm_public_ip.my-public-ip.id : null
  
  
  }
}

# Creates network security groups (NSGs)
resource "azurerm_network_security_group" "nsg" {
  count               = length(var.subnet-names)
  name                = "${var.subnet-names[count.index]}-nsg"
  location            = data.azurerm_resource_group.my-rg.location
  resource_group_name = data.azurerm_resource_group.my-rg.name

 # Loop through the NSG variables
 dynamic "security_rule" {
    for_each = var.nsg-rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  } 
}

# Defines NSGs association with subnets
resource "azurerm_subnet_network_security_group_association" "nsg-associate" {
  count                     = length(var.subnet-ips)
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
  
}

# Creates 3 virtual machines using count parameter
resource "azurerm_virtual_machine" "my-vms" {
  count                 = length(var.vm-names)
  name                  = var.vm-names[count.index]
  location              = data.azurerm_resource_group.my-rg.location
  resource_group_name   = data.azurerm_resource_group.my-rg.name
  network_interface_ids = [azurerm_network_interface.my-nic[count.index].id]
  
  vm_size               = var.vm-size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm-names[count.index]}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm-names[count.index]
    admin_username = "adminuser"
    admin_password = "1AAnaconda123."
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

