resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.prefix}-vnet-databricks"
  address_space       = [var.cidr_vnet]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = {
    Name = "vnet-${var.prefix}"
  }
}

resource "azurerm_subnet" "PAAS" {
  name                 = "PAAS"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = [var.cidr_subnet_PAAS]

  private_endpoint_network_policies_enabled = false
}

resource "azurerm_subnet" "ADBP" {
  name                 = "ADBP"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = [var.cidr_subnet_ADBP]

  delegation {
    name = "databricks-del-pub-ADBP"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet" "ADBPP" {
  name                 = "ADBPP"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = [var.cidr_subnet_ADBPP]

  delegation {
    name = "databricks-del-pri-ADBPP"

    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
      ]
      name = "Microsoft.Databricks/workspaces"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "ADBP-public" {
  subnet_id                 = azurerm_subnet.ADBP.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_subnet_network_security_group_association" "ADBPP-private" {
  subnet_id                 = azurerm_subnet.ADBPP.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = {
    Name = "nsg-${var.prefix}"
  }
}