# Defines the location Azure
variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus2"
}

# Defines the variable for the virtual network
variable "my-vnet" {
description   = "Azure virtual network"
type          = string
default       = "dev-vnet"

}

# Defines the variable for the Vnet_address_space
variable "my-vnet-address-space" {
  description = "Address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Defines the names of the subnets
variable "subnet-names" {
  type    = list(string)
  default = ["web-subnet", "api-subnet", "db-subnet"]
}

# Defines the subnet nos for each VMs
variable "subnet-ips" {
  description = "List of subnet names"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

# Defines the names of the VMs
variable "vm-names" {
  type    = list(string)
  default = ["web-vm", "api-vm", "db-vm"]
}

# Defines the size of the VMs
variable "vm-size" {
  description = "Size of the virtual machines"
  default     = "Standard_B1s"
}

# Defines the NSG_rules variables and respective values
variable "nsg-rules" {
  type = list(map(any))
  default = [
    {
      name                       = "Allow_Inbound_HTTP_Web"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "Internet"
      destination_address_prefix = "10.0.0.0/24"
    },

    {
      name                       = "Allow_Inbound_SSH_Web"
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.0.0/24"
    },

    {
      name                       = "Allow_Outbound_HTTP_Web"
      priority                   = 105
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.0.0/24"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow_Inbound_HTTP_API"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "10.0.0.0/24"
      destination_address_prefix = "10.0.1.0/24"
    },
    {
      name                       = "Allow_Inbound_SSH_API"
      priority                   = 201
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.0.0/24"
      destination_address_prefix = "10.0.1.0/24"
    },
    {
      name                       = "Allow_Outbound_SSH_API"
      priority                   = 905   
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "10.0.0.0/24"
    },
    
     {
      name                       = "Deny_Outbound_DB_Web"
      priority                   = 918  
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "10.0.0.0/24"
    },

    {
      name                       = "Allow_Outbound_SSH_DB"
      priority                   = 500
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "10.0.1.0/24"
    },

    {
      name                       = "Deny_Inbound_DB_Internet"
      priority                   =  919  
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.2.0/24"
    },
    
    {

      name                       = "Deny_Inbound_API_Internet"
      priority                   = 920 
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "10.0.1.0/24"
    }, 
      
    {
      name                       = "Allow_Inbound_SSH_DB"
      priority                   = 900
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "10.0.2.0/24"
    
    },

    {
      name                       = "Deny_Inbound_DB_Web"
      priority                   = 901
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "10.0.0.0/24"  
      destination_address_prefix = "10.0.2.0/24"
    },

    {
      name                       = "Deny_Inbound_Web_DB"
      priority                   = 902
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "10.0.0.0/24"
      
   },

  ]
}

