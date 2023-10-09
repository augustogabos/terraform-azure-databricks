output "subnet_name_ADBP" {
  value = azurerm_subnet.ADBP.name
}

output "subnet_name_ADBPP" {
  value = azurerm_subnet.ADBPP.name
}

output "subnet_id_PAAS" {
  value = azurerm_subnet.PAAS.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet01.id
}

output "snsga_ADDP_public" {
  value = azurerm_subnet_network_security_group_association.ADBP-public.id
}

output "snsga_ADBPP-private" {
  value = azurerm_subnet_network_security_group_association.ADBPP-private.id
}

output "security_group_id" {
  value = azurerm_network_security_group.nsg.id
}