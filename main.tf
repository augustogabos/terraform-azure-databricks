# Network com todas as subnets
module "network" {
  source = "./network"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  cidr_vnet               = "10.0.0.0/20"
  cidr_subnet_PAAS        = "10.0.2.0/23"
  cidr_subnet_ADBP        = "10.0.4.0/23"
  cidr_subnet_ADBPP       = "10.0.6.0/23"
  prefix                  = var.environment == "dev" ? "Dev" : "Hml"
}

module "databricks" {
  source = "./databricks"
  depends_on = [ module.network ]

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  subnet_name_ADBP        = module.network.subnet_name_ADBP
  subnet_name_ADBPP       = module.network.subnet_name_ADBPP
  subnet_id_PAAS          = module.network.subnet_id_PAAS
  vnet_id                 = module.network.vnet_id
  snsga_ADDP_public       = module.network.snsga_ADDP_public
  snsga_ADDPP_private     = module.network.snsga_ADBPP-private
  prefix                  = var.environment == "dev" ? "Dev" : "Hml"
}