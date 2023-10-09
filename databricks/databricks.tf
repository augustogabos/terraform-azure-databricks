data "azurerm_databricks_workspace_private_endpoint_connection" "adb_pec" {
  workspace_id        = azurerm_databricks_workspace.adb_workspace.id
  private_endpoint_id = azurerm_private_endpoint.databricks.id
}

resource "azurerm_databricks_workspace" "adb_workspace" {
  name                        = "${var.prefix}-DBW"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  sku                         = "premium"
  managed_resource_group_name = "${var.prefix}-DBW-managed-private-endpoint"

  public_network_access_enabled         = true
  network_security_group_rules_required = "AllRules"

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = var.subnet_name_ADBP
    private_subnet_name = var.subnet_name_ADBPP
    virtual_network_id  = var.vnet_id

    public_subnet_network_security_group_association_id  = var.snsga_ADDP_public
    private_subnet_network_security_group_association_id = var.snsga_ADDPP_private
  }

  tags = {
    Environment = "${var.prefix}"
    Pricing     = "Premium"
  }
}

resource "azurerm_private_endpoint" "databricks" {
  name                = "adb-pe"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id_PAAS

  private_service_connection {
    name                           = "adb-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.adb_workspace.id
    subresource_names              = ["databricks_ui_api"]
  }
}

resource "azurerm_private_dns_zone" "dns_priv" {
  depends_on = [azurerm_private_endpoint.databricks]

  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_cname_record" "dns_record" {
  name                = azurerm_databricks_workspace.adb_workspace.workspace_url
  zone_name           = azurerm_private_dns_zone.dns_priv.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  record              = "eastus-c2.azuredatabricks.net"
}