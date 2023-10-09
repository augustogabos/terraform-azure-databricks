variable "resource_group_name" {
  description = "RG name"
  type        = string
}

variable "resource_group_location" {
  description = "RG location"
  type        = string
}

variable "subnet_name_ADBP" {
  description = "Nome da Subnet ADBP"
  type        = string
}

variable "subnet_name_ADBPP" {
  description = "Nome da Subnet ADBPP"
  type        = string
}

variable "vnet_id" {
  description = "Vnet ID do modulo Network"
  type        = string
}

variable "snsga_ADDP_public" {
  description = "Nsg public association ID"
  type        = string
}

variable "snsga_ADDPP_private" {
  description = "Nsg private association ID"
  type        = string
}

variable "subnet_id_PAAS" {
  description = "PAAS subnet ID"
  type        = string
}

variable "prefix" {
  description = "Env prefix"
  type        = string
}